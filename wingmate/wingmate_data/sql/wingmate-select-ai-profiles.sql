set define off verify off feedback on
prompt Wingmate Select AI profile setup
prompt Replace every <placeholder> value before running this script as WINGMATE.

prompt Creating WINGMATE_OCI_CRED
BEGIN
    DBMS_CLOUD.DROP_CREDENTIAL(
        credential_name => 'WINGMATE_OCI_CRED'
    );
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

BEGIN
    DBMS_CLOUD.CREATE_CREDENTIAL(
        credential_name => 'WINGMATE_OCI_CRED',
        user_ocid       => '<oci_user_ocid>',
        tenancy_ocid    => '<oci_tenancy_ocid>',
        private_key     => '<full_private_key_text>',
        fingerprint     => '<api_key_fingerprint>'
    );
END;
/

prompt Creating WINGMATE_SECURITY
BEGIN
    DBMS_CLOUD_AI.DROP_PROFILE(
        profile_name => 'WINGMATE_SECURITY',
        force        => TRUE
    );
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

BEGIN
    DBMS_CLOUD_AI.CREATE_PROFILE(
        profile_name => 'WINGMATE_SECURITY',
        description  => 'Security Wingmate profile for IAM policy review, CIS findings, tenancy, compartment, and tag context.',
        attributes   => q'~{
            "provider": "oci",
            "credential_name": "WINGMATE_OCI_CRED",
            "region": "<genai_region>",
            "oci_compartment_id": "<compartment_ocid>",
            "model": "<oci_genai_chat_model_name_or_ocid>",
            "comments": true,
            "temperature": 0,
            "object_list": [
                {"owner":"WINGMATE","name":"CIS_IAM_POLICIES"},
                {"owner":"WINGMATE","name":"CIS_IAM_POLICIES_SV"},
                {"owner":"WINGMATE","name":"MV_TENANCY_DIM_V"},
                {"owner":"WINGMATE","name":"MV_COMPARTMENT_DIM_V"},
                {"owner":"WINGMATE","name":"MV_COMPARTMENT_HIERARCHY_V"},
                {"owner":"WINGMATE","name":"MV_REGION_DIM_V"},
                {"owner":"WINGMATE","name":"MV_TAGS_DIM_V"}
            ]
        }~'
    );
END;
/

prompt Creating WINGMATE_MULTICLOUD
BEGIN
    DBMS_CLOUD_AI.DROP_PROFILE(
        profile_name => 'WINGMATE_MULTICLOUD',
        force        => TRUE
    );
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

BEGIN
    DBMS_CLOUD_AI.CREATE_PROFILE(
        profile_name => 'WINGMATE_MULTICLOUD',
        description  => 'Multicloud Wingmate profile for Exadata, VM clusters, database inventory, multicloud views, and host insights.',
        attributes   => q'~{
            "provider": "oci",
            "credential_name": "WINGMATE_OCI_CRED",
            "region": "<genai_region>",
            "oci_compartment_id": "<compartment_ocid>",
            "model": "<oci_genai_chat_model_name_or_ocid>",
            "comments": true,
            "temperature": 0,
            "object_list": [
                {"owner":"WINGMATE","name":"CIS_MULTICLOUD_DETAILS_V"},
                {"owner":"WINGMATE","name":"RA_MULTICLOUD_DETAILS_V"},
                {"owner":"WINGMATE","name":"RA_MULTICLOUD_INVENTORY_V"},
                {"owner":"WINGMATE","name":"OCI_EXA_INFR"},
                {"owner":"WINGMATE","name":"OCI_EXA_VM_CLUSTER"},
                {"owner":"WINGMATE","name":"OCI_CDB"},
                {"owner":"WINGMATE","name":"OCI_PDB"},
                {"owner":"WINGMATE","name":"OCI_DOC_REF"},
                {"owner":"WINGMATE","name":"OCI_DOC_REF_COMPUTE_SV"},
                {"owner":"WINGMATE","name":"HOSTINSIGHTS_REPORT_PERIOD"},
                {"owner":"WINGMATE","name":"HOSTINSIGHTS_CPU_USAGE_SUMMARY"},
                {"owner":"WINGMATE","name":"HOSTINSIGHTS_MEMORY_USAGE_SUMMARY"},
                {"owner":"WINGMATE","name":"HOSTINSIGHTS_RES_STAT"},
                {"owner":"WINGMATE","name":"HOSTINSIGHTS_RES_STAT_MEMORY"},
                {"owner":"WINGMATE","name":"HOSTINSIGHTS_CPU_FORECAST_TREND"},
                {"owner":"WINGMATE","name":"HOSTINSIGHTS_REPORT_SV"}
            ]
        }~'
    );
END;
/

prompt Creating WINGMATE_COMPUTE
BEGIN
    DBMS_CLOUD_AI.DROP_PROFILE(
        profile_name => 'WINGMATE_COMPUTE',
        force        => TRUE
    );
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

BEGIN
    DBMS_CLOUD_AI.CREATE_PROFILE(
        profile_name => 'WINGMATE_COMPUTE',
        description  => 'Compute Wingmate profile for Resource Analytics compute inventory, capacity, utilization, metrics, volumes, and compartment context.',
        attributes   => q'~{
            "provider": "oci",
            "credential_name": "WINGMATE_OCI_CRED",
            "region": "<genai_region>",
            "oci_compartment_id": "<compartment_ocid>",
            "model": "<oci_genai_chat_model_name_or_ocid>",
            "comments": true,
            "temperature": 0,
            "object_list": [
                {"owner":"WINGMATE","name":"MV_COMPUTE_INSTANCE_DIM_V"},
                {"owner":"WINGMATE","name":"MV_INSTANCE_VOLUME_DETAILS_V"},
                {"owner":"WINGMATE","name":"MV_TENANCY_DIM_V"},
                {"owner":"WINGMATE","name":"MV_COMPARTMENT_DIM_V"},
                {"owner":"WINGMATE","name":"MV_COMPARTMENT_HIERARCHY_V"},
                {"owner":"WINGMATE","name":"MV_REGION_DIM_V"},
                {"owner":"WINGMATE","name":"MV_AD_DIM_V"},
                {"owner":"WINGMATE","name":"MV_TAGS_DIM_V"},
                {"owner":"WINGMATE","name":"HOSTINSIGHTS_CPU_USAGE_SUMMARY"},
                {"owner":"WINGMATE","name":"HOSTINSIGHTS_MEMORY_USAGE_SUMMARY"},
                {"owner":"WINGMATE","name":"HOSTINSIGHTS_CPU_FORECAST_TREND"}
            ]
        }~'
    );
END;
/

prompt Validating profiles
SELECT profile_name, status, description
FROM user_cloud_ai_profiles
WHERE profile_name IN (
    'WINGMATE_SECURITY',
    'WINGMATE_MULTICLOUD',
    'WINGMATE_COMPUTE'
)
ORDER BY profile_name;

SELECT profile_name,
       attribute_name,
       DBMS_LOB.SUBSTR(attribute_value, 300, 1) AS attribute_value
FROM user_cloud_ai_profile_attributes
WHERE profile_name IN (
    'WINGMATE_SECURITY',
    'WINGMATE_MULTICLOUD',
    'WINGMATE_COMPUTE'
)
AND attribute_name = 'object_list'
ORDER BY profile_name;

prompt Wingmate Select AI profile setup complete.
