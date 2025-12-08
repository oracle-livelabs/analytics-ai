# Connecting Oracle AI Data Platform to Oracle Analytics Cloud (OAC)

## Introduction

This lab demonstrates how to establish a connection between Oracle AI Data Platform and Oracle Analytics Cloud (OAC) to visualize and analyze data.

Estimated Time: 30 minutes

### Objectives

In this lab, you will:
* Generate and download the necessary connection configuration file from Oracle AI Data Platform.
* Create a connection in OAC using the configuration file.
* Access and utilize data from Oracle AI Data Platform within OAC.

## Prerequisites

This lab assumes you have:
* An Oracle Cloud account with access to both Oracle AI Data Platform and Oracle Analytics Cloud.
* Basic understanding of data visualization concepts.

## Task 1: Generating the Connection Configuration File

1. **Access Oracle AI Data Platform:**
   - Log in to your Oracle AI Data Platform instance.
   - Navigate to the **Compute** section and select your compute cluster.

   ![Compute Cluster](images/compute_cluster.png)

2. **Download the Configuration File:**
   - Within the compute cluster details, go to the **Connection Details** tab.
   - Under "Connect to BI Tool," select **OAC** and download the `config.json` file.

   ![Download Config File](images/download_config_file.png)

   > **Note:** This file contains the necessary credentials and configurations for establishing the connection.

## Task 2: Creating the Connection in Oracle Analytics Cloud

1. **Access OAC:**
   - Log in to your Oracle Analytics Cloud instance.
   - Navigate to the **Data** tab and click on **Connections**.

   ![OAC Connections](images/oac_connections.png)

2. **Create a New Connection:**
   - Click on **Create** and select **Oracle AI Data Platform** as the connection type.
   - Upload the previously downloaded `config.json` file.
   - Enter the private API key associated with your Oracle Cloud user.
   - Specify the catalog name you wish to access (e.g., `gold_supplier`).
   - Click **Create** to establish the connection.

   ![Create OAC Connection](images/create_oac_connection.png)

   > **Note:** Ensure that the private API key is generated and accessible from your OCI console.

## Task 3: Accessing Data from Oracle AI Data Platform in OAC

1. **Explore the Connection:**
   - Within OAC, select the newly created connection.
   - Expand the **Schemas** tab to view available data assets.

   ![Explore Connection](images/explore_connection.png)

2. **Create a Dataset:**
   - Drag a table from the connection into the workspace to create a new dataset.
   - Utilize this dataset to build visualizations and analyses within OAC.

   ![Create Dataset](images/create_dataset.png)

   > **Note:** Currently, the connection can only be made to a single catalog, not the master catalog.

## Learn More

* [Connecting to AI Data Platform](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acsds/connect-ai-data-platform.html)

## Acknowledgements
* **Author** - Miles Novotny, Senior Product Manager, Oracle Analytics Service Excellence
* **Contributors** -  Farzin Barazandeh, Senior Principal Product Manager, Oracle Analytics Service Excellence
* **Last Updated By/Date** - Miles Novotny, December 2025
