set define off verify off feedback on serveroutput on
prompt Wingmate Doc Research RAG setup v2026-06-05
prompt Uses OCI GenAI for chat and an in-database ONNX transformer for RAG embeddings.
prompt Replace every <placeholder> value before running this script as WINGMATE.

prompt Creating Doc Research RAG profile and vector index.
DECLARE
    c_profile_name                CONSTANT VARCHAR2(128)  := 'WINGMATE_DOC_RESEARCH_RAG';
    c_vector_index_name           CONSTANT VARCHAR2(128)  := 'WINGMATE_DOC_RESEARCH_VECIDX';
    c_vector_table_name           CONSTANT VARCHAR2(128)  := 'WINGMATE_DOC_RESEARCH_VECTAB';
    c_db_embedding_model          CONSTANT VARCHAR2(128)  := 'ALL_MINILM_L12_V2';
    c_db_embedding_model_file     CONSTANT VARCHAR2(512)  := 'all_MiniLM_L12_v2.onnx';
    c_db_embedding_model_uri      CONSTANT VARCHAR2(4000) :=
        'https://adwc4pm.objectstorage.us-ashburn-1.oci.customer-oci.com/p/eLddQappgBJ7jNi6Guz9m9LOtYe2u8LWY19GfgU8flFK4N9YgP4kTlrE9Px3pE12/n/adwc4pm/b/OML-Resources/o/all_MiniLM_L12_v2.onnx';
    c_db_embedding_directory      CONSTANT VARCHAR2(128)  := 'DATA_PUMP_DIR';
    c_embedding_vector_dimension  CONSTANT NUMBER         := 384;
    c_genai_region                CONSTANT VARCHAR2(256)  := '<genai_region>';
    c_compartment_ocid            CONSTANT VARCHAR2(1024) := '<compartment_ocid>';
    c_chat_model                  CONSTANT VARCHAR2(1024) := '<oci_genai_chat_model_name_or_ocid>';
    c_object_storage_doc_uri      CONSTANT VARCHAR2(4000) := '<object_storage_doc_uri>';

    l_profile_attributes          CLOB;
    l_vector_attributes           CLOB;
    l_model_count                 NUMBER;

    PROCEDURE assert_replaced(
        p_value IN VARCHAR2,
        p_name  IN VARCHAR2
    ) IS
    BEGIN
        IF p_value IS NULL OR REGEXP_LIKE(p_value, '^<[^>]+>$') THEN
            RAISE_APPLICATION_ERROR(
                -20000,
                'Replace ' || p_name || ' before running this script.'
            );
        END IF;
    END assert_replaced;
BEGIN
    assert_replaced(c_genai_region, '<genai_region>');
    assert_replaced(c_compartment_ocid, '<compartment_ocid>');
    assert_replaced(c_chat_model, '<oci_genai_chat_model_name_or_ocid>');
    assert_replaced(c_object_storage_doc_uri, '<object_storage_doc_uri>');

    SELECT COUNT(*)
    INTO l_model_count
    FROM user_mining_models
    WHERE model_name = c_db_embedding_model;

    IF l_model_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Loading in-database embedding model ' || c_db_embedding_model || '.');

        BEGIN
            DBMS_CLOUD.GET_OBJECT(
                credential_name => NULL,
                directory_name  => c_db_embedding_directory,
                object_uri      => c_db_embedding_model_uri
            );
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(
                    'Model download did not complete: ' || SQLERRM
                );
                DBMS_OUTPUT.PUT_LINE(
                    'Trying to load from an existing ' ||
                    c_db_embedding_model_file || ' in ' ||
                    c_db_embedding_directory || '.'
                );
        END;

        BEGIN
            EXECUTE IMMEDIATE q'~
                BEGIN
                    DBMS_VECTOR.LOAD_ONNX_MODEL(
                        directory  => :directory_name,
                        file_name  => :file_name,
                        model_name => :model_name
                    );
                END;
            ~' USING
                c_db_embedding_directory,
                c_db_embedding_model_file,
                c_db_embedding_model;
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(
                    -20001,
                    'Unable to load in-database embedding model ' ||
                    c_db_embedding_model || '. Verify EXECUTE on DBMS_VECTOR, ' ||
                    'access to ' || c_db_embedding_directory || ', and the ONNX file. ' ||
                    SQLERRM
                );
        END;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Using existing in-database embedding model ' || c_db_embedding_model || '.');
    END IF;

    l_profile_attributes := JSON_OBJECT(
        'provider' VALUE 'oci',
        'credential_name' VALUE 'WINGMATE_OCI_CRED',
        'region' VALUE c_genai_region,
        'oci_compartment_id' VALUE c_compartment_ocid,
        'model' VALUE c_chat_model,
        'embedding_model' VALUE 'database: ' || c_db_embedding_model,
        'temperature' VALUE 0,
        'comments' VALUE 'true' FORMAT JSON,
        'vector_index_name' VALUE c_vector_index_name
    );

    l_vector_attributes := JSON_OBJECT(
        'vector_db_provider' VALUE 'oracle',
        'location' VALUE c_object_storage_doc_uri,
        'object_storage_credential_name' VALUE 'WINGMATE_OCI_CRED',
        'profile_name' VALUE c_profile_name,
        'vector_table_name' VALUE c_vector_table_name,
        'vector_dimension' VALUE c_embedding_vector_dimension,
        'vector_distance_metric' VALUE 'COSINE',
        'chunk_size' VALUE 1024,
        'chunk_overlap' VALUE 128
    );

    BEGIN
        DBMS_CLOUD_AI.DROP_VECTOR_INDEX(
            index_name   => c_vector_index_name,
            include_data => TRUE,
            force        => TRUE
        );
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;

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
        description  => 'Doc Research RAG profile for Wingmate documentation-grounded OCI answers.',
        attributes   => l_profile_attributes
    );

    BEGIN
        DBMS_CLOUD_AI.CREATE_VECTOR_INDEX(
            index_name          => c_vector_index_name,
            description         => 'Doc Research RAG vector index for Wingmate OCI documentation reference data.',
            status              => 'ENABLED',
            attributes          => l_vector_attributes,
            wait_for_completion => TRUE
        );
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Vector index creation failed: ' || SQLERRM);
            DBMS_OUTPUT.PUT_LINE(
                'This script uses database embeddings. If the error still references ' ||
                '/actions/embedText, upload and run this updated script version.'
            );
            DBMS_OUTPUT.PUT_LINE(
                'Verify ' || c_db_embedding_model ||
                ' exists in USER_MINING_MODELS and that WINGMATE_OCI_CRED can read ' ||
                c_object_storage_doc_uri || '.'
            );
            RETURN;
    END;

    DBMS_OUTPUT.PUT_LINE('Doc Research RAG setup complete: created ' ||
                         c_profile_name || ' and ' || c_vector_index_name || '.');
END;
/

prompt Validating in-database embedding model.
SELECT model_name, algorithm, mining_function
FROM user_mining_models
WHERE model_name = 'ALL_MINILM_L12_V2';

prompt Validating Doc Research RAG profile and vector index.
SELECT profile_name, status, description
FROM user_cloud_ai_profiles
WHERE profile_name = 'WINGMATE_DOC_RESEARCH_RAG';

SELECT index_name, status
FROM user_cloud_vector_indexes
WHERE index_name = 'WINGMATE_DOC_RESEARCH_VECIDX';

DECLARE
    l_index_count NUMBER;
    l_chunk_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO l_index_count
    FROM user_cloud_vector_indexes
    WHERE index_name = 'WINGMATE_DOC_RESEARCH_VECIDX';

    IF l_index_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('WINGMATE_DOC_RESEARCH_VECIDX was not created. Fix the earlier error before checking chunks.');
        RETURN;
    END IF;

    BEGIN
        EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM WINGMATE_DOC_RESEARCH_VECTAB'
        INTO l_chunk_count;
        DBMS_OUTPUT.PUT_LINE('Indexed chunks: ' || l_chunk_count);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('WINGMATE_DOC_RESEARCH_VECTAB is not available yet: ' || SQLERRM);
    END;
END;
/

prompt Wingmate Doc Research RAG setup complete.
