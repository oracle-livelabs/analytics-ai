# Wingmate SME Review Checklist

Use this checklist to convert the current draft workshop into final executable LiveLabs content. Items marked here should be confirmed by the Oracle subject matter expert before final commit or publication.

## Lab 1: Resource Analytics and Data Preparation

- **Approved:** Use `WINGMATE` as the database schema, APEX workspace, and APEX developer username.
- **Approved:** Use the current `ADMIN` SQL structure to create the `WINGMATE` user, grant application privileges, and enable the `WINGMATE` schema for Database Actions with `ords_admin.enable_schema`, pending the separate tablespace/quota decision.
- **Approved:** Use `GRANT UNLIMITED TABLESPACE TO wingmate;` for the workshop lab.
- **Approved:** Grant `CREATE SESSION`, `CREATE TABLE`, `CREATE VIEW`, `CREATE MATERIALIZED VIEW`, `CREATE PROCEDURE`, `CREATE TRIGGER`, `CREATE SEQUENCE`, `CREATE SYNONYM`, and `CREATE JOB` to `WINGMATE`.
- **Approved:** Grant both `OCIRA_RO` and `DWROLE` to `WINGMATE` for Resource Analytics read access and SQL Developer Web / Database Actions access.
- **Approved:** Validate `WINGMATE` Resource Analytics access with `OCIRA.COMPUTE_INSTANCE_DIM_V` and `OCIRA.COMPARTMENT_DIM_V` count queries.
- Confirm Task 5 APEX workspace screenshots match the approved existing-schema flow, including `WINGMATE` values and highlighting **Existing Schema** rather than **New Schema**.
- **Approved:** Use the current curated Resource Analytics materialized view starter set: all `COMPUTE_%` views, `INSTANCE_VOLUME_DETAILS_V`, and `TENANCY_DIM_V`, `COMPARTMENT_DIM_V`, `COMPARTMENT_HIERARCHY_V`, `REGION_DIM_V`, `AD_DIM_V`, and `TAGS_DIM_V`. Additional views may be added later for Security, Multicloud, or Operations mappings.
- **Approved:** Name materialized views `MV_<OCIRA_VIEW_NAME>`, use `BUILD IMMEDIATE`, use `REFRESH COMPLETE ON DEMAND`, skip existing materialized views, and include a manual refresh PL/SQL block.
- **Approved:** Keep the materialized view creation PL/SQL block embedded in Lab 1 so learners can copy and run it directly.
- **Approved:** Use the updated `wingmate_data.zip` Object Storage PAR link for the synthetic data package. Keep the current workflow: unzip the package, upload and run `wingmate-ddl.sql`, then load each dataset into the matching created table, starting with `CIS_IAM_POLICIES`.
- **Approved:** Keep RESTful OCI API endpoints optional in Lab 1 as a reusable pattern. Reference the REST API data source later in labs where Ops Insights or other OCI API context materially supports the agent workflow.
- **Approved:** Expand ShowOCI from future-scope to an optional Cloud Shell workflow. Scope the extract to compute, database, identity, networking, and related block-volume context with `python3 showoci.py -dt -c -d -i -n -csv $HOME/wingmate-showoci-output`. Use the CSV output as optional staging input for later Operations, Security, Multicloud, and Compute Wingmate labs. Final staging-table DDL and column mappings still need implementation validation against the generated CSV files.

## Lab 2: Operations Wingmate Foundation

- **Approved:** Use the Lab 2 APEX workspace sign-in flow against the Resource Analytics-provisioned Autonomous AI Database with workspace `WINGMATE`, username `WINGMATE`, and the password created in Lab 1.
- **Approved:** Use the Lab 2 Web Credential flow with OCI Native Authentication, Name `api_key`, Static ID `api_key`, and a region-aware Generative AI inference URL pattern. Keep Chicago as the concrete example.
- **Approved:** Use `OCI_GENAI` as the Generative AI service object name, `api_key` as the Web Credential, and `xai.grok-4.3` as the recommended default model. Add a note that the model's large context window is appropriate for richer Resource Analytics and application context. If `xai.grok-4.3` is not available in the subscribed region, use the closest tenancy-approved OCI Generative AI chat model.
- **Approved:** Lab 2 imports the prebuilt Ask Oracle APEX application from `ADB-AskOracle-Chatbot-2026-03-04.sql` in the Oracle Autonomous Database samples repository.
- **Approved:** Lab 2 uses bundled setup scripts under `wingmate_data/sql` for the Select AI profiles and optional RAG Agent Team setup instead of embedding all PL/SQL in the lab text.
- **Approved:** Labs 3, 4, and 5 import one page each into the Lab 2 Ask Oracle application from `wingmate_data/apex-pages`.
- Confirm the Ask Oracle import flow, supporting object prompts, parsing schema selection, and target application ID in the workshop environment.
- **Approved:** Use Resource Analytics materialized views as the primary Operations Wingmate starter sources: `MV_COMPUTE_INSTANCE_DIM_V`, `MV_COMPARTMENT_DIM_V`, `MV_REGION_DIM_V`, `MV_AD_DIM_V`, `MV_TAGS_DIM_V`, and `MV_INSTANCE_VOLUME_DETAILS_V`. Keep `CIS_IAM_POLICIES` as supporting security context rather than the primary Operations source.
- Confirm the final Select AI credential pattern for the lab environment: `DBMS_CLOUD.CREATE_CREDENTIAL` with API-key values, resource principal, or a lab-provided credential.
- Confirm the final OCI Generative AI Select AI profile attributes, including `provider`, `region`, `oci_compartment_id`, `model`, and `credential_name`.
- Confirm the three Lab 2 profile scopes:
  - `WINGMATE_SECURITY`: `CIS_IAM_POLICIES`, `CIS_IAM_POLICIES_SV`, and tenancy/compartment/tag materialized views.
  - `WINGMATE_MULTICLOUD`: multicloud inventory views, Exadata/VM cluster/CDB/PDB objects, documentation-reference objects, and host-insights fallback objects.
  - `WINGMATE_COMPUTE`: Resource Analytics compute materialized views, volume relationships, tenancy/compartment/region/AD/tag context, and host-insights fallback objects. Add `OCI_COMPUTE_METRICS` after the Lab 5 metrics collector creates it.
- Keep exploratory `SELECT *` source-query examples in Lab 2 until Resource Analytics column names are validated. Final report/dashboard SQL and assistant context SQL remain open.
- Keep open: define Ask Oracle default profile behavior, profile dropdown labels, prompt examples, and expected validation responses.
- **Approved:** Use the current Lab 2 foundation validation checks: app opens without authentication or authorization errors, Ask Oracle supporting objects compile as `VALID`, the three Wingmate Select AI profiles appear in `USER_CLOUD_AI_PROFILES`, and test questions can use the correct profile to generate SQL against the intended object scope.

## Lab 3: Security Wingmate

- **Approved:** Use `CIS_IAM_POLICIES` as the primary Security Wingmate source for Lab 3. Resource Analytics identity views and ShowOCI identity exports can be optional future/context sources.
- **Approved:** Import `wingmate-page-02-security-overview.sql` as Page 2 into the existing Lab 2 Ask Oracle application.
- **Approved:** Use the `wingmate_security_rag` AI Configuration with a RAG Source over `CIS_IAM_POLICIES_SV` instead of hidden page-item context injection.
- Confirm whether Security Wingmate uses synthetic `CIS_` policy data, Resource Analytics identity views, or both.
- Confirm APEX page layout, region names, dynamic action settings, and screenshots.
- Confirm assistant prompt wording, welcome message, prompt examples, and expected validation responses.

## Lab 4: Multicloud Wingmate

- **Approved:** Use the existing host-insights and multicloud objects as the Lab 4 data foundation: `oci_exa_infr`, `oci_exa_vm_cluster`, `oci_cdb`, `oci_pdb`, `CIS_MULTICLOUD_DETAILS_V`, `HOSTINSIGHTS_REPORT_PERIOD`, `HOSTINSIGHTS_CPU_USAGE_SUMMARY`, `HOSTINSIGHTS_MEMORY_USAGE_SUMMARY`, `HOSTINSIGHTS_RES_STAT`, `HOSTINSIGHTS_RES_STAT_MEMORY`, `HOSTINSIGHTS_CPU_FORECAST_TREND`, `hostinsights_report_sv`, `oci_doc_ref_compute_sv`, and `MULTICLOUD_GRAPH`.
- **Approved:** Import `wingmate-page-21-multicloud-overview.sql` as Page 21 into the existing Lab 2 Ask Oracle application.
- **Approved:** Use the `wingmate_multicloud_rag` AI Configuration with RAG Sources for host insights, multicloud summary, and compute documentation reference context instead of hidden page-item context injection.
- Confirm all table and view names used by the lab, including host insights, database, documentation-reference, and graph objects.
- Confirm SQL source queries for every report, chart, RAG Source, and graph region.
- Confirm imported page number assumptions and AI Configuration static IDs.
- Confirm assistant role wording, welcome message, RAG context, and expected validation responses.
- Confirm whether the APEX Graph Visualization plug-in is required, where learners should download it, and how installation should be validated.

## Lab 5: Compute Wingmate

- **Approved:** Import `wingmate-page-05-oci-compute-wingmate.sql` as Page 5 into the existing Lab 2 Ask Oracle application.
- **Approved:** Use the `wingmate_compute_rag` AI Configuration with a RAG Source over `compute_wingmate_context_v` instead of direct assistant context SQL.
- Provide exact Compute Wingmate APEX page layout, screenshots, region types, and navigation placement.
- Provide approved Resource Analytics compute source views or materialized views.
- Provide SQL queries for compute inventory, capacity, utilization, block volume relationships, and compartment context.
- Provide assistant role wording, RAG Source SQL, welcome message, and prompt examples.
- Provide validation questions, expected data points, screenshots, and troubleshooting notes.
