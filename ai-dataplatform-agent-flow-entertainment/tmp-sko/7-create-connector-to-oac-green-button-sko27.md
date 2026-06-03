# Create Connection from Oracle AI Data Platform Workbench to Oracle Analytics Cloud (OAC)

## Introduction

In this lab you will learn how to establish a connection between Oracle AI Data Platform Workbench and Oracle Analytics Cloud (OAC) to visualize and analyze your AIDP data in OAC. This optional lab requires access to an OAC instance where you can create the connection, because you cannot create one in the lab tenancy.

Estimated Time: 20 minutes

### Objectives

In this lab, you will:
* Generate an API key pair to be used when defining the connection.
* Generate and download the connection configuration file from Oracle AI Data Platform.
* Create a connection in OAC to AIDP Workbench using the config file and API key.


### Prerequisites

This lab assumes you have:
* Access to an Oracle Analytics Cloud (OAC) instance (you cannot create one in your lab tenancy).
* Familiarity with Oracle Analytics Cloud.

## Task 1: Generate an API Key pair

You will need an API key to create the connection between OAC and AIDP Workbench.

1. From any page in the OCI Console, select the **Profile** icon then select your username.

    ![access profile](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/7-create-connector-to-oac-green-button/images/access-user-profile.png)

2. Select the **Tokens and keys** tab and then **Add API key**

    ![add api key](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/7-create-connector-to-oac-green-button/images/access-api-key.png)

3. Keep **Generate API key pair** selected. Select **Download private key** then choose **Add**.

    ![download private key](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/7-create-connector-to-oac-green-button/images/add-api-key.png)

## Task 2: Generate the Connection Configuration File

To connect AIDP Workbench and OAC, you first need a config file from the compute cluster you will use for the connection.

1. Return to the AIDP Workbench. Select **Compute** from within your workspace and then the **Medallion_Compute** cluster.

    ![navigate to compute](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/7-create-connector-to-oac-green-button/images/access-compute.png)

2. Select the **Connection Details** tab. Select the **Oracle Analytics Cloud** icon. A **config.json** file will download to your local machine.

    ![download config](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/7-create-connector-to-oac-green-button/images/get-oac-config.png)



## Task 3: Create the Connection in Oracle Analytics Cloud

1. Open the Oracle Analytics Cloud homepage. Select **Create** and then **Connection**.

    ![create connection](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/7-create-connector-to-oac-green-button/images/create-connection-from-homepage.png)

2. Select the **Oracle AI Data Platform** icon. Use the search bar if you cannot locate it.

    ![find connector](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/7-create-connector-to-oac-green-button/images/select-aidp-connector.png)

3. Enter the **Connection Name** **Livelab\_AIDP\_Connection**. In the **Connection Details**, select **Select...** and choose the **config.json** file that you downloaded from the compute cluster. In **Private API Key**, select **Select...** and choose the private key that you downloaded from the OCI console. Note that fields will be populated using these files, which are blocked out in the image for privacy. Select `supplier_external_26ai` for **Catalog** and then select **Save**.

    > **Note:** Currently, the connection can only be made to a single catalog, not the master catalog.

    ![provide connection details](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/7-create-connector-to-oac-green-button/images/configure-connection.png)

Congratulations! You have now created a connection between the `supplier_external_26ai` catalog and your OAC instance. You can now use this connection to pull data from the catalog into OAC for visualization and analysis.


## Learn More

- [Oracle AI Data Platform Community Site](https://community.oracle.com/products/oracleaidp/)
- [Oracle AI Data Platform Documentation](https://docs.oracle.com/en/cloud/paas/ai-data-platform/)
- [Oracle Analytics Training Form](https://community.oracle.com/products/oracleanalytics/discussion/27343/oracle-ai-data-platform-webinar-series)
- [Connecting OAC to AIDP Workbench Documentation](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acsds/connect-ai-data-platform.html)

## Acknowledgements
* **Author** - Miles Novotny, Senior Product Manager, Oracle Analytics Service Excellence
* **Contributors** -  Farzin Barazandeh, Senior Principal Product Manager, Oracle Analytics Service Excellence
* **Last Updated By/Date** - Miles Novotny, March 2026

