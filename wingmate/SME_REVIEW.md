# Wingmate SME Review Checklist

Use this checklist to convert the current draft workshop into final executable LiveLabs content. Items marked here should be confirmed by the Oracle subject matter expert before final commit or publication.

## Lab 1: Resource Analytics and Data Preparation

- **Approved:** Use `WINGMATE` as the database schema, APEX workspace, and APEX developer username.
- **Approved:** Use the current `ADMIN` SQL structure to create the `WINGMATE` user and grant application privileges, pending the separate tablespace/quota decision.
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

- Confirm APEX workspace sign-in flow against the Resource Analytics-provisioned Autonomous AI Database.
- Confirm Web Credential values, valid URL patterns, and regional endpoint guidance.
- Confirm approved OCI Generative AI model, region, compartment, and service object defaults.
- Confirm the first application page list and navigation structure.
- Confirm source objects for Operations Wingmate pages, including Resource Analytics materialized views and synthetic `CIS_` tables.
- Confirm SQL source queries for reports, dashboards, and assistant context.
- Confirm assistant prompt, page item names, context SQL, welcome message, and prompt examples.
- Confirm validation questions and expected responses.

## Lab 3: Security Wingmate

- Confirm final security source tables or views.
- Confirm whether Security Wingmate uses synthetic `CIS_` policy data, Resource Analytics identity views, or both.
- Confirm APEX page layout, region names, dynamic action settings, and screenshots.
- Confirm assistant prompt wording, welcome message, prompt examples, and expected validation responses.

## Lab 4: Multicloud Wingmate

- Confirm whether the existing host-insights and multicloud tables are still the approved data foundation.
- Confirm all table and view names used by the lab, including host insights, database, documentation-reference, and graph objects.
- Confirm SQL source queries for every report, chart, hidden item, computation, and graph region.
- Confirm copied page number assumptions and hidden page item names such as `P4_OCI_DOC_REF_COMPUTE`, `P4_OCI_HOSTINSIGHTS_DETAILS`, and `P4_OCI_DATABASE_DETAILS`.
- Confirm assistant prompt wording, welcome message, page context, and expected validation responses.
- Confirm whether the APEX Graph Visualization plug-in is required, where learners should download it, and how installation should be validated.

## Lab 5: Compute Wingmate

- Provide exact Compute Wingmate APEX page layout, screenshots, region types, and navigation placement.
- Provide approved Resource Analytics compute source views or materialized views.
- Provide SQL queries for compute inventory, capacity, utilization, block volume relationships, and compartment context.
- Provide assistant prompt, context item names, welcome message, and prompt examples.
- Provide validation questions, expected data points, screenshots, and troubleshooting notes.
