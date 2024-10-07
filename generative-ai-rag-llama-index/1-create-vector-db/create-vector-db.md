# Lab 1: Create and configure Autonomous Database

## Introduction

In this lab we will provision an Oracle Autonomous Database to use as the vector store for the following labs. We will be using the new vector data type in Oracle Database 23ai.

Estimated Time: 20 mins

### Prerequisites

* An Oracle Cloud Infrastructure Account
* Permissions to create an Autonomous Database

## Task 1: Create the Autonomous Database

1. Log in to your OCI console.<br>
2. Open the main "hamburger" menu in the top left corner of the Console. Select "Oracle Database" and then click "Autonomous Database."<br>
![Opening main OCI menu](images/oci-main-menu.png)
3. Select the correct compartment from the "List Scope"→"Compartment" on the left side of the page, and then click the "Create Autonomous Database" button.<br>
![Selecting compartment on OCI console](images/oci-create-adb.png)
4. Change the "Display name" and "Database name" to "LiveLabVS" and choose the "Transaction Processing" workload. Everything else can remain as the default.<br>
![Entering details to create database](images/adb-create-form-name.png)
5. Make sure the database version is "23ai". Everything else can remain as the default.<br>
![Selecting database version 23ai](images/adb-create-form-version.png)
6. Enter an administrator password. For this lab, we will use "<b>Livelabpassword1!</b>".<br>
![Entering database admin password](images/adb-create-form-passwd.png)
7. Leave everything else as the default, and click the "Create Autonomous Database" button.<br>
8. Wait while the database is fully provisioned. Once the "ADW" icon turns from orange to green, and the word "AVAILABLE" appears under it, the database is ready.<br>
![Green "ADW" tile on OCI console](images/adb-lifecycle-tile-green.png)

## Task 2: Download the Autonomous Database Wallet File

1. Once the database is ready, click the "Database connection" button on the database details page.<br>
![Clicking "Database connection" button on OCI console](images/adb-connection-button.png)
2. Leave "Wallet Type" as "Instance wallet" and click the "Download wallet" button. Enter a password for the wallet. For this lab, we will be using "<b>Livelabpassword1!</b>". Click the "Download" button.<br>
![ADB Wallet download interface](images/adb-wallet-download.png)
![ADB Wallet password](images/adb-wallet-password.png)
3. Close the database connection page

## Task 3(Optional): Create an AIUSER Database Account

1. From the database details page, click the "Database actions" dropdown button and select "Database Users".<br>
![ADB details page database actions button](images/adb-actions-users.png)
2. Click the "Create User" button on the right side of the page.<br>
![ADB users page](images/adb-users-create-user.png)
3. Enter the following details for the user:<br>
a. Username: <b>AIUSER</b><br>
b. Quota on tablespace DATA: <b>UNLIMITED</b><br>
c. Password: <b>Livelabpassword1!</b><br>
Enable the slider for "Web Access"<br>
![Form for creating ADB user](images/adb-users-create-user-form.png)
4. Click the "ADMIN" profile button in the top right of the page, and select "Sign Out".<br>
![Selecting person silhouette, then sign out](images/adb-admin-signout.png)
5. Enter the credentials for the user account you just created. In this lab we use the following:<br>
a. Username: <b>AIUSER</b><br>
b. Password: <b>Livelabpassword1!</b><br>
![ADB login screen](images/adb-login-form.png)
6. Select the "Development" tab and select "SQL" from the list. Click the "Open" button.<br>
![ADB console](images/adb-dev-sql.png)

## Task 4: Create Database Tables For Vector Store   
**If you did Task 3, skip to number 2 below:**
1. From the database details page, click the "Database actions" dropdown button and select "SQL".<br>
![Selecting ADB database actions button, then SQL](images/adb-actions-sql.png)
2. Copy and paste the SQL code from the create_tables.sql file into the SQL worksheet and click the "Run Script" button (or press F5).<br>
![ADB SQL worksheet](images/adb-sql-worksheet.png)

<copy>

```sql
create table BOOKS
("ID" NUMBER NOT NULL,
"NAME" VARCHAR2(100) NOT NULL,
PRIMARY KEY ("ID") 
);
 
create table CHUNKS
("ID" VARCHAR2(64) NOT NULL,
"CHUNK" CLOB,
"VEC" VECTOR(1024, FLOAT64),
"PAGE_NUM" VARCHAR2(10),
"BOOK_ID" NUMBER,
PRIMARY KEY ("ID"),
CONSTRAINT fk_book
        FOREIGN KEY (BOOK_ID)
        REFERENCES BOOKS (ID)
);
```
</copy>
## **Acknowledgements**

* **Authors** - Travis Ledbetter

