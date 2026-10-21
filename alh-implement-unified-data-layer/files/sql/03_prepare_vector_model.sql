WHENEVER SQLERROR EXIT SQL.SQLCODE
SET DEFINE ON
SET VERIFY OFF
SET ECHO OFF
SET FEEDBACK ON

DEFINE workshop_user = '&1'

CREATE OR REPLACE DIRECTORY onnx_dir AS 'onnx_model';
GRANT READ, WRITE ON DIRECTORY onnx_dir TO &workshop_user;
GRANT SELECT, UPDATE ON seer_gold.document_chunks TO &workshop_user;

PROMPT Vector model directory and temporary document-chunk privileges prepared.
EXIT SUCCESS
