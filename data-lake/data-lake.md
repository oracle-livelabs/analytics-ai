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


You may now proceed to the next lab.

## Acknowledgements

* **Author** - Michelle Malcher, Database Product Management, Massimo Castelli, Senior Director Product Management
* **Contributors** - 
* **Last Updated By/Date** - Michelle Malcher, Database Product Management, September 2022
