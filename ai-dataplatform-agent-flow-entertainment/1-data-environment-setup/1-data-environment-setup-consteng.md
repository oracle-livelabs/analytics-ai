# Lab 1: Data Environment Setup

## Introduction

Before building the AI agent, we need to ensure the data environment is in place. In this lab, you'll create the AI Compute instance, verify the generated external catalog, create a standard catalog, create a managed volume, and create the Knowledge Base used by the construction engineering workshop. You'll also verify the Oracle AI Database tables that power the agent's SQL tools.

By the end of this lab, all the data assets - structured project and supplier tables plus unstructured knowledge base documents - will be ready for the agent flow you'll build in Lab 2.

**Estimated Time:** 15 Minutes

### Objectives

In this lab you will:

1. Create the AI Compute instance used by the agent.
2. Verify the generated external database catalog (`vector_db_...`) created by AI feature enablement.
3. Create a new standard catalog (`ce_std_catalog`) and managed volume (`ce_volume`) where you'll upload construction procurement and compliance documents.
4. Create a Knowledge Base (`ce_kb`) and an associated data source that consumes the documents from the managed volume.
5. Verify the Oracle AI Database tables that contain construction projects, supplier records, certifications, recommendations, and decision data.
6. Understand how structured SQL data and unstructured RAG documents connect to the agent you'll build.

### Prerequisites

This lab assumes you have:

* Reviewed the Workshop Introduction and Overview.
* Access to the AIDP Workbench instance provisioned for this workshop.
* The Terraform stack has completed successfully. The stack provisions the AIDP Workbench and automatically starts AI feature enablement against the workshop Autonomous AI Lakehouse database. If the Workbench still shows **Enable AI features**, wait a few minutes and refresh the browser before continuing.

## Task 1: Create the AI Compute Instance

An AI Compute hosts your agent flows. You need an active AI Compute to test agent flows and deploy them.

1. Log into the OCI Console if you've not already done so.

2. Click the navigation menu in the top left corner.

    ![Screenshot of main navigation menu](images/01-navigate-nav-menu.png " ")

3. Navigate **Analytics & AI** -> **AI Data Platform Workbench**.

    ![Screenshot of link to AI Data Platform menu item](images/01-navigate-ai-data-platform.png " ")

4. From the *List scope* menu, select the compartment assigned by the LiveLabs environment.

5. Click the name of the AIDP instance to open the Workbench. The workbench opens in a new tab.

    ![Assigned compartment and AIDP Workbench name](images/01-aidp-console-compartment-consteng.png " ")

6. From the AIDP Workbench Home Page, select your workspace from the workspace drop-down.

    ![Use the drop-down menu to select your workspace](images/01-dashboard-select-workspace-consteng.png " ")

7. Click **Compute** under the selected workspace.

    ![Screenshot depicting the Compute section of workspace](images/01-aidp-navigate-compute-consteng.png " ")

8. In the Compute page, click the **AI Compute** tab, then click the **+** button.

    ![Screenshot of the AI compute tab and plus button](images/01-aidp-create-compute-consteng.png " ")

9. Enter a name and description:

    **Name**
    ```
    <copy>
    ce_compute
    </copy>
    ```

    **Description**
    ```
    <copy>
    AI Compute for the Construction Engineering Supplier Evaluation Agent
    </copy>
    ```

10. Use the default size of **1 OCPU** and **16 GB of RAM**.

11. Click **Create**.

    ![Create new AI compute dialog window](images/01-compute-create-instance-consteng.png " ")

    > **Note**: It may take 3-5 minutes to provision this resource. You can continue to the next task while it provisions.

## Task 2: Verify the Generated External Database Catalog

An external catalog in AIDP enables the agent SQL tools to query the Autonomous AI Lakehouse database. For this workshop, these setup steps have already been completed for you: AI features have been enabled on the Workbench, the ALH instance has been provisioned, and an external catalog named with the **`vector_db_`** prefix has been created so the Workbench can discover and query the ALH data through agent SQL tools.

1. From the AIDP Workbench Home Page, click **Master Catalog**.

    ![Screenshot of AIDP workbench home page](images/01-aidp-master-catalog-consteng.png " ")

2. Confirm that the catalog list contains:

    - **`default` standard catalog** - the standard catalog created by the Workbench.
    - **`vector_db_...`** - an external catalog connected to the workshop Autonomous AI Lakehouse database.

    > **Note:** The generated external catalog name includes the ALH database name and a unique suffix. Do not delete this catalog. You'll select this **`vector_db_...`** catalog when you configure SQL tools in Lab 2.

3. Confirm that the generated **`vector_db_...`** catalog shows **Active** status.

## Task 3: Create the Standard Catalog

A standard catalog in AIDP stores AI-related artifacts - volumes, tables, schemas, and knowledge bases. For this workshop, you'll be creating a new standard catalog.

1. From the AIDP Workbench Home Page, click **Master Catalog**.

2. Click **Create catalog** and provide the following:

    ![Master Catalog and Create catalog controls](images/01-catalog-create-button-consteng.png " ")

    **Catalog name**
    ```
    <copy>
    ce_std_catalog
    </copy>
    ```

    **Description**
    ```
    <copy>
    A catalog that stores assets needed by the construction engineering supplier evaluation agent.
    </copy>
    ```

3. Click **Create**.

    ![Create standard catalog dialog](images/01-catalog-create-dialog-consteng.png " ")

4. When ready, click **`ce_std_catalog`** to open the new catalog.

    ![Open the new standard catalog](images/01-catalog-open-standard-catalog-consteng.png " ")

    > **Note:** A **Standard Catalog** stores data directly within AIDP, backed by OCI Object Storage and the Delta Lake open source file format. An **External Catalog** connects to data outside the platform.

5. Click the **default** schema within the catalog.

    ![Select the default schema](images/01-catalog-default-schema-consteng.png " ")

## Task 4: Create the Managed Volume

A volume stores unstructured files within a catalog. The volume for this workshop contains internal construction supplier evaluation, compliance, and technical addendum guidance.

These are the documents that the AI agent will search via RAG when users ask questions about definitions, policies, thresholds, or interpretation rules. For example, when a user asks *"When should a construction supplier be denied instead of marked request info?"*, the agent will retrieve relevant passages from these documents.

1. Download **[kb_documents.zip](https://github.com/oracle-livelabs/analytics-ai/raw/refs/heads/main/ai-dataplatform-agent-flow-entertainment/files/consteng/kb_documents.zip)**, which contains the sample knowledge base documents. If the file opens in GitHub instead of downloading automatically, click **Download raw file**.

2. Unzip the file. You should have 3 `.docx` files:

    - **Construction Supplier Evaluation Playbook** - Defines approve, request-info, deny, and RFP-trigger decision criteria.
    - **Construction Compliance and Certification Guidelines** - Defines certification, NCR, safety, delivery, and capacity thresholds.
    - **Technical Addendum and Risk Triage Procedure** - Defines how to handle missing technical packages and re-analysis scenarios.

3. Back in AIDP Workbench, return to the **`ce_std_catalog`** catalog, locate the **default** schema, and click **Volumes**.

    ![Select Volumes in the default schema](images/01-catalog-schema-volumes-consteng.png " ")

4. Click the **+** next to the filter field to create a new volume.

    ![Volumes interface - add new volume button](images/01-catalog-add-volume-consteng.png " ")

5. Provide a name and description:

    **Name**
    ```
    <copy>
    ce_volume
    </copy>
    ```

    **Description**
    ```
    <copy>
    This volume stores construction procurement, supplier compliance, and technical addendum documents.
    </copy>
    ```

6. Click **Create**.

    ![Create volume dialog](images/01-catalog-create-volume-consteng.png " ")

7. Click the volume name **`ce_volume`**.

    ![Open the ce_volume volume](images/01-catalog-volume-open-consteng.png " ")

8. Click the **+** button, then click **Upload**.

    ![Volume add file button](images/01-catalog-volume-plus-consteng.png " ")

9. Upload the three `.docx` files from the zip archive.

    ![Upload files interface](images/01-catalog-volume-upload-files-consteng.png " ")

10. Click **Upload**, then confirm the files appear in the volume.

    ![Verify files uploaded successful](images/01-catalog-volume-upload-files-complete-consteng.png " ")

## Task 5: Create a Knowledge Base

Now we'll create the key asset that enables RAG. A Knowledge Base creates vector representations (embeddings) of the documents in the volume. When the agent receives a question, it performs a semantic search against these vectors to find the most relevant passages - even if the user's wording doesn't exactly match the document text.

1. Navigate back to **`ce_std_catalog`** and click the **default** schema.

    ![Select the default schema](images/01-catalog-default-schema-consteng.png " ")

2. Click **Knowledge Bases**.

    ![Select Knowledge Bases in the default schema](images/01-catalog-schema-knowledge-bases-consteng.png " ")

3. Click the **+** button to create a new Knowledge Base.

    ![Knowledge Base add button](images/01-catalog-kbase-plus-consteng.png " ")

4. Enter the following values:

    **Name**
    ```
    <copy>
    ce_kb
    </copy>
    ```

    **Description**
    ```
    <copy>
    Knowledge base for construction engineering supplier evaluation policy, compliance, and technical addendum guidance.
    </copy>
    ```

5. Leave the **Advanced Settings** as-is.

6. Click **Create** and wait for the Knowledge Base to become **Active**.

    ![Create a new knowledgebase in the catalog](images/01-catalog-create-kbase-consteng.png " ")

7. Open the Knowledge Base details, click the **Data Source** tab, and click the **+** button.

    ![Open ce_kb details](images/01-catalog-kbase-active-consteng.png " ")

    ![Data Source add button](images/01-catalog-kbase-datasource-plus-consteng.png " ")

8. Select the **`ce_volume`** volume and leave advanced settings as-is.

9. Click **Add**.

    ![Add data source to knowledge base](images/01-catalog-kbase-add-datasource-consteng.png " ")

10. Navigate to the **History** tab of your Knowledge Base. You should see a line entry with the operation name **"Update Knowledge Base"**. This step ingests the documents - chunking them, generating embeddings, and indexing the vectors.

    ![Knowledge base ingestion succeeded](images/01-catalog-kbase-history-succeeded-consteng.png " ")

11. Wait for the status to show **Succeeded** before moving on. This typically takes less than one minute since we're ingesting a small set of documents.

    > **What just happened?** The Knowledge Base chunked each document into smaller passages, generated vector embeddings for each chunk using an embedding model, and stored those vectors in an index. When the RAG tool receives a query, it converts the query into a vector, finds the most semantically similar chunks, and returns them as context for the LLM. This is how the agent can answer policy and definition questions grounded in your actual internal documents.

## Task 6: Optional - Verify the Oracle AI Database Tables

The agent's SQL tools query structured data from an Oracle AI Database. For this workshop, the database has already been provisioned and loaded with construction engineering project and supplier data.

1. When you opened AIDP Workbench earlier, it opened in a new browser tab. Locate and select the browser tab or window that still contains the OCI Console.

2. Use the navigation menu to open the Autonomous AI Database Console.

    ![OCI Nav menu - Autonomous AI Database console](images/01-navigate-autonomous-ai-database.png " ")

3. Make sure the **Applied filters** match your assigned compartment.

4. You should see the Autonomous AI Database for your reservation. Click the database name that starts with **hol-consteng-** to view details.

5. When the page loads, click **Database actions** and select **SQL**. This opens SQL Worksheet in a new browser tab.

6. In the Navigator on the left, click the schema drop-down and locate the **CONSTRUCTION_ENGINEERING** schema.

    You should see the following tables populate below.

    | Table Name | Description | Key Columns |
    |---|---|---|
    | `CE_PROJECTS` | Construction projects under supplier evaluation | `PROJECT_ID`, `PROJECT_NAME`, `PROJECT_TYPE`, `EVALUATION_STATUS` |
    | `CE_PROJECT_REQUIREMENTS` | Trade, material, certification, delivery, budget, and risk requirements | `PROJECT_ID`, `TRADE_CATEGORY`, `REQUIRED_CERTIFICATION` |
    | `CE_SUPPLIERS` | Supplier master records | `SUPPLIER_ID`, `SUPPLIER_NAME`, `CATEGORY`, `CAPACITY_STATUS` |
    | `CE_SUPPLIER_CERTIFICATIONS` | Supplier certification evidence | `SUPPLIER_ID`, `CERTIFICATION_NAME`, `STATUS` |
    | `CE_SUPPLIER_PERFORMANCE` | Similar-project, delivery, cost, NCR, and safety history | `SUPPLIER_ID`, `ON_TIME_DELIVERY_RATE`, `UNRESOLVED_NCR_COUNT` |
    | `CE_SUPPLIER_RECOMMENDATION` | Fit score, risk, explanation, strengths, and missing information | `PROJECT_ID`, `SUPPLIER_ID`, `RECOMMENDATION`, `FIT_SCORE` |
    | `CE_SUPPORTING_DOCS` | Supporting document references and extracted text | `PROJECT_ID`, `SUPPLIER_ID`, `DOC_TYPE`, `DOC_TEXT` |
    | `CE_DECISION` | Generated decision text and decision type | `EVALUATION_ID`, `DECISION_TYPE`, `LETTER_TEXT` |

7. To check the data in the tables, enter this query in SQL Worksheet and click the green play button to **Run Statement**.

    ```sql
    <copy>
    select project_id, project_name, evaluation_status
    from CONSTRUCTION_ENGINEERING.ce_projects;
    </copy>
    ```

8. The query result should show projects such as **Downtown Mixed-Use Tower**, **Harbor Seismic Retrofit**, and **North Campus Lab Expansion**.

9. These tables represent the **gold layer** of the medallion architecture - curated, query-optimized data ready for business consumption. The agent's SQL tools will execute parameterized, read-only queries against these tables to answer questions about project requirements, supplier fit, missing documentation, evaluation status, and decision recommendations.

    > **Key takeaway:** You now have two categories of data assets ready for the agent:
    > - **Unstructured (RAG):** The Knowledge Base with vector-indexed construction procurement and compliance documents - for answering questions about definitions, policies, thresholds, and interpretation rules.
    > - **Structured (SQL):** The Oracle AI Database tables with project, supplier, certification, performance, recommendation, and decision data - for answering questions about specific project and supplier facts.

10. You may close the SQL Worksheet browser tab and return to the AI Data Platform tab for the remainder of the workshop.

## Lab 1 Recap

In this lab, you set up the complete data environment for the Construction Engineering Supplier Evaluation Agent:

- You created an **AI Compute** to host and execute the agent flow.
- You verified the generated **`vector_db_...`** external catalog connected to the Autonomous AI Lakehouse database.
- You created **`ce_std_catalog`** and **`ce_volume`**, then uploaded internal construction guidance documents.
- You created a **Knowledge Base** (`ce_kb`), populated it with files from the volume, and verified that the ingestion succeeded. This enables RAG - the agent can now search your internal documents by semantic meaning.
- You verified the **Oracle AI Database tables** containing construction engineering project, supplier, certification, performance, recommendation, and decision data. These power the agent's SQL tools.

In the next lab, you'll create the agent flow itself - building the agent node and wiring up the RAG and SQL tools.

## Acknowledgements

* **Author** - Eli Schilling, Cloud Architect || Evangelist
* **Contributors** - ONA Lab Engineering team
* **Last Updated By/Date** - Eli Schilling, July 2026
