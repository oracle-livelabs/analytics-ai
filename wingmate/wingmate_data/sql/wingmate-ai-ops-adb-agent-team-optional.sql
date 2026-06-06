set define off verify off feedback on serveroutput on
prompt Wingmate AI Ops ADB Agent Team setup v2026-06-05
prompt Creates an AI Ops tool that uses Resource Analytics multicloud data for dry-run-first ADB provisioning.
prompt Run sql/wingmate-select-ai-profiles.sql first so WINGMATE_MULTICLOUD exists.

CREATE OR REPLACE FUNCTION wingmate_list_subscribed_regions(
    p_tenancy_ocid IN VARCHAR2 DEFAULT '<oci_tenancy_ocid>',
    p_home_region  IN VARCHAR2 DEFAULT '<identity_home_region>'
) RETURN CLOB
AUTHID CURRENT_USER
IS
    l_result CLOB;
BEGIN
    IF p_tenancy_ocid IS NULL OR REGEXP_LIKE(p_tenancy_ocid, '^<[^>]+>$') THEN
        RETURN JSON_OBJECT(
            'status' VALUE 'missing_input',
            'message' VALUE 'Provide the tenancy OCID before listing subscribed regions.'
            RETURNING CLOB
        );
    END IF;

    IF p_home_region IS NULL OR REGEXP_LIKE(p_home_region, '^<[^>]+>$') THEN
        RETURN JSON_OBJECT(
            'status' VALUE 'missing_input',
            'message' VALUE 'Provide an identity home region such as us-ashburn-1.'
            RETURNING CLOB
        );
    END IF;

    EXECUTE IMMEDIATE q'~
        DECLARE
            l_response dbms_cloud_oci_id_identity_list_region_subscriptions_response_t;
            l_result   CLOB := '[';
        BEGIN
            l_response := dbms_cloud_oci_id_identity.list_region_subscriptions(
                tenancy_id      => :b_tenancy_ocid,
                region          => :b_home_region,
                credential_name => 'WINGMATE_OCI_CRED'
            );

            IF l_response.response_body IS NOT NULL THEN
                FOR i IN 1 .. l_response.response_body.COUNT LOOP
                    IF i > 1 THEN
                        l_result := l_result || ',';
                    END IF;

                    l_result := l_result || JSON_OBJECT(
                        'region_key' VALUE l_response.response_body(i).region_key,
                        'region_name' VALUE l_response.response_body(i).region_name,
                        'status' VALUE l_response.response_body(i).status,
                        'is_home_region' VALUE l_response.response_body(i).is_home_region
                        RETURNING CLOB
                    );
                END LOOP;
            END IF;

            l_result := l_result || ']';
            :b_result := l_result;
        END;
    ~'
    USING IN p_tenancy_ocid, IN p_home_region, OUT l_result;

    RETURN JSON_OBJECT(
        'status' VALUE 'success',
        'regions' VALUE l_result FORMAT JSON
        RETURNING CLOB
    );
EXCEPTION
    WHEN OTHERS THEN
        RETURN JSON_OBJECT(
            'status' VALUE 'error',
            'message' VALUE SQLERRM,
            'hint' VALUE 'Confirm WINGMATE_OCI_CRED, OCI PL/SQL SDK availability, and IAM permission to inspect region subscriptions.'
            RETURNING CLOB
        );
END wingmate_list_subscribed_regions;
/

CREATE OR REPLACE FUNCTION wingmate_multicloud_db_advisor(
    p_question IN VARCHAR2 DEFAULT 'Summarize the multicloud database inventory and recommend whether to provision or scale an Autonomous Database.'
) RETURN CLOB
AUTHID CURRENT_USER
IS
    l_prompt VARCHAR2(32767);
    l_answer CLOB;
BEGIN
    l_prompt :=
        NVL(
            p_question,
            'Summarize the multicloud database inventory and recommend whether to provision or scale an Autonomous Database.'
        ) ||
        CHR(10) ||
        'Use the Resource Analytics and multicloud database objects available to the WINGMATE_MULTICLOUD profile. ' ||
        'Focus on Exadata infrastructure, VM clusters, CDBs, PDBs, regions, multicloud placement, host insights, ' ||
        'capacity signals, and a practical recommendation for provisioning, scaling, or replicating an Autonomous Database footprint.';

    l_answer := DBMS_CLOUD_AI.GENERATE(
        prompt       => l_prompt,
        profile_name => 'WINGMATE_MULTICLOUD',
        action       => 'narrate'
    );

    RETURN JSON_OBJECT(
        'status' VALUE 'success',
        'source_profile' VALUE 'WINGMATE_MULTICLOUD',
        'question' VALUE SUBSTR(l_prompt, 1, 4000),
        'answer' VALUE DBMS_LOB.SUBSTR(l_answer, 32000, 1)
        RETURNING CLOB
    );
EXCEPTION
    WHEN OTHERS THEN
        RETURN JSON_OBJECT(
            'status' VALUE 'error',
            'source_profile' VALUE 'WINGMATE_MULTICLOUD',
            'message' VALUE SQLERRM,
            'hint' VALUE 'Confirm sql/wingmate-select-ai-profiles.sql ran successfully and WINGMATE_MULTICLOUD can query the database inventory objects.'
            RETURNING CLOB
        );
END wingmate_multicloud_db_advisor;
/

CREATE OR REPLACE FUNCTION wingmate_provision_adb_tool(
    p_compartment_ocid IN VARCHAR2 DEFAULT '<adb_target_compartment_ocid>',
    p_region           IN VARCHAR2,
    p_db_name          IN VARCHAR2,
    p_display_name     IN VARCHAR2,
    p_admin_password   IN VARCHAR2,
    p_db_workload      IN VARCHAR2 DEFAULT 'OLTP',
    p_compute_model    IN VARCHAR2 DEFAULT 'ECPU',
    p_compute_count    IN NUMBER   DEFAULT 2,
    p_cpu_core_count   IN NUMBER   DEFAULT NULL,
    p_storage_tbs      IN NUMBER   DEFAULT 1,
    p_license_model    IN VARCHAR2 DEFAULT 'LICENSE_INCLUDED',
    p_free_tier        IN VARCHAR2 DEFAULT 'N',
    p_auto_scaling     IN VARCHAR2 DEFAULT 'Y',
    p_execute          IN VARCHAR2 DEFAULT 'N'
) RETURN CLOB
AUTHID CURRENT_USER
IS
    l_execute           BOOLEAN := UPPER(NVL(p_execute, 'N')) IN ('Y', 'YES', 'TRUE');
    l_db_workload       VARCHAR2(32) := UPPER(NVL(p_db_workload, 'OLTP'));
    l_compute_model     VARCHAR2(32) := UPPER(NVL(p_compute_model, 'ECPU'));
    l_license_model     VARCHAR2(64) := UPPER(NVL(p_license_model, 'LICENSE_INCLUDED'));
    l_free_tier_flag    NUMBER := CASE WHEN UPPER(NVL(p_free_tier, 'N')) IN ('Y', 'YES', 'TRUE') THEN 1 ELSE 0 END;
    l_auto_scaling_flag NUMBER := CASE WHEN UPPER(NVL(p_auto_scaling, 'Y')) IN ('Y', 'YES', 'TRUE') THEN 1 ELSE 0 END;
    l_compute_count     NUMBER := NVL(p_compute_count, 2);
    l_storage_tbs       NUMBER := NVL(p_storage_tbs, 1);
    l_result            CLOB;

    PROCEDURE assert_value(
        p_condition IN BOOLEAN,
        p_message   IN VARCHAR2
    ) IS
    BEGIN
        IF NOT p_condition THEN
            RAISE_APPLICATION_ERROR(-20000, p_message);
        END IF;
    END assert_value;
BEGIN
    assert_value(p_compartment_ocid IS NOT NULL AND NOT REGEXP_LIKE(p_compartment_ocid, '^<[^>]+>$'), 'Provide the target compartment OCID.');
    assert_value(p_region IS NOT NULL, 'Provide the OCI region name.');
    assert_value(p_db_name IS NOT NULL, 'Provide an ADB database name.');
    assert_value(REGEXP_LIKE(UPPER(p_db_name), '^[A-Z][A-Z0-9]{1,13}$'), 'Use an ADB database name that starts with a letter and is 2-14 alphanumeric characters.');
    assert_value(p_display_name IS NOT NULL, 'Provide a display name.');
    assert_value(p_admin_password IS NOT NULL, 'Provide an admin password. The tool never returns it.');
    assert_value(l_db_workload IN ('OLTP', 'DW', 'AJD', 'APEX'), 'Use db workload OLTP, DW, AJD, or APEX.');
    assert_value(l_compute_model IN ('ECPU', 'OCPU'), 'Use compute model ECPU or OCPU.');
    assert_value(l_compute_count >= 1, 'Compute count must be at least 1.');
    assert_value(l_storage_tbs >= 1, 'Storage must be at least 1 TB.');
    assert_value(l_license_model IN ('LICENSE_INCLUDED', 'BRING_YOUR_OWN_LICENSE'), 'Use LICENSE_INCLUDED or BRING_YOUR_OWN_LICENSE.');

    IF NOT l_execute THEN
        RETURN JSON_OBJECT(
            'mode' VALUE 'dry-run',
            'message' VALUE 'No Autonomous Database was created. Review the request and call again with p_execute = Y only after explicit human confirmation.',
            'request' VALUE JSON_OBJECT(
                'compartment_ocid' VALUE p_compartment_ocid,
                'region' VALUE p_region,
                'db_name' VALUE UPPER(p_db_name),
                'display_name' VALUE p_display_name,
                'admin_password' VALUE '[redacted]',
                'db_workload' VALUE l_db_workload,
                'compute_model' VALUE l_compute_model,
                'compute_count' VALUE l_compute_count,
                'cpu_core_count' VALUE p_cpu_core_count,
                'storage_tbs' VALUE l_storage_tbs,
                'license_model' VALUE l_license_model,
                'free_tier' VALUE l_free_tier_flag,
                'auto_scaling' VALUE l_auto_scaling_flag
            )
            RETURNING CLOB
        );
    END IF;

    EXECUTE IMMEDIATE q'~
        DECLARE
            l_details          dbms_cloud_oci_database_create_autonomous_database_base_t;
            l_response         dbms_cloud_oci_db_database_create_autonomous_database_response_t;
            l_compute_model    VARCHAR2(32);
            l_compute_count    NUMBER;
            l_cpu_core_count   NUMBER;
        BEGIN
            l_compute_model := :b_compute_model;
            l_compute_count := :b_compute_count;
            l_cpu_core_count := :b_cpu_core_count;

            l_details := dbms_cloud_oci_database_create_autonomous_database_base_t();
            l_details.compartment_id := :b_compartment_ocid;
            l_details.db_name := :b_db_name;
            l_details.display_name := :b_display_name;
            l_details.admin_password := :b_admin_password;
            l_details.db_workload := :b_db_workload;
            l_details.data_storage_size_in_t_bs := :b_storage_tbs;
            l_details.license_model := :b_license_model;
            l_details.is_free_tier := :b_free_tier_flag;
            l_details.is_auto_scaling_enabled := :b_auto_scaling_flag;

            IF l_compute_model = 'ECPU' THEN
                l_details.compute_model := 'ECPU';
                l_details.compute_count := l_compute_count;
            ELSE
                l_details.cpu_core_count := NVL(l_cpu_core_count, l_compute_count);
            END IF;

            l_response := dbms_cloud_oci_db_database.create_autonomous_database(
                create_autonomous_database_details => l_details,
                opc_retry_token                    => RAWTOHEX(SYS_GUID()),
                region                             => :b_region,
                credential_name                    => 'WINGMATE_OCI_CRED'
            );

            IF l_response.response_body IS NULL THEN
                :b_result := JSON_OBJECT(
                    'status' VALUE 'submitted',
                    'http_status' VALUE l_response.status_code,
                    'message' VALUE 'Create request submitted. No response body was returned.'
                    RETURNING CLOB
                );
            ELSE
                :b_result := JSON_OBJECT(
                    'status' VALUE 'submitted',
                    'http_status' VALUE l_response.status_code,
                    'id' VALUE l_response.response_body.id,
                    'db_name' VALUE l_response.response_body.db_name,
                    'display_name' VALUE l_response.response_body.display_name,
                    'lifecycle_state' VALUE l_response.response_body.lifecycle_state
                    RETURNING CLOB
                );
            END IF;
        END;
    ~'
    USING
        IN l_compute_model,
        IN l_compute_count,
        IN p_cpu_core_count,
        IN p_compartment_ocid,
        IN UPPER(p_db_name),
        IN p_display_name,
        IN p_admin_password,
        IN l_db_workload,
        IN l_storage_tbs,
        IN l_license_model,
        IN l_free_tier_flag,
        IN l_auto_scaling_flag,
        IN p_region,
        OUT l_result;

    RETURN l_result;
EXCEPTION
    WHEN OTHERS THEN
        RETURN JSON_OBJECT(
            'status' VALUE 'error',
            'message' VALUE SQLERRM,
            'hint' VALUE 'Dry-run mode requires only the function. Live provisioning also requires OCI PL/SQL SDK availability and IAM permission to manage autonomous-database-family in the target compartment.'
            RETURNING CLOB
        );
END wingmate_provision_adb_tool;
/

DECLARE
    c_ai_ops_profile_name         CONSTANT VARCHAR2(128)  := 'WINGMATE_AI_OPS';
    c_multicloud_profile_name     CONSTANT VARCHAR2(128)  := 'WINGMATE_MULTICLOUD';
    c_inventory_tool_name         CONSTANT VARCHAR2(128)  := 'WINGMATE_MULTICLOUD_DB_ADVISOR_TOOL';
    c_region_tool_name            CONSTANT VARCHAR2(128)  := 'WINGMATE_LIST_SUBSCRIBED_REGIONS_TOOL';
    c_provision_tool_name         CONSTANT VARCHAR2(128)  := 'WINGMATE_PROVISION_ADB_TOOL';
    c_agent_name                  CONSTANT VARCHAR2(128)  := 'WINGMATE_AI_OPS_ADB_AGENT';
    c_task_name                   CONSTANT VARCHAR2(128)  := 'WINGMATE_AI_OPS_ADB_TASK';
    c_team_name                   CONSTANT VARCHAR2(128)  := 'WINGMATE_AI_OPS_ADB_AGENT_TEAM';
    c_genai_region                CONSTANT VARCHAR2(256)  := '<genai_region>';
    c_compartment_ocid            CONSTANT VARCHAR2(1024) := '<compartment_ocid>';
    c_chat_model                  CONSTANT VARCHAR2(1024) := '<oci_genai_chat_model_name_or_ocid>';
    c_tenancy_ocid                CONSTANT VARCHAR2(1024) := '<oci_tenancy_ocid>';
    c_identity_home_region        CONSTANT VARCHAR2(256)  := '<identity_home_region>';
    c_adb_target_compartment_ocid CONSTANT VARCHAR2(1024) := '<adb_target_compartment_ocid>';

    l_profile_attributes          CLOB;
    l_count                       NUMBER;

    PROCEDURE assert_replaced(
        p_value IN VARCHAR2,
        p_name  IN VARCHAR2
    ) IS
    BEGIN
        IF p_value IS NULL OR REGEXP_LIKE(p_value, '^<[^>]+>$') THEN
            RAISE_APPLICATION_ERROR(-20000, 'Replace ' || p_name || ' before running this script.');
        END IF;
    END assert_replaced;

    PROCEDURE run_agent_ddl(
        p_block IN CLOB
    ) IS
    BEGIN
        EXECUTE IMMEDIATE p_block;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Agent DDL skipped or failed: ' || SQLERRM);
            RAISE;
    END run_agent_ddl;
BEGIN
    assert_replaced(c_genai_region, '<genai_region>');
    assert_replaced(c_compartment_ocid, '<compartment_ocid>');
    assert_replaced(c_chat_model, '<oci_genai_chat_model_name_or_ocid>');
    assert_replaced(c_tenancy_ocid, '<oci_tenancy_ocid>');
    assert_replaced(c_identity_home_region, '<identity_home_region>');
    assert_replaced(c_adb_target_compartment_ocid, '<adb_target_compartment_ocid>');

    SELECT COUNT(*)
    INTO l_count
    FROM user_cloud_ai_profiles
    WHERE profile_name = c_multicloud_profile_name;

    IF l_count = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'Run wingmate-select-ai-profiles.sql first. Missing profile ' ||
            c_multicloud_profile_name || '.'
        );
    END IF;

    l_profile_attributes := JSON_OBJECT(
        'provider' VALUE 'oci',
        'credential_name' VALUE 'WINGMATE_OCI_CRED',
        'region' VALUE c_genai_region,
        'oci_compartment_id' VALUE c_compartment_ocid,
        'model' VALUE c_chat_model,
        'temperature' VALUE 0,
        'comments' VALUE 'true' FORMAT JSON
    );

    BEGIN
        EXECUTE IMMEDIATE q'~BEGIN DBMS_CLOUD_AI_AGENT.DROP_TEAM(team_name => 'WINGMATE_AI_OPS_ADB_AGENT_TEAM', force => TRUE); EXCEPTION WHEN OTHERS THEN NULL; END;~';
        EXECUTE IMMEDIATE q'~BEGIN DBMS_CLOUD_AI_AGENT.DROP_TASK(task_name => 'WINGMATE_AI_OPS_ADB_TASK', force => TRUE); EXCEPTION WHEN OTHERS THEN NULL; END;~';
        EXECUTE IMMEDIATE q'~BEGIN DBMS_CLOUD_AI_AGENT.DROP_AGENT(agent_name => 'WINGMATE_AI_OPS_ADB_AGENT', force => TRUE); EXCEPTION WHEN OTHERS THEN NULL; END;~';
        EXECUTE IMMEDIATE q'~BEGIN DBMS_CLOUD_AI_AGENT.DROP_TOOL(tool_name => 'WINGMATE_PROVISION_ADB_TOOL', force => TRUE); EXCEPTION WHEN OTHERS THEN NULL; END;~';
        EXECUTE IMMEDIATE q'~BEGIN DBMS_CLOUD_AI_AGENT.DROP_TOOL(tool_name => 'WINGMATE_LIST_SUBSCRIBED_REGIONS_TOOL', force => TRUE); EXCEPTION WHEN OTHERS THEN NULL; END;~';
        EXECUTE IMMEDIATE q'~BEGIN DBMS_CLOUD_AI_AGENT.DROP_TOOL(tool_name => 'WINGMATE_MULTICLOUD_DB_ADVISOR_TOOL', force => TRUE); EXCEPTION WHEN OTHERS THEN NULL; END;~';
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Agent cleanup skipped or partially completed: ' || SQLERRM);
    END;

    BEGIN
        DBMS_CLOUD_AI.DROP_PROFILE(
            profile_name => c_ai_ops_profile_name,
            force        => TRUE
        );
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    DBMS_CLOUD_AI.CREATE_PROFILE(
        profile_name => c_ai_ops_profile_name,
        description  => 'AI Ops profile for Wingmate Autonomous Database provisioning agents.',
        attributes   => l_profile_attributes
    );

    run_agent_ddl(q'~
        BEGIN
            DBMS_CLOUD_AI_AGENT.CREATE_TOOL(
                tool_name   => 'WINGMATE_MULTICLOUD_DB_ADVISOR_TOOL',
                description => 'Uses the WINGMATE_MULTICLOUD NL2SQL profile to summarize Resource Analytics database inventory for provisioning and scaling decisions.',
                attributes  => '{"instruction":"Use Resource Analytics and multicloud database inventory to make an informed provisioning, scaling, or replication recommendation before preparing an ADB request.","function":"WINGMATE_MULTICLOUD_DB_ADVISOR"}'
            );
        END;
    ~');

    run_agent_ddl(q'~
        BEGIN
            DBMS_CLOUD_AI_AGENT.CREATE_TOOL(
                tool_name   => 'WINGMATE_LIST_SUBSCRIBED_REGIONS_TOOL',
                description => 'Lists OCI regions subscribed by the tenancy.',
                attributes  => '{"instruction":"List OCI subscribed regions before recommending where to create an Autonomous Database. Use the default tenancy and home region values unless the user supplies different values.","function":"WINGMATE_LIST_SUBSCRIBED_REGIONS"}'
            );
        END;
    ~');

    run_agent_ddl(q'~
        BEGIN
            DBMS_CLOUD_AI_AGENT.CREATE_TOOL(
                tool_name   => 'WINGMATE_PROVISION_ADB_TOOL',
                description => 'Prepares or submits Autonomous Database create requests. Dry-run is the default.',
                attributes  => '{"instruction":"Prepare an Autonomous Database provisioning request. Always call this tool first with p_execute set to N for dry-run. Call it with p_execute set to Y only after the human explicitly confirms the summarized request.","function":"WINGMATE_PROVISION_ADB_TOOL"}'
            );
        END;
    ~');

    run_agent_ddl(q'~
        BEGIN
            DBMS_CLOUD_AI_AGENT.CREATE_AGENT(
                agent_name  => 'WINGMATE_AI_OPS_ADB_AGENT',
                description => 'AI Ops agent for Resource Analytics-informed Autonomous Database provisioning workflows.',
                attributes  => '{"profile_name":"WINGMATE_AI_OPS","role":"You are the Wingmate AI Ops Autonomous Database provisioning agent. Use the multicloud database advisor tool to inspect Resource Analytics database inventory before recommending provisioning, scaling, or replication. List subscribed regions before choosing a target region. Build a dry-run request first, summarize it, and require explicit human confirmation before any live provisioning. Never invent or reveal admin passwords; ask the user for a temporary password only when live provisioning is requested.","enable_human_tool":true}'
            );
        END;
    ~');

    run_agent_ddl(q'~
        BEGIN
            DBMS_CLOUD_AI_AGENT.CREATE_TASK(
                task_name   => 'WINGMATE_AI_OPS_ADB_TASK',
                description => 'Inspect Resource Analytics database inventory, plan ADB provisioning or scaling, and provision only after human confirmation.',
                attributes  => '{"instruction":"Handle the user request: {query}. Use WINGMATE_MULTICLOUD_DB_ADVISOR_TOOL to inspect Resource Analytics and multicloud database inventory. Use WINGMATE_LIST_SUBSCRIBED_REGIONS_TOOL to confirm available OCI regions. Use WINGMATE_PROVISION_ADB_TOOL with p_execute=N to produce a dry-run request for provisioning or self-replicating an Autonomous Database footprint from natural language. If the user requests live provisioning, summarize every setting and use HUMAN for explicit confirmation before calling WINGMATE_PROVISION_ADB_TOOL with p_execute=Y.","tools":["WINGMATE_MULTICLOUD_DB_ADVISOR_TOOL","WINGMATE_LIST_SUBSCRIBED_REGIONS_TOOL","WINGMATE_PROVISION_ADB_TOOL","HUMAN"]}'
            );
        END;
    ~');

    run_agent_ddl(q'~
        BEGIN
            DBMS_CLOUD_AI_AGENT.CREATE_TEAM(
                team_name   => 'WINGMATE_AI_OPS_ADB_AGENT_TEAM',
                description => 'Wingmate AI Ops Agent Team for Resource Analytics-informed Autonomous Database provisioning.',
                attributes  => '{"agents":[{"name":"WINGMATE_AI_OPS_ADB_AGENT","task":"WINGMATE_AI_OPS_ADB_TASK"}],"process":"sequential"}'
            );
        END;
    ~');

    DBMS_OUTPUT.PUT_LINE('Created profile ' || c_ai_ops_profile_name || '.');
    DBMS_OUTPUT.PUT_LINE('Created Agent Team ' || c_team_name || '.');
    DBMS_OUTPUT.PUT_LINE('Default tenancy OCID for region tool: ' || c_tenancy_ocid);
    DBMS_OUTPUT.PUT_LINE('Default identity home region for region tool: ' || c_identity_home_region);
    DBMS_OUTPUT.PUT_LINE('Default ADB target compartment: ' || c_adb_target_compartment_ocid);
END;
/

DECLARE
    l_agent_team_count NUMBER;
BEGIN
    EXECUTE IMMEDIATE q'~
        SELECT COUNT(*)
        FROM user_ai_agent_teams
        WHERE agent_team_name = 'WINGMATE_AI_OPS_ADB_AGENT_TEAM'
    ~'
    INTO l_agent_team_count;

    DBMS_OUTPUT.PUT_LINE('WINGMATE_AI_OPS_ADB_AGENT_TEAM rows: ' || l_agent_team_count);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Agent Team validation skipped or unavailable: ' || SQLERRM);
END;
/
