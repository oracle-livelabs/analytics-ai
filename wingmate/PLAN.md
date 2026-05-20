# Wingmate LiveLabs Reorganization Plan

## Summary

Reorganize the Wingmate LiveLabs workshop into a Resource Analytics-first flow:

1. Lab 1: Provision OCI Resource Analytics and Prepare Wingmate Data
2. Lab 2: Build an Agentic Operations Wingmate with Oracle APEX and OCI Generative AI
3. Lab 3: Build a Security Wingmate Agent
4. Lab 4: Build a Multicloud Wingmate Agent
5. Lab 5: Build a Compute Wingmate Agent

The implementation must preserve the existing LiveLabs structure, resolve current stash conflict markers, update the manifest, and avoid inventing exact APEX configuration or Resource Analytics data model details. Where exact SQL, grants, views, prompts, or APEX component mappings are not known, add explicit SME review gates and sample SQL for review.

## Important References

- Resource Analytics ADW user access:
  https://docs.oracle.com/en-us/iaas/Content/resource-analytics/manage-user-access-adw.htm
- Resource Analytics compute data model:
  https://docs.oracle.com/en-us/iaas/Content/resource-analytics/reference-compute.htm
- ShowOCI:
  https://github.com/oracle/oci-python-sdk/tree/master/examples/showoci
- Materialized view script:
  `/Users/jujufu/work/analytics-ai/wingmate/ocira_dev_create_materialized_views.sql`

## Key Decisions

- Lab 1 moves Resource Analytics setup from the current Lab 2.
- Lab 2 moves current APEX and GenAI app setup from the current Lab 1, but uses the Resource Analytics-provisioned Autonomous AI Database instead of provisioning a standalone ADB.
- Lab 5 is added as a visible stub because exact Compute Wingmate content is not available yet.
- Folder renaming is approved so lab numbers match content.
- `WINGMATE` is the intended database schema, APEX workspace, and APEX developer username unless SME changes it.
- Exact SQL and APEX configuration must be reviewed by SME before final commit.

## Manifest And Folder Plan

Update `workshops/freetier/manifest.json` to this lab order:

1. `Lab 1: Provision OCI Resource Analytics and Prepare Wingmate Data`
2. `Lab 2: Build an Agentic Operations Wingmate with Oracle APEX and OCI Generative AI`
3. `Lab 3: Build a Security Wingmate Agent`
4. `Lab 4: Build a Multicloud Wingmate Agent`
5. `Lab 5: Build a Compute Wingmate Agent`

Use `git mv` so folder names match the new order. The implementation target paths are:

- `1-provision-resource-analytics/provision-resource-analytics.md`
- `2-build-operations-wingmate/build-operations-wingmate.md`
- `3-build-security-wingmate/build-security-wingmate.md`
- `4-build-multicloud-wingmate/build-multicloud-wingmate.md`
- `5-build-compute-wingmate/build-compute-wingmate.md`

## Lab 1 Plan

Lab 1 should prepare the Resource Analytics-backed data foundation for Wingmate.

Tasks:

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

Resource Analytics ADW user setup must follow the ADW user access documentation:

- Resource Analytics objects are in the protected `OCIRA` schema.
- App users query Resource Analytics objects through the `OCIRA_RO` role.
- SQL Developer Web access should include `DWROLE`.

### Sample SQL For SME Review

Use this as draft content for the lab, not as final execution truth until SME confirms.

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
-- Goal: create MV_<OCIRA_VIEW_NAME> in WINGMATE only for Wingmate-relevant Resource Analytics views.

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

### Materialized View Script Notes

The current script:

- Expects schema `OCIRA_DEV`.
- Source owner is `OCIRA`.
- Creates `MV_<OCIRA_VIEW_NAME>`.
- Uses `BUILD IMMEDIATE`.
- Uses `REFRESH COMPLETE ON DEMAND`.
- Skips existing materialized views unless drop/recreate is enabled.
- Iterates all accessible `OCIRA` views.

Needed changes:

- Change expected schema to `WINGMATE`.
- Add a curated filter instead of creating materialized views for every accessible `OCIRA` view.
- Focus on compute, identity, database, block storage, networking, and related shared reference components.
- Keep preview mode available for SME review.
- Keep `l_drop_if_exists := false` unless SME approves otherwise.
- Confirm whether `UNLIMITED TABLESPACE`, grants, refresh mode, and selected view list are acceptable.

## Lab 2 Plan

Lab 2 should build the APEX and GenAI Wingmate app on top of the Resource Analytics-provisioned Autonomous AI Database / Autonomous AI Data Lakehouse.

Tasks:

1. Use the `WINGMATE` APEX workspace created in Lab 1.
2. Generate API keys for the APEX app.
3. Configure APEX Web Credentials for OCI access.
4. Create the OCI Generative AI service object in APEX.
5. Create the Wingmate APEX application using Resource Analytics data and Lab 1 materialized views.

Do not invent the exact APEX source queries, component mappings, assistant prompts, region settings, hidden items, or page computations. Add SME TODO gates where exact details are unknown.

## Labs 3-5 Plan

Lab 3:

- Rename and normalize as `Build a Security Wingmate Agent`.
- Update prerequisites and references so it depends on Lab 1 data preparation and Lab 2 APEX/GenAI setup.

Lab 4:

- Rename and normalize as `Build a Multicloud Wingmate Agent`.
- Update prerequisites and references so it depends on Lab 1 data preparation and Lab 2 APEX/GenAI setup.

Lab 5:

- Add a new stub lab titled `Build a Compute Wingmate Agent`.
- Include only overview, objectives, prerequisites, and explicit SME TODOs.
- SME TODOs must request exact APEX steps, SQL/views/materialized views, assistant prompt, screenshots, and validation steps.

## Validation Plan

Static validation:

- Validate manifest JSON:
  `jq empty workshops/freetier/manifest.json`
- Confirm no unresolved conflict markers:
  `<<<<<<<`, `=======`, `>>>>>>>`
- Confirm all manifest markdown paths exist.
- Confirm all local image references resolve after folder renames.
- Search for stale lab numbering, old titles, and obsolete "previous lab" references.
- Confirm markdown code blocks are balanced.

SQL review validation:

- Confirm sample grants match Resource Analytics ADW user access guidance.
- Confirm `WINGMATE` can query `OCIRA.COMPUTE_INSTANCE_DIM_V`.
- Confirm `WINGMATE` can query `OCIRA.COMPARTMENT_DIM_V`.
- Preview materialized view DDL before execution by keeping a preview mode in the adapted script.

APEX validation:

- Confirm the APEX workspace is created by reusing the existing `WINGMATE` schema.
- Confirm the APEX developer user can sign in and create the Wingmate application.
- Validate APEX GenAI service steps against current Oracle APEX documentation.

Commit gate:

- Do not commit until static validation passes.
- Do not commit executable SQL/APEX instructions until SME confirms exact database user/role/grant SQL, materialized view list, APEX mappings, and Compute Wingmate content.

## Assumptions

- `WINGMATE` is the database schema, APEX workspace, and APEX developer username.
- Folder renaming is approved so lab numbers match content.
- Lab 5 should be visible in the manifest as a stub.
- Sample SQL is acceptable only as SME-review draft content.
- Exact APEX configuration and data model details must not be invented.
