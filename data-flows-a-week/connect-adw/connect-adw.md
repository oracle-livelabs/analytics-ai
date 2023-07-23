# Connect OAC to ADW

## Introduction

In this lab, you will connect your Oracle Analytics Cloud (OAC) instance to an Oracle Autonomous Data Warehouse (ADW).

Estimated Time: 2 minutes

### Objectives

In this lab, you will:
* Connect OAC to ADW

### Prerequisites

This lab assumes you have:
* Access to Oracle Analytics Cloud
* Access to DV Content Author, BI Data Model Author, or a BI Service Administrator role
* Credentials and wallet file to connect to an ADW

## Task 1: Connect to Autonomous Data Warehouse


1. Login to your OAC instance using your credentials.

  ![login](images/login.png =400x*)

2. On the top right corner, click **Create** and then select **Connection**.

  ![create connection](images/create-connection.png =400x*)

3. Here, you'll see all the different sources that OAC can connect to. Select **Oracle Autonomous Data Warehouse**.

  ![select adw](images/select-adw.png =450x*)

4. Enter the **Connection Name** and select your ADW wallet .zip file. This wallet file will used to connect to your ADW. Then enter the **Username** and **Password** of your ADW user. For **Service Name** select **..._medium** and enable **System connection**. Click **Save**. You will see a message notifying that your **Connection created successfully**.

  ![connection credentials](images/connection-credentials.png =400x*)

You may now **proceed to the next lab**.

## Learn More
* [Autonomous Data Warehouse](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/)
* [OAC Connect to Data](https://docs.oracle.com/en/cloud/paas/analytics-cloud/upload-data.html)

## Acknowledgements
* Author - Nagwang Gyamtso, Product Manager, Analytics Product Strategy
* Contributors - Lucian Dinescu
* Last Updated By/Date - Nagwang Gyamtso, July, 2023
