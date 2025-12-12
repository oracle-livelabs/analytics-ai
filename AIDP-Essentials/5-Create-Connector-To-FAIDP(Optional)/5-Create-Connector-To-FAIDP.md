# Integrating Fusion AI Data Platform with Oracle AI Data Platform

## Introduction

In this lab you will go through the process of sharing data from Fusion AI Data Platform (FAIDP) with Oracle AI Data Platform. Creating shares from FAIDP to AIDP allows for seemless integration of the two systems for AI and data science tasks on your FAIDP data.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:
* Enable the Oracle AI Data Platform feature within FAIDP.
* Configure a connection from FAIDP to Oracle AI Data Platform.
* Share data from FAIDP to Oracle AI Data Platform and view it in the master catalog.

## Prerequisites

This lab assumes you have:

* Access to the admin console of a FAIDP instance.
* Familiarity with the FAIDP admin console.

## Task 1: Enabling Oracle AI Data Platform Feature in FDI

1. Begin at the admin console of your FAIDP instance. Select **Enable Features**

![FDI Admin Console](images/access-enable-features.png)

2. Scroll to find the **Oracle AI Data Platform** feature and select it to enable the feature. Return to the main admin console page.

![Enable Feature](images/enable-feature.png)

   > **Note:** This step is essential to proceed with the integration.

## Task 2: Creating a Connection from FAIDP to Oracle AI Data Platform

1. From the admin console, select **Data Configuration**.

![access data configuration](images/access-data-configuration.png)

2. Next choose **Manage Connections**.

![access manage connection](images/access-manage-connections.png)

3. Here a connection to **Oracle AI Data Platform** should now appear (may appear as **Oracle Intelligent Data Lake**). To configure this connection choose the actions menu then **Edit Connection**.

![edit connection](images/access-configure-connection.png)

4. In the popup window the top 3 fields are autofilled, complete the others. The OCIDS for various OCI resources can be found from the OCI console section for the given resource. Select **Update** when finished.

![provide connection details](images/configure-connection.png)

5. Back out to the **Data Configuration** page and select **Data Share**.

![go to data share page](images/access-data-share.png)

6. On this page you see a list of the data tables from your FAIDP instance that are available to share to external sources. Find a table you would like to share with the AIDP Workbench. Select the actions menu then **Edit**

![Select a table](images/edit-target.png)

7. In the popup window select **Oracle AI Data Platform** (may appear as **Oracle Intelligent Data Lake**) in the **Target Connections** section. Select **Update**.

![choose AIDP destination](images/update-target.png)

8. Select the data table whose target you just updated. Select **Publish** then choose **Publish** again in the popup window to publish the table to the AIDP Workbench.

![Publish data](images/publish-data.png)

9. Return to your AIDP Workbench instance. The tables shared with AIDP will appear in the master catalog, in a catalog with the name you specified when editing the connection in the FAIDP admin console. Here you can view the shared tables. It may take some time for the data to appear in AIDP Workbench after the share has been created.

![View FAIDP data](images/view-fusion-data-aidp.png)


## Learn More

- [Oracle AI Data Platform Community Site](https://community.oracle.com/products/oracleaidp/)
- [Oracle AI Data Platform Documentation](https://docs.oracle.com/en/cloud/paas/ai-data-platform/)
- [Oracle Anlaytics Training Form](https://community.oracle.com/products/oracleanalytics/discussion/27343/oracle-ai-data-platform-webinar-series)
* [Fusion Data in Oracle AI Data Platform with BICC](https://docs.oracle.com/en/cloud/paas/ai-data-platform/aidug/fusion-data-oracle-ai-data-platform.html)

## Acknowledgements
* **Author** - Miles Novotny, Senior Product Manager, Oracle Analytics Service Excellence
* **Contributors** -  Farzin Barazandeh, Senior Principal Product Manager, Oracle Analytics Service Excellence
* **Last Updated By/Date** - Miles Novotny, December 2025
