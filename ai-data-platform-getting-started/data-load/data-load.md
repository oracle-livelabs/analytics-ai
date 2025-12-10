# Load the Formula 1 test data in your AI Data platform in Bronze layer

## Introduction

This lab is to prepare your environment, data and load it into your object storage bucket that you have prepared as prerequisite for this workshop. From Object storage the files get added to the volume in Bronze as external files.
Once that is done the files will be loaded in the Bronze catalog schema in Delta format. For this part we provide a setup sample notebooks that we load into the workspace and we run the first set to load the files into delta lake tables.

Estimated Time: 60 minutes

### Objectives

In this lab, you will:

* Define a folder structure to load and structure various content elements like datasets, notebooks, files to use them in following labs
* Load the datasets needed for next labs into your object storage bucket
* Load notebook files in preparation of executing and building workflows

### Prerequisites

This lab assumes you have:

* All previous labs successfully completed
* The object storage bucket already created in the same compartment as the AI Data Platform and you have access to that bucket.

## Task 1: Open your bucket in Oracle OCI and load datasets

From the GitHub folder [Download notebook and source data files](https://c4u04.objectstorage.us-ashburn-1.oci.customer-oci.com/p/EcTjWk2IuZPZeNnD_fYMcgUhdNDIDA6rt9gaFj_WZMiL7VvxPBNMY60837hu5hga/n/c4u04/b/livelabsfiles/o/labfiles%2FSourcedataandnotebookfiles.zip)) you can download the source files and upload them into your OCI Object storage bucket.
In the upload screen you can drag an drop the files in the bucket. No need to adjust any settings

1. Step 1: Upload downloaded files into AI Data Platform

    After you have downloaded the files from Github, navigate to your OCI Object storage bucket, select the 'Object' tab and use the 'Upload Objects' button to upload your files.

    ![file location](./images/filestoload.png)

    Upload into bucket

    ![bucket file upload](./images/bucketupload.png)

2. Step 2: create catalog entry

    Go to your AI Data Platform and open your master catalog. There you need to define 3 catalogs for each layer of the medallion architecture. In the example screen print they are called: f1\_bronze, f1\_silver, f1\_gold

    ![creation of catalogs](./images/createcatalogentry.png)

3. Step 3: create schema

    Open each catalog that you have created in step 2 and create schema inside each catalog. In the example screen print they are called: bronze, silver, gold

    ![creation of schema](./images/createcatalogschema.png)

4. Step 4: create volume and upload files

    In the 'f1\_bronze' catalog in the 'bronze' schema you need to create a volume to store the data files as external catalog items. Select the 'bronze' schema in the master catalog pane, and in the main pane you select 'volume'. Once selected you click the '+' symbol to create a volume. In the example the volume name 'f1\_bronze_volume' is used. In the entry screen, create name, select 'external' and select the compartment, bucket, (and folder) where you stored you data files at steps 1. Make. sure you push the 'upload' button.

    ![creation of external volume](./images/createcatalogexternalvolume.png)

## Task 2: Create a tables in Bronze from files that have been uploaded

As final step of loading data is the creation of tables in the bronze catalog of AI Data Platform based on data files we have uploaded as external data volume files.

> **Note:** Occasionally you may get an error when executing a notebook that starts like. 
> [DELTA_CREATE_TABLE_WITH_NON_EMPTY_LOCATION] Cannot create table ('`f1_bronze`.`bronze`.`f1_lap_times_dlt`'). The associated location ('oci://IDL-458725532-1692497c19be4c739c68aec2e436a825@fro8fl9kuqli/1692497c19be4c739c68aec2e436a825.cat/bronze.db/f1_lap_times_dlt') is not empty and also not a Delta table.]
> or
> [DELTA_TRUNCATED_TRANSACTION_LOG] oci://IDL-458725532-1692497c19be4c739c68aec2e436a825@fro8fl9kuqli/1692497c19be4c739c68aec2e436a825.cat/bronze.db/f1_results_dlt/_delta_log/00000000000000000000.json: Unable to reconstruct state at version 1 as the transaction log
> In case this happens some. easy steps can be executed to work around this problem. From the error message you need to capture the associated location, which is pointing to an object storage location.
In OCI console you navigate to the object storage buckets. Use the location from the error message and open that bucket - folder to where you see the names o fthe tables as folders.
Right of the folder name (in this example f1_results_dlt or f1_lap_times_dlt) at the 3 ... you have the option to delete that particular folder. pelase do so and run the notebook that loads that file in the delta table again.
You might face the same error when loading data from Bronze to Silver. Same workaround applies.

1. Step 1: create workspace structure

    Open the workspace you created and create following folder structure (You can create your own structure but that will require changes to the notebook content).

    * Load-files
    * Files-to-bronze
    * Bronze-to-silver
    * Silver-to-gold

    ![workspace folder structure](./images/createfoldersworkspace.png)

2. Step 2: upload notebooks

    Upload notebook files that you downloaded from Github into their respective workspace folder. The notebook filenames start with a number followed by a name.
    In the 'Files-to-bronze' folder upload files starting with 01\_... to 07\_...
    In the 'Bronze-to-silver' folder upload files starting with 08\_... to 14\_...
    In the 'Silver-to-gold' folder upload files starting with 15\_... to 18\_...

    ![upload of notebooks](./images/uploadfilestoworkspace.png)

3. Step 3: open and run notebooks

    Open the workspace you created and open the 'Files-to-bronze' folder. In the main pane you open the file starting with name '01\_git\_file\_pitstops.ipynb'. In the Notebook pane which looks like the picture you see the content of the notebook. The Notebook is structured in cells which contain code. For this example we mainly use 'Python'.

    In between the code cells you also find descriptions. Cell can be run 1 by 1 as highlighted with the small arrow at the cell. The entire notebook also can be run with one click in top right corner. Before you are able to run a notebook you first need to attach the compute cluster as highlighted in the picture by clicking on 'cluster' get the drop down and click 'attach existing cluster'
    If you get a message that 'No Clusters area available' you need to start the cluster that you created previously by selecting 'compute' in the left pane and start the compute cluster at the '...' at the right side of the line of your compute cluster. (This start will take a little while. The cluster being stopped related to the idle time set at creation of the cluster. This setting can be adjusted if needed). You can go back to your notebook and attach the cluster. A green message appears when the cluster is attached. AI Data Platform will remember the cluster that was attached previously, but it has to be active.

    Once the cluster is attached you can run the notebook by clicking 'Run all', Or cell by cell if you prefer to track any errors.

    The structure of the notebooks is, that in the first cell some parameters are defined related folder structure and file names.

    When you have completed the first notebook in the 'Files-to-bronze' folder, you can open and run the other notebooks from that folder to populate the tables.

    ![open notebook file in workspace](./images/filestobronzeload.png)

4. Step 4: validate table creation

    This step is to verify the creation of the tables in the f1\_bronze schema in the catalog.
    After the notebook runs have completed successfully you can expand the f1\_bronze catalog item and expand the bronze schema to view the created tables. If they are not appearing you may need to refresh the catalog by using the refresh button at the top of the catalog pane.

    ![validate table creation](./images/filestobronzeviewresult.png)

**proceed to the next lab**

## Acknowledgements

* **Author** - Wilbert Poeliejoe, AI Data Platform Black Belt
* **Contributors** -  Massimo Dalla Rovere, AI Data Platform Black Belt
* **Reviewed by** - Lucian Dinescu, Senior Principal Product Manager, Analytics
* **Last Updated By/Date** - Wilbert Poeliejoe, AI Data Platform Black Belt: December 11th, 2025