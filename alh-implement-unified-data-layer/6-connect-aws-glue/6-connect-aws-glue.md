# Lab 6: Connect ALH to AWS Glue Data Catalog

## Introduction

Seer's supplier-performance team publishes a conventional dataset in Amazon S3 and manages its schema in AWS Glue Data Catalog. In this lab, you will connect ALH to that catalog, synchronize selected metadata, and query the resulting external table without copying the S3 objects into Oracle-managed storage.

**Estimated Time:** 30 minutes

### Objectives

In this lab, you will:

- Publish a small supplier dataset to Amazon S3 and AWS Glue.
- Create a restricted AWS credential in ALH.
- Register an AWS Glue Data Catalog connection.
- Synchronize Glue metadata into ALH-generated external tables.
- Monitor the synchronization and join S3 data to a Gold product.

### Prerequisites

- Completion of Labs 1 through 5
- An AWS account with permission to use S3, Glue, Athena, and a restricted IAM access key
- Permission to create an ALH credential and catalog connection
- The supplier CSV downloaded in Lab 1

> **Credential requirement:** The Glue catalog integration currently uses an AWS access-key ID and secret access key. Create a short-lived, least-privilege workshop identity and delete or deactivate the key during cleanup. Do not paste AWS secrets into workshop notes or screenshots.

## Task 1: Publish the supplier exchange dataset in AWS

1. Sign in to AWS and create a private S3 bucket in your selected region.

2. Upload `supplier_extract.csv` under this prefix:

    ```text
    <copy>
    supplier-performance/supplier_extract.csv
    </copy>
    ```

3. Open Amazon Athena. Configure an Athena query-results location if prompted.

4. Replace `<s3-bucket-name>` and run:

    ```sql
    <copy>
    CREATE DATABASE IF NOT EXISTS seer_supplier_exchange;

    CREATE EXTERNAL TABLE IF NOT EXISTS seer_supplier_exchange.supplier_performance (
      source_record_id string,
      supplier_name string,
      source_status string,
      certification string,
      location string,
      source_system string,
      ingestion_batch_id string
    )
    ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
    LOCATION 's3://<s3-bucket-name>/supplier-performance/'
    TBLPROPERTIES ('skip.header.line.count'='1');
    </copy>
    ```

5. Query the table in Athena and confirm that eight rows are returned. Athena registers the database and table metadata in AWS Glue Data Catalog.

## Task 2: Create the AWS credential in ALH

1. Sign in to Database Actions as `ADMIN` and open SQL.

2. Replace the placeholders with the restricted workshop key and run the statement. Do not save the completed statement in a shared file.

    ```sql
    <copy>
    BEGIN
      DBMS_CLOUD.CREATE_CREDENTIAL(
        credential_name => 'AWS_GLUE_CREDENTIAL',
        username        => '<aws-access-key-id>',
        password        => '<aws-secret-access-key>'
      );
    END;
    /
    </copy>
    ```

3. Clear the editor and SQL history entry if it exposes the secret. The database stores the credential encrypted.

## Task 3: Register AWS Glue Data Catalog

1. Open **Data Studio**, select **Data Load**, and then open **Connections**.

2. Create a new Data Catalog connection and select **AWS Glue**.

3. Supply:

    - Connection name: `SEER_AWS_GLUE`
    - Credential: `AWS_GLUE_CREDENTIAL`
    - AWS region: the region containing the Glue database
    - AWS account/catalog ID
    - Glue endpoint for the selected region

4. Use `AWS_GLUE_CREDENTIAL` for both catalog metadata and S3 object access, and test the connection.

> **Testing note:** Field labels and wizard order will be verified against the live Data Studio release before screenshots are added.

## Task 4: Synchronize the Glue table

1. From the registered catalog, browse `seer_supplier_exchange` and select `supplier_performance`.

2. Start a synchronization for the selected table.

3. Monitor the job until it succeeds. In SQL, review recent load operations:

    ```sql
    <copy>
    SELECT id, type, status, start_time, update_time
    FROM user_load_operations
    ORDER BY start_time DESC
    FETCH FIRST 10 ROWS ONLY;
    </copy>
    ```

4. Browse the generated `GLUE$...` schema. Glue synchronization derives an external table from the catalog metadata; the rows remain in S3.

## Task 5: Query and reconcile the external data

1. In Catalog or SQL, identify the generated schema and table name.

2. Replace the placeholders and query it:

    ```sql
    <copy>
    SELECT source_record_id, supplier_name, source_status,
           certification, location, ingestion_batch_id
    FROM "<GLUE$SCHEMA>"."SUPPLIER_PERFORMANCE"
    ORDER BY source_record_id;
    </copy>
    ```

3. Compare the external source with the Gold supplier product:

    ```sql
    <copy>
    SELECT g.supplier_name,
           g.qualification_status,
           g.certifications,
           a.source_status AS aws_source_status,
           a.certification AS aws_certification
    FROM seer_gold.supplier_profile g
    JOIN "<GLUE$SCHEMA>"."SUPPLIER_PERFORMANCE" a
      ON UPPER(TRIM(a.supplier_name)) LIKE '%' || UPPER(SUBSTR(g.supplier_name,1,8)) || '%'
    ORDER BY g.supplier_name;
    </copy>
    ```

4. In production, use stable source identifiers or a governed mapping rather than fuzzy name matching.

## Task 6: Understand synchronization behavior

Review these distinctions:

- Glue contains metadata; S3 contains the data files.
- Synchronization creates and maintains ALH external-table definitions.
- A Glue schema change can alter the generated Oracle representation.
- Automatic synchronization can be scheduled with `DBMS_DCAT.CREATE_SYNC_JOB`.
- Synchronization is not the same as copying or transforming the source rows.

## Lab 6 Recap

You connected ALH to AWS Glue, synchronized catalog metadata, queried an automatically generated external table over S3, and reconciled cross-cloud supplier information with a governed Gold product.

## Learn More

- [Query External Data with AWS Glue Data Catalog](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/query-external-data-aws-glue-data-catalog.html)
- [AWS Glue Data Catalog](https://docs.aws.amazon.com/glue/latest/dg/catalog-and-crawler.html)

## Acknowledgements

- **Author:** Eli Schilling, Cloud Architect || Evangelist
- **Contributors:** Oracle LiveLabs and ONA Lab Experience Teams
- **Last Updated By / Date:** ONA Lab Experience team, July 2026
