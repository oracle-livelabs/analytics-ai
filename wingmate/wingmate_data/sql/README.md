# Wingmate SQL Scripts

This folder contains the SQL setup scripts used by the Wingmate LiveLab. Do not run the files alphabetically. Follow the run order in the lab guide because some scripts depend on credentials, database grants, loaded CSV data, or ADMIN-installed tool packages.

## Learner Run Order

| Order | File | Run As | Used In | Purpose |
| --- | --- | --- | --- | --- |
| 1 | `wingmate_ddl.sql` | `WINGMATE` | Lab 1, Task 7 | Creates the local Wingmate tables and support views used by the synthetic CSV load, security context, multicloud inventory, host insights, and compute lab data. |
| 2 | `wingmate-select-ai-profiles.sql` | `WINGMATE` | Lab 2, Task 5 | Creates the `WINGMATE_OCI_CRED` credential and the `WINGMATE_SECURITY`, `WINGMATE_MULTICLOUD`, and `WINGMATE_COMPUTE` Select AI NL2SQL profiles. |
| 3 | `wingmate-doc-research-rag.sql` | `WINGMATE` | Lab 2, Task 6 | Creates `WINGMATE_DOC_RESEARCH_RAG`, loads the in-database embedding model when needed, and builds the vector index over the Object Storage documentation reference CSV. |
| 4 | `prebuilt-select-ai-agents/oci_autonomous_database_tools.sql` | `ADMIN` | Lab 2, Task 7 | Installs the OCI Autonomous Database tool package and Select AI tool definitions into the `WINGMATE` schema. |
| 5 | `prebuilt-select-ai-agents/dbms_scheduler_monitor_tools.sql` | `ADMIN` | Lab 2, Task 7 | Installs the DBMS Scheduler monitoring tool package and Select AI tool definitions into the `WINGMATE` schema. |
| 6 | `wingmate-prebuilt-select-ai-agent-team.sql` | `WINGMATE` | Lab 2, Task 7 | Creates `WINGMATE_PREBUILT_SELECT_AI_AGENT_TEAM` for Autonomous Database provisioning and lifecycle requests, plus `DBMS_SCHEDULER_MONITOR_TEAM` for scheduler diagnostics. |
| 7 | `wingmate-multicloud-graph.sql` | `WINGMATE` | Lab 4, Task 1 and Task 6 | Creates deterministic Exadata, VM cluster, CDB, and PDB relationship tables, then creates the `MULTICLOUD_GRAPH` SQL property graph used by the APEX Graph Visualization plug-in. |

## Convenience and Reference Files

| File | Used In | Notes |
| --- | --- | --- |
| `wingmate-prebuilt-select-ai-agent-tools.sql` | Lab 2, Task 7 note | SQLcl or SQL*Plus convenience wrapper that runs the two ADMIN tool scripts with `@@` relative includes. SQL Developer Web users should run the two tool scripts directly instead. |
| `prebuilt-select-ai-agents/create-database-provisioning-agent-team.sql` | Not called by the current learner steps | Alternate copy of the Wingmate pre-built Agent Team installer kept for users who prefer the database-provisioning file name. The current lab uses `wingmate-prebuilt-select-ai-agent-team.sql`. |

## Folder Notes

- The `prebuilt-select-ai-agents` folder contains the vendored Oracle Select AI Agent tool scripts that the Wingmate AI Ops flow depends on.
- The APEX page imports live in `wingmate_data/apex-pages`, not this folder.
- The CSV files loaded by Lab 1 live in `wingmate_data/data`, not this folder.
- The Object Storage PAR or authenticated URI used by the documentation RAG setup is supplied in the lab guide, not embedded in these scripts.
