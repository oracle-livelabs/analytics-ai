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

1. Begin at the admin console of your FAIDP instance. Select **Enable Features**

   ![FDI Admin Console](images/.png)

2. Scroll to find the **Oracle AI Data Platform** feature and select it to enable the feature. Return to the main admin console page.

   ![Enable Feature](images/.png)

   > **Note:** This step is essential to proceed with the integration.

## Task 2: Creating a Connection from FAIDP to Oracle AI Data Platform

1. From the admin console, select **Data Configuration**.

2. Next choose **Manage Connections**.

3.



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
