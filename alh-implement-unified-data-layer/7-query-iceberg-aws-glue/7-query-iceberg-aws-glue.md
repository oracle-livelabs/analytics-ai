# Lab 7: Query Apache Iceberg through AWS Glue

## Introduction

Lab 6 synchronized a conventional Glue table over files. This lab uses Glue in a different role: AWS Glue stores the metadata for an Apache Iceberg table that Athena updates. ALH reads the Iceberg table in place and observes a new committed row without reloading the dataset.

**Estimated Time:** 20–25 minutes

### Objectives

In this lab, you will:

- Create a small Iceberg table with Amazon Athena.
- Create an ALH external table that uses the Iceberg access protocol and AWS Glue metadata.
- Query the table from ALH without copying it.
- Commit a source change and observe it from ALH.
- Distinguish Glue synchronization from Iceberg table-format access.

### Prerequisites

- Completion of Lab 6
- The AWS S3 bucket, region, and `AWS_GLUE_CREDENTIAL` from Lab 6
- Permission to create and update an Athena Iceberg table

## Task 1: Create an Iceberg material-pricing table

1. Return to the Athena query editor.

2. Replace `<s3-bucket-name>` and run:

    ```sql
    <copy>
    CREATE TABLE seer_supplier_exchange.material_pricing_iceberg (
      material_code string,
      material_description string,
      supplier_id string,
      unit_price decimal(12,2),
      currency_code string,
      effective_date date
    )
    LOCATION 's3://<s3-bucket-name>/iceberg/material-pricing/'
    TBLPROPERTIES ('table_type'='ICEBERG');

    INSERT INTO seer_supplier_exchange.material_pricing_iceberg VALUES
      ('STL-A992','ASTM A992 Grade 50 structural steel','SUP-ATLAS-001',1.08,'USD',DATE '2026-07-01'),
      ('BLT-A325','ASTM F3125 Grade A325 bolt assembly','SUP-ATLAS-001',4.75,'USD',DATE '2026-07-01'),
      ('STL-A572','ASTM A572 Grade 50 plate','SUP-WEST-002',1.02,'USD',DATE '2026-07-01');
    </copy>
    ```

3. Query the table and confirm that three rows are returned.

## Task 2: Create the ALH Iceberg external table

1. Sign in to ALH Database Actions as `ADMIN` and open SQL.

2. Replace `<aws-region>` and run:

    ```sql
    <copy>
    BEGIN
      DBMS_CLOUD.CREATE_EXTERNAL_TABLE(
        table_name      => 'MATERIAL_PRICING_ICEBERG_EXT',
        credential_name => 'AWS_GLUE_CREDENTIAL',
        file_uri_list   => NULL,
        format          => '{
          "access_protocol": {
            "protocol_type": "iceberg",
            "protocol_config": {
              "iceberg_catalog_type": "aws_glue",
              "iceberg_glue_region": "<aws-region>",
              "iceberg_table_path": "seer_supplier_exchange.material_pricing_iceberg"
            }
          }
        }'
      );
    END;
    /
    </copy>
    ```

3. Query the external table:

    ```sql
    <copy>
    SELECT material_code, material_description, supplier_id,
           unit_price, currency_code, effective_date
    FROM material_pricing_iceberg_ext
    ORDER BY material_code;
    </copy>
    ```

4. Confirm that ALH returns the same three committed rows.

## Task 3: Join Iceberg pricing to trusted supplier context

1. Run:

    ```sql
    <copy>
    SELECT p.material_code,
           p.material_description,
           p.unit_price,
           s.supplier_name,
           s.qualification_status,
           s.risk_indicator
    FROM material_pricing_iceberg_ext p
    LEFT JOIN seer_gold.supplier_profile s
      ON s.supplier_id = p.supplier_id
    ORDER BY p.material_code;
    </copy>
    ```

2. Observe that externally managed pricing can be evaluated with governed supplier qualification and risk without first duplicating the Iceberg table.

## Task 4: Commit and observe a source change

1. In Athena, add a new committed row:

    ```sql
    <copy>
    INSERT INTO seer_supplier_exchange.material_pricing_iceberg VALUES
      ('PLT-CONN','Structural connection plate','SUP-ATLAS-001',0.94,'USD',DATE '2026-07-15');
    </copy>
    ```

2. Query the Athena table and confirm four rows.

3. Return to ALH and rerun the external-table query. Confirm that the committed row is visible without a Data Loader job.

## Task 5: Compare the two Glue patterns

| Lab 6 | Lab 7 |
|---|---|
| Synchronizes Glue table definitions into generated `GLUE$` schemas | Creates an external table that understands Iceberg metadata |
| Best for catalog-scale discovery and synchronization | Best for direct access to a table-format dataset |
| Glue metadata describes conventional files | Glue metadata identifies Iceberg metadata and snapshots |
| Optional scheduled catalog synchronization | New committed table state is resolved through the Iceberg protocol |

## Lab 7 Recap

You queried an AWS-managed Iceberg table from ALH, joined it to trusted Oracle data, committed a new source row, and observed the update without a copy operation.

## Learn More

- [Query Apache Iceberg Tables](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/query-iceberg-table.html)
- [Use Iceberg tables in Athena](https://docs.aws.amazon.com/athena/latest/ug/querying-iceberg.html)

## Acknowledgements

- **Author:** Eli Schilling, Cloud Architect || Evangelist
- **Contributors:** Oracle LiveLabs and ONA Lab Experience Teams
- **Last Updated By / Date:** ONA Lab Experience team, July 2026
