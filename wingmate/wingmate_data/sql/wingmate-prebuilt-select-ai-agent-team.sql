rem ============================================================================
rem NAME
rem   wingmate-prebuilt-select-ai-agent-team.sql
rem
rem DESCRIPTION
rem   Creates the Wingmate pre-built Select AI Agent Team using the Oracle sample
rem   agents from:
rem
rem   https://github.com/oracle-devrel/oracle-autonomous-database-samples/tree/main/autonomous-ai-agents
rem
rem   The team is based on the practical note:
rem   https://blogs.oracle.com/machinelearning/build-your-agentic-solution-using-oracle-adb-select-ai-agent
rem
rem AGENTS INCLUDED
rem   Agent 1: OCI Autonomous Database AI Agent and Tools
rem     Agent: OCI_AUTONOMOUS_DATABASE_ADVISOR
rem     Task:  OCI_AUTONOMOUS_DATABASE_TASKS
rem
rem   Agent 2: Select AI Inspect - Database Inspection Tool
rem     Agent: INSPECT_AGENT_WINGMATE_DATABASE_INSPECT_TEAM
rem     Task:  INSPECT_TASK_WINGMATE_DATABASE_INSPECT_TEAM
rem
rem   Agent 3: Select AI - DBMS Scheduler Monitoring Agent
rem     Agent: SCHEDULER_MONITOR_ADVISOR
rem     Task:  SCHEDULER_MONITOR_TASKS
rem
rem   Composite team:
rem     WINGMATE_PREBUILT_SELECT_AI_AGENT_TEAM
rem
rem RUN ORDER
rem   1. Run wingmate-select-ai-profiles.sql.
rem   2. Run wingmate-doc-research-rag.sql so ALL_MINILM_L12_V2 is available.
rem   3. Run wingmate-prebuilt-select-ai-agent-tools.sql as ADMIN, or run the
rem      three vendored tool scripts manually as ADMIN with SCHEMA_NAME=WINGMATE.
rem   4. Connect as WINGMATE and run this script.
rem
rem PARAMETERS TO EDIT
rem   <genai_region>
rem   <compartment_ocid>
rem   <oci_genai_chat_model_name_or_ocid>
rem ============================================================================

SET DEFINE OFF
SET VERIFY OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK

PROMPT Creating Wingmate pre-built Select AI Agent Team.

DECLARE
    c_schema_name                  CONSTANT VARCHAR2(128)  := 'WINGMATE';
    c_profile_name                 CONSTANT VARCHAR2(128)  := 'WINGMATE_PREBUILT_AGENT_PROFILE';
    c_genai_region                 CONSTANT VARCHAR2(256)  := '<genai_region>';
    c_compartment_ocid             CONSTANT VARCHAR2(1024) := '<compartment_ocid>';
    c_chat_model                   CONSTANT VARCHAR2(1024) := '<oci_genai_chat_model_name_or_ocid>';
    c_embedding_model              CONSTANT VARCHAR2(128)  := 'ALL_MINILM_L12_V2';
    c_inspect_team_name            CONSTANT VARCHAR2(128)  := 'WINGMATE_DATABASE_INSPECT_TEAM';
    c_scheduler_target_owner       CONSTANT VARCHAR2(128)  := 'WINGMATE';
    c_composite_team_name          CONSTANT VARCHAR2(128)  := 'WINGMATE_PREBUILT_SELECT_AI_AGENT_TEAM';
    c_oci_agent_name               CONSTANT VARCHAR2(128)  := 'OCI_AUTONOMOUS_DATABASE_ADVISOR';
    c_oci_task_name                CONSTANT VARCHAR2(128)  := 'OCI_AUTONOMOUS_DATABASE_TASKS';
    c_oci_team_name                CONSTANT VARCHAR2(128)  := 'OCI_AUTONOMOUS_DATABASE_TEAM';
    c_inspect_agent_name           CONSTANT VARCHAR2(128)  := 'INSPECT_AGENT_WINGMATE_DATABASE_INSPECT_TEAM';
    c_inspect_task_name            CONSTANT VARCHAR2(128)  := 'INSPECT_TASK_WINGMATE_DATABASE_INSPECT_TEAM';
    c_scheduler_agent_name         CONSTANT VARCHAR2(128)  := 'SCHEDULER_MONITOR_ADVISOR';
    c_scheduler_task_name          CONSTANT VARCHAR2(128)  := 'SCHEDULER_MONITOR_TASKS';
    c_scheduler_team_name          CONSTANT VARCHAR2(128)  := 'DBMS_SCHEDULER_MONITOR_TEAM';

    l_profile_attributes           CLOB;
    l_inspect_attributes           CLOB;
    l_scheduler_target_owner       VARCHAR2(128);
    l_count                        NUMBER;

    PROCEDURE assert_replaced(
        p_value IN VARCHAR2,
        p_name  IN VARCHAR2
    ) IS
    BEGIN
        IF p_value IS NULL OR REGEXP_LIKE(p_value, '^<[^>]+>$') THEN
            RAISE_APPLICATION_ERROR(-20000, 'Replace ' || p_name || ' before running this script.');
        END IF;
    END assert_replaced;

    PROCEDURE assert_package_valid(
        p_package_name IN VARCHAR2,
        p_script_name  IN VARCHAR2
    ) IS
    BEGIN
        SELECT COUNT(*)
        INTO l_count
        FROM user_objects
        WHERE object_name = UPPER(p_package_name)
          AND object_type IN ('PACKAGE', 'PACKAGE BODY')
          AND status = 'VALID';

        IF l_count < 2 THEN
            RAISE_APPLICATION_ERROR(
                -20001,
                'Missing or invalid package ' || p_package_name ||
                '. Run ' || p_script_name || ' first.'
            );
        END IF;
    END assert_package_valid;

    PROCEDURE assert_tool_exists(
        p_tool_name IN VARCHAR2,
        p_script_name IN VARCHAR2
    ) IS
    BEGIN
        SELECT COUNT(*)
        INTO l_count
        FROM user_ai_agent_tools
        WHERE tool_name = UPPER(p_tool_name);

        IF l_count = 0 THEN
            RAISE_APPLICATION_ERROR(
                -20002,
                'Missing Select AI Agent tool ' || p_tool_name ||
                '. Run ' || p_script_name || ' first.'
            );
        END IF;
    END assert_tool_exists;

    PROCEDURE drop_team_if_exists(
        p_team_name IN VARCHAR2
    ) IS
    BEGIN
        DBMS_CLOUD_AI_AGENT.DROP_TEAM(p_team_name, TRUE);
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END drop_team_if_exists;

    PROCEDURE drop_agent_if_exists(
        p_agent_name IN VARCHAR2
    ) IS
    BEGIN
        DBMS_CLOUD_AI_AGENT.DROP_AGENT(p_agent_name, TRUE);
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END drop_agent_if_exists;

    PROCEDURE drop_task_if_exists(
        p_task_name IN VARCHAR2
    ) IS
    BEGIN
        DBMS_CLOUD_AI_AGENT.DROP_TASK(p_task_name, TRUE);
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END drop_task_if_exists;

    PROCEDURE create_oci_autonomous_database_agent IS
    BEGIN
        drop_team_if_exists(c_oci_team_name);
        drop_agent_if_exists(c_oci_agent_name);
        drop_task_if_exists(c_oci_task_name);

        DBMS_CLOUD_AI_AGENT.CREATE_TASK(
            task_name   => c_oci_task_name,
            description => 'Task for provisioning and managing OCI Autonomous Databases.',
            attributes  => q'~{
              "instruction": "Identify the intent of the user request and determine the correct Autonomous Database operation. Prompt the user only for necessary missing details. Ask clarifying questions if intent is ambiguous. When presenting any list, object, or JSON structure to the user, format it in a human-readable way. Confirm destructive actions before execution. User request: {query}",
              "tools": [
                "LIST_SUBSCRIBED_REGIONS_TOOL",
                "LIST_COMPARTMENTS_TOOL",
                "GET_COMPARTMENT_OCID_BY_NAME_TOOL",
                "LIST_AUTONOMOUS_DATABASES_TOOL",
                "GET_AUTONOMOUS_DATABASE_DETAILS_TOOL",
                "ADBS_PROVISIONING_TOOL",
                "ADBS_UNPROVISION_TOOL",
                "START_AUTONOMOUS_DATABASE_TOOL",
                "STOP_AUTONOMOUS_DATABASE_TOOL",
                "DATABASE_RESTART_TOOL",
                "MANAGE_AUTONOMOUS_DB_POWER_TOOL",
                "UPDATE_AUTONOMOUS_DB_RESOURCES_TOOL",
                "GET_MAINTENANCE_RUN_HISTORY_TOOL",
                "UPDATE_AUTONOMOUS_DATABASE_TOOL",
                "LIST_KEY_STORES_TOOL",
                "LIST_DB_HOMES_TOOL",
                "SHRINK_AUTONOMOUS_DATABASE_TOOL",
                "DELETE_KEY_STORE_TOOL",
                "LIST_ACDS_TOOL",
                "LIST_ADB_BACKUPS_TOOL"
              ],
              "enable_human_tool": "true"
            }~'
        );

        DBMS_CLOUD_AI_AGENT.CREATE_AGENT(
            agent_name  => c_oci_agent_name,
            attributes  =>
                '{"profile_name":"' || c_profile_name || '",' ||
                '"role":"You are an OCI Autonomous Database Advisor. You help users provision, list, start/stop/restart, resize, update configuration, and inspect ADB-related resources safely. You confirm destructive actions and present results clearly."' ||
                '}',
            description => 'AI agent for advising and automating OCI Autonomous Database operations'
        );

        DBMS_CLOUD_AI_AGENT.CREATE_TEAM(
            team_name   => c_oci_team_name,
            description => 'Oracle sample OCI Autonomous Database AI Agent team.',
            attributes  => '{"agents":[{"name":"' || c_oci_agent_name || '","task":"' || c_oci_task_name || '"}],"process":"sequential"}'
        );
    END create_oci_autonomous_database_agent;

    PROCEDURE create_database_inspect_agent IS
    BEGIN
        BEGIN
            DATABASE_INSPECT.DROP_INSPECT_AGENT_TEAM(
                agent_team_name => c_inspect_team_name,
                force           => TRUE
            );
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;

        l_inspect_attributes :=
            '{"profile_name":"' || c_profile_name ||
            '","object_list":[{"owner":"' || c_schema_name ||
            '","type":"schema"}],"match_limit":10}';

        DATABASE_INSPECT.CREATE_INSPECT_AGENT_TEAM(
            agent_team_name => c_inspect_team_name,
            attributes      => l_inspect_attributes
        );
    END create_database_inspect_agent;

    PROCEDURE create_scheduler_monitor_agent IS
        l_task_attributes CLOB;
    BEGIN
        drop_team_if_exists(c_scheduler_team_name);
        drop_agent_if_exists(c_scheduler_agent_name);
        drop_task_if_exists(c_scheduler_task_name);

        l_scheduler_target_owner := UPPER(TRIM(NVL(c_scheduler_target_owner, c_schema_name)));
        l_task_attributes :=
            '{"instruction": "You are an Oracle DBMS_SCHEDULER monitoring expert. ' ||
            'Default owner label is ' || l_scheduler_target_owner || ' when owner is omitted. ' ||
            'This agent monitors USER_SCHEDULER_* objects in the install schema (local schema scope). ' ||
            'For schema-wide requests, auto-discover local jobs from USER_SCHEDULER metadata and do not ask users to provide object lists. ' ||
            'When user asks how many jobs or all job details, call LIST_ALL_JOBS_TOOL first and answer with count plus detailed rows. ' ||
            'If user asks for full list of jobs, return the complete job-name list from LIST_ALL_JOBS_TOOL rows (not a sample). ' ||
            'Do not show sample tables unless user explicitly asks for sample/top-N. ' ||
            'Never use ellipsis like dot-dot-dot (N more jobs) for full-list requests. ' ||
            'For full-list table requests, output every row from LIST_ALL_JOBS_TOOL rows. ' ||
            'If output is too large for one response, paginate deterministically as Page 1, Page 2, ... with fixed row ranges until all rows are shown. ' ||
            'Do not infer total jobs from job history or running jobs when LIST_ALL_JOBS_TOOL is available. ' ||
            'If user mentions another schema name, explain this agent is local-schema scoped (USER_SCHEDULER_*), then continue using current schema data unless cross-schema support is explicitly added. ' ||
            'Always return: executive summary, detailed tables, chart section, diagnostics, and recommendations. ' ||
            'For any relative date/time request (today, yesterday, last day, previous day, last week), call GET_DATABASE_CURRENT_TIME_TOOL first and derive interval boundaries from database time, not model time. ' ||
            'Use LIST_RUNNING_JOBS_TOOL for running jobs. ' ||
            'Use LIST_JOB_HISTORY_TOOL for historical interval analysis with success/failure and p95 metrics. ' ||
            'Use GET_JOB_DETAILS_TOOL for selected job metadata, args, schedule/program details, and recent run diagnostics. ' ||
            'Use ANALYZE_CPU_BY_JOB_TOOL and ANALYZE_LOAD_BY_JOB_TOOL for CPU and load correlation. ' ||
            'Use COMPARE_JOBS_TOOL when user asks comparison. ' ||
            'Use IDENTIFY_HOTSPOTS_TOOL for contention and overlap hotspots. ' ||
            'Use DETECT_FAILURES_TOOL for recurring failures and error patterns. ' ||
            'Use SUMMARIZE_SCHEDULER_HEALTH_TOOL for fleet overview. ' ||
            'Use GENERATE_CHARTS_TOOL for chart-ready output. ' ||
            'Use EXPORT_TABLES_TOOL for exportable table payloads. ' ||
            'Clearly label correlations as exact or inferred and include confidence level; do not overstate weak attribution. ' ||
            'If performance views are unavailable, say so and provide nearest proxy metrics. ' ||
            'User request: {query}",' ||
            '"tools": [' ||
            '"GET_DATABASE_CURRENT_TIME_TOOL",' ||
            '"LIST_ALL_JOBS_TOOL",' ||
            '"LIST_RUNNING_JOBS_TOOL",' ||
            '"LIST_JOB_HISTORY_TOOL",' ||
            '"GET_JOB_DETAILS_TOOL",' ||
            '"ANALYZE_CPU_BY_JOB_TOOL",' ||
            '"ANALYZE_LOAD_BY_JOB_TOOL",' ||
            '"COMPARE_JOBS_TOOL",' ||
            '"IDENTIFY_HOTSPOTS_TOOL",' ||
            '"DETECT_FAILURES_TOOL",' ||
            '"SUMMARIZE_SCHEDULER_HEALTH_TOOL",' ||
            '"GENERATE_CHARTS_TOOL",' ||
            '"EXPORT_TABLES_TOOL"],' ||
            '"enable_human_tool": "true"}';

        DBMS_CLOUD_AI_AGENT.CREATE_TASK(
            task_name   => c_scheduler_task_name,
            description => 'Task for Oracle DBMS_SCHEDULER monitoring, history, and CPU/load analysis',
            attributes  => l_task_attributes
        );

        DBMS_CLOUD_AI_AGENT.CREATE_AGENT(
            agent_name  => c_scheduler_agent_name,
            attributes  =>
                '{"profile_name":"' || c_profile_name || '",' ||
                '"role":"You are a senior Oracle scheduler operations and performance advisor. You diagnose running and historical scheduler behavior, correlate workload with CPU/load, and provide actionable operational recommendations."' ||
                '}',
            description => 'AI agent for DBMS_SCHEDULER monitoring and performance diagnostics'
        );

        DBMS_CLOUD_AI_AGENT.CREATE_TEAM(
            team_name   => c_scheduler_team_name,
            description => 'Oracle sample DBMS Scheduler Monitoring Agent team.',
            attributes  => '{"agents":[{"name":"' || c_scheduler_agent_name || '","task":"' || c_scheduler_task_name || '"}],"process":"sequential"}'
        );
    END create_scheduler_monitor_agent;

    PROCEDURE create_composite_team IS
    BEGIN
        drop_team_if_exists(c_composite_team_name);

        DBMS_CLOUD_AI_AGENT.CREATE_TEAM(
            team_name   => c_composite_team_name,
            description => 'Wingmate composite team for OCI ADB operations, database inspection, and scheduler monitoring.',
            attributes  =>
                '{"agents":[' ||
                '{"name":"' || c_oci_agent_name || '","task":"' || c_oci_task_name || '"},' ||
                '{"name":"' || c_inspect_agent_name || '","task":"' || c_inspect_task_name || '"},' ||
                '{"name":"' || c_scheduler_agent_name || '","task":"' || c_scheduler_task_name || '"}' ||
                '],"process":"sequential"}'
        );
    END create_composite_team;
BEGIN
    assert_replaced(c_genai_region, '<genai_region>');
    assert_replaced(c_compartment_ocid, '<compartment_ocid>');
    assert_replaced(c_chat_model, '<oci_genai_chat_model_name_or_ocid>');

    SELECT COUNT(*)
    INTO l_count
    FROM user_mining_models
    WHERE model_name = c_embedding_model;

    IF l_count = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20003,
            'Missing embedding model ' || c_embedding_model ||
            '. Run wingmate-doc-research-rag.sql first or load the model before creating the Database Inspect agent.'
        );
    END IF;

    assert_package_valid('OCI_AUTONOMOUS_DATABASE_AGENTS', 'prebuilt-select-ai-agents/oci_autonomous_database_tools.sql');
    assert_package_valid('DATABASE_INSPECT', 'prebuilt-select-ai-agents/database_inspect_tool.sql');
    assert_package_valid('SCHEDULER_MONITORING', 'prebuilt-select-ai-agents/dbms_scheduler_monitor_tools.sql');
    assert_package_valid('SELECT_AI_SCHEDULER_MONITOR', 'prebuilt-select-ai-agents/dbms_scheduler_monitor_tools.sql');

    assert_tool_exists('LIST_SUBSCRIBED_REGIONS_TOOL', 'prebuilt-select-ai-agents/oci_autonomous_database_tools.sql');
    assert_tool_exists('ADBS_PROVISIONING_TOOL', 'prebuilt-select-ai-agents/oci_autonomous_database_tools.sql');
    assert_tool_exists('LIST_ALL_JOBS_TOOL', 'prebuilt-select-ai-agents/dbms_scheduler_monitor_tools.sql');
    assert_tool_exists('GET_DATABASE_CURRENT_TIME_TOOL', 'prebuilt-select-ai-agents/dbms_scheduler_monitor_tools.sql');

    l_profile_attributes := JSON_OBJECT(
        'provider' VALUE 'oci',
        'credential_name' VALUE 'WINGMATE_OCI_CRED',
        'region' VALUE c_genai_region,
        'oci_compartment_id' VALUE c_compartment_ocid,
        'model' VALUE c_chat_model,
        'embedding_model' VALUE 'database: ' || c_embedding_model,
        'temperature' VALUE 0,
        'comments' VALUE 'true' FORMAT JSON
        RETURNING CLOB
    );

    BEGIN
        DBMS_CLOUD_AI.DROP_PROFILE(
            profile_name => c_profile_name,
            force        => TRUE
        );
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

    DBMS_CLOUD_AI.CREATE_PROFILE(
        profile_name => c_profile_name,
        description  => 'Wingmate profile for pre-built Select AI Agent teams.',
        attributes   => l_profile_attributes
    );

    create_oci_autonomous_database_agent;
    create_database_inspect_agent;
    create_scheduler_monitor_agent;
    create_composite_team;

    DBMS_OUTPUT.PUT_LINE('Created profile ' || c_profile_name || '.');
    DBMS_OUTPUT.PUT_LINE('Created standalone team ' || c_oci_team_name || '.');
    DBMS_OUTPUT.PUT_LINE('Created standalone team ' || c_inspect_team_name || '.');
    DBMS_OUTPUT.PUT_LINE('Created standalone team ' || c_scheduler_team_name || '.');
    DBMS_OUTPUT.PUT_LINE('Created composite team ' || c_composite_team_name || '.');
END;
/

PROMPT Verifying pre-built Select AI agents, tasks, and teams.

COLUMN agent_name FORMAT A48
COLUMN task_name FORMAT A48
COLUMN team_name FORMAT A48
COLUMN status FORMAT A12

SELECT agent_name, status
FROM user_ai_agents
WHERE agent_name IN (
    'OCI_AUTONOMOUS_DATABASE_ADVISOR',
    'INSPECT_AGENT_WINGMATE_DATABASE_INSPECT_TEAM',
    'SCHEDULER_MONITOR_ADVISOR'
)
ORDER BY agent_name;

SELECT task_name, status
FROM user_ai_agent_task
WHERE task_name IN (
    'OCI_AUTONOMOUS_DATABASE_TASKS',
    'INSPECT_TASK_WINGMATE_DATABASE_INSPECT_TEAM',
    'SCHEDULER_MONITOR_TASKS'
)
ORDER BY task_name;

SELECT team_name, status
FROM user_ai_agent_teams
WHERE team_name IN (
    'OCI_AUTONOMOUS_DATABASE_TEAM',
    'WINGMATE_DATABASE_INSPECT_TEAM',
    'DBMS_SCHEDULER_MONITOR_TEAM',
    'WINGMATE_PREBUILT_SELECT_AI_AGENT_TEAM'
)
ORDER BY team_name;

PROMPT
PROMPT To use the composite team:
PROMPT EXEC DBMS_CLOUD_AI_AGENT.SET_TEAM(team_name => 'WINGMATE_PREBUILT_SELECT_AI_AGENT_TEAM');
PROMPT SELECT AI AGENT inspect the WINGMATE schema and summarize scheduler jobs before recommending an Autonomous Database action
PROMPT
