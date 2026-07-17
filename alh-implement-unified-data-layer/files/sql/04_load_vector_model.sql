WHENEVER SQLERROR EXIT SQL.SQLCODE
SET DEFINE ON
SET VERIFY OFF
SET ECHO OFF
SET FEEDBACK ON

DEFINE model_object_uri = '&1'

BEGIN
  FOR m IN (
    SELECT model_name
    FROM user_mining_models
    WHERE model_name = 'ALL_MINILM_L12_V2'
  ) LOOP
    DBMS_VECTOR.DROP_ONNX_MODEL(
      model_name => m.model_name,
      force      => TRUE
    );
  END LOOP;
END;
/

BEGIN
  UTL_FILE.FREMOVE('ONNX_DIR', 'all_MiniLM_L12_v2.onnx');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE != -29283 THEN
      RAISE;
    END IF;
END;
/

BEGIN
  DBMS_CLOUD.GET_OBJECT(
    credential_name => 'OCI$RESOURCE_PRINCIPAL',
    directory_name  => 'ONNX_DIR',
    object_uri      => '&model_object_uri'
  );
END;
/

BEGIN
  DBMS_VECTOR.LOAD_ONNX_MODEL(
    directory  => 'ONNX_DIR',
    file_name  => 'all_MiniLM_L12_v2.onnx',
    model_name => 'ALL_MINILM_L12_V2'
  );
END;
/

UPDATE seer_gold.document_chunks
SET embedding = VECTOR_EMBEDDING(
      ALL_MINILM_L12_V2
      USING DBMS_LOB.SUBSTR(chunk_text, 4000, 1) AS DATA
    ),
    embedding_status = 'READY';

COMMIT;

SELECT model_name, algorithm, mining_function
FROM user_mining_models
WHERE model_name = 'ALL_MINILM_L12_V2';

PROMPT In-database embedding model loaded and document embeddings generated.
EXIT SUCCESS
