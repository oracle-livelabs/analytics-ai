# Setup OCI Agent RAG tool

## Introduction

This lab will guide you through the steps to set up knowledge bases, configure data sources, and connect with OCI Agents. The lab covers the following OCI Generative AI Agent concepts:

* *RAG Tool* - In Generative AI Agents, a RAG tool retrieves information from one or more knowledge bases and provides relevant, context-aware responses in natural language.
* *Knowledge Bases* - A knowledge base contains the data sources that an agent can use to retrieve information for chat responses. You can create a knowledge base in advance and then add it to an agent's RAG tool.
* *Data Source* - A data source specifies where the data resides. After adding a data source to a knowledge base, you must ingest the data so that agents using the knowledge base can access it.

Estimated Time: 30 minutes

## Task 1: Download PDFs for the RAG usage.

1. Run the command below for the Data Science notebook, or proceed to the next step for running ADK on a local machine.

   ```
   <copy>
    !mkdir pdfs
    !wget https://docs.oracle.com/en/database/oracle/sql-developer-command-line/19.2/sqcug/oracle-sqlcl-users-guide.pdf -O pdfs/oracle-sqlcl-users-guide.pdf
    !wget https://docs.oracle.com/en/database/oracle/oracle-database/26/vecse/ai-vector-search-users-guide.pdf -O pdfs/ai-vector-search-users-guide.pdf
    !wget https://docs.oracle.com/en/operating-systems/oracle-linux/10/relnotes10.0/OL10-RELNOTES-10-0.pdf -O pdfs/OL10-RELNOTES-10-0.pdf
    </copy>
    ```

    ![Download PDFs](images/download_pdfs.png)

2. Run the commands below for ADK running on a local machine.

    ```
    <copy>
    mkdir pdfs
    wget https://docs.oracle.com/en/database/oracle/sql-developer-command-line/19.2/sqcug/oracle-sqlcl-users-guide.pdf -O pdfs/oracle-sqlcl-users-guide.pdf
    wget https://docs.oracle.com/en/database/oracle/oracle-database/26/vecse/ai-vector-search-users-guide.pdf -O pdfs/ai-vector-search-users-guide.pdf
    wget https://docs.oracle.com/en/operating-systems/oracle-linux/10/relnotes10.0/OL10-RELNOTES-10-0.pdf -O pdfs/OL10-RELNOTES-10-0.pdf
    </copy>
    ```

## Task 2: Upload the PDFs to Object Storage

1. Run the commands below to upload PDFs to Object Storage:

    Via OCI Data Science notebook:

    ```
    <copy>

    oci os object bulk-upload --src-dir pdfs  -bn "<Name of the Bucket>" -ns "<Namespace Name>" --auth "resource_principal" --prefix "oracle_pdfs/"
    </copy>
    ```

    ![Uploaded file](images/file_uploaded.png)

    Via locally installed OCI CLI:

    ```
    <copy>
    oci os object bulk-upload --src-dir pdfs  -bn "<Name of the Bucket>" -ns "<Namespace Name>"  --prefix "oracle_pdfs/"
    </copy>
    ```

    You can also download and upload the files manually.

1. Validate the uploaded files via the Object Storage bucket.

    ![List files](images/os_file_list.png)

## Task 3: Create OCI AI Agents Knowledge Base

1. Open OCI Console > Analytics & AI > Generative AI Agents

    ![Agents view](images/agents_view.png)

2. Click Knowledge Bases > Create knowledge base.

    ![Create KB](images/create_kb_view.png)

3. Provide a Name and Description.

4. Select the appropriate compartment.

5. Select Data store type as Object Storage.

6. Enable the option Enable hybrid search.

    ![New KB](images/new_kb.png)

7. Click Specify data source.

    ![Click specify the DS](images/specify_datasource.png)

8. Provide Name, Description, and select the option Enable multi-model parsing.

    ![New DS](images/new_ds_basic.png)

9. Select the bucket and all the files that were uploaded.

10. Click Create.

    ![Select files](images/select_files_for_ds.png)

11. You will return to the previous screen—ensure the option Automatically start ingestion job for above data sources is selected.

12. Click Create.

    ![Create KB](images/create_kb.png)

13. The status of the knowledge base will show as Creating.

    ![KB progress](images/kb_in_progress.png)

1. Once its become active,make a note of the OCID for further steps.

    ![KB final](images/kb_active.png)

15. We will associate the knowledge base with agents later.


**Proceed to the next lab.**

## Acknowledgements

* **Author**
    * **Rahul MR**, Principal Solutions Architect - OCI 
* **Contributors**
    * **Sanjeeva Kalva**, Principal Data Scientist - OCI 











