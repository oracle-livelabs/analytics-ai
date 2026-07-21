WHENEVER SQLERROR EXIT SQL.SQLCODE
SET DEFINE ON
SET VERIFY OFF
SET ECHO OFF
SET FEEDBACK ON

DEFINE workshop_user = '&1'

CREATE VECTOR INDEX seer_gold.document_chunks_hnsw_idx
  ON seer_gold.document_chunks (embedding)
  ORGANIZATION INMEMORY NEIGHBOR GRAPH
  DISTANCE COSINE
  WITH TARGET ACCURACY 95;

BEGIN
  FOR t IN (
    SELECT owner, table_name
    FROM all_tables
    WHERE owner IN ('SEER_BRONZE', 'SEER_SILVER', 'SEER_GOLD')
  ) LOOP
    EXECUTE IMMEDIATE
      'GRANT SELECT ON ' || DBMS_ASSERT.ENQUOTE_NAME(t.owner) || '.' ||
      DBMS_ASSERT.ENQUOTE_NAME(t.table_name) || ' TO ' ||
      DBMS_ASSERT.ENQUOTE_NAME(UPPER('&workshop_user'));
  END LOOP;
END;
/

SELECT owner, object_type, COUNT(*) AS object_count
FROM all_objects
WHERE owner IN ('SEER_BRONZE', 'SEER_SILVER', 'SEER_GOLD')
  AND object_type IN ('TABLE', 'INDEX')
GROUP BY owner, object_type
ORDER BY owner, object_type;

PROMPT Workshop grants and vector index are ready.
EXIT SUCCESS
