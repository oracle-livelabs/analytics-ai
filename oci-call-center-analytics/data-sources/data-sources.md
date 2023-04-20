# Prepare Data Sources

## Introduction

This lab walks you through the steps to prepare the sample data that will be used to perform sentiment analysis, in this case, a set of hotel reviews. We will also create the buckets and databases to save the processed data.

Estimated Time: 60 minutes

### Objectives

In this lab, you will:
* Create Object Storage Bucket
* Download and Upload Sample Data
* Prepare Target Database
* Create Tables to Store Output Data

### Prerequisites

This lab assumes you have:
* An Oracle account
* All previous labs completed


## **Task 1**: Create Object Storage Bucket

In this task, we'll create 3 buckets one for storing source audio files, one for storing the transcribed audio files and last for the merged transcribed files. The merged transcriptions bucket is a 'location' where OCI Data Integration needs to dump intermediate files before publishing data to a data warehouse.(Need to confirm)

1.	In the Oracle Cloud Infrastructure Console navigation menu, go to **Storage**, and then select **Buckets**.

   ![Navigate to bucket page](./images/navigate-to-buckets.png " ")

2. In the buckets page, select the compartment you want to create the bucket and click create bucket button.

    ![Create Bucket](./images/create-bucket-button.png " ")

3. Next Fill the fields with name "FilesForTranscription" and make to tick box to emit events

    ![Create Bucket detail fields](./images/create-bucket.png " ")

4. Repeat steps **1** to **3** to create two new buckets named "MergedTranscriptions" and "TranscribedFiles"

    ![Buckets list](./images/bucket-list.png " ")



## **Task 2**: Prepare Target Database

In this task, we'll create and configure your target Autonomous Data Warehouse database to add a schema and a table.

1.	In the Oracle Cloud Infrastructure Console navigation menu, go to **Oracle Database**, and then select **Autonomous Data Warehouse**.

   ![Navigate to ADW](./images/navigate-to-adw.png " ")

2.	Select your compartment and click **Create Autonomous Database**.

    ![Create ADW button](./images/create-database-button.png " ")

3.	On the options, set a **Display Name** and **Database Name**

   ![Create ADW details](./images/create-database-1.png " ")

4.	Workload type: **Data warehouse**.

5.	Remember your password (**labDatabase01**)

6.	Access type **Secure access from allowed IPs and VCNs only**

7.	Click **Create Autonomous Database** (Wait for your dataset to provision which may take up to 15mins)

   ![Create ADW details](./images/create-database-2.png " ")

8. On the Autonomous Database details page, click **Database connection**.
    ![Database Connection button](./images/database-connection-button.png " ")

9. CLick Download Wallet
    ![Download wallet](./images/download-wallet-button.png " ")

10. Enter password of your choice and store the password. Then click on Download. Store the downloaded wallet zip file.
    ![Create wallet password](./images/download-wallet-password.png " ")

11.	On your database details page, click **Database Actions**.

   ![ADW details](./images/database-details.png " ")

12.	Under **Development**, click **SQL**.

   ![Navigate to database](./images/database-navigation.png " ")

13. Create a Contributor user. Autonomous Databases come with a predefined database role named **DWROLE**. This role provides the common privileges for a database developer or data scientist to perform real-time analytics. Depending on the usage requirements you may also need to grant individual privileges to users.

	Run the following script as shown in the image below:

	    <copy>CREATE USER livelabUser IDENTIFIED BY "<enter user1 password here>";GRANT DWROLE TO livelabUser;ALTER USER livelabUser QUOTA 200M ON DATA;</copy>

   ![Create User](./images/create-user-database.png " ")


## **Task 3**: Create Tables to Store Output Data

Whilst we are in the Database Actions dashboard, we will create 2 Tables

1.	A table **REVIEWS** to store the extracted aspects and related entities
2.	A table **SENTIMENT** to store the raw reviews
Follow the scripts below:

  **Create Raw Reviews Table**

			<copy>CREATE TABLE livelabUser.REVIEWS
			("RECORD_ID" INT,
			"HOTEL_ID" VARCHAR2(200 BYTE),
			"HOTEL_NAME" VARCHAR2(200 BYTE),
			"REVIEW_DATE" DATE,
			"REVIEW_RATING" INT,
			"REVIEW" VARCHAR2(2000 BYTE),
			"REVIEW_TITLE" VARCHAR2(200 BYTE)
			)SEGMENT CREATION IMMEDIATE
			PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
			NOCOMPRESS LOGGING
			STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
				PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
				BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
				TABLESPACE "LANGUAGE";</copy>


  **Create Sentiment Table**

		  <copy>CREATE TABLE livelabUser.SENTIMENT
	 	  ("RECORD_ID" INT,
		  "HOTEL_NAME" VARCHAR2(200 BYTE),
		  "ASPECT" VARCHAR2(200 BYTE),
		  "SENTIMENT" VARCHAR2(200 BYTE),
		  "OFFSET" INT,
		  "LENGTH" INT
		  ) SEGMENT CREATION IMMEDIATE
		  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
 		  NOCOMPRESS LOGGING
		  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
			  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
			  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
			  TABLESPACE "LANGUAGE";<copy>

This concludes this lab. You may now **proceed to the next lab**.

## Learn More
 [Overview of Object Storage](https://docs.oracle.com/en-us/iaas/Content/Object/home.htm)
 [Overview of Autonomous Database](https://docs.oracle.com/en-us/iaas/Content/Database/Concepts/adboverview.htm)

## Acknowledgements
**Authors**
  * Rajat Chawla  - Oracle AI OCI Language Services
  * Sahil Kalra - Oracle AI OCI Language Services
  * Ankit Tyagi -  Oracle AI OCI Language Services
  * Veluvarthi Narasimha Reddy - racle AI OCI Language Services

**Last Updated By/Date**
* Veluvarthi Narasimha Reddy  - Oracle AI OCI Language Services, April 2023