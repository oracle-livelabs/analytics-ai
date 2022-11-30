# Use OCI Document Understanding in the Console

## Introduction
In this lab, we will provide a ZIP file containing biomedical images separated into 3 subfolders based on how each image has been medically classified. In this lab, participants will download this ZIP file, bulk upload the images to object storage, and will create a labeled dataset using the Data Labeling Service and custom bulk-labeling code.

*Estimated Time*: 20 minutes

### Objectives

In this lab, you will:
- Create an Object Storage Bucket and load images from your local machine into the Bucket
- Create a Data Labeling Service dataset and bulk label the images that were loaded into Object Storage

### Prerequisites

- An Oracle Free Tier, or Paid Cloud Account
- Ensure that you have OCI-CLI installed. If unsure, run the following in your local command line and make sure your namespace is returned.
    ```
    <copy>oci os ns get</copy>
    ```
    Else, refer to the [OCI-CLI setup instructions](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm)
- Ensure that you have Python SDK installed on your machine by following the steps [here](https://docs.oracle.com/en-us/iaas/tools/python/2.57.0/installation.html#install)
  * Note that if you have a Python version of less than 3, it is necessary to replace all instances of 'python3' in the CLI operations mentioned in this lab with 'python'. In these lab instructions, we will assume that the user has Python3.

**Required Download:**

Mac Users: Use [this](https://objectstorage.us-ashburn-1.oraclecloud.com/p/zDOLdHIblEgbMO_4RCotgp4_iL32UnBY8WCjR78hAvJJJj8nbQyB6FNoHt633fIb/n/orasenatdpltintegration03/b/all-images-live-lab/o/biomedical-image-classification-training-data.zip) link to download the files needed throughout the lab. Unzip the file to a location of your choice on your local machine.

Windows Users: Use [this](https://objectstorage.us-ashburn-1.oraclecloud.com/p/PN4oCX_LSj-gkGIciVxpHVpW36-Vh_wj8VVEk7q-5VR5sO_bGR_IY4XPvOvVFg89/n/orasenatdpltintegration03/b/all-images-live-lab/o/windows-biomedical-image-classification-training-data.zip) link to download the files needed throughout the lab. Unzip the file to a location of your choice on your local machine.

## **Policy Setup**

Before you start using OCI Data Labeling Service, you or your tenancy administrator should set up the following policies by following below steps:
      ```
## **Task 1:** Upload data to Object Storage (Optional)
This is an optional set of steps if you want to test OCI Document Understanding with a variety of sample documents

1. Create an Object Storage Bucket (This step is optional in case the bucket is already created)
  a. First, From the OCI Services menu, click Object Storage.
  ![Console navigation window](./images/bucket1.png)

  b. Then, Select Compartment from the left dropdown menu. Choose the compartment matching your name or company name.
  ![Create object storage compartment window](./images/bucket2.png)

  c. Next click Create Bucket.
  ![Create bucket window](./images/bucket3.png)

  d. Next, fill out the dialog box:
  -Bucket Name: Provide a name
  -Storage Tier: Standard

  e. Click create
  ![Create bucket window](./images/bucket4.png)

2. Upload image files into Storage Bucket

  a. Switch to OCI window and click the Bucket Name.

  b. Bucket detail window should be visible. 
  ![Console navigation window](./images/bucket5.png)

  c.Click on Upload and then browse to file which you desire to upload. 
  ![Console navigation window](./images/bucket6.png)

## **Task 2:** Analyze Document Data

  **a. Navigate to the Document Understanding page**
  Using the Burger Menu on the top left corner, navigate to Analytics and AI and click it, and then select Document Understanding
  ![Console navigation window](./images/DUS1.png)

  **b. Test with a demo image**
  On the panel under Document Understanding, select a feature page like text detection. Toggle between sample image buttons to see the different extraction results on the right hand Results panel. 
  ![DUS demo window](./images/DUS2.png)

  If you're curious about the raw JSON response, select the dropdown button under "Response"
  ![Results panel](./images/DUS3.png)

  You can repeat these steps across the Table detection, key value detection, and document classification panels in the console.
  ![DUS navigation panel](./images/DUS4.png)

  **c. Test with your own documents**
  To test with your own documents, you have two options: either select a local file from your machine or a document in Object storage. To select either option, click either radio button next to "Demo Files" at the top of the page:
  ![Local file panel](./images/DUS5.png)

  You'll be prompted to choose an output location in Object Storage for Document Understanding service to store the JSON result. On this prompt window, choose a compartment, bucket, and prefix. Then select submit.
  ![Local file panel](./images/DUS6.png)

  Now you can select a local file or file you uploaded to object storage in Task 1.
  ![Local file panel](./images/DUS7.png)

## **Summary**

Congratulations! </br>
In this lab you have learnt how use OCI Document Understanding in the conosle.

You may now **proceed to the next lab**.

[Proceed to the next section](#next).

## Acknowledgements
* **Authors**
    * Kate D'Orazio - Product Manager


* **Last Updated By/Date**




## **Task 2:** Upload the Images From Your Local Machine Into Your Bucket
**Note:** These instructions are Mac OS compatible
1. On your local machine, execute the following commands to set environment variables for the name of your bucket and the OCID of the compartment where your bucket exists. Be sure to replace the information in "<>" with your own values.
    ```
    <copy>export DL_BucketName="<your bucket name>"</copy>
    ```
    ```
    <copy>export DL_Compartment=<OCID of your Compartment></copy>
    ```

2. On your local machine, execute the following commands to set environment variables for the directory named "Cell" that contains your JPG/JPEG image files to be labeled accordingly. Be sure to replace the information in "<>" with your own values.
    ```
    <copy>export DL_LabelDirectory="<path to Cell folder>"</copy>
    ```

3. Execute the following command to bulk-upload the JPG/JPEG image files to your bucket from the "Cell" folder, appending the prefix "c" to the objects that will be created from this bulk-upload command, which will be used to bulk-label the records in our Dataset later in this lab.
    ```
    <copy>oci os object bulk-upload --bucket-name "${DL_BucketName}" --src-dir $DL_LabelDirectory --content-type 'image/jpeg' --object-prefix c</copy>
    ```
4. Repeat Steps 2 and 3, replacing "Cell" and "c" with "Stripe" and "s", which represent another category into which our images will be classified.

5. Repeat Steps 2 and 3, replacing "Stripe" and "s" with "Debris" and "d", which represent another category into which our images will be classified.

6. Confirm that the images have been uploaded to object storage and have been prepended with the appropriate letter.
![Inspecting that images were uploaded to object storage](./images/obj-storage-upload-confirm.png)

## **Task 3:** Create a Data Labeling Service Dataset
1. From the OCI services menu, click 'Data Labeling' under 'Machine Learning.'
![OCI services menu](./images/dls.png)

2. Click on 'Datasets.'
![Clicking on datasets from Data Labeling Service](./images/datasets.png)

3. Set your Compartment to the same Compartment where you created your Bucket using the drop down under List Scope.
![Selecting the compartment](./images/compartment-dls.png)

4. Create your dataset by clicking 'Create dataset.'

  a. Name: enter a name for your DLS Dataset that you can recognize, e.g. image-classification-demo

  b. Dataset format: Images

  c. Annotation Class: Single Label

  d. Click 'Next'
  ![Create dataset window - add dataset details](./images/create-dataset.png)

  e. Retrieve files from Object Storage by choosing 'Select from Object Storage'
  ![Create dataset window - select from object storage](./images/select-from-obj-storage.png)

  f. Choose the name of compartment where your Bucket exists
  ![Create dataset window - select compartment where bucket resides](./images/select-dataset-compartment.png)

  g. Choose your Bucket by name
  ![Create dataset window - select bucket](./images/select-dataset-bucket.png)

  h. Add Labels: enter all possible labels that you will want to use to label any of your data, pressing enter between each label. In our case, our labels will be:
    * cell
    * stripe
    * debris
  ![Adding labels](./images/dataset-labels.png)

  i. Click 'Next'
  ![Clicking next](./images/dataset-next.png)

  j. Review the information and deploy your Dataset by clicking 'Create'
  ![Create dataset window - review information](./images/click-create-dataset.png)

5. Retrieve the Dataset OCID- you will need this during the next Task. Dataset OCID can be found here:
  ![Identifying dataset OCID](./images/dataset-OCID.png)

## **Task 4:** Populate Your DLS Dataset With the Data From Your Object Storage Bucket
1. Click into your new Dataset. When all of the data has been imported into your DLS Dataset from your Object Storage Bucket, it will be time to perform a bulk-labeling operation on your data.

2. Download the bulk-labeling tool to your machine. Navigate to the link [here](https://github.com/scacela/oci-dls-bulk-labeling), select 'Code' and select 'Download ZIP' to download the tool locally.
![GitHub repository where bulk data labeling code resides](./images/download-bulk-labeling-code.png)

3. Open the file named config.py from the bulk-labeling tool contents, and replace the values with your own (config\_file\_path, region\_identifier, compartment\_id, dataset\_id, labels).

  **Note:** Enter "cell", "stripe", "debris" as the 3 labels.

4. Modify the labeling\_algorithm to "first\_letter" from "first\_match"

5. Open your Command-Line Interface (CLI) and navigate to the folder where the bulk-labeling tool files exist on your machine.

6. Bulk-label the records in your DLS Dataset by running the following command:
    ```
    <copy>python3 main.py</copy>
    ```

7. Verify that your images have been labeled by navigating to the dataset created earlier and selecting one of the images.
![Pointing to an image in the dataset](./images/verify-label1.png)
![Verifying image has label](./images/verify-label2.png)

Congratulations on completing this lab!

[You may now **proceed to the next lab**](#next).

## Acknowledgements
* **Authors**
    * Samuel Cacela - Staff Cloud Engineer
    * Gabrielle Prichard - Cloud Solution Engineer

* **Last Updated By/Date**
    * Gabrielle Prichard - Cloud Solution Engineer, April 2022
