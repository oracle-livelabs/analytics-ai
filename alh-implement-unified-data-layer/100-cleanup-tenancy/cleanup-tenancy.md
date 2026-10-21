# Clean Up the Tenancy Environment

## Introduction

This workshop creates billable OCI and AWS resources and stores temporary cloud credentials. Remove the resources you no longer need. Cleanup is intentionally explicit because the tenancy variant does not have a Terraform stack to destroy everything automatically.

**Estimated Time:** 15 minutes

### Objectives

In this section, you will:

- Remove external connections, profiles, links, and credentials.
- Delete optional remote-database and AWS resources.
- Terminate the workshop ALH instance.
- Delete Object Storage objects, the bucket, and IAM policy.
- Confirm that no workshop resources remain billable.

### Prerequisites

- Completion of the workshop
- Administrative access to the OCI and AWS resources you created
- A record of the resource names used in each lab

> **Destructive action:** The following tasks permanently delete workshop data and cloud resources. Export anything you need before continuing.

## Task 1: Remove ALH external integrations

1. In Data Studio, remove the Delta Sharing subscription and `SEER_PARTNER_SHARE` provider if you completed Lab 9.

2. Remove the `SEER_REMOTE_INSPECTIONS` connection and linked objects from Lab 8.

3. Remove the AWS Glue catalog connection from Lab 6.

4. Drop the Iceberg external table and remote snapshot if they are no longer needed:

    ```sql
    <copy>
    DROP TABLE material_pricing_iceberg_ext;
    DROP TABLE seer_silver.remote_inspection_snapshot;
    </copy>
    ```

5. Drop the stored AWS credential:

    ```sql
    <copy>
    BEGIN
      DBMS_CLOUD.DROP_CREDENTIAL('AWS_GLUE_CREDENTIAL');
    END;
    /
    </copy>
    ```

## Task 2: Remove AWS resources

1. Drop the Athena Iceberg and conventional external tables, then drop the workshop Glue database when it is empty.

2. Delete the objects from the workshop S3 bucket and delete the bucket.

3. Deactivate and delete the workshop IAM access key.

4. Remove the workshop IAM user or role and its policies if they are no longer needed.

5. Confirm that no Athena workgroup output or Glue crawler resource remains from the lab.

## Task 3: Remove the remote Oracle source

1. If you created a second Autonomous AI Database for Lab 8, terminate it from its details page.

2. Confirm the database name carefully before accepting the termination prompt.

3. If you used an existing shared database, remove only the `SEER_SOURCE` user and workshop connection artifacts authorized by its owner.

## Task 4: Terminate the workshop ALH database

1. Open the `seer-unified-lakehouse` Autonomous AI Database details page.

2. From **More actions**, select **Terminate**.

3. Confirm the database name and wait for termination to complete.

## Task 5: Delete Object Storage and IAM resources

1. Open the workshop bucket and delete every object under `source-data/`, `documents/`, and `models/`.

2. Delete the empty bucket.

3. Open **Identity & Security > Policies** in the root compartment.

4. Delete `seer-unified-lakehouse-object-access` if it is used only by this workshop.

5. Verify that the policy does not support another environment before deleting it.

## Task 6: Confirm cleanup

Verify that:

- The main ALH database is terminated.
- The optional remote database is terminated or detached from the workshop.
- The OCI bucket and objects are deleted.
- The workshop IAM policy is deleted.
- AWS S3, Glue, Athena, and IAM resources are removed.
- The local Delta Sharing profile and downloaded wallet are securely deleted.
- No passwords, keys, profiles, or wallets remain in shared folders.

## Cleanup Recap

You removed the workshop integrations, credentials, databases, storage objects, and policies so the tenancy no longer incurs workshop-related charges or retains temporary secrets.

## Learn More

- [Terminate Autonomous AI Database](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/autonomous-terminate.html)
- [Object Storage Buckets](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets.htm)

## Acknowledgements

- **Author:** Eli Schilling, Cloud Architect || Evangelist
- **Contributors:** Oracle LiveLabs and ONA Lab Experience Teams
- **Last Updated By / Date:** ONA Lab Experience team, July 2026
