# Provisioning your Oracle Analytics Cloud (OAC) instance

## Introduction

This section describes the process of deploying **Oracle Analytics Cloud** instances on Oracle Cloud Infrastructure Gen 2, which is the default for newly provisioned accounts in **EMEA** and **US**.

Your Oracle Cloud Free Tier account will use the Oracle Cloud Free Trial **credits** while this instance is provisioned, as Oracle Analytics Cloud is not part of the **Always Free** cloud services.

Provisioning an Oracle Analytics Cloud instance can take over **40 minutes**.

Watch our short video that explains how to provision your Oracle Analytics Cloud instance:

[](youtube:ZAqXlhivQCg)

Estimated Time 15 minutes.

### Objectives
- Create an Oracle Analytics Cloud Instance

## Task 1: Create an Oracle Analytics Cloud (OAC) Instance

Return to the Oracle Cloud Infrastructure Console accessing from **Oracle Home Page** (oracle.com) and sign in into your cloud account.
Click in **View Account** and **Sign in to Cloud**.

![Oracle Console SignIn](./images/laboac-one.png)

1. Go to the **Home Console Page** and navigate to **Analytics & AI** section and then **Analytics Cloud**.

    ![Oracle Analytics Console](https://oracle-livelabs.github.io/common/images/console/analytics-oac.png " ")

2. Select **Create Instance**.

    Complete the form using the following information:

    - **Compartment**: Select a valid compartment in your tenancy

    - **Instance Name**: `WORKSHOPADWOAC`

    - **Description**: &lt;optional&gt;

    - **Feature Set**: Enterprise Analytics (important)

    - **Capacity**: 1 - Non Production

    - **License Type**: "Subscribe to a new Analytics Cloud software > license and the Analytics Cloud." (You will use this service as part of the free Oracle Cloud trial that you requested for this workshop).

3. Select **Create**.

    ![OAC Instance Creation](./images/laboac-six.png)

4. On the **Confirmation** screen, select **Create**.

    The Analytics instance page will be displayed with a status of **CREATING**.

    ![OAC Instance Creating](./images/laboac-seven.png)

    ***Reminder***: Provisioning an Oracle Analytics Cloud instance can take over **40 minutes**.

5. The Analytics instance page will be displayed with a status of **ACTIVE**.

    ![OAC Instance Active](./images/laboac-eight.png)

## Task 2: Upload Workbook

1. In the Analytics Instance listing page, Open the Cloud Analytics URL associated with your instance by using the three dots menu button on the right-hand side of your instance information and select **Analytics Home Page**.
    ![Cloud Analytics URL](./images/oac-instance.png)  
    The **Oracle Analytics** page will open in a new browser window/tab.

2. In the **Oracle Analytics** page click on the three dots beside create button and click on **Import Workbook/Flow..**.
    ![Import workbook](./images/import-workbook.png)

3. This will open a UI to upload a workbook. download this [CallCenterAnalyticsWorkbookFile](./files/CallCenterAnalytics.dva) workbook file  and upload it
    ![Upload workbook](./images/upload-workbook.png)

## Task 3: Configure Workbook

1. On the top right-hand side of the **Analytics Home Page**, click **Create**, and then **Connection**.

    ![Connection Creation](./images/oaccreateconnection.png)

4. Choose **Oracle Autonomous Data Warehouse**.

    ![Connection Creation - ADW](./images/select-adwh-connection.png)

5.	Enter the credentials to the data warehouse (target database) you created in **Lab 2: Prepare data sources > Task 2: Prepare Target Database**. If you need a reminder on how to get the wallet, See [Download a Wallet](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/cswgs/autonomous-connect-download-credentials.html#GUID-B06202D2-0597-41AA-9481-3B174F75D4B1).  
Click **Save** to save your new connection **information**.

  ![Define Connection](./images/adw-conn.png " ")


This concludes this lab. You may now **proceed to the next lab**.

## Acknowledgements

- **Author** - Priscila Iruela - Technology Product Strategy Director, Juan Antonio Martin Pedro - Analytics Business Development
- **Contributors** - Victor Martin, Melanie Ashworth-March, Andrea Zengin
- **Last Updated By/Date** - Chenai Jarimani, April 2023
