set define off verify off feedback on serveroutput on
prompt Deprecated Wingmate combined RAG + Agent Team setup script.
prompt This file is intentionally non-destructive.
prompt Use sql/wingmate-doc-research-rag.sql to create the Doc Research RAG service.
prompt Use sql/wingmate-ai-ops-adb-agent-team.sql to create the AI Ops ADB Agent Team.
prompt The previous version of this file created a legacy combined RAG and notification flow.
prompt That model has been replaced by a separate Doc Research RAG service and an ADB provisioning Agent Team.

BEGIN
    DBMS_OUTPUT.PUT_LINE('No setup was run from wingmate-rag-agent-team-optional.sql.');
    DBMS_OUTPUT.PUT_LINE('Run wingmate-doc-research-rag.sql for RAG or wingmate-ai-ops-adb-agent-team.sql for AI Ops if your ADB supports Select AI Agent.');
END;
/
