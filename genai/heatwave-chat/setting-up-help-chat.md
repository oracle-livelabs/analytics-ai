# Setting Up a GenAI-Powered Help Chat 

This quickstart shows how to use the vector store functionality and use HeatWave Chat to create an AI-powered Help chat that refers to the HeatWave user guide to respond to HeatWave related queries. 

**Note**: This quickstart assumes that you’re familiar with the HeatWave database systems. 

## Setting Up the Object Storage Bucket  

1. Download the [HeatWave user guide PDF (A4) - 1.7Mb](https://downloads.mysql.com/docs/heatwave-en.a4.pdf).  
2. [Create an Object Storage Bucket](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets_topic-To_create_a_bucket.htm) with the name `quickstart_bucket`.  
3. [Upload the PDF file to the Object Storage Bucket](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingobjects_topic-To_upload_objects_to_a_bucket.htm) using the prefix `quickstart/` to create a new folder by the name **quickstart**. 
    

## Setting Up the Environment 

1. [Connect to your HeatWave database system](https://docs.oracle.com/en-us/iaas/mysql-database/doc/compute-instance.html#GUID-6087DA45-06E0-44AD-9CAB-0FC37423A07A).
   To run this quickstart, you need HeatWave database system version `9.0.0 - Innovation` or higher. 
1. If not already done, [add a HeatWave Cluster to your database system](https://docs.oracle.com/en-us/iaas/mysql-database/doc/adding-heatwave-cluster.html). 
1. If not already done, [enable HeatWave Lakehouse on the database system](https://docs.oracle.com/en-us/iaas/mysql-database/doc/managing-heatwave-cluster.html#MYAAS-GUID-1E6279C0-B7DB-4110-975B-2812846E3CD7). 
1. Enable the database system to access an OCI Object Storage bucket. For more information, see [Resource Principals](https://dev.mysql.com/doc/heatwave/en/mys-hw-resource-principal.html).

## Setting Up the Vector Store 

1. Create a new database:

    ```mysql
    create database quickstart_db;
    ```
1. Create the new database:

    ```mysql
    use quickstart_db;
    ```
1. Call the following method to create a schema used for task management:

    ```mysql
    select mysql_task_management_ensure_schema();
    ```

1. Create the vector table and load the source document:

    ```mysql
    call sys.vector_store_load('oci://quickstart_bucket@<TenancyName>/quickstart/heatwave-en.a4.pdf', '{"table_name": "quickstart_embeddings"}');
    ```

   Replace <TenancyName> with the name of the tenancy that you're using.

   This creates a task in the background which loads the vector embeddings into the specified table `quickstart_embeddings`.

1. To track the progress of the task, run the task query displayed on the screen:
    
    ```mysql
    select id, name, message, progress, status, scheduled_time,estimated_completion_time, estimated_remaining_time, progress_bar FROM mysql_task_management.task_status WHERE id=TaskID\G
    ```

    Replace **<var>TaskID</var>** with the task ID that is displayed.

    The output looks similar to the following:

    ```none
                           id: 1 
                         name: Vector Store Loader 
                      message: Task starting. 
                     progress: 0 
                       status: RUNNING 
               scheduled_time: 2024-07-02 14:42:38 
    estimated_completion_time: NULL 
     estimated_remaining_time: NULL 
                 progress_bar: __________
    ```

1. After the task status has changed to Completed, verify that embeddings are loaded in the vector embeddings table:

    ```mysql
    select count(*) from quickstart_embeddings;
    ```

    If you a numerical value in the output, similar to the following, then your embeddings are successfully loaded in the table:

   ```none
    +----------+
    | count(*) |
    +----------+
    |     2112 |
    +----------+
   ```

## Starting a Chat Session 

1. Clear the previous chat history and states:

    ```mysql
    set @chat_options=NULL;
    ```

1.  Ask your question using HeatWave Chat:
    
    ```mysql
    call sys.heatwave_chat("What is HeatWave AutoML?");
    ```

    The `heatwave_chat` method automatically loads the LLM and runs a contextual search on the available vector stores by default. The output is similar to the following: 

    ```none
    |  HeatWave AutoML is a feature of MySQL HeatWave that makes it easy to use machine learning,
    whether you are a novice user or an experienced ML practitioner. It analyzes the characteristics
    of the data and creates an optimized machine learning model that can be used to generate
    predictions and explanations. The data and models never leave MySQL HeatWave, saving time and
    effort while keeping the data and models secure. HeatWave AutoML is optimized for HeatWave shapes
    and scaling, and all processing is performed on the HeatWave Cluster. | 
    ```

1. Ask a follow-up question:

    ```mysql
    call sys. heatwave_chat("How to set it up?");
    ```

    The output is similar to the following:

    ```none
    |  To set up HeatWave AutoML in MySQL HeatWave, you need to follow these steps:
      1\. Ensure that you have an operational MySQL DB System and are able to connect to it using a MySQL client.
      If not, complete the steps described in Getting Started with MySQL HeatWave.
      2\. Ensure that your MySQL DB System has an operational HeatWave Cluster. If not, complete the steps
      described in Adding a HeatWave Cluster.     
      3\. Obtain the MySQL user privileges described in Section 3.2, Before You Begin. 
      4\. Prepare and load training and test data. See Section 3.4, Preparing Data. 
      5\. Train a machine learning model. See Section 3.5, Training a Model.
      6\. Make predictions using the trained model. See Section 3.6, Making Predictions.
      7\. Generate explanations for the predictions made by the model. See Section 3.7, Generating Explanations.
      8\. Monitor and manage the performance of the model. See Section 3.8, Monitoring and Managing Performance. |
    ```
 
      You can continue asking follow-up questions in the same chat session.

## Cleaning Up 

To avoid being billed for the resources that you created for this quickstart, perform the following steps:

1.  Delete the database that you created:

    ```mysql
    drop database quickstart_db;
    ```

1.  Delete `quickstart_bucket`. For more information, see [Deleting the Object Storage Bucket](https://docs.oracle.com/en-us/iaas/Content/Object/Tasks/managingbuckets_topic-To_delete_a_bucket.htm).
