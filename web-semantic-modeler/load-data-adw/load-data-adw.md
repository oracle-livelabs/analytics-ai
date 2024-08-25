# Load data into the ADW and connect to OAC

## Introduction

In this lab, you will walk through the steps to create a database user, load data into the ADW using Data Load, and connect your ADW to your OAC instance.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:
* Create a BISAMPLE user
* Load data into the Autonomous Data Warehouse
* Connect OAC to ADW

### Prerequisites

This lab assumes you have:
* Access to Oracle Analytics Cloud
* Access to DV Content Author, BI Data Model Author, or a BI Service Administrator role
* Downloaded the [BISAMPLE.xlsx](https://objectstorage.us-ashburn-1.oraclecloud.com/p/vL6XiAFR-g1xAcok3aqWKH2z2rWobXtgI-3SWEhEFpeplt002IHSwY9cEMMvYeWe/n/idmqvvdwzckf/b/OAC-Workshops/o/BISAMPLE.xlsx) file
* All previous labs successfully completed

## Task 1: Create a BISAMPLE user
In this section we will create the necessary user/schema required for this lab.

>**Note:** This process is done by the ADMIN user

1. Navigate back to your SemanticModelerDB details page and click **Database actions**. Then select **Database Users**.

	![DB Users](./images/db-users.png =500x*)

2. Click **Create User**.

	![Create user](./images/create-user.png =500x*)

3. Enter the following information in the **User** tab:
	* User Name: BISAMPLE
	* Password: Choose a valid password (You will need this to log in to the BISAMPLE user in the next task)
	* Quota on tablespace DATA: Unlimited
	* Web Access: Enable

	![User info](./images/user-info.png =500x*)

4. Click the **Granted Roles** tab and grant the role **"DWROLE"** and check all three options. Then click **Create User**.

	![Grant roles](./images/grant-roles.png =600x*)

You have just created the BISAMPLE user role in the SemanticModelerDB.

## Task 2: Load your data into the ADW
In this section, you will login to the BISAMPLE user you just created and load the BISAMPLE.data.xlsx (Enter object storage URL here) file into the BISAMPLE schema.

1. Sign out of the ADMIN user by clicking **ADMIN** on the top right of the page and selecting **Sign Out**.

	![Sign out of admin](./images/sign-out-admin.png =300x*)

2. Once you are signed out, click **Sign in**, enter the username, BISAMPLE and click **Next**. The enter the password you created for the BISAMPLE and **Sign in**.

	![Sign in](./images/sign-in.png =300x*)

3. Click **Data Studio**, then click **Data Load**.

	![Data Load](./images/data-load.png =500x*)

4. Choose **Load Data**.

	![Local file](./images/local-file.png)

5. Drag and drop or select the BISAMPLE.xlsx file from your local machine.

	>**Note**: Find the BISAMPLE.xls file download in the prerequisites section above.

	![Select data](./images/select-data.png)

6. Once your files are ready for loading, find the **SAMP\_ADDRESSES\_D** table and click the **Settings** icon.

	![Settings](./images/settings-icon.png)

7. Under **Mapping**, change the **POSTAL_CODE** data type to **VARCHAR2**. This will prevent issues while loading the data since this dataset includes postal codes from around the world which have letters and numbers in the format. Close the table editor.

	![Data Type](./images/varchar.png)

8. Now let's make one more change. Find **SAMP\_TIME\_DAY\_D** and click the **Settings** icon.

	![Settings](./images/settings-icon-day.png)

9. Under **Mapping**, change the **DAY_KEY** data type to **NUMBER**. Close the table editor.

	![Data Type](./images/number.png)

10. We're now ready to load the data. Click the **Start** button to start the data load. This should take about 2 minutes.

	![Start data load](./images/start-load.png)

11. Once the data load is complete, you will see the tables.

	![Load done](./images/load-done.png)

12. To verify that your data has loaded successfully, click the **Hamburger menu** and select **SQL** under Development.

	![SQL Development](./images/sql.png =500x*)

13. All your tables should be listed here under the **BISAMPLE** user/schema. Right-click **SAMP\_REVENUE\_F** and select **Open**. We'll take a closer look to confirm all the data is there.

	![Open revenue](./images/open-revenue.png)

14. Click the **Data** column and right click on the table. Select **Count Rows** to make sure all the rows were loaded. There should be 71,000 rows.

	![Count Rows](./images/count-rows.png)
	![Row count](./images/row-count.png =300x*)

You have just loaded data into the BISAMPLE schema using the Data Load feature in the ADW.

## Task 3: Download database connection wallet
In this section, you will download the SemanticModelerDB wallet which will be used to connect to the Autonomous Data Warehouse within Oracle Analytics Cloud.

1. Navigate back to the SemanticModelerDB details page and click **Database connection**.

	![ADW details](./images/adw-details.png)

2. Under wallet type, make sure **Instance Wallet** is selected and then click **Download wallet**.

	![Instance wallet](./images/instance-wallet.png)

3. Enter a wallet **Password** and click **Download**. We will use this wallet file in the next task to connect to the ADW.

	![Download wallet](./images/download-wallet.png)

## Task 4: Connect OAC to ADW
In this section, you define a connection to the data source to use for the Semantic Model. This lab uses the BISAMPLE schema to demonstrate the steps required to create an initial semantic model.

1. Navigate back to your Oracle Analytics Cloud instance details page and click **Analytics Home Page**. This will direct you to the OAC console.

	![OAC access](images/access-oac.png)

2. On the Home page, click **Create**, and then select **Connection**.

	![Create connection](./images/create-connection.png =300x*)

3. In **Create Connection**, select a **relational database** connection type to use such as Oracle Database.

	![DB type](./images/db-type.png =500x*)

4. In the connection dialog, enter the following:

	* Connection Name: BISAMPLE
	* Description:
	* Client Credentials: Select the wallet zip file you downloaded in task 3
	* Username: ADMIN
	* Password: (The ADMIN password you created for the ADW)
	* Service Name: This will auto load once you upload the wallet
	* System connection: Check

	![Connection details](./images/connection-details.png =500x*)

5. Select **System Connection**, and then click **Save**.

You have just created the connection to the Autonomous Data Warehouse.

## Learn More
* [Autonomous Data Warehouse](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/)
* [OAC Connect to Data](https://docs.oracle.com/en/cloud/paas/analytics-cloud/upload-data.html)

## Acknowledgements
* **Author** - Nagwang Gyamtso, Product Manager, Analytics Product Strategy
* **Contributors** - Lucian Dinescu, Peter Monteiro
* **Last Updated By/Date** - Nagwang Gyamtso, February, 2024
