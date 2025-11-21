# implement OAC Instance

## Introduction

This lab will walk you thru staging and loading of autoclaims data into the Autonomous Database created in previous steps. You will stage data in an object storage bucket, use the api key to create a cloud store for the object storage bucket, load data from the bucket into the autonomous database and create an auto table using parquet files in object storage bucket.

Estimated Time: 30 minutes

### Objectives


In this lab, you will:
* Import OAC Workbooks
* Update Connection and Datasets

### Prerequisites

 
This lab assumes you have:
* An Oracle Cloud account with privileges to manage Oracle Analytics Cloud
 

## Task 1: Import OAC Workbooks

1. Open the OAC Instance Console

    ![Open OAC Instance Console](./images/navigate_to_oac_instance.png)

2. Select import workbook/flow and open the FSI Auto Claims Justin Report.dva file

    ![Open OAC Instance Console](./images/import_workbook.png)

3. Make sure Import Permissions (if available) is disabled and click the import button

    ![Open OAC Instance Console](./images/import_workbook_permissions.png)

## Task 2: Update data connection

1. find the FSIDEMO_ADB data connection via Data

    ![Inspect data connection](./images/inspect_data_connection.png)

2. click the three dot stack on the connection and select inspect

    ![Inspect data connection](./images/inspect_data_connection.png)

3. click the Select... button on the Client Credentials row

    ![Select ADB Wallet](./images/select_adb_wallet.png)

4. Open the wallet file of the autonomous database 

5. Input FSIDEMO as Username, the password from Lab 2 and click the Save button
 

## Task 3: Refresh datasets

1. Open the FSIAutoLeakage dataset

    ![Open FSIAutoLeakage](./images/open_fsi_auto_leakage.png)

2. Select each of the tables and refresh the data connection by clicking the try again button.

    ![Refresh Connection](./images/refresh_connection.png)

3. Make sure Claims MV has Preserve Grain enabled and save changes.

    ![claims mv preserve grain](./images/claims_mv_preserve_grain.png)   

4. Repeat steps 1 and 2 with Claims Fraud Predict Apply dataset.
 