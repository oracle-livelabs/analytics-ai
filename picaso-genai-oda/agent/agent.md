# Provision Generative AI Agents Service

## Introduction

This lab walks you through the steps to setup an OCI Generative AI Agent including ingesting a knowledge base from OCI Object Storage

Estimated Time: 30 minutes

### About Generative AI Agents

OCI Generative AI Agents is a fully managed service that combines the power of large language models (LLMs) with an intelligent retrieval system to create contextually relevant answers by searching your knowledge base, making your AI applications smart and efficient.

OCI Generative AI Agents supports several ways to onboard your data and then allows you and your customers to interact with your data using a chat interface or API. OCI Object Storage Service enables you to create Buckets. Once the Buckets are created, you can then upload your unstructured PDF manuals / documents in those buckets.

### Objectives

In this lab, you will:

* Create Object Storage Bucket and upload files
* Create OCI Gen AI RAG Agent
* (optional) test agent in console
* (optional) update Agent's Knowledge Base

### Prerequisites

This lab assumes you have:

* All previous labs successfully completed
* Permissions to manage OCI Services: Generative AI Agents, Object Storage
* Access to a Region where the Agent service is available: Chicago, Frankfurt

## Task 1: Provision Oracle Object Storage Bucket

This task will help you to create Oracle Object Storage Bucket under your chosen compartment.

1. Locate Buckets under Object Storage & Archive Storage

    ![object storage navigation](images/os_nav.png)

2. Provide the information for **Compartment** and **Bucket Name**. Click Create.
    The Object Storage Bucket will be created

    ![object storage bucket creation](images/os_bucket_create.png)

    <!--TODO: may need object events and may want object versioning -->

## Task 2: Upload PDF Document(s) to the Object Storage Bucket

1. Click on the Bucket name, then Objects -> Upload button

    Click on “select files” link to select files from your machine. This step can be repeated to select multiple files to upload to the bucket.

    **Note:** The Gen AI Agents service currently supports .pdf and .txt file formats

    <!--TODO: should we provide a sample dataset? -->

    ![object storage select files](images/os_file_select.png)

2. Click Upload -> Close to upload the PDF file in the Object Storage Bucket.

    ![object storage upload files](images/os_upload.png)

## Task 3: Provision Knowledge Base

This task will help you to create Oracle Generative AI Agent’s Knowledge Base under your chosen compartment.

1. Locate Generative AI Agents under AI Services

    ![genai agent navigation](images/agent_nav.png)

2. Locate Knowledge Bases in the left panel, select the correct Compartment.

    Then click on “Create knowledge base” button

    ![knowledge base navigation](images/kb_nav.png)

3. Specify the name of the knowledge base, ensure that you have selected the correct compartment.

    Select “Object storage” in the “Select data source” dropdown, and then click on the “Specify data source” button

    ![knowledge base creation wizard](images/kb_wizard.png)

4. Specify the name of the data source and Description (Optional)

    Select the bucket that you have created in the previous lab, and for Object prefix choose “Select all in bucket”

    Click the “Create” button

    ![knowledge base data source](images/kb_data_source.png)

5. Click the “Create” button to create the knowledge base

    ![knowledge base creation](images/kb_create.png)

6. In few minutes the status of recently created Knowledge Base will change from Creating to Active

    ![knowledge base active](images/kb_active.png)

## Task 4: Provision Agent

This task will help you to create Oracle Generative AI Agent under your chosen compartment.

1. Locate Agents in the left panel, select the correct Compartment.

    Then click on “Create agent” button

    ![agent](images/agent.png)

2. Specify the agent name, ensure the correct compartment is selected and indicate a suitable welcome message

    Select the Knowledge Base that you created in the previous task. Provide a Welcome message.

    Click the “Create” button.

    ![agent creation wizard](images/agent_wizard.png)

3. In few minutes the status of recently created Agent will change from Creating to Active

    Click on “Endpoints” menu item in the left panel and then the Endpoint link in the right panel.

    ![agent active](images/agent_active_endpoint.png)

4. It’ll open up the Endpoint Screen. Copy and keep the OCID of the Endpoint. It’ll be used later.

   Click on “Launch chat” button

   ![agent endpoint](images/agent_endpoint.png)

5. It’ll open up the Chat Playground, where you can ask questions in natural language, and get the responses from your PDF documents

    ![Agent Chat Playground](images/agent_launch_chat.png)

## Task 5: Update Agent's Knowledge Base (optional)

You may want to update your agent's knowledge base for a variety of reasons in the future. This optional tasks walks through how to do this manually.

1. Add/Update/Remove files from Object Storage

    follow the same steps as in [Task 2](#task-2-upload-pdf-documents-to-the-object-storage-bucket)

2. Navigate to Data Source

    ![knowledge base nav](images/kb_nav.png)

    * In the Generative AI Agents Service, navigate to the **knowledge bases** view
    * Click on the name of your knowledge base in the list
    * Click on the name of your data source in the list

3. Run Ingestion Job

    ![data source details](images/data_source.png)
    * Click **Create Ingestion Job**
    * Provide a unique name and optional description
    * click **Create**

    **Note:** Data ingestion Jobs perform incremental ingestion from 2nd run onwards. The time this job takes is proportional to the amount of changes you made to your data source.

## Acknowledgements

* **Author**
    * **Kaushik Kundu**, Master Principal Cloud Architect, NACIE
    * **JB Anderson**, Senior Cloud Engineer, NACIE
* **Contributors**
    * **Abhinav Jain**, Senior Cloud Engineer, NACIE
* **Last Updated By/Date**
    * **JB Anderson**, Senior Cloud Engineer, NACIE, October 2024
