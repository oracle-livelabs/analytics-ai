# Provision Generative AI Agents Service

## Introduction

This lab walks you through the steps to setup an OCI Generative AI Agent including ingesting a knowledge base from OCI Object Storage

Estimated Time: -- minutes

### About Generative AI Agents

OCI Generative AI Agents is a fully managed service that combines the power of large language models (LLMs) with an intelligent retrieval system to create contextually relevant answers by searching your knowledge base, making your AI applications smart and efficient.

OCI Generative AI Agents supports several ways to onboard your data and then allows you and your customers to interact with your data using a chat interface or API. OCI Object Storage Service enables you to create Buckets. Once the Buckets are created, you can then upload your unstructured PDF manuals / documents in those buckets.

### Objectives

In this lab, you will:

* Create Object Storage Bucket and upload files
* Create OCI Gen AI RAG Agent
* (optional) test agent in console
* (optional) update Agent's Knowledge Base

### Prerequisites (Optional)

<!--*List the prerequisites for this lab using the format below. Fill in whatever knowledge, accounts, etc. is needed to complete the lab. Do NOT list each previous lab as a prerequisite.*-->

This lab assumes you have:

* All previous labs successfully completed

## Task 1: Provision Oracle Object Storage Bucket

This task will help you to create Oracle Object Storage Bucket under your chosen compartment.

1. Locate Buckets under Object Storage & Archive Storage

    ![object storage navigation](images/os_nav.png)

2. Provide the information for **Compartment** and **Bucket Name**. Click Create.
    The Object Storage Bucket will be created 

    ![object storage bucket creation](images/os_bucket_create.png)

## Task 2: Upload custom PDF document in the Object Storage Bucket

1. Click on the Bucket name, then Objects -> Upload button

    Click on “select files” link to select files from your machine. This step can be repeated to select multiple files to upload to the bucket.

    **Note:** The Gen AI Agents service currently supports .pdf and .txt file formats

    ![object storage select files](images/os_file_select.png)

2. Click Upload -> Close to upload the PDF file in the Object Storage Bucket.

    ![object storage upload files](images/os_upload.png)


## Task 3: Provision Knowledge Base

This task will help you to create Oracle Generative AI Agent’s Knowledge Base under your chosen compartment.

1. Locate Generative AI Agents (new Beta) under AI Services

    ![genai agent navigation](images/agent_nav.png)

2. Locate Knowledge Bases in the left panel, select the correct Compartment.

    Then click on “Create knowledge base” button

    ![knowledge base navigation](images/kb_nav.png)

3. Specify the name of the knowledge base, ensure that you have selected the correct compartment.

    Select “Object storage” in the “Select data source” dropdown, and then click on the “Specify data source” button

    1[knowledge base creation wizard](images/kb_wizard.png)

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

    Select the Knowledge Base that you created in the previous task

    Click the “Create” button.

    ![agent creation wizard](images/agent_wizard.png)

3. In few minutes the status of recently created Agent will change from Creating to Active

    Click on “Launch chat” button

    ![agent active](images/agent_active.png)

4. It’ll open up the Chat Playground, where you can ask questions in natural language, and get the responses from your PDF documents

    ![Agent Chat Playground](images/chat.png)

## Task 5: Update Agent's Knowledge Base (optional)

You may want to update your agent's knowledge base for a variety of reasons in the future. This optional tasks walks through how to do this.

1. Add/Update/Remove files from Object Storage

2. Run Ingestion Job

    **Note:** Data ingestion Jobs perform incremental ingestions from 2nd run onwards
<!-- TODO -->

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author**
* **Kaushik Kundu**, Master Principal Cloud Architect, NACIE
* **JB Anderson**, Senior Cloud Engineer, NACIE
* **Contributors** -  <Name, Group> -- optional
* **Abhinav Jain**, Senior Cloud Engineer, NACIE
* **Last Updated By/Date** - <Name, Month Year>