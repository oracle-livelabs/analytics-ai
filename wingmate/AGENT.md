# Wingmate LiveLabs Codex Handoff

## Working Context

Royce is a Master Principal Cloud Architect at Oracle on the Observability and Management Specialist team. The workshop is focused on OCI Observability and Management, Resource Analytics, AIOps/operations use cases, Oracle APEX, Oracle Database 26ai, and OCI Generative AI.

The repo is:

`/Users/jujufu/work/analytics-ai/wingmate`

Primary planning artifact:

`PLAN.md`

## Current Goal

Reorganize the Wingmate LiveLabs workshop into a Resource Analytics-first flow:

1. Lab 1: Provision OCI Resource Analytics and Prepare Wingmate Data
2. Lab 2: Build an Agentic Operations Wingmate with Oracle APEX and OCI Generative AI
3. Lab 3: Build a Security Wingmate Agent
4. Lab 4: Build a Multicloud Wingmate Agent
5. Lab 5: Build a Compute Wingmate Agent

This is a LiveLabs workshop reorganization. Preserve LiveLabs structure, keep instructional steps explicit, and do not invent APEX or database configuration details that require SME confirmation.

## Important Files

- `workshops/freetier/manifest.json`
- `1-introduction/introduction.md`
- `1-provision-resource-analytics/provision-resource-analytics.md`
- `2-build-operations-wingmate/build-operations-wingmate.md`
- `3-build-security-wingmate/build-security-wingmate.md`
- `4-build-multicloud-wingmate/build-multicloud-wingmate.md`
- `5-build-compute-wingmate/build-compute-wingmate.md`
- `ocira_dev_create_materialized_views.sql`
- `PLAN.md`

The markdown lab files previously had stash conflict markers. Before implementing, verify and resolve all:

- `<<<<<<<`
- `=======`
- `>>>>>>>`

## Key Decisions Already Made

- Lab 1 moves Resource Analytics setup from the current Lab 2.
- Lab 2 moves current APEX and GenAI setup from the current Lab 1, but must use the Resource Analytics-provisioned Autonomous AI Database instead of creating a standalone ADB.
- Lab 5 builds a Compute Wingmate Agent by combining Resource Analytics compute metadata with OCI compute metrics collected into Autonomous Database.
- Folder renaming is approved so lab numbers match content.
- `WINGMATE` is the intended database schema, APEX workspace, and APEX developer username unless SME changes it.
- Exact SQL and APEX configuration must not be invented.
- Sample SQL may be included only as SME-review draft content.

## Authoritative References

- Resource Analytics ADW user access:
  https://docs.oracle.com/en-us/iaas/Content/resource-analytics/manage-user-access-adw.htm
- Resource Analytics compute data model:
  https://docs.oracle.com/en-us/iaas/Content/resource-analytics/reference-compute.htm
- ShowOCI:
  https://github.com/oracle/oci-python-sdk/tree/master/examples/showoci
- Materialized view script:
  `/Users/jujufu/work/analytics-ai/wingmate/ocira_dev_create_materialized_views.sql`

## Lab 1 Direction

Lab 1 should prepare the Resource Analytics-backed data foundation for Wingmate.

It should include:

1. Configure Resource Analytics prerequisites.
2. Provision the Resource Analytics instance.
3. Open the Resource Analytics-provisioned Autonomous AI Database.
4. Create a dedicated `WINGMATE` database user/schema for the APEX app.
5. Grant Resource Analytics read access and app/schema privileges.
6. Create the APEX workspace using the existing `WINGMATE` schema.
7. Create curated materialized views on top of Resource Analytics views.
8. Load synthetic data.
9. Optionally connect RESTful OCI API data, such as Ops Insights REST endpoints.
10. Optionally load ShowOCI data after SME provides exact mapping and load instructions.

Resource Analytics ADW user setup should follow the Oracle doc:

- Resource Analytics objects are in the protected `OCIRA` schema.
- App users query Resource Analytics objects through the `OCIRA_RO` role.
- SQL Developer Web access should include `DWROLE`.

## Sample SQL For SME Review

Use this as draft content only. Do not treat it as final execution truth until SME confirms.

```sql
-- Connect as ADMIN to the Resource Analytics-provisioned ADW.
CREATE USER wingmate IDENTIFIED BY "<replace_with_strong_password>";

GRANT UNLIMITED TABLESPACE TO wingmate;

GRANT CREATE SESSION,
      CREATE TABLE,
      CREATE VIEW,
      CREATE MATERIALIZED VIEW,
      CREATE PROCEDURE,
      CREATE TRIGGER,
      CREATE SEQUENCE,
      CREATE SYNONYM,
      CREATE JOB
TO wingmate;

GRANT OCIRA_RO TO wingmate;
GRANT DWROLE TO wingmate;
```

```sql
-- Connect as WINGMATE before creating materialized views.
SELECT COUNT(*) AS compute_instances
FROM OCIRA.COMPUTE_INSTANCE_DIM_V;

SELECT COUNT(*) AS compartments
FROM OCIRA.COMPARTMENT_DIM_V;
```

```sql
-- SME-reviewed filtered pattern adapted from ocira_dev_create_materialized_views.sql.
SELECT view_name
FROM all_views
WHERE owner = 'OCIRA'
AND (
       view_name LIKE 'COMPUTE\_%' ESCAPE '\'
    OR view_name = 'INSTANCE_VOLUME_DETAILS_V'
    OR view_name IN ('TENANCY_DIM_V', 'COMPARTMENT_DIM_V', 'COMPARTMENT_HIERARCHY_V')
    OR view_name LIKE 'DBAAS\_%' ESCAPE '\'
    OR view_name LIKE 'BLOCK\_%' ESCAPE '\'
    OR view_name LIKE 'VCN\_%' ESCAPE '\'
    OR view_name IN ('NETWORK_RESOURCE_MAP_V', 'REGION_DIM_V', 'AD_DIM_V', 'TAGS_DIM_V')
)
ORDER BY view_name;
```

## Materialized View Script Notes

The current script:

- Expects schema `OCIRA_DEV`.
- Source owner is `OCIRA`.
- Creates `MV_<OCIRA_VIEW_NAME>`.
- Uses `BUILD IMMEDIATE`.
- Uses `REFRESH COMPLETE ON DEMAND`.
- Skips existing materialized views unless drop/recreate is enabled.
- Iterates all accessible `OCIRA` views.

Needed adaptation:

- Change expected schema to `WINGMATE`.
- Add a curated filter instead of creating materialized views for every accessible `OCIRA` view.
- Focus on compute, identity, database, block storage, networking, and related shared reference components.
- Keep preview mode available for SME review.
- Keep `l_drop_if_exists := false` unless SME approves otherwise.
- Confirm whether `UNLIMITED TABLESPACE`, grants, refresh mode, and selected view list are acceptable.

## Lab 2 Direction

Lab 2 should build the APEX and GenAI Wingmate app on top of the Resource Analytics-provisioned Autonomous AI Database / Autonomous AI Data Lakehouse.

It should include:

1. Use the `WINGMATE` APEX workspace created in Lab 1.
2. Generate API keys for the APEX app.
3. Configure APEX Web Credentials for OCI access.
4. Create the OCI Generative AI service object in APEX.
5. Run the bundled Select AI profile setup script and optional RAG Agent Team setup script from `wingmate_data/sql`.
6. Import the prebuilt Ask Oracle APEX application from the Oracle sample repository.
7. Validate the imported Ask Oracle application and Select AI profiles against Resource Analytics data and Lab 1 materialized views.

Do not invent exact APEX source queries, component mappings, assistant roles, region settings, RAG Source SQL, or AI Configuration behavior. Add SME TODO gates where exact details are unknown.

## Labs 3-5 Direction

Lab 3:

- Rename and normalize as `Build a Security Wingmate Agent`.
- Import `wingmate-page-02-security-overview.sql` into the Lab 2 Ask Oracle application as Page 2.
- Configure `wingmate_security_rag` with a RAG Source over `CIS_IAM_POLICIES_SV`.
- Update prerequisites and references so it depends on Lab 1 data preparation and Lab 2 APEX/GenAI setup.

Lab 4:

- Rename and normalize as `Build a Multicloud Wingmate Agent`.
- Import `wingmate-page-21-multicloud-overview.sql` into the Lab 2 Ask Oracle application as Page 21.
- Configure `wingmate_multicloud_rag` with host-insights, multicloud summary, and compute documentation RAG Sources.
- Update prerequisites and references so it depends on Lab 1 data preparation and Lab 2 APEX/GenAI setup.

Lab 5:

- Import `wingmate-page-05-oci-compute-wingmate.sql` into the Lab 2 Ask Oracle application as Page 5.
- Configure the Compute page using Resource Analytics materialized views or direct `OCIRA` schema views for compute metadata.
- Configure OCI Metrics Collector from `https://github.com/jujufugh/oci-metrics-collector-py`.
- Write compute CPU and memory metrics into the `WINGMATE` Autonomous Database schema.
- Create SQL overlay views that combine compute metadata with metrics.
- Add APEX visualization widgets and configure `wingmate_compute_rag` over `compute_wingmate_context_v`.
- Keep SME gates for Resource Analytics join columns, metric table mappings, and final RAG Source limits.

## Validation Gates

Before final commit:

- Validate `workshops/freetier/manifest.json` with `jq empty`.
- Confirm no conflict markers remain.
- Confirm all manifest markdown paths exist.
- Confirm all local image references resolve after folder renames.
- Search for stale lab numbering, old titles, and obsolete "previous lab" references.
- Confirm markdown code blocks are balanced.
- Confirm sample grants match Resource Analytics ADW user access guidance.
- Confirm `WINGMATE` can query `OCIRA.COMPUTE_INSTANCE_DIM_V`.
- Confirm `WINGMATE` can query `OCIRA.COMPARTMENT_DIM_V`.
- Preview materialized view DDL before execution.
- Validate APEX GenAI service steps against current Oracle APEX documentation.

Commit gate:

- Do not commit until static validation passes.
- Do not commit executable SQL/APEX instructions until SME confirms exact database user/role/grant SQL, materialized view list, APEX mappings, and Compute Wingmate metric overlay mappings.

## Collaboration Notes

- Keep the user involved before making high-impact content decisions.
- If APEX configuration, Resource Analytics view selection, SQL grants, or data model behavior is uncertain, stop and ask.
- Preserve unrelated user changes in the worktree.
- Prefer small, traceable edits and validate after each major content move.
