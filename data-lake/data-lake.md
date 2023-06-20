# OCI Data Flow in the Data Lake

## Introduction

Data is constantly growing being enhanced, validated and updated. That is why once you have the data assets you need to make sure that processing continues to manage the data assets and provide updated values you data lake.

OCI Data Flows handles these processes by loading new data or updating.

Estimated time: 20 minutes

Watch the video below for a quick walk through of the lab.

[](youtube:arWzMjy5-y8)

### Objectives

* Learn how to create OCI Data Flow App
* Learn how to create OCI Data Load 
* Learn how to schedule to automate OCI Data Flow Apps

## Task 1: Create an OCI Data Flow app

You have several choices on how to create applications and languages. You can choose something that makes sense for your environment. First, we are going to take a look at the OCI Data Flow and create an application to read through files in the object storage or data lake.

We have created a python script for you to use as part of your OCI Data Flow application. It requires a little bit of editing to get your ADB ID, user name and password added to script and then uploaded to object storage. We are going to use Cloud Shell to do the editing and upload to our object storage bucket.

Start Cloud Shell

Click on the cloudshell icon in the top left hand corner next to your region information.
![Find Cloud Shell](./images/cloudshell-icon.png "Cloud Shell icon")

![Start Cloud Shell](./images/cloudshell-open.png " ")

From the current directory (your home directory of your user in Cloud Shell), create a file called livelabs-df.py

```
<copy>
vi livelabs-df.py
</copy>
```
Copy the following script and insert it into the livelabs-df.py file you are currently editing in Cloud Shell:

```
<copy>
from pyspark.sql import SparkSession
import sys

def oracle_datasource_example(spark):
    # Wallet  information.
    properties = {"adbId": ADB_ID,"user" : USERNAME,"password": PASSWORD}

    ##print("Reading data from autonomous database.")
    ##df = spark.read.format("oracle").option("dbtable", SRC_TABLE).options(**properties).load()
    
    print("Reading data from json file in object storage")
    df = spark.read.json("oci://data_lakehouse@c4u04/export-stream-2020-custid-genreid.json")
    
    df.printSchema()

    print("Filtering recommendation.")
    df.filter(df.recommended == "Y")

    print("Writing to autonomous database.")
    df.write.format("oracle").mode("overwrite").option("dbtable",TARGET_TABLE).options(**properties).save()

if __name__ == "__main__":
    spark = SparkSession \
        .builder \
        .appName("Python Spark Oracle Datasource Example") \
        .getOrCreate()

    # TODO: PROVIDE THE ARGUMENTS 
    ADB_ID = "replacewithADBID"
    SRC_TABLE = "ADMIN.EXPORT_STREAM_2020_UPDATED" 
    TARGET_TABLE = "ADMIN.MOVIE_GENRE" 
    USERNAME = "replacewithUSER"
    PASSWORD = "replacewithPASSWORD"

    oracle_datasource_example(spark)

    spark.stop()
</copy>
```

After pasting the above script, in the TODO section at bottom of the script a few of the variables need values. Replace the ADB ID with your autonomous database ocid, replace the username and password for your autonomous database, probably ADMIN, where it states replacewithXXXX. If you are unsure of your ADB ID, with Cloud Shell still open you can navigate to your ADW database from the hamburger menu to Autonomous Database and **Copy** the OCID to be pasted in the script in Cloud Shellwhere it states "replacewithADBID".

![Get the ADB ID](./images/getadbid.png " ")

Edit the replacewithXXXXX text with the correct information (paste with right click between the quotation marks):

![Paste ADB ID](./images/editfilepaste.png " ")

![Edited File](./images/editedfile.png " ")

See the edited file above for the three areas to edit. When finished editing press **esc** **:wq** to save the file and your changes.

Upload this edited file to your object storage using the command line in Cloud Shell after replacing REPLACEYOURNAMESPACE with your actual namespace name (Namespace name can be found in OCI tenancy:

```
<copy>
oci os object put --file livelabs-df.py --namespace REPLACEYOURNAMESPACE --bucket-name dataflow-warehouse
</copy>
```

![Upload File](./images/cloudshellupload.png " ")

Navigate from the hamburger memu to storage and select buckets. And you should see your python script in your dataflow-warehouse bucket ready for you to use in your application.

![Storage Buckets](./images/showbuckets.png " ")

Now, navigate to the OCI Data Flow and click on Create Application.

![Create Data Flow](./images/nav_dataflow.png " ")

For creating the application, you need to have the python code and we are providing an example one. Also you will need to have access to the data files. Enter a name for the application and if you would like a description. Take the other defaults for the first part of the form.

![Create Data Flow](./images/createsparkapp.png " ")

For this example,Than choose python. Select Object Storage dataflow-warehouse, and then choose the file you just uploaded livelabs-df.py

![Create Data Flow](./images/createappconfigure.png " ")

The Application Log location is the dataflow-logs bucket that was created. Output logs and error messages will go into this bucket.
Click on Show advanced options. And enter in the Spark configuration properties the key: spark.oracle.datasource.enabled and the value: true

![Advanced Options](./images/createappadvoptions.png " ")

Click on Create Application.

Now we can run the application by selecting the more option dots and selecting Run from the menu.

![Run Data Flow](./images/runappmanual.png " ")

It of course depends on how big your data file is but this sample takes about two minutes to return successfully. This job has filtered out the data and populated the movie_genre table with the job.

![Completed Data Flow](./images/runappresults.png " ")

You can also monitor your applications in the Spark UI. Click on the application name and click on the Spark UI button.

![Create Data Flow](./images/df_sparkui1.png " ")

And there are additional views to see the details about the jobs and applications running and completed.

![Create Data Flow](./images/df_sparkui2.png " ")

Now let's go back to OCI Data Integrations because we setup some other data sources to load as part of our data integration into the Data Lakehouse and use for additional queries as par of our analysis.


## Task 2: Create OCI Data Integration - Load

First we want to download the customer sales csv file that we can put into our object storage. This will show how you can do integrations from your object storage directly into your ADW or we can use the object storage to filter and change the files and stora back into our object storage without even going to the database.

Download the CSV file:

```
<copy>
https://objectstorage.us-ashburn-1.oraclecloud.com/n/c4u04/b/data_lakehouse/o/custsales_custsales-2020-01.csv
</copy>
```

Navigate to your object storage buckets. (Hamburger Menu, Storage, Buckets):

![Navigate to object storage](./images/object-storage-menu.png " ")

Select your dataflow-warehouse bucket to see the contents and to perform an upload of the csv file to that bucket.

![Select dataflow-warehouse bucket](./images/object-storage-select-bucket.png " ")

Upload this file to your object storage bucket dataflow-warehouse:

![Upload to object storage](./images/upload-object-storage.png " ")

Select the custsales_custsales-2020-01.csv file from your downloaded folder and click upload.

Navigate from the Hamburger menu to Analytics & AI, select Data Integration, and from the left menu select **Workspaces**. Here we will see our Workspace Lakehouse that we created as part of our configuration. We are going to then create a data loader task.

![Select Workspaces](./images/data-integration-workspaces-menu.png " ")

Select the workspace where you are creating the data integration, in this case it is the Lakehouse workspace.

![Select the Lakehouse workspace](./images/data-integration-workspace-select.png " ")

Select create data loader task, because we are going to use this as a data flow to take our csv file, perform transformations against and save it back into the object storage as json. This is a way to process data from files, to files, or to and from databases. We have already seen the loads to the database, and we know we have data that is going to be files that need filtering or transformations and we don't even have to put them in the database to do that.

![Select Create data loader task](./images/create-data-loader-task1.png " ")

Let's call this task LoadCustomerCSV

![Load Data Task](./images/create-data-loader-task.png " ")

Now we have to just put in the Source, any transformations and Target for the load process. 
Here you can see the options for source and target data. Click on File Storage for Source and File Storage for Target. We only have one file, so make sure that Single data entity is selected. Enter the name of LoadCustomerCSV, and before clicking next select the project - Project_lakehouse. Click Next.

![Select source and target type](./images/create-data-loader-task3.png " ")



Now provide information about the Source. There is the ability to create a new source, or select from those available. Be sure to choose the compartment lakehouse1 and the Bucket that the file was just uploaded to, dataflow-warehouse.

![Create Select File](./images/create-data-loader-task5.png " ")

Provide the file settings, such as CSV for file type, if the data has a header, and make sure the delimiter is set to COMMA, and uncheck the Trailing delimiter.

![Source file information](./images/create-data-loader-task4.png " ")

Last step for the source is to select the data entity because there can be multiple files in bucket. Select the custsales_custsales-2020-01.csv file that was uploaded to the bucket. Then click on Set as Source. Click next to setup the target.

![Provide file settings](./images/create-data-loader-task6.png " ")

Now it is time to fille out the information for the Target. This lab is just taking a CSV file and transforming to JSON as an example of what you can do outside of the database because we all know you have these files for loading and integrations either coming from other APIs or systems. So our target is going to be an object storage bucket and setting of JSON.

![Create Target and file settings](./images/create-data-loader-target.png " ")

Create new data entities for the Target. Create an output as a single file. Not to confuse the source and target, set a prefix of New.

![Set target information](./images/create-data-loader-target2.png " ")

Next step are the transformations and filters on the source data set. This time the file just changing format from CSV to JSON. Click Next.

![See transformation](./images/create-data-loader-transformation.png " ")

The last view is the validation of the source, target and data entities selected. If there are any errors in the files or formats, they will appear here and need to be corrected before the ability to run the loading task. Click on Create and Close if the validation result is Successful. You can Create if it still needs errors corrected.

![Validation of the data loader task](./images/create-data-loader-validate.png " ")

## Task 3: Create an application for automation

Now you are going to navigate back to the data integration workspace, and click on Application. Click on create application. Enter a name for the application, LAKEHOUSEAPP.

![Create Application](./images/create-app.png " ")

Click on Save and Close. It is just a shell of an application where you can now publish tasks to be scheduled and run through the application. Navigate to the Project_lakehouse, from the menu select Tasks. LoadCustomerCSV will be seen in the list and you will need to expand the three dot menu and add it to the application.

![Add Task to Application](./images/create-app2.png " ")

![Publish to application](./images/create-app3.png " ")

Select the application name, lakehouseapp:

![Select Application and Publish](./images/create-app4.png " ")

## Task 4: Run and schedule apps for automation

Now under the application select the menu at the end of the LoadCustomerCSV task. 

![View Task Added](./images/create-app5.png " ")

Now select **Run** task. After this runs successfully, you can return here to schedule the task to run regularly.

![Run Task](./images/create-app6.png " ")



You may now proceed to the next lab.

## Acknowledgements

* **Author** - Michelle Malcher, Database Product Management, Massimo Castelli, Senior Director Product Management
* **Contributors** - 
* **Last Updated By/Date** - Michelle Malcher, Database Product Management, September 2022
