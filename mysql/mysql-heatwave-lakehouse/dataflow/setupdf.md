
# Setting up Oracle Cloud Infrastructure Data Flow and load datasets from demo-events-silver-mysqlhw to MYSQL HW

The labs shows who we can set up the OCI Data Flow pyspark application and extract data from ***demo-events-raw-mysqlhw*** bucket ,consolidate the datasets and load the data to ***demo-events-silver-mysqlhw*** bucket .
Setting up OCI Data Flow
- Provision the OCI Data flow in the tenancy 
- Deploy the Pyspark application to run using Data flow.

Load the datasets from demo-events-silver-mysqlhw to MYSQL HW
- Create PAR Link for the bucket
- Run Autoload to infer the schema and estimate capacity
- Load complete T\_AGGR\_DEVICE\_PRED\_HOUR table from Object Store into MySQL HeatWave
*Estimated Lab Time*: 45 mins

### Objectives

In this lab you will learn about Oracle Cloud Infrastructure Data Flow, what it is, what you need to do before you begin using it, including setting up policies and storage, loading data, and how to import and bundle Spark applications. 

Before you can create, manage and execute applications in Data Flow, the tenant administrator (or any user with elevated privileges to create buckets and modify IAM) must create specific storage buckets and associated policies in IAM. These set up steps are required in Object Store and IAM for Data Flow to function. This lab will set the foundation for future labs to follow.

- Provision the OCI Data flow in the tenancy 
- Deploy the Pyspark application to run using Data flow.
- Create PAR Link for the bucket
- Run Autoload to infer the schema and estimate capacity
- Load complete T\_AGGR\_DEVICE\_PRED\_HOUR table from Object Store into MySQL HeatWave

  ![architecture](images/DF_Overview1.png " ")

### Prerequisites

Before you Begin with Data Flow lab, you must have:

* An Oracle Cloud Infrastructure account. Trial accounts can be used to demo Data Flow.
* A Service Administrator role for your Oracle Cloud services. When the service is activated, Oracle sends the credentials and URL to the designated Account Administrator. The Account Administrator creates an account for each user who needs access to the service.
* A supported browser, such as:
    * Microsoft Internet Explorer 11.x+
    * Mozilla Firefox ESR 38+
    * Google Chrome 42+
* Familiarity with Object Storage Service.


## Task 1: Object Store: Setting Up Storage

1. Before running the application in the Data Flow service, create two storage buckets that are required in object storage.

    * From the OCI Services menu, click `Storage` and then click `Buckets` under Object Storage

       ![storage bucket](images/OBJECT-STORAGE001.png " ")

    * Click `Bucket`
       ![navigation](images/BUCKET001.png " ")

      **NOTE:** Ensure the correct Compartment is selected under COMPARTMENT list

    * A bucket to store the logs (both standard out and standard err) for every application run.Create a standard storage tier bucket called `dataflow-logs` in the Object Store service.

      ![create bucket](images/CREATEBUCKET001.png " ")

    * A data warehouse bucket for Spark SQL applications. Create a standard storage tier bucket called `dataflow-warehouse` in the Object Store service.
        ![dataflow warehouse](images/DATAWAREHOUSEBUCKET.png " ")

## Task 2: Identity: Policy Set Up

A user's permissions to access services comes from the _groups_ to which they belong. The permissions for a group are defined by policies. Policies define what actions members of a group can perform, and in which compartments. Users can access services and perform operations based on the policies set for the groups of which they are members.

We'll create a user, a group, and policies to understand the concept.


1. **User Policies** : Data Flow requires policies to be set in IAM to access resources in order to manage and run applications. We categorize the Data Flow users into two groups for clear separation of authority administrator and users:

    * From the OCI Services menu, click `Identity and Security` and in identity click `Group`

        ![groups](images/Groups001.png " ")

    * Create a group in your identity service called `dataflow-admin`

        ![admin](images/DataflowAdminUser.png " ")

    * Click on your new group to display it. Your new group is displayed.Add users to the groups

        ![admin user](images/AddUsertoDFAdminGroup.png " ")

        ![add users](images/AddUsers.png " ")

    * From the OCI Services menu, click `Identity and Security` and in identity click `Policies`

        ![new policy](images/Policies001.png " ")    

    * Create a policy called `dataflow-admin` in your `compartment` and add the following statements:

       ![policy](images/CreateDFAdminPolicy.png " ")  

      ```
      <copy>
      ALLOW GROUP dataflow-admin TO READ buckets IN TENANCY
      </copy>
      ```

      ```
      <copy>
      ALLOW GROUP dataflow-admin TO MANAGE dataflow-family IN TENANCY
      </copy>
      ```
      ```
      <copy>
      ALLOW GROUP dataflow-admin TO MANAGE objects IN TENANCY WHERE ALL
          {target.bucket.name='dataflow-logs', any {request.permission='OBJECT_CREATE',
          request.permission='OBJECT_INSPECT'}}
      </copy>
      ```
    * Create a group in your identity service called dataflow-users and add users to this group.

      ![group](images/DFUserGroup.png " ")

    * Create a policy called dataflow-users and add the following statements:

      ![policy](images/dfcreateuserspolicies.png " ")

      ```
      <copy>
      ALLOW GROUP dataflow-users TO READ buckets IN TENANCY
      </copy>
      ```
      ```
      <copy>
      ALLOW GROUP dataflow-users TO USE dataflow-family IN TENANCY
      </copy>
      ```
      ```
      <copy>
      ALLOW GROUP dataflow-users TO MANAGE dataflow-family IN TENANCY WHERE ANY {request.user.id = target.user.id, request.permission = 'DATAFLOW_APPLICATION_CREATE', request.permission = 'DATAFLOW_RUN_CREATE'}
      </copy>
      ```
      *Note: Replace <tenancy> with the name of your tenancy*

2. **Service Policies** : The Data Flow service needs permission to perform actions on behalf of the user or group on objects within the tenancy.To set it up, create a policy called `dataflow-service` and add the following statement:

      ```
      <copy>
      ALLOW SERVICE dataflow TO READ objects IN tenancy WHERE target.bucket.name='dataflow-logs'
      </copy>
 
     ```
## Task 2: Deploy the Pyspark Application to the data flow
In this task we will be deploying the Pyspark Application to OCI Objectstore and will be creating a Data flow application.
1. Modify the Pyspark script - Open the script locall
- Download the Labfiles and navigate to the below folder location to collect the codepump.zip file.

   Download file [`MYSQLLakehouse_labfiles.zip`](https://objectstorage.us-ashburn-1.oraclecloud.com/p/RPka_orWclfWJmKN3gTHfEiv-uPckBJTZ3FV0sESZ3mm3PDCQcVDCT-uM2dsJNGf/n/orasenatdctocloudcorp01/b/MYSQLLakehouse_labfiles/o/MYSQLLakehouse_labfiles.zip)

  *** Python Framework Location in the Zip file - MYSQLLakehouse_labfiles\_Lab6a

  ![Spark Application code](images/spark-code.png " ")

      ```
      <copy>
      line 26: change the namespace of the bucket path
      line36: change the namespace of the bucket path
      </copy>
 
     ```
     ![Spark Application code](images/script-chnage.png " ")

2. Upload the main.py script to Objectstore bucket ***Dataflowbucket***

    ![Spark Application code](images/script-upload.png " ")

3. Create a Pyspark application on Data Flow.
  Navigate to DataFlow

  ![Spark Application code](images/df-navigate.png " ")

  Create the Data Flow Application

  DataFlow Application Name - 
      ```
      <copy>
      dfPipeline
      </copy>
 
     ```
  *** Note - Select the parameters based on the below snapshot provided.
  ![Spark Application Navigate](images/df-create-app.png " ")

  ![Spark Application Create](images/create-one.png " ")

  ![Spark Application Allocate Resources](images/create-two.png " ")

  ![Spark Application Allocate Resources](images/df-app-executor.png" ")

  ![Spark Application Allocate Resources](images/df-app-selection.png" ") 
  

4. Run the Pyspark App
   ![Spark Application Run](images/run-app.png " ")

## Task 3: Create the PAR Link for the "e2e-demo-events-silver-mysqlhw" bucket 

1. Create a PAR URL for all of the **e2e-demo-events-silver-mysqlhw** objects with a prefix

    - a. From your OCI console, navigate to your e2e-demo-events-silver-mysqlhw bucket in OCI.

        ![Go to Bucket](./images/bucket-details.png "Go to Bucket folder")
    - b. Click the three vertical dots of "e2e-demo-events-silver-mysqlhw" bucket 

        ![Create Par](./images/bucket-three-dots.png "create par")

    - c. Click on ‘Create Pre-Authenticated Request’
    - d. Click to select the ‘Objects with prefix’ option under ‘PreAuthentcated Request Target’.
    - e. Leave the ‘Access Type’ option as-is: ‘Permit object reads on those with the specified prefix’.
    - f. Click to select the ‘Enable Object Listing’ checkbox.
    - g. Click the ‘Create Pre-Authenticated Request’ button.

       ![Create Par Configuration](./images/par-with-prefix-object-listing.png "Par Configuration")

    - h. Click the ‘Copy’ icon to copy the PAR URL, it will not be shown again.
    - i. Save the generated PAR URL; you will need it later.
    - j. You can test the URL out by pasting it in your browser. It should return output like this:

        ![List par files](./images/list-par-file.png "par files list")

2. Save the generated PAR URL; you will need it in the next task

## Task 4: Run Autoload to infer the schema and estimate capacity required to upload the aggregate device data 

1. Aggregated data information is the csv files in the object store for which we have created a PAR URL in the earlier task. Enter the following commands one by one and hit Enter.

2. This sets the schema, in which we will load table data into. Don’t worry if this schema has not been created. Autopilot will generate the commands for you to create this schema if it doesn’t exist.

    ```bash
    <copy>SET @db_list = '["MFG_SENSOR"]';</copy>
    ```
    ![autopilot set dblist example](./images/set-db-list.png "autopilot set dblist example")


3. This sets the parameters for the table name we want to load data into and other information about the source file in the object store. Substitute the **PAR URL** below with the one you generated in the previous task:
    ```bash
    <copy>SET @dl_tables = '[{
    "db_name": "MFG_SENSOR",
    "tables": [{
    "table_name": "T_AGGR_DEVICE_PRED_HOUR",
    "dialect": 
       {
       "format": "csv",
       "field_delimiter": ",",
       "record_delimiter": "\\n"
       },
    "file": [{"par": "PAR URL"}]
    }] }]';</copy>
    ```
    Be sure to include the PAR URL inside the quotes " " and it should look like as in following:

    ![autopilot set table example](./images/set-load-table-examples.png "autopilot set table example")

4. This command populates all the options needed by Autoload:

    ```bash
    <copy>SET @options = JSON_OBJECT('mode', 'dryrun',  'policy', 'disable_unsupported_columns',  'external_tables', CAST(@dl_tables AS JSON));</copy>
    ```
    ![autopilot set option](./images/set-options.png "autopilot set option example")

5. Run this Autoload command:

    ```bash
    <copy>CALL sys.heatwave_load(@db_list, @options);</copy>
    ```


6. Once Autoload completes running, its output has several pieces of information:
    - a. Whether the table exists in the schema you have identified.
    - b. Auto schema inference determines the number of columns in the table.
    - c. Auto schema sampling samples a small number of rows from the table and determines the number of rows in the table and the size of the table.
    - d. Auto provisioning determines how much memory would be needed to load this table into HeatWave and how much time loading this data take.

    ![Load Script](./images/heatwave-load-op1.png "load script dryrun")

    ![Load Script log](./images/heatwave-load-op2.png "load script log dryrun")

7. Autoload also generated a statement lke the one below. Execute this statement now.

    ```bash
    <copy>SELECT log->>"$.sql" AS "Load Script" FROM sys.heatwave_autopilot_report WHERE type = "sql" ORDER BY id;</copy>
    ```

    ![log table output](./images/log-create-table-output.png "log table output dryrun")

8. The execution result contains the SQL statements needed to create the table. As there was no header in the csv file generated,  Now execute the following **CREATE TABLE** command by replacing your **PAR Value**. In following create table we have used the required column name for this lab.
 
 **NOTE: Ensure to Replace you PAR VALUE after copying the following command**


    ```bash
    <copy>CREATE TABLE `MFG_SENSOR`.`T_AGGR_DEVICE_PRED_HOUR`( `year` year NOT NULL, `month` tinyint unsigned NOT NULL, `Day` tinyint   unsigned NOT NULL, `Hour` tinyint unsigned NOT NULL, `device_id` varchar(6) NOT NULL COMMENT 'RAPID_COLUMN=ENCODING=VARLEN',  `prod_type` varchar(1) NOT NULL COMMENT 'RAPID_COLUMN=ENCODING=VARLEN', `device_temp_mean` decimal(17,14) NOT NULL,  `device_temp_max` decimal(4,1) NOT NULL, `device_temp_min` decimal(4,1) NOT NULL, `rotn_speed_mean` decimal(17,13) NOT NULL,     `rotn_speed_max` decimal(5,1) NOT NULL, `rotn_speed_min` decimal(5,1) NOT NULL, `torque_mean` decimal(18,16) NOT NULL, `torque_max`     decimal(3,1) NOT NULL, `torque_min` decimal(3,1) NOT NULL, `tool_wear_mean` decimal(17,14) NOT NULL, `tool_wear_max` decimal(4,1)   NOT NULL, `tool_wear_min` decimal(4,1) NOT NULL, `prob_mean` decimal(20,19) NOT NULL, `prob_max` decimal(4,3) NOT NULL, `prob_min`    decimal(4,3) NOT NULL, `prob_freq_over90` tinyint unsigned NOT NULL, `prob_freq_over60` tinyint unsigned NOT NULL) ENGINE=lakehouse    SECONDARY_ENGINE=RAPID ENGINE_ATTRIBUTE='{"file": [{"par": "PAR_URL"}], "dialect": {"format": "csv", "field_delimiter": ",",   "record_delimiter": "\\n"}}';</copy>
    ```


9. The above create command and result should look like this

      ![Create Table Main](./images/create-table-output-main.png "create table main")

## Task 5: Load the data from Object Store into MySQL HeatWave Table


1. Now load the data from the Object Store into the ORDERS table.

    ```bash
    <copy> ALTER TABLE `MFG_SENSOR`.`T_AGGR_DEVICE_PRED_HOUR` SECONDARY_LOAD; </copy>
    ```
    ![Load Table](./images/alter-table-load.png "load aggr table")


2. View a sample of the data in the table.

    ```bash
    <copy>select * from T_AGGR_DEVICE_PRED_HOUR limit 5;</copy>
    ```
    ![Sample Reuslt](./images/sample-five-rows.png "sample result")



You may now **proceed to the next lab**
## Acknowledgements
* **Author** - Biswanath Nanda, Principal Cloud Architect, North America Cloud Infrastructure - Engineering
* **Contributors** -  Biswanath Nanda, Principal Cloud Architect,Bhushan Arora ,Principal Cloud Architect,Sharmistha das ,Master Principal Cloud Architect,North America Cloud Infrastructure - Engineering
* **Last Updated By/Date** - Biswanath Nanda, March 2024

