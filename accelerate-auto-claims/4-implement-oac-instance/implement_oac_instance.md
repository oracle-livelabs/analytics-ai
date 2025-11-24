# Implement OAC Instance

## Introduction

This lab will guide you through setting up the Oracle Analytics Cloud instance with prebuilt workbooks and updating the data connections and datasets.

Estimated Time: 10 minutes

### Objectives

In this lab, you will:
* Import OAC workbooks
* Update connections and datasets

### Prerequisites

This lab assumes you have:
* Completed previous labs successfully
 

## Task 1: Import OAC Workbooks

1. Open the OAC Instance Console.

    ![Open OAC Instance Console](./images/navigate_to_oac_instance.png)

2. Select Import Workbook/Flow and open the FSI Auto Claims Justin Report.dva file.

    ![Open OAC Instance Console](./images/import_workbook.png)

3. Make sure Import Permissions (if available) is disabled and click the Import button.

    ![Open OAC Instance Console](./images/import_workbook_permissions.png)

4. Repeat steps 2 and 3 with the FSI Auto Claims Gail.dva file

## Task 2: Update Data Connection

1. Find the FSIDEMO_ADB data connection via Data.

    ![Inspect data connection](./images/inspect_data_connection.png)

2. Click the three-dot menu on the connection and select Inspect.

    ![Inspect data connection](./images/inspect_data_connection.png)

3. Click the Select... button on the Client Credentials row.

    ![Select ADB Wallet](./images/select_adb_wallet.png)

4. Open the wallet file for the Autonomous AI Database created in Lab 1.

5. Enter FSIDEMO as the Username, the password from Lab 2, and click the Save button.
 

## Task 3: Refresh Datasets

1. Open the FSIAutoLeakage dataset.

    ![Open FSIAutoLeakage](./images/open_fsi_auto_leakage.png)

2. Select each table and refresh the data connection by clicking the Try Again button.

    ![Refresh Connection](./images/refresh_connection.png)

3. Ensure that Claims MV has Preserve Grain enabled, and save the changes.

    ![claims mv preserve grain](./images/claims_mv_preserve_grain.png)

4. Repeat steps 1 and 2 for the Claims Fraud Predict Apply dataset.
