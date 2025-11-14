# Process data from Silver into Gold schema into an Autonomous AI Lakehouse

## Introduction

In this lab we will promote the data that was curated and processed in the **Silver** catalog schema into the Gold schema to make it easily consumable for business users but we are not going to use the Delta format like in previous lab, but we are going to use an Autonomous AI Lakehouse as target.

Estimated Lab Time: 45 minutes

### Objectives

In this lab, you will:
* Use the notebook functionality of AI Data Platform to process data
* Use data that is loaded in Silver schema and process into Autonomous AI Lakehouse Gold layer

### Prerequisites 

*List the prerequisites for this lab using the format below. Fill in whatever knowledge, accounts, etc. is necessary to complete the lab. Do NOT list each previous lab as a prerequisite.*

This lab assumes you have:
* An Oracle Cloud account
* The Autonomous AI Lakehouse provisioned already
  * A database user and schema that we will use
  * Access to the Database tools to create tables
* All previous labs successfully completed

*This is the "fold" - below items are collapsed by default*

## Task 1: Create external Catalog to Autonomous AI Lakehouse

1. Step 1

  Select the Master Catalog and use the **+** to create a new catalog entry. Provide all the details in the form. For **catalog type** select **External Catalog**. The form will change and at **External Source Type** select **Oracle Autonomous Data Warehouse**.
  Fill in all the details and use the wallet, test the connection and create the catalog entry. 

   ![Exteral Autonomous AI Lakehouse catalog ](images/Create-external-catalog-ADW.png)

## Task 2: Prepare and run Silver to Gold notebooks to load data in Autonomous AI Lakehouse.

1. Step 1

  Create tables in Autonomous AI Lakehouse in the schema that is same as the connection user in taksk 1, using SQL , making use of prebuilt table definitions from file f1_DDL_ADW_Tables.txt which is available in Github.

  2. Step 2

  The Notebook parameters cell require some adjustments for the notebooks that are part of the Silver-to-gold workspace folder

  The original content is e.g.:
```json
   target_type   =oidlUtils.parameters.getParameter("TARGET_TYPE", "table")
   target_format =oidlUtils.parameters.getParameter("TARGET_FORMAT", "delta")
   silver_catalog    = "f1_silver"
   gold_catalog    = "f1_gold"
   adw_catalog = "f1_gold_adw"
   silver_schema     = "silver"
   gold_schema     = "gold"
   adw_schema =      "f1_gold"
   gold_table_dlt = "f1_drivers_ranking_dlt"
   gold_table_par = "f1_drivers_ranking_par"
```
To use the autonomous AI Lakehouse line 2 **delta** needs to be replaced with **adw**
The adw_catalog (line 5) name needs to be replaced by the name of the external catalog created at task 1. It is visible in the master catalog.
The adw_schema  (line 8) needs to be replaced by the name of the schema you created the table definitions.
Although autosave is enabled, make sure that changes are saved.


  3. Step 3

  Now you can run the notebooks again in following order:
  - 17_silver_drivers.ipynb
  - 18-silver_constructors.ipynb
  - 15_silver_team_ranking.ipynb
  - 16_silver_driver_ranking.ipynb

For validation you can query the database tables to check if data has been inserted.

## Acknowledgements
* **Author** - Wilbert Poeliejoe
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>