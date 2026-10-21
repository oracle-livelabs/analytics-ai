
# Introduction

## About This Workshop
We will create a Enterprise AI / Hybrid Search web application, using Terraform. This application will search documents using OCI Database with PostgreSQL and the pgvector extension. pgvector will turn our OCI Database with PostgreSQL into a vector database where we can natively store and manage vector embeddings while handling unstructured data like pdf documents and html files.

We’ll be able to search documents like:
- PDF with text 
- HTML files
- Text Files
- CSV files
- XML files

![Screenshot](images/app-demo-screenshot.png)

The website created during the workshop has several ways to search:
- Full Text Search: Based on *Words* in the documents
- Semantic Search: Based on the *Meaning* (Vector Search)
- Hybrid: Based on the 2 above search
- RAG (Retrieval Augmented Generation): Answer questions based on documents

The procedures in this workshop are designed for users that have obtained an Oracle Cloud free trial account with active credits. The procedures will also work for other Oracle Cloud accounts but may, in some cases, require minor adaptation.

Estimated Workshop Time: 90 minutes

### Architecture

It works like this:
1. A document is uploaded in the Search App
2. The document is converted, parsed & cleaned.
3. Using an embedding model, vector embeddings are created and stored in OCI PostgreSQL database
4. You can now ask natural language questions in the App to retrieve results using a combination of semantic search using pgvector and OCI Enterprise AI service LLM.


This picture shows the ingestion, embeddings and RAG pipeline workflow.

![Workflow](images/ai-workflow-1.png)

![Workflow](images/ai-workflow-3.png)


### Objectives

- Provision the services needed for the system
    - Compartment, VCN, Compute instance, PostgreSQL, and Enterprise AI services.

## Prerequisites
### Cloud Account
You need an Oracle Cloud account (i.e. access to an OCI tenancy) to complete this workshop. Participants can take advantage of Oracle's free trial account that comes with free cloud credits that are good for 30 days or until used up. Many Oracle events, such as CloudWorld, offer trial accounts with extra free cloud credits. You should be able to complete this workshop in the allotted time if your free trial cloud account is already created and ready to use. If you previously had a free trial account but the credits have expired, you won't be able to complete the lab. An option in this case is to obtain a new free trial account with fresh credits using a different email address. You can also use an existing paid Oracle Cloud account as long as you have administrator rights that will be needed to provision services.

### Laptop
You need a macOS or Windows 10/11 computer (laptop or desktop) with a web browser, a text editor, and internet access. Chrome, Edge, or another current browser is recommended. Windows participants also need the OpenSSH Client and Git for Windows; Lab 1 includes preflight checks. Attempting this workshop on a tablet or phone is not recommended and has not been tested.

### Region
This workshop is validated in the **US Midwest (Chicago)** region (`us-chicago-1`) and uses it by default. Ashburn can be used only if you deliberately change the Console region, Terraform region, OCI Generative AI endpoint, and model OCID so that they all use the same region.

- For a Free Trial account, create the trial in Chicago when possible.
- For a paid account, subscribe to Chicago if it is not already available in the tenancy. Use Ashburn only when Chicago is unavailable.


**Please proceed to the [next lab.](#next)**

## Acknowledgements 

- **Author**:
    - Shadab Mohammad, Master Principal Cloud Architect, January 2026
- **Contributors**:
    - Kaushik Kundu, Master Principal Cloud Architect
    - Sasanka Abeysinghe, Principal Cloud Architect
    - Luke Farley, Senior Cloud Engineer
- **Last Updated By** - Luke Farley, Senior Cloud Engineer, September 2026
