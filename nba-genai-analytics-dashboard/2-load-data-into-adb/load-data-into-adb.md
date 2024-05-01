# Learn how to Load Data into a Database

## Introduction

You will learn how to load data into an Oracle Autonomous Database to be used later by Oracle Analytics Cloud and VisualBuilder.

Estimated time - 20 minutes

### Objectives

In this lab, you will:
* Provision an Oracle Autonomous Data Warehouse.
* Load data into the Database using the data load interface.
* Download the wallet file for use in connecting to Oracle Analytics Cloud.

### Prerequisites

* An OCI cloud account

## Task 1: Provision Autonomous Data Warehouse

1. From the OCI home page, click on the hamburger menu in the top right corner. Choose **Oracle Database** then **Autonomous Data Warehouse**.


![Navigate to Autonomous Database](https://oracle-livelabs.github.io/common/images/console/database-adw.png " ")

2. Click the **Create Autonomous Database** button.

![Profile my profile](images/create-adb-1.png "Create ADB 1")

3. Enter a display name and database name, then make sure that **Data Warehouse** is selected as the workload type.

![Profile my profile](images/create-adb-2.png "Create ADB 2")

4. Leave all other options as their default and scroll down to the **Create administrator credentials** section. Enter and confirm an administrator password, then click **Create Autonomous Database**

![Profile my profile](images/create-adb-3.png "Create ADB 3")

3. Your Autonomous Database will now begin creation. It's status is initially set as **Provisioning**. After a couple minutes this will update to **Available** and your database will be ready to use.

## Task 2: Load Datasets into Database

1. Once your database has finished provisioning, click on **Database actions** then **Data Load**.

![Navigate to DB Actions](images/adb-db-actions.png "DB Actions")

2. Choose **Load Data** then **Select Files**. Choose the lab files named **nba_game_summary_stats_2024_regular_season.csv** and **nba_shotchart_2024_regular_season.csv** from your desktop. This files can be downloaded from THIS link.

![Choose Data Load](images/db-actions-dataload.png "Data Load")

![Choose Files to Upload](images/db-actions-dataload2.png "Choose Datasets")

3. You may review the settings for either dataset before the data is loaded by pressing the edit icon at the right side of the page. Here details like the table name and column data types can be set. No updates are required for these two datasets. Press the **Start** button and the database tables will be created after a few moments.

![Start Data Load](images/db-actions-dataload3.png "Start Data Load")

## Task 3: Download Wallet File

1. Before we analyze this data to use in Oracle Analytics Cloud (OAC), we need to download the database wallet file so that we can access it from OAC. Back at the overview page for your database click **Database connection** and **Download wallet**.

![Choose Database connection](images/adb-connection.png "Choose Database connection")

![Download wallet](images/abd-connection2.png "Download wallet")

2. You will be asked to give the wallet file a password. Do so, then hit the **Download** button

![Give wallet password](images/adb-connection3.png "Give wallet password")

You may now **proceed to the next lab**.

## Acknowledgements

* **Authors:**
	* Nicholas Cusato - Cloud Engineer
	* Malia German - Cloud Engineer
	* Miles Novotny - Cloud Engineer
* **Last Updated by/Date** - Miles Novotny, May 2024
