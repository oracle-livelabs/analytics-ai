# Lab 1: Data Environment Setup

## Introduction

Before building the AI agent, we need to ensure the data environment is in place. In this lab, you'll explore the pre-configured catalog and volume that have been set up for the workshop, then create a Knowledge Base that turns those documents into vector representations for RAG retrieval. You'll also verify the Oracle AI Database tables that will power the agent's SQL tools.

By the end of this lab, all the data assets — structured (database tables) and unstructured (knowledge base documents) — will be ready for the agent flow you'll build in Lab 2.

**Estimated Time:** 15 Minutes

### Objectives

In this lab you will:

1. Create the AI Compute instance used by the Agent (created in Lab 2)
2. Create a new standard catalog (`entertainment_analyst`) and managed volume (`entertainment_analyst`) where you'll upload release playbooks and strategy documents
3. Create a Knowledge Base and an associated data source that consumes the documents from the managed volume
4. Verify the Oracle AI Database tables that contain box office, streaming, and marketing data
5. Understand how the structured (SQL) and unstructured (RAG) data assets connect to the agent you'll build

### Prerequisites

This lab assumes you have:

* Reviewed the Workshop Introduction and Overview
* Access to the AIDP Workbench instance provisioned for this workshop

## Task 1: Create the AI Compute Instance

An AI Compute hosts your agent flows. You need an active AI Compute to test agent flows and deploy them. Think of it as the runtime engine for your agent.

1. Log into the OCI Console if you've not already done so (See **Getting Started** link in the left nav) 

    ![Animated gif showing log in and password reset](images/01-tenancy-login-reset-password.gif)

2. Click the navigation menu in the top left corner.

    ![Screenshot of main navigation menu](images/01-navigate-nav-menu.png " ")

2. Navigate **Analytics & AI** --> **AI Data Platform Workbench**.

    ![Screenshot of link to AI Data Platform menu item](images/01-navigate-ai-data-platform.png " ")

3. From the *List scope* menu on the left side of the page, click the drop-down and locate the *Compartment* assigned by the LiveLabs environment.

    ![Animated gif illustrating how to locate and select assigned compartment](images/01-tenancy-select-compartment.gif " ")

4. Click the name of the AIDP Instance to open the Workbench. The workbench will open in a new tab.

5. From the AIDP Workbench Home Page, select your workspace from the drop-down menu listing all workspaces.

    ![Use the drop-down menu to select your workspace](images/01-dashboard-select-workspace.gif " ")

6. Click on **Compute** under the selected workspace.

    ![Screenshot depicting the Compute section of workspace](images/01-aidp-navigate-compute.png " ")

7. In the Compute page, click on the **AI Compute** tab.

8. Click the **+** button to add an AI Compute.

    ![Screenshot of the AI compute tab and plus button](images/01-aidp-create-compute.png " ")

9. Enter a name and description:

    **Name**
    ```
    <copy>
    entertainment_analyst_compute
    </copy>
    ```

    **Description**
    ```
    <copy>
    AI Compute for the Entertainment Release & Performance Analyst agent
    </copy>
    ```

10. Use the default size of **1 OCPU** and **16 GB of RAM**.

11. Click **Create**..

    ![Create new AI compute dialog window](images/01-compute-create-instance.png " ")
    
    > **Note**: It may take 3-5 minutes to provision this resource. The AI Compute instance is where your agent flow executes. Once attached, any changes you make to the agent flow are automatically propagated to the AI Compute instance — meaning you can edit and test quasi-simultaneously.

12. There's no need wait for the **`entertainment_analyst_compute`** resource to finish provisioning right now. You can move to the next task. The instance should be ready to go by the time it's needed in Lab 2.

## Task 2: Create the (External) Database Catalog

An external catalog in AIDP enables you to connect to an Autonomous Lakehouse (ALH) database. In a production setting, that means you aren't moving data around to facilicate your AI solutions. Rather, you're bringing AI right to your data.

For this workshop, an ALH instance has been provisioned and loaded with sample data already. You'll be creating a new external catalog to leverage that dataset.



1. From the AIDP Workbench Home Page, click on **Master Catalog**.

    ![Screenshot of AIDP workbench home page](images/01-aidp-master-catalog.png " ")

    >Note: You will see that two catalogs already exist **`vectordb26ai`** and **`default`**. Pay no mind to these, we'll cover the steps of creating all requisite catalogs  here in this lab.

2. Click **[Create catalog]** in the upper right coner. 

    ![Screenshot of Create Catalog button](images/01-aidp-create-catalog.png " ")

3. Enter the following details:

    **Catalog name:**
    ```
    <copy>
    aidatabase
    </copy>
    ```

    **Description**
    ```
    <copy>
    A catalog that connects to the Autonomous AI Lakehouse database.
    </copy>
    ```

4. Once you select the **Catalog type**, there will be several critical configuration details. Consider watching this animation for reference before proceeding:

    ![Animation showing steps to create external catalog](images/01-catalog-add-external-details.gif " ")

5. Now, select **Catalog type** -> **External catalog**.

    >Note: The **External source type** should default to **`Oracle Autonomous AI Lakehouse`**. That is exactly what we want.

6. For **External source method** select **Choose ALH instance**.

7. Several fields should auto-populate. If the **Compartment** drop-down does not show your assigned workshop compartment, go ahead and locate / select your designated compartment.

8. Move to the **ALH instance** drop down and locate the **hol-entertainment-dev-zzz** instance. The last 8 characters will be a random string.

    >NOTE: You might see a second resource with a shorter name listed in the drop-down. This is the database instance created by AI Data Platform for storing its vector embeddings. No need to pay it any mind.

9. From the **Service** dropdown, select the label that ends with **_high** to choose the high priority Data Source Name (DSN). This is the connection string AIDP will use for high-priority access to the database.

10. Enter authentication details:

    - **Wallet password (optional)**: You may choose your own password, or leave this field blank and allow AIDP to manage the wallet password.
    - **Username**: ENTERTAINMENT
    - **ADM Admin Password**: Retrieved from the LiveLabs instructions page -> View Login Info -> Terraform Outputs -> ADB Admin Password.

    > **Important** You'll need the **`ADB Admin Password`** found in the **`View Login Info`** on the LiveLabs workshop page (covered in the **Getting Started** section). Scroll down under **Reservation Information** and you should see a **Terraform Outputs** section.

    ![Screenshot of ADB admin password location](images/01-database-retrieve-password.png " ")

11. Click **[Test connection]** - confirm that the connection is successful.

    >Note: If the connect returns an error or is otherwise not successful, contact a workshop facilitator. Do not proceed to the next step.

12. Click **[Create]**.

    ![Screenshot of the create catalog dialog](images/01-catalog-add-external.png " ")
 
## Task 3: Create the (Standard) Entertainment Analyst Catalog

A standard catalog in AIDP stores AI-related artifacts — volumes, tables, schemas, and knowledge bases. For this workshop, you'll be creating a new standard catalog.

1. From the AIDP Workbench Home Page, click on **Master Catalog**.

2. Click **[Create catalog]** in the upper right corner and provide the following: 

    **Catalog name**
    ```
    <copy>
    entertainment_analyst
    </copy>
    ```

    **Description**
    ```
    <copy>
    A catalog that stores the assets needed by the entertainment industry analyst agent.
    </copy>
    ```

3. Click **[Create]**

    ![Master Catalog interface - create new standard catalog](images/01-catalog-create.png)

4. It will take just a moment to create the new catalog. When ready, click **entertainment_analyst** to open the new catalog.

    > **Note**: a **Standard Catalog** means it stores data directly within AIDP (backed by OCI Object Storage and [Delta Lake](https://delta.io/) open source file format), as opposed to an External Catalog which connects to data outside the platform.

5. Click on the **default** schema within the catalog. This is where the volume and knowledge base assets are organized.

    ![Catalog interface - resource types inside entertainment_analyst](images/01-catalog-view-components.png)

## Task 4: Create the Managed Volume

A volume stores unstructured data — files, documents, images — within a catalog. The volume for this workshop contains the internal release playbooks and strategy documents that the RAG tool will search.

1. First off, [Click Here](https://github.com/oracle-livelabs/analytics-ai/raw/refs/heads/main/ai-dataplatform-agent-flow-entertainment/files/kb_documents.zip) to download the Zip file containing all the sample docs required for this workshop.

2. Unzip the file; you should have 3 `.docx` files pertaining to the Knowledge Base components that will be built here in Lab 1.

    - **Content Strategy & Release Operations Playbook** — Defines release windows, territory prioritization, green/yellow/red performance signals, and decision frameworks
    - **Marketing Measurement & Attribution Guidelines** — Defines metric definitions (e.g., completion rate, ROI), attribution logic, and interpretation rules
    - **Distribution Window & Territory Rules** — Defines territorial constraints, windowing strategies, and market codes

3. Back in the AIDP Workbench browser window, return to the **`entertainment_analyst`** catalog, locate the **default** schema, click on **Volumes**.

4. Click the **+** next to the filter field to start creating a new volume.

    ![Volumes interface - add new volume button](images/01-catalog-add-volume.png " ")

5. Provide a name and description for the volume:

    **Name**
    ```
    <copy>
    entertainment_analyst
    </copy>
    ```

    **Description**
    ```
    <copy>
    This volume stores release playbooks, market prioritization, etc.
    </copy>
    ```

    ![Create new volume](images/01-catalog-create-volume.png " ")

6. Click the volume name **`entertainment_analyst`** then click the **+** button to the right of the Filter field then click **`Upload file`**.

7. Click to browse or drag-and-drop the three `.docx` files from the Zip archive you downloaded earlier.

    ![Upload files interface](images/01-catalog-volume-upload-files.png " ")

8. Click **[Upload]**, then review the files. You should see the following internal documents:

    ![Verify files uploaded successful](images/01-catalog-volume-upload-files-complete.png " ")

8. These are the documents that the AI agent will search via RAG when users ask questions about definitions, policies, thresholds, or interpretation rules. For example, when a user asks *"What does our playbook say about territory priorities for releases?"*, the agent will retrieve relevant passages from these documents.

## Task 5: Create a Knowledge Base

Now we'll create the key asset that enables RAG. A Knowledge Base creates vector representations (embeddings) of the documents in the volume. When the agent receives a question, it performs a semantic search against these vectors to find the most relevant passages — even if the user's wording doesn't exactly match the document text.

1. Navigate back to the **`entertainment_analyst`** catalog. Click on the **default** schema.

2. Click on **Knowledge Bases**.

3. Click the **+** button to create a new Knowledge Base.

4. Enter the following values:

    **Name**
    ```
    <copy>
    entertainment_analyst_kb
    </copy>
    ```

    **Description**
    ```
    <copy>
    Contains internal release playbooks, marketing guidelines, and distribution rules.
    </copy>
    ```

    ![Create a new knowledgebase in the catalog](images/01-catalog-create-kbase.png " ")

5. Leave the **Advanced Settings** as-is for now. These settings control the embedding model, chunk size, and chunk overlap. The defaults are appropriate for this workshop.

6. Click **Create**. The Knowledge Base will take a few moments to become Active.

7. Once the Knowledge Base shows status **Active**, click on it to open the details.

    ![Verify knowledge base status is Active](images/01-catalog-kbase-active.png " ")

8. Under the **Data Source** tab, click the **+** button to add a data source.

    ![Add data source to entertainment_analyst_kb](images/01-catalog-kbase-add-datasource.png " ")

9. In the data source selection window, select the **`entertainment_analyst`** volume from your catalog. This is the volume containing the release strategy and playbook documents. Leave all advanced settings as-is.

10. Click **Add**.

    ![Select and add the entertainment_analyst data source](images/01-catalog-kbase-add-select-datasource.png " ")

11. Navigate to the **History** tab of your Knowledge Base. You should see a line entry with the operation name **"Update Knowledge Base"**. This step ingests the documents — chunking them, generating embeddings, and indexing the vectors.

    ![Knowledgebase is ingesting documents from the data source](images/01-catalog-kbase-ingest-docs.png " ")

12. Wait for the status to show **Succeeded** before moving on. This typically takes less than one minute since we're ingesting a small set of documents.

    > **What just happened?** The Knowledge Base chunked each document into smaller passages, generated vector embeddings for each chunk using an embedding model, and stored those vectors in an index. When the RAG tool receives a query, it converts the query into a vector, finds the most semantically similar chunks, and returns them as context for the LLM. This is how the agent can answer policy and definition questions grounded in your actual internal documents.

## Task 6: [Optional] Verify the Oracle AI Database Tables

The agent's SQL tools query structured data from an Oracle AI Database. For this workshop, the following tables have been pre-ingested with entertainment performance data.

1. When you clicked the link to access the AIDP Workbench, it would have opened in a new browser tab. Locate and select the browser tab or window that still contains the OCI Console (it might say AI DataPlatform Workbench).

    ![Change browser tabs](images/01-switch-browser-tabs.png " ")

2. Use the navigation menu to open the Autonomous AI Database Console.

    ![OCI Nav menu - Autonomous AI Database console](images/01-navigate-autonomous-ai-database.png " ")

3. Make sure the **Applied filters** matches your assigned compartment.

    ![Screenshot of the AI database console page](images/01-database-console.png " ")

4. You should see two database instances here. Click the name of the autonomous database that starts with **hol-entertainment-** to view details. 

5. When the page loads, click **[Database actions]** and select **SQL**.  This will open the SQL Workbench in a new brower tab.

6. In the *Navigator* on the left, click the first drop-down menu and locate the **Entertainment** schema. 

    * You should see the following tables populate below.

    | Table Name | Description | Key Columns |
    |---|---|---|
    | `titles` | Master list of all movies and TV shows | `title_id`, `title_name` |
    | `markets` | Reference table of market codes, names, and currencies | `market_code`, `market_name`, `currency` |
    | `box_office_weekend` | Weekend theatrical performance by title and market | `title_id`, `weekend_end_date`, `market_code`, `gross_usd_m`, `screens`, `rank` |
    | `streaming_weekly` | Weekly streaming metrics by title and region | `title_id`, `week_start_date`, `region_code`, `starts`, `hours_streamed_k`, `completion_rate` |
    | `marketing_campaigns` | Campaign metadata linking campaigns to titles | `campaign_id`, `campaign_name`, `title_id`, `start_date`, `end_date` |
    | `marketing_daily_spend` | Daily spend and attributed revenue by campaign and channel | `campaign_id`, `channel`, `spend_usd`, `attributed_revenue_usd` |

5. To check the data in the tables, you will need to enter a query in the worksheet screen as shown below. Click the green play button to **`Run Statement`**. 

    ```sql
    <copy>
    select * from ENTERTAINMENT.marketing_daily_spend;
    </copy>
    ```

    ![Input SQL query and click run button](images/01-sql-test-query.png " ")

    ![SQL query output](images/01-sql-test-query-output.png " ")

6. If you want to query multiple tables at the same time, just separate them with a **"/"** like this, and click the **`Run Script`** icon which is just to the right of Run Statement (Play button):

    ![Image of multi-table query](images/01-sql-workbench-note.png " ")

    >Note: Selecting the table in the left nave bar will only show the columns in the table, not the data.  To review the data you must query with a SQL statement as shown.

7. These tables represent the **gold layer** of the medallion architecture — curated, query-optimized data ready for business consumption. The agent's SQL tools will execute parameterized, read-only queries against these tables to answer performance and ROI questions.


    > **Key takeaway**: You now have two categories of data assets ready for the agent:
    > - **Unstructured (RAG)**: The Knowledge Base with vector-indexed release playbooks and strategy documents — for answering questions about definitions, policies, and interpretation rules
    > - **Structured (SQL)**: The Oracle AI Database tables with box office, streaming, and marketing data — for answering questions about specific metrics, trends, and ROI numbers

8. You may close the SQL Workbench browser tab and return to the AI Data Platform tab for the remainder of the workshop.

## Lab 1 Recap

In this lab, you set up the complete data environment for the Entertainment Analyst agent:

- You created an **AI Compute** to host and execute the agent flow.
- You created a new **`AiDatabase`** external catalog connecting to the Autnomous Lakehouse AI Database instance.
- You created a new **`entertainment_analyst`** standard catalog and a **`entertainment_analyst`** volume, then uploaded internal release playbooks and strategy documents.
- You created a **Knowledge Base** (`entertainment_analyst_kb`), populated it with documents from the volume, and verified that the ingestion succeeded. This enables RAG — the agent can now search your internal documents by semantic meaning.
- You verified the **Oracle AI Database tables** containing box office, streaming, and marketing campaign data. These power the agent's SQL tools.

In the next lab, you'll create the agent flow itself — building the agent node and wiring up the RAG and SQL tools.

## Learn More

* [Unlock the Power of the Catalog in AIDP Workbench — Oracle Community](https://community.oracle.com/products/oracleaidp/discussion/27748/unlock-the-power-of-the-catalog-in-aidp-workbench)
* [AIDP Workbench FAQs: Collaboration, Medallion Architecture, and Data Storage — Oracle Community](https://community.oracle.com/products/oracleanalytics/discussion/28251/aidp-workbench-faqs-collaboration-medallion-architecture-and-data-storage)
* [Oracle AI Data Platform — Documentation](https://docs.oracle.com/en/cloud/paas/ai-data-platform/)
* [Oracle AI Data Platform — Sample Notebooks on GitHub](https://github.com/oracle-samples/oracle-aidp-samples)

## Acknowledgements

* **Author(s)** - Jean-Rene Gauthier [AIDP]
* **Contributors** - Eli Schilling - Cloud Architect, Gareth Nathan - SDE, GenAI
* **Last Updated By/Date** - Published March 2026
