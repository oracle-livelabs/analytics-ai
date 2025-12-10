# Oracle AI Data Platform Essentials: Creating the Catalog and Collecting Data

## Introduction

This lab guides you through the process of provisioning an Oracle AI Data Platform (AIDP) Workbench instance, Creating an Autonomous Data Warehouse, creating catalogs, and managing data within those catalogs. You'll learn how to set up access to your data and organize your catalogs for future use in notebooks and jobs.

Estimated Time: 45 minutes

### Objectives

In this lab, you will:

- Provision an AIDP Workbench instance.
- Provision a 26ai Autonomous Data Warehouse
- Access the master catalog.
- Create internal and external catalogs.
- Manage data by creating schemas, tables, and volumes.

## Prerequisites

This lab assumes you have:

- An Oracle Cloud account.
- Necessary permissions to create and manage AIDP Workbench instances.

## Task 1: Provision an AIDP Workbench Instance

1. Log in to your Oracle Cloud Infrastructure (OCI) account and access the OCI Console.

2. From the OCI Console homepage, click on the hamburger menu, navigate to **Analytics and AI**, and select **AI Data Platform Workbench**.

![Accessing AIDP Workbench area in OCI](images/OCI_Console_Access_AIDP.png)

3. Click on **Create AI Data Platform Workbench**.

![Choose Create AIDP Workbench](images/Begin_AIDP_Creation.png)

4. Provide an instance name and workspace name. In the **Add Policies** section for **Choose access level** select **Standard - Reccomended access settings at tenancy level**.

![Name instance and workspace](images/Input_AIDP_Information.png)

5. A dialog may appear telling you that further policies are required to create the AIDP Workbench instance. If this happens review the policies and choose **Add**.


6. Under **Optional Policies** view other suggested policies related to you AIDP Workbench instance. Add any you would like then select **Create**. It may take a few minutes for the instance to provision

![Create AIDP Instance](images/Create_AIDP_Instance.png)


## Task 2: Provision an Autonomous Data Warehouse

1. While waiting for the AIDP Workbench to provision, navigate to the OCI menu. Select **Oracle AI Database** then **Autonomous AI Database**.

![Navigate to Automonous Database page](images/Navigate_To_DBs.png)

2. Select **Create Autonomous AI Database**.

![Begin Database creation](images/Begin_DB_Creation.png)

3. Give it a display name and database name. Leave the **Workload type** as **Lakehouse**.

![Name database and choose workload](images/Name_Database.png)

4. Under **Database Version** select **26ai**. Unselect **Compute auto scaling**.

![Choose DB version](images/Choose_DB_Version.png)

5. Enter a strong password for the admin credentials, leave all other fields as is, then select **Create**.

![Choose DB password](images/Create_DB_Password.png)

6. When the database is finished provisioning, select **Database Connection**

![Navigate to database connection](images/Access_DB_Connection.png)

7. Select **Download Wallet**. You will be asked to provide a password for the wallet, do so then select **Download**.

![Download wallet](images/Choose_Wallet_Password.png)

8. the final step of this task is to configure table access for the **ADMIN** user. Under **Database actions** select **SQL**.

![Select SQL database action](images/Database_Actions.png)

9. In the SQL worksheet paste in the following command and run the statement. This allows the **ADMIN** user to select from any table in the DB.

![Run SQL statement](images/Grant_Select.png)

'''GRANT SELECT ANY TABLE TO ADMIN;''' (need to reformat this)

10. Paste this next statement over the previous one and run it as well. This statement defines a database table that we will write our gold tier data to once our medallion architecture is created.

![Create database table](images/Create_Gold_Table.png)

'''CREATE TABLE gold_supplier_feedback (
    supplier_name VARCHAR(100),
    continent VARCHAR(100),
    country VARCHAR(100),
    city VARCHAR(100),
    summary_review VARCHAR(1000),
    rating VARCHAR(10)
);'''

## Task 3: Create an External Catalog in AIDP Workbench

1. Navigate back to your AIDP Workbench instance by again using the OCI menu and choosing **Analytics and AI** then **AI Data Platform Workbench**

![Navigate to AIDP Section](images/OCI_Console_Access_AIDP.png)

2. Select the AIDP Workbench instance you created earlier. You will be asked to sign in again with the same credentials you use to login to OCI.

![Select AIDP Instance](images/Access_AIDP_Instance.png)

3. Your first step in AIDP will be to connect to your data. From the AIDP Workbench homepage, select the **Master catalog** tab from the left-hand menu. Notice the default catalog already present here. Expand it and the **oci\_ai\_models** folder to see LLMs that are available for use in AIDP Workbench.

![Select Master Catalog](images/View_GenAI_Models.png)


4. Create your first catalog by choosing **Create Catalog**.

![Select Master Catalog](images/Create_Catalog.png)

5. Name it **supplier\_external\_23ai** and choose **External Catalog** for **Catalog type**

![Select Master Catalog](images/Name_External_Catalog.png)

6. Select **Oracle Autonomous Data Warehouse** as the source type. Upload the wallet file you downloaded in the previous task. Select the low option for **Service Level**, input **ADMIN** for **Username**, then the password you created under **Password**. Leave all other sections as is. Select **Test connection** then **Create**.

![Select Master Catalog](images/Configure_Catalog_DB_Access.png)

7. When the catalog finishes creation select the arrow next to it, then the arrow next to the **admin** to see tables that are now accessible. You will use this connection to save your gold tier data to this database for further use.

![View DB tables](images/View_External_Catalog.png)

## Task 3: Create and Populate a Standard Catalog in AIDP Workbench

1. Next you will create a standard catalog. Select the breadcrumb menu to return to the master catalog if you are not already there. Select **Create catalog**.

![Create Catalog](images/Create_Catalog.png)

2. Name it **Supplier**. Leave the **Catalog Type** as **Standard catalog**. Select the same compartment your other lab assets are in, then choose **Create**

![create catalog](images/Create_Supplier_Catalog.png)

3. When the catalog finishes creation select its name to access it.

![select catalog](images/View_Standard_Catalog.png)

4. Select **Create schema**.

![create schema](images/Create_Schema.png)

5. Name the schema **supplier\_schema** and choose **Create**.

![create supplier schema](images/Create_Supplier_Schema.png)

6. Select the **supplier_schema**.

![select schema](images/Select_SUpplier_Schema.png)

7. Choose **Add to schema** then select **Table**.

![Create table](images/Create_Table_Clicks.png)

8. Keep the **Table type** as **Managed**. drop in the **basic_supplier.csv** file. Select **Preview data** then **Create**.

![create table](images/Create_Basic_Supplier.png)

9. Create another managed table, this time use the **supplier_emotions.csv** file.

![create emotions table](images/Create_Supplier_Emotions.png)

10. Now create a volume. Again select **Add to schema**, this time choose **Volume**.

![create volume](images/Create_Volume_Clicks.png)

11. Name it **supplier_volume** and choose **Managed** as the volume type.

![set as managed volume](images/Create_Supplier_Volume.png)

12. Select the **Volumes** tab then select the **Supplier_Volume** you just created.

![select volume](images/Access_Supplier_Volume.png)

13. Select the plus icon then **Upload file**. Select the **supplier_info.txt** file from your computer then choose **Upload**.

![upload file to volume](images/Upload_To_Volume.png)

You have now created your structured and unstructured data assets in AIDP Workbench that are ready to be processed into the bronze, silver, and gold tiers of your medallion architecture.

## Learn More

ADD DOCUMENTATION

## Acknowledgements
* **Author** - Miles Novotny, Senior Product Manager, Oracle Analytics Service Excellence
* **Contributors** -  Farzin Barazandeh, Senior Principal Product Manager, Oracle Analytics Service Excellence
* **Last Updated By/Date** - Miles Novotny, December 2025
