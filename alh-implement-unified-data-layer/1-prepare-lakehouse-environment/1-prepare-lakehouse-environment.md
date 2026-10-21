# Lab 1: Build the Unified Lakehouse Landing Zone

## Introduction

In the sandbox version of this workshop, infrastructure and data products are prepared before attendees arrive. In a customer tenancy, Alex must establish that foundation. In this lab, you will provision Oracle Autonomous AI Lakehouse (ALH), create a governed Object Storage landing zone, load representative enterprise extracts, and run staged SQL automation that creates the Bronze, Silver, and Gold environment used by every later lab.

The scripts automate repetitive database work, but each stage is explained and independently verified. You will still perform the important platform activities yourself: provisioning ALH, creating the bucket, configuring resource-principal access, loading source files through Data Studio, and checking the resulting objects.

**Estimated Time:** 50–60 minutes

### Objectives

In this lab, you will:

- Create a private Object Storage landing zone and upload structured and unstructured source material.
- Provision an Autonomous AI Lakehouse with 2 ECPUs and 1 TB of data storage.
- Authorize the ALH resource principal to read the workshop bucket.
- Create the workshop user and the Bronze, Silver, and Gold schemas.
- Load five representative CSV extracts with Data Studio Data Loader.
- Build the curated medallion products with staged SQL automation.
- Register documents, load an ONNX embedding model, generate vectors, and create a vector index.
- Verify that the complete environment is ready for the remaining labs.

### Prerequisites

- An OCI tenancy with permission to create Autonomous AI Database, Object Storage, and IAM policies
- A compartment in which to create workshop resources
- Permission to create a tenancy-level policy, or assistance from a tenancy administrator
- A supported browser that allows local file downloads and uploads
- Approximately 1 hour for provisioning and setup

> **Cost notice:** This lab creates billable cloud resources. Complete the cleanup section when you finish the workshop.

## Task 1: Download and review the workshop assets

1. Download and extract the [complete tenancy setup bundle](../files/tenancy/downloads/alh-unified-data-layer-tenancy-setup.zip). It contains the source CSVs, project PDFs, and staged SQL scripts.

2. If your browser or security policy blocks ZIP files, download the five source extracts individually:

    - [Financial assets CSV](../files/source-data/assets/financial_assets.csv)
    - [Inspection findings CSV](../files/source-data/inspections/inspection_findings.csv)
    - [Purchase orders CSV](../files/source-data/purchasing/purchase_orders.csv)
    - [Project milestones CSV](../files/source-data/schedules/project_milestones.csv)
    - [Supplier extract CSV](../files/source-data/suppliers/supplier_extract.csv)

3. Download the three project documents individually if needed:

    - [Supplier framework agreement](../files/documents/atlas_supplier_framework_agreement.pdf)
    - [Receiving inspection report](../files/documents/austin_receiving_inspection_report.pdf)
    - [Structural engineering specification](../files/documents/austin_structural_engineering_specification.pdf)

4. Download the staged setup scripts individually if needed. Do not run them yet.

    - [Stage 1 – administrative bootstrap](../files/tenancy/sql/01-admin-bootstrap.sql)
    - [Stage 2 – medallion structures](../files/tenancy/sql/02-create-medallion-structures.sql)
    - [Stage 3 – curated medallion build](../files/tenancy/sql/03-build-medallion-layers.sql)
    - [Stage 4 – vector-model preparation](../files/tenancy/sql/04-prepare-vector-model.sql)
    - [Stage 5 – model and embeddings](../files/tenancy/sql/05-load-model-and-generate-embeddings.sql)
    - [Stage 6 – final validation](../files/tenancy/sql/06-finalize-and-validate.sql)

5. The scripts are staged deliberately:

    | Stage | Purpose | Run as |
    |---|---|---|
    | 1 | Create schemas, the workshop account, roles, Database Actions access, and resource-principal enablement | `ADMIN` |
    | 2 | Create the medallion, document, quality, lineage, pipeline, and product structures | `ADMIN` |
    | 3 | Verify the Data Loader sources and build the compact curated workshop dataset | `ADMIN` |
    | 4 | Create the ONNX directory and grant temporary model-loading access | `ADMIN` |
    | 5 | Load the model and generate document embeddings | `SEER_WORKSHOP` |
    | 6 | Create the vector index, apply final grants, and report readiness | `ADMIN` |

## Task 2: Create the Object Storage landing zone

1. From the OCI Console navigation menu, select **Storage**, and then select **Buckets**.

2. Confirm the correct compartment and select **Create bucket**.

3. Name the bucket `seer-unified-data-<your initials>`. Keep **Standard** storage tier and **Private** access, and then create it.

4. Upload the CSV files with these object names:

    ```text
    <copy>
    source-data/assets/financial_assets.csv
    source-data/inspections/inspection_findings.csv
    source-data/purchasing/purchase_orders.csv
    source-data/schedules/project_milestones.csv
    source-data/suppliers/supplier_extract.csv
    </copy>
    ```

5. Upload the PDFs with these object names:

    ```text
    <copy>
    documents/atlas_supplier_framework_agreement.pdf
    documents/austin_receiving_inspection_report.pdf
    documents/austin_structural_engineering_specification.pdf
    </copy>
    ```

6. Record the region, namespace, bucket name, and base URI. Your base URI follows this pattern:

    ```text
    <copy>
    https://objectstorage.<region>.oraclecloud.com/n/<namespace>/b/<bucket-name>/o/
    </copy>
    ```

## Task 3: Provision Autonomous AI Lakehouse

1. From the OCI Console navigation menu, select **Oracle AI Database**, and then select **Autonomous AI Database**.

2. Select **Create Autonomous AI Database** and confirm the workshop compartment.

3. Configure the database:

    | Setting | Value |
    |---|---|
    | Display name | `seer-unified-lakehouse` |
    | Database name | A unique name of 14 characters or fewer |
    | Workload type | Autonomous AI Lakehouse |
    | Database version | 26ai |
    | Compute model | ECPU |
    | Compute count | 2 ECPUs |
    | Compute auto scaling | Disabled |
    | Data storage | 1 TB |
    | Network access | Secure access from everywhere |
    | Require mutual TLS | Enabled |
    | License type | Select the option appropriate for your tenancy |

4. Create and securely record a strong `ADMIN` password. Do not place it in the workshop notes or screenshots.

5. Create the database and wait until its lifecycle state is **Available**. Provisioning can take several minutes.

6. Open the database details and copy its OCID. You will use it to restrict the Object Storage policy.

## Task 4: Configure governed Object Storage access

ALH uses its resource principal to read the private bucket. No OCI user auth token is stored in the database.

1. From the OCI Console navigation menu, select **Identity & Security**, and then select **Policies**.

2. Select the root compartment and create a policy named `seer-unified-lakehouse-object-access`.

3. Replace `<autonomous-database-ocid>` in these statements with the OCID you recorded:

    ```text
    <copy>
    Allow any-user to inspect buckets in tenancy where all {request.principal.type = 'autonomousdatabase', request.principal.id = '<autonomous-database-ocid>'}
    Allow any-user to read objects in tenancy where all {request.principal.type = 'autonomousdatabase', request.principal.id = '<autonomous-database-ocid>'}
    </copy>
    ```

4. Create the policy. IAM changes can require several minutes to propagate.

> **Security note:** The policy is tenancy-visible but is restricted to the single ALH resource OCID. Production policies should use the narrowest resource and location scope that satisfies the workload.

## Task 5: Run the administrative bootstrap

1. Return to the ALH details page. Select **Database actions**, and then select **SQL**. Database Actions opens in a new tab.

2. Clear any first-run tours or informational messages.

3. Open `01-admin-bootstrap.sql` in a text editor. Replace `Replace_With_Strong_Password` with a strong temporary password for `SEER_WORKSHOP`. Save the file.

4. In SQL, select **Open**, select the edited script, and then select **Run Script**.

5. The script creates three no-login layer schemas, the `SEER_WORKSHOP` Database Actions account, required roles, package grants, and resource-principal enablement. It does not delete existing users.

6. Confirm that the output ends with `Stage 1 complete`, then run:

    ```sql
    <copy>
    SELECT username, account_status
    FROM dba_users
    WHERE username IN ('SEER_BRONZE','SEER_SILVER','SEER_GOLD','SEER_WORKSHOP')
    ORDER BY username;
    </copy>
    ```

## Task 6: Create the medallion structures

1. Open `02-create-medallion-structures.sql` and select **Run Script**.

2. This stage creates the compact workshop structures for source inventory, purchase orders, canonical assets and suppliers, mappings, events, quarantine, Gold products, document chunks, lineage, quality, freshness, consumers, and AI readiness.

3. Confirm `Stage 2 complete`, then run:

    ```sql
    <copy>
    SELECT owner, COUNT(*) AS table_count
    FROM all_tables
    WHERE owner IN ('SEER_BRONZE','SEER_SILVER','SEER_GOLD')
    GROUP BY owner
    ORDER BY owner;
    </copy>
    ```

## Task 7: Load the source extracts with Data Loader

1. Return to the Database Actions Launchpad, select **Data Studio**, and then select **Data Load**.

2. Select **Load Data**, and then select **Local File**.

3. Add each CSV and configure these target names in the `ADMIN` schema:

    | File | Target table | Expected rows |
    |---|---|---:|
    | `financial_assets.csv` | `FINANCIAL_ASSETS_LOAD` | 3 |
    | `purchase_orders.csv` | `PURCHASE_ORDERS_LOAD` | 4 |
    | `project_milestones.csv` | `PROJECT_MILESTONES_LOAD` | 4 |
    | `supplier_extract.csv` | `SUPPLIER_EXTRACT_LOAD` | 8 |
    | `inspection_findings.csv` | `INSPECTION_FINDINGS_LOAD` | 4 |

4. For each file, verify that row 1 contains column names and data begins on row 2. Review inferred character, number, date, and timestamp types before starting the load.

5. Start the job and review its report. Resolve any rejected rows before continuing.

6. These tables preserve the raw source shape for inspection. Stage 3 validates their presence, then publishes a compact prepared medallion result so the workshop does not spend 30–40 minutes executing a full production pipeline.

## Task 8: Build the curated medallion layers

1. Return to SQL and open `03-build-medallion-layers.sql`.

2. Replace `Replace_With_Object_Storage_Base_URI` with the base URI recorded in Task 2. Retain the trailing `/`.

3. Run the script. It first reports the five Data Loader row counts, then builds the prepared Bronze inventory, Silver reconciliation, Gold products, document metadata, and simulated pipeline evidence.

4. Confirm `Stage 3 complete`, then verify the Austin context:

    ```sql
    <copy>
    SELECT project_name, asset_name, current_milestone,
           supplier_name, inspection_status, agent_readiness
    FROM seer_gold.project_context
    WHERE UPPER(project_name) LIKE '%AUSTIN%';
    </copy>
    ```

## Task 9: Upload and prepare the embedding model

1. Download the [Oracle-hosted all-MiniLM-L12-v2 model ZIP](https://adwc4pm.objectstorage.us-ashburn-1.oci.customer-oci.com/p/TtH6hL2y25EypZ0-rrczRZ1aXp7v1ONbRBfCiT-BDBN8WLKQ3lgyW6RxCfIFLdA6/n/adwc4pm/b/OML-ai-models/o/all_MiniLM_L12_v2_augmented.zip).

2. Extract the `.onnx` file and rename it `all_MiniLM_L12_v2.onnx` if necessary.

3. Upload it to the workshop bucket as:

    ```text
    <copy>
    models/all_MiniLM_L12_v2.onnx
    </copy>
    ```

4. In the `ADMIN` SQL worksheet, open and run `04-prepare-vector-model.sql`. Confirm `Stage 4 complete`.

## Task 10: Load the model and generate embeddings

1. Sign out of Database Actions and sign in as `SEER_WORKSHOP` with the password selected in Task 5.

2. Open SQL and load `05-load-model-and-generate-embeddings.sql`.

3. Replace `Replace_With_ONNX_Object_URI` with the complete URI of the uploaded ONNX object.

4. Run the script. It retrieves the model using the resource principal, loads the model into the `SEER_WORKSHOP` schema, and generates a 384-dimension vector for each prepared document chunk.

5. If Object Storage access is denied, wait several minutes for IAM propagation and run this stage again.

6. Confirm `Stage 5 complete`, then run:

    ```sql
    <copy>
    SELECT embedding_status, COUNT(*) AS chunks
    FROM seer_gold.document_chunks
    GROUP BY embedding_status;
    </copy>
    ```

## Task 11: Finalize and validate the environment

1. Sign back in as `ADMIN`.

2. Open and run `06-finalize-and-validate.sql`.

3. This stage creates the HNSW vector index, grants read access to `SEER_WORKSHOP`, and reports readiness for document embeddings, Gold products, and the vector model.

4. Confirm that every validation reports `PASS`. The unified lakehouse landing zone is now ready.

## Lab 1 Recap

In this lab, you manually established the OCI landing zone and ALH service, used a resource principal instead of embedding OCI user credentials, loaded representative source extracts through Data Loader, and used six explained automation stages to build the governed medallion, document, and vector foundation. Later labs will explore, extend, and consume the environment you created.

## Learn More

- [Autonomous AI Database documentation](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/overview-autonomous-database.html)
- [Load Data with Data Studio](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/load-data.html)
- [Use Resource Principal with Autonomous AI Database](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/resource-principal.html)
- [Load ONNX Models](https://docs.oracle.com/en/database/oracle/oracle-database/26/vecse/load-onnx-models-oracle-database.html)

## Acknowledgements

- **Author:** Eli Schilling, Cloud Architect || Evangelist
- **Contributors:** Oracle LiveLabs and ONA Lab Experience Teams
- **Last Updated By / Date:** ONA Lab Experience team, July 2026
