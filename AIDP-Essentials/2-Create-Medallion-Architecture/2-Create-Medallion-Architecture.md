# Oracle AI Data Platform: Medallion Architecture Demo

## Introduction

This lab guides you through creating a medallion architecture using the Oracle AI Data Platform (AIDP). You'll learn how to set up workspaces, configure compute resources, and implement a multi-tier data processing pipeline.

Estimated Time: 60 minutes

### Objectives

In this lab, you will:

- Create and configure a workspace in AIDP Workbench.
- Create a compute cluster in the workspace.
- Use the AIDP Workbench notebook interface to implement a medallion architecture with Bronze, Silver, and Gold data layers.
- Utilize AI functionalities to enhance data processing.

### Prerequisites

This lab assumes you have:

- An Oracle Cloud account.
- Completed the previous lab.

## Task 1: Create Workspace and Compute Cluster

1. In your AIDP Workbench, select the **Workspace** tab and choose **Create**.

2. Name the workspace **Medallion_Arch** then select **Create**. While it provisions notice that there is a default workspace already populated in the instance whose name we specified when creating the AIDP Workbench instance.

3. Select the workspace name to enter it. We would like to create folders for the notebooks we create associated with the bronze, silver, and gold medallion tiers. Select the plus icon then **Folder**

4. Name the folder **Bronze** then select **Create**. Repeat this two more times to make folders named **Silver** and **Gold**.

5. Review the permissions associated with the **Bronze** folder by selecting the actions menu for the folder then choosing **Permissions**.

6. Select the plus icon and review how permissions on a folder can be given to roles or individual users. These role-based access controls allow fine grain control over security and collaboration in AIDP Workbench.

7. Next create a compute cluster in the workspace. Select **Compute** from the menu then the plus icon.

8. Name the compute cluster **Medallion__Compute**. Cluster creation defaults to a **Quickstart** setting which creates a small cluster that spins up very quickly. Deselect **Autoscale** and leave all other selections as is. Feel free browse and look at the compute shape options under the **Custom** section.

9. The cluster will become available after a few moments. Select its name to view its details. Here you can learn more about a cluster, including which notebooks it is used by. Additionally in the **Library** section you can install libraries from a **requirements.txt** file.

## Task 2: Import and Run Notebooks

1. Now you will import the notebooks used to run the Python code that processes your data into the 3 tiers of the medallion architecture. Select the **Medallion_Arch** workspace name from the menu then navigate to the **Bronze** folder.

2. Now to import the notebook used to create the bronze tier. Select the upload file icon.

3. Upload the _____ file and select **Upload**.

4. Repeat the same process for the **Silver** and **Gold** folders. Upload the _______ folders into the **Silver** folder and the ____ file into the **Gold** folder.

5. Return to the **Bronze** folder and select the _____ file to open it in the notebook interface.

6. Once in the notebook interface you need to attach a compute cluster on which to run the code. Select ______.

7. Scroll through the notebook and review the code you are about to run. This notebook

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
