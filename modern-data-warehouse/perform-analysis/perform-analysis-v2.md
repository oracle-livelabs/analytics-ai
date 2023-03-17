# Perform Analysis - Create Dashboards

## Introduction

In this lab, you will get started with the analysis of the EBS data in Oracle Analytics Cloud. To get you started with an analytics project, you will use a dva file to set up an Analytics project and use the Source ADW to supply data for the visualizations. You will then connect to the destination ADW to explore the data.

Estimated Time: 15 minutes

### Objectives

- Import analytics workbook.
- Connect to ADW and create data sets.
- Analyse data.

### Prerequisites

- The source and destination Autonomous Data Warehouses (ADW) and Analytics Cloud (OAC) instance.
- Access to the ModernDW file needed to recreate an analytics project.
    - [ModernDW.dva](https://objectstorage.us-ashburn-1.oraclecloud.com/p/VEKec7t0mGwBkJX92Jn0nMptuXIlEpJ5XJA-A6C9PymRgY2LhKbjWqHeB5rVBbaV/n/c4u04/b/livelabsfiles/o/data-management-library-files/modern-data-warehouse/ModernDW.dva)

**Note:** Please download the file above before continuing.

## Task 1: Set up the Analytics Project in OAC 

While creating the ODI-ADW-OAC stack, you were asked to note the URL of the Analytics instance. Directly open that URL in the browser and proceed to step 3. In case the URL wasn't present then follow steps 1 and 2.

![No Link to Analytics Instance](./images/no-link-to-oac.png "No Link to Analytics Instance")

1. Click on the **Navigation Menu** in the upper left, navigate to **Analytics & AI**, and select **Analytics Cloud**.

	![OCI Console Analytics Cloud](https://oracle-livelabs.github.io/common/images/console/analytics-oac.png "OCI Console Analytics Cloud")

2. Choose the right compartment and then select your analytics instance. In the page that opens, click on **Analytics Home Page** to login to the analytics cloud instance.

    ![Access Analytics Instance](./images/access-analytics-instance.png "Access Analytics Instance")

    ![Go to Analytics Home Page](./images/go-to-analytics-home-page.png "Go to Analytics Home Page")

3. Click on the ellipses menu in the top right, select **Import Workbook/Flow**. Then, click on **Select File** and choose the ModernDW.dva file.

    ![OAC Home Page](./images/oac-home-page.png "OAC Home Page")

    ![Import Workbook](./images/import-workbook.png "Import Workbook")

    ![Select File](./images/select-file.png "Select File")

4.  Import the file into OAC by clicking on **Import**. The password is **Admin123**. Hit **OK** to close the dialog.

    ![Import](./images/import-dva.png "Import")

    ![Import Successful](./images/dva-import-successful.png "Import Successful")

5. Click on the navigation menu icon in the top left. Go to **Data** and open the **Connections** tab. You should see a connection named **EBS\_ADW\_OAC**.

    ![Go to Data](./images/go-to-data-page.png "Go to Data")

    ![Select Connections](./images/go-to-connections-tab.png "Select Connections")

6. Click on the ellipses menu on the extreme right of the row with the connection entry and select inspect.

    ![Inspect Connection](./images/inspect-connection.png "Inspect Connection")

7. Click on the **Select** button in front of Client Credentials and select the wallet to your Source ADW instance. Enter the username as **ADMIN** and provide the schema password. Click **Save**.

    ![Update Connection Credentials](./images/update-connection-credentials.png "Update Connection Credentials")

8. You will now refresh the data sets to utilise the connection. Select the **Data Sets** tab and you will see all the tables appear below. Go ahead and reload each data set by clicking on the ellipses menu on the right of the row with the data set entry and selecting **Reload Data**.

    ![Reload Data Sets](./images/reload-data-sets.png "Reload Data Sets")

9. Now, proceed to the hamburger menu and select **Catalog** and open your project. The visualisations should load, but click **Refresh Data** if needed, to refresh the visuals.

    ![Go to Catalog](./images/go-to-catalog.png "Go to Catalog")

    ![EBS Dashboard](./images/ebs-dashboard.png "EBS Dashboard")

## Task 2: Establish a connection to the Destination Database as ADMIN

As you might remember, you loaded the data from the EBS instance into the **ADMIN** schema of the destination ADW and from the Source ADW into the **EBS** schema. You will now create a connection to the database as the **ADMIN** user.

1. Click on the navigation menu icon in the top left. Go to **Data** and then open the **Connections** tab. Click on the **Create** button in the top right of the screen and select **Connection**. Choose **Autonomous Data Warehouse**.

    ![Select Connections](./images/go-to-connections-tab.png "Select Connections")

    ![Create Connection](./images/create-connection.png "Create Connection")

    ![Choose Autonomous Data Warehouse](./images/choose-connection-type.png "Choose Autonomous Data Warehouse")

3. Provide a name to the connection. Click on the **Select** button in front of Client Credentials and select the wallet to your destination ADW instance. Let the username be **ADMIN** and provide the schema password. Select the high service from the **Service Name** dropdown and click on **Save** to establish the connection.

    ![Enter Connection Details](./images/enter-connection-details.png "Enter Connection Details")

    ![Created Connections](./images/connections.png "Created Connections")

## Task 3: Create Data Sets in OAC

1. To the right of the connection's name an ellipses button will appear. Click on it. In the menu that appears, select **Create Data Set**. 

    ![Create Data Set](./images/create-data-set.png "Create Data Set")

2. You will see all the available schemas including the **ADMIN** and **EBS** schemas. You may now choose any data set to see its columns and play with it. Thereafter, click on the save button, give the data set a name and click on **OK** to save it.

    ![Choose Table under ADMIN Schema](./images/choose-table-under-admin-schema.png "Choose Table under ADMIN Schema")

    ![Save Data Set](./images/save-data-set.png "Save Data Set")

3. The data set can now be seen under the **Data Sets** tab. Feel free to repeat the process to create more data sets.

    ![All Data Sets](./images/all-datasets.png "All Data Sets")

We will now leave it up to your imagination to analyse the data sets that have been provided to you and to use them in visualisations.

*Congratulations! You have successfully completed the lab*.

## Acknowledgements
- **Authors** - Yash Lamba, Senior Cloud Engineer; Massimo Castelli, Senior Director Product Management. January 2021
- **Last Updated By/Date** - Yash Lamba, March 2023
