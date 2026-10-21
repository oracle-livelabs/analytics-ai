# Lab 5: Analyze Trusted Data with Oracle Database for Excel

## Introduction

Seer's data engineering team has published trusted Gold products, but many finance and project users work in Microsoft Excel. In this lab, you will connect Excel directly to ALH, retrieve governed project context, and create a simple analysis without distributing an unmanaged source-data extract.

The product is named **Oracle Database Add-in for Microsoft Excel**. Queries execute against ALH; the returned result becomes local workbook data and must be governed accordingly.

**Estimated Time:** 20–25 minutes

### Objectives

In this lab, you will:

- Verify that the workshop user can use the Excel add-in.
- Install the add-in from Database Actions or Microsoft AppSource.
- Connect Excel to the workshop ALH instance.
- Retrieve a Gold data product with Direct SQL.
- Create a simple workbook analysis and refresh it.
- Explain the governance boundary between ALH and local workbook data.

### Prerequisites

- Completion of Labs 1 through 4
- Microsoft Excel desktop with permission to install an Office add-in
- The `SEER_WORKSHOP` credentials created in Lab 1
- Network access from Excel to Database Actions

## Task 1: Verify Excel access

1. Sign in to Database Actions as `SEER_WORKSHOP` and open SQL.

2. Verify the role granted in Lab 1:

    ```sql
    <copy>
    SELECT granted_role
    FROM user_role_privs
    WHERE granted_role = 'ADPUSER';
    </copy>
    ```

3. The query should return `ADPUSER`. Ask the database administrator to grant the role if it is absent.

## Task 2: Install the Excel add-in

1. From the Database Actions header, open **Downloads** and locate the Microsoft Excel/Google Sheets add-in option.

2. Download the Excel add-in package and follow its included installation instructions.

3. If your organization manages Office add-ins centrally, search Microsoft AppSource for **Oracle Database for Excel** or ask your Microsoft 365 administrator to deploy it.

4. Open a new workbook and confirm that the **Oracle Database** ribbon is present.

> **Expected result:** Excel displays Oracle Database actions such as Connections and Direct SQL. Exact installation prompts vary by Microsoft 365 policy and will be validated during workshop testing.

## Task 3: Connect Excel to ALH

1. In the **Oracle Database** ribbon, select **Connections**, and then add or import a connection.

2. Use the Database Actions connection information for the ALH instance and sign in as `SEER_WORKSHOP`.

3. Confirm that the connection reports success. Do not save the workshop password in a shared workbook.

## Task 4: Retrieve a trusted Gold product

1. Select **Direct SQL**.

2. Enter this query:

    ```sql
    <copy>
    SELECT project_name,
           asset_name,
           current_milestone,
           total_committed_cost,
           supplier_name,
           inspection_status,
           agent_readiness
    FROM seer_gold.project_context
    ORDER BY project_name;
    </copy>
    ```

3. Run the query and place the result in a new worksheet named `Project Context`.

4. Confirm that the Austin, Houston, and Harbor projects appear and that the worksheet records query information such as the database user and execution time.

## Task 5: Analyze and refresh the result

1. Format `total_committed_cost` as currency.

2. Add a filter for `agent_readiness` and identify any project that is not ready.

3. Optionally create a PivotTable or chart that compares committed cost by readiness or inspection status.

4. Return to the Oracle Database add-in and refresh or rerun the query. Observe that the database remains the governed source while the workbook holds a local result set.

## Task 6: Review the governance boundary

Discuss these controls before sharing the workbook:

- ALH privileges and policies control the query executed by the add-in.
- The retrieved cells are local Excel data and can be copied or forwarded.
- Workbook protection does not replace database authorization.
- Sensitive Gold columns should be excluded, masked, or aggregated before retrieval.
- Inactive connections can time out and require authentication again.

## Lab 5 Recap

You used a familiar business tool to consume a governed Gold product directly from ALH, created a lightweight analysis, and identified where database governance ends and local workbook governance begins.

## Learn More

- [Using Oracle Database for Excel](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/using-oadb-for-excel.html)
- [Run Direct SQL queries in Excel](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/run-direct-sql.html)

## Acknowledgements

- **Author:** Eli Schilling, Cloud Architect || Evangelist
- **Contributors:** Oracle LiveLabs and ONA Lab Experience Teams
- **Last Updated By / Date:** ONA Lab Experience team, July 2026
