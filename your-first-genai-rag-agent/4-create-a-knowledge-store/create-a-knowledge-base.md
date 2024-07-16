# Create a knowledge base

## Introduction

In this lab we are going to create a knowledge base which will consist of the text files we've uploaded to the storage bucket.
A Knowledge Base maintains information about the Data Source (where the data comes from, for example, text files in storage bucket) as well as metadata for accessing that data and in certain cases, it would also manage indexing and vector storage for the data.
Creating a Knowledge Base lets the OCI Generative AI Agents service know where our data is stored and what format it is stored in. Using this information, the service will be able to ingest the data, understand it and index it for fast retrieval later.
A single knowledge base can be used for multiple Agents.

Estimated Time: 10 minutes

### Objectives

In this lab, you will:

* Create a knowledge base

### Prerequisites

This lab assumes you have:

* An Oracle Cloud account
* All previous labs successfully completed

## Task 1: Create a knowledge base

1. From the OCI Generative AI Agents service overview page, click the **Knowledge Bases** link on the left.

1. Make sure that the root compartment is selected in the **Compartment** list under the **List scope** section on the left.

1. Click the **Create knowledge base** button at the top of the **Knowledge bases** table.

  ![Agents service navigation](./images/knowledge-base-navigation.png)

1. Provide a name for the Knowledge base (for example: oci-generative-ai-agents-cw24-hol-kb)

1. Make sure that the root compartment is selected in the **Compartment** list.

1. Make sure that the **Object storage** option is selected in the **Select data store** list.

1. Click the **Create data source** button at the top of the **Data sources** table.

1. In the **Create data source** pane, provide a name for the data source (for example: oci-generative-ai-agents-cw24-hol-ds)

1. In the **Data bucket** section, make sure that the root compartment is selected. If not, click the **Change compartment** link and select the root compartment.

1. Select the storage bucket into which you've uploaded the dataset text files in the previous lab.

1. Select the **Select all in bucket** option from the **Object prefixes** list.

1. Click the **Create** button at the bottom of the pane.

  ![Create knowledge base and data source](./images/create-data-source.png)

1. Make sure that the **Automatically start ingestion job for above data sources** option is checked.

1. Click the **Create** button at the bottom of the page.

  ![Knowledge base](./images/create-knowledge-base.png)

If everything went to plan, your Knowledge Base will be created. This can take a few minutes.

Please wait until the **Lifecycle state** shows the **Active** state before moving on to the next lab.

  ![Knowledge base](./images/knowledge-base-created.png)

  ![Knowledge base](./images/knowledge-base-active.png)

## Acknowledgements

* **Author** - Lyudmil Pelov, Senior Principal Product Manager, Yanir Shahak, Senior Principal Software Engineer
