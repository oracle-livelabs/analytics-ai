# Integrating Fusion AI Data Platform with Oracle AI Data Platform

## Introduction

This lab guides you through the process of integrating Fusion AI Data Platform (FAIDP) with Oracle AI Data Platform to share and analyze data across platforms.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:
* Enable the Oracle AI Data Platform feature within FAIDP.
* Create a connection from FAIDP to Oracle AI Data Platform.
* Share data from FAIDP to Oracle AI Data Platform.

## Prerequisites

This lab assumes you have:
* An Oracle Cloud account with access to both Fusion Data Intelligence and Oracle AI Data Platform.
* Basic knowledge of data integration concepts.

## Task 1: Enabling Oracle AI Data Platform Feature in FDI

1. Begin at the admin console of your FAIDP instance. **Access FDI Admin Console:**
   - Log in to your Fusion Data Intelligence instance.
   - Navigate to the **Admin Console**.

   ![FDI Admin Console](images/fdi_admin_console.png)

2. **Enable the Feature:**
   - Go to the **Enable Features** page.
   - Scroll down to find **Oracle AI Data Platform**.
   - Toggle the feature to **Enabled**.

   ![Enable Feature](images/enable_feature.png)

   > **Note:** This step is essential to proceed with the integration.

## Task 2: Creating a Connection from FDI to Oracle AI Data Platform

1. **Navigate to Data Configuration:**
   - In the FDI Admin Console, select **Data Configuration** and then **Manage Connections**.

   ![Data Configuration](images/data_configuration.png)

2. **Create a New Connection:**
   - Click on **Create Connection**.
   - Select **Oracle AI Data Platform** as the connection type.
   - Enter the required credentials:
     - **Object Storage Bucket Name**
     - **Object Storage Namespace**
     - **Object Storage Host Name**
     - **AI Data Platform Instance OCID**
     - **User OCID with API Key Access**

   ![Create Connection](images/create_connection.png)

   > **Note:** Ensure that all credentials are accurate and have the necessary permissions.

## Task 3: Sharing Data from FDI to Oracle AI Data Platform

1. **Access Data Sharing:**
   - In FDI, navigate to the **Data Sharing** section.

   ![Data Sharing](images/data_sharing.png)

2. **Create a Data Share:**
   - Click on **Create Share**.
   - Name the share and select the data assets to include.
   - Add recipients by entering their email addresses.
   - Click **Share** to initiate the data sharing process.

   ![Create Data Share](images/create_data_share.png)

   > **Note:** Data shares allow for seamless collaboration and data integration between platforms.

## Learn More

* [Fusion Data in Oracle AI Data Platform with BICC](https://docs.oracle.com/en/cloud/paas/ai-data-platform/aidug/fusion-data-oracle-ai-data-platform.html)

## Acknowledgements
* **Author** - Miles Novotny, Senior Product Manager, Oracle Analytics Service Excellence
* **Contributors** -  Farzin Barazandeh, Senior Principal Product Manager, Oracle Analytics Service Excellence
* **Last Updated By/Date** - Miles Novotny, December 2025
