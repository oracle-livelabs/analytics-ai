# Oracle AI Data Platform: Medallion Architecture Demo

## Introduction

This lab guides you through creating a medallion architecture using the Oracle AI Data Platform (AIDP). You'll learn how to set up workspaces, configure compute resources, and implement a multi-tier data processing pipeline.

Estimated Time: 60 minutes

### About Oracle AI Data Platform

Oracle AI Data Platform simplifies cataloging, ingesting, and analyzing data for data professionals in an organization. It provides a unified workspace for building, managing, and deploying AI and data-driven solutions.

### Objectives

In this lab, you will:

- Create and configure a workspace in AIDP Workbench.
- Set up and manage compute resources.
- Implement a medallion architecture with Bronze, Silver, and Gold data layers.
- Utilize AI functionalities to enhance data processing.

### Prerequisites

This lab assumes you have:

- An Oracle Cloud account.
- Completed the previous lab on setting up the AIDP environment.

## Task 1: Pre-Webinar Setup

1. **Prepare the Environment**

   - Ensure your Oracle Cloud instance from the previous lab is ready.
   - If unavailable, set up a new instance and complete the initial configurations.

2. **Create Workspace and Upload Notebooks**

   - In AIDP Workbench, create a new workspace.
   - Organize the workspace with folders: `bronze`, `silver`, `gold`, and `misc`.
   - Upload the provided demo notebooks into their respective folders based on their names.

3. **Create Compute Cluster**

   - Within the workspace, navigate to the Compute tab.
   - Create a new compute cluster to run the notebooks.
   - Configure the cluster with appropriate settings for your workload.

## Task 2: Introduction

1. **Review Previous Session**

   - Navigate to the master catalog to review assets created in the previous session.
   - Discuss the types of catalog assets and their roles in the data pipeline.

2. **Overview of AIDP Tools**

   - Introduce key AIDP components: Workspaces, Compute Clusters, and Notebooks.
   - Highlight how these tools facilitate data processing and AI model development.

## Task 3: Workspace and Compute Creation

1. **Create a Workspace**

   - In AIDP Workbench, select the Workspaces tab.
   - Click the plus icon to create a new workspace.
   - Name the workspace and select the default catalog.

2. **Create a Compute Cluster**

   - Within the newly created workspace, navigate to the Compute tab.
   - Click the plus icon to create a new compute cluster.
   - Configure the cluster by selecting runtime, driver and worker shapes, and the number of workers.
   - Return to the base configuration and choose "Create" to provision the compute resource.

## Task 4: Medallion Architecture Implementation

1. **Access Pre-Created Workspace**

   - Use the dropdown next to the workspace name to access a pre-created workspace.
   - Review the different folders and files to understand the pre-configured environment.

2. **Access Pre-Created Compute Cluster**

   - Navigate to the Compute tab and select the pre-created cluster.
   - Explore the different tabs to understand the compute cluster's configuration and status.

3. **Create Bronze Layer**

   - Open the `upload_from_volume.ipynb` notebook in the `bronze` folder.
   - Programmatically create a catalog and schema if not already present.
   - Read data from a volume and create a Bronze table in the catalog.

4. **Transform Data to Silver Layer**

   - Open the `silver_transformation.ipynb` notebook in the `silver` folder.
   - Read data from the Bronze table, add necessary columns, and write to the Silver catalog.
   - Utilize AI functionalities to enhance the Silver table, such as adding a continent column using GenAI models.

5. **Summarize Customer Feedback with AI**

   - Access the `silver_transformation_summary.ipynb` notebook.
   - Use GenAI models to summarize customer feedback and provide sentiment scores.
   - Write the summarized data to the Silver catalog.

6. **Join Silver Tables into Gold Layer**

   - Open the `silver_join.ipynb` notebook.
   - Join two Silver tables and write the combined data to the Gold tier.

7. **Write Gold Data to Database**

   - Access the `gold_join_into_DB.ipynb` notebook.
   - Transfer the clean, curated, and enriched data from the Gold tier into the database for final use.

## Task 5: AI Agent for Compliance

1. **Verify Blacklisted Suppliers**

   - Open the `GenAi_Agent.ipynb` notebook.
   - Explain the code and use case for checking unapproved suppliers.
   - Demonstrate how blacklisted suppliers are identified to illustrate compliance capabilities.

## Task 6: Optional GenAI Access Methods

1. **Explore Different GenAI Access Options**

   - If time permits, open the `access_GenAI_multiple_ways.ipynb` notebook.
   - Show various methods for calling LLMs in the notebook interface.
   - Discuss the value of different approaches to accessing GenAI services.

## Task 7: Closing

1. **Recap Progress and Next Steps**

   - Review the accomplishments of the demo, including the creation of the medallion architecture and the use of AI functionalities.
   - Navigate around AIDP to highlight the data assets created during the demo.
   - Encourage questions or discussions to clarify any points.

## Learn More

- [Oracle AI Data Platform Documentation](https://docs.oracle.com/en/cloud/paas/ai-data-platform/)
- [Oracle LiveLabs Workshops](https://livelabs.oracle.com/)
- [Oracle AI Data Platform Webinar Series](https://community.oracle.com/products/oracleanalytics/discussion/27343/oracle-ai-data-platform-webinar-series)

## Acknowledgements
* **Author** - Miles Novotny, Senior Product Manager, Oracle Analytics Service Excellence
* **Contributors** -  Farzin Barazandeh, Senior Principal Product Manager, Oracle Analytics Service Excellence
* **Last Updated By/Date** - Miles Novotny, December 2025
