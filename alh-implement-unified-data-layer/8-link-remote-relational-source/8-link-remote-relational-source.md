# Lab 8: Link a Remote Relational Source

## Introduction

File and catalog integrations are only part of Seer's estate. Current inspection and compliance records remain in an operational Oracle database. In this lab, you will provision or use a small remote Autonomous AI Database, create a database connection from ALH, and expose the remote table as a live linked view before deciding whether to copy it into Silver.

**Estimated Time:** 25–30 minutes, excluding source-database provisioning

### Objectives

In this lab, you will:

- Prepare a remote Oracle inspection source.
- Create a secure database connection from ALH.
- Link a remote table through Data Studio.
- Join live operational data to a Gold product.
- Compare live linking with scheduled ETL or materialization.

### Prerequisites

- Completion of Labs 1 through 7
- A second Oracle Autonomous AI Database or another reachable Oracle Database
- Permission to create a source user, database connection, and database link
- Network connectivity between ALH and the source database

> **Cost notice:** If you create a second Autonomous AI Database for this lab, it is billable unless covered by your account entitlement. Record it for cleanup.

## Task 1: Prepare the remote inspection database

1. Use an existing nonproduction Oracle source or create a small Autonomous AI Transaction Processing database named `seer-remote-inspections`.

2. Open its Database Actions SQL worksheet as `ADMIN`.

3. Download [the remote inspection seed script](../files/tenancy/sql/07-create-remote-inspection-source.sql).

4. Replace `Replace_With_Strong_Password`, run the script, and securely record the `SEER_SOURCE` password.

5. Confirm that the summary reports two `PASS`, one `REQUEST_INFO`, and one `FAIL` inspection.

6. Record the source database connection information. Download a wallet if the selected connection method requires one.

## Task 2: Create the remote database connection in ALH

1. Return to the main workshop ALH and sign in to Database Actions as `ADMIN`.

2. Open **Data Studio**, select **Data Load**, and then open **Connections**.

3. Create an Oracle Database connection named `SEER_REMOTE_INSPECTIONS`.

4. Provide the source service information, `SEER_SOURCE` username, and password. Upload or select the source wallet when required.

5. Test and save the connection.

> **Expected result:** Data Studio can list the source schema and tables. Exact public-endpoint and wallet fields will be verified during live testing.

## Task 3: Link the remote inspection table

1. From **Data Load**, select **Link Data**, and then select **Database**.

2. Select `SEER_REMOTE_INSPECTIONS` and browse the `SEER_SOURCE` schema.

3. Add `INSPECTION_COMPLIANCE` to the link cart.

4. Name the ALH target `REMOTE_INSPECTION_COMPLIANCE` and start the link job.

5. Data Studio creates a database-backed linked view rather than copying the source rows. Preview it and confirm four records.

## Task 4: Combine live inspection state with Gold context

1. Return to SQL and run:

    ```sql
    <copy>
    SELECT p.project_name,
           p.asset_name,
           p.supplier_name,
           r.inspection_number,
           r.compliance_area,
           r.result_status,
           r.finding_description,
           r.inspected_at
    FROM remote_inspection_compliance r
    JOIN seer_gold.project_context p
      ON p.project_name = CASE r.project_reference
        WHEN 'AUS-BANK-01' THEN 'Austin Regional Bank Structure'
        WHEN 'HOU-MIXED-02' THEN 'Downtown Mixed-Use Tower'
        WHEN 'HAR-SEISMIC-03' THEN 'Harbor Seismic Retrofit'
      END
    ORDER BY r.inspected_at;
    </copy>
    ```

2. Identify the failing Harbor record and the Houston request for information.

3. Note that every query depends on source availability and network latency.

## Task 5: Materialize a Silver snapshot

For agent workloads, a governed snapshot may be preferable to a live operational dependency.

1. Create a local Silver snapshot:

    ```sql
    <copy>
    CREATE TABLE seer_silver.remote_inspection_snapshot AS
    SELECT inspection_number,
           project_reference,
           asset_reference,
           compliance_area,
           result_status,
           finding_description,
           inspected_at,
           SYSTIMESTAMP AS snapshot_at
    FROM remote_inspection_compliance;
    </copy>
    ```

2. Compare the patterns:

    | Live link | Silver snapshot |
    |---|---|
    | Current source state | State as of the snapshot |
    | Depends on source and network availability | Available inside ALH |
    | Minimal duplication | Requires refresh and retention controls |
    | Source permissions remain part of every query | ALH grants govern the copy |

3. In production, schedule the snapshot through Data Transforms or a database job and record its lineage and refresh status.

## Lab 8 Recap

You connected a real relational source, queried it live from ALH, combined it with Gold context, and materialized a governed Silver snapshot when local availability and repeatability were more important than live access.

## Learn More

- [Link Data in Data Studio](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/link-data.html)
- [Create Database Links from Autonomous AI Database](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/database-links.html)

## Acknowledgements

- **Author:** Eli Schilling, Cloud Architect || Evangelist
- **Contributors:** Oracle LiveLabs and ONA Lab Experience Teams
- **Last Updated By / Date:** ONA Lab Experience team, July 2026
