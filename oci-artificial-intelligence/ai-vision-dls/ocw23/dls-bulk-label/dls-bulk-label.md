# Use Data Labeling to bulk label a dataset
**Estimated Time**: *35 minutes*

## Introduction

In this Lab, you will be provided a dataset consisting of *1710 images*. The images have been pre-sorted into folders by medical professionals, named either *Cell*, *Debris*, or *Stripe*. While images in the *Cell* folder depict intact and viable cellular structures, the *Debris* and *Stripe* folders contain images of two types of non-cell structures. The folders contain the same number of images.

You will load this dataset into Object Storage, and prepare the data for model training by labeling each image. But don't worry - you won't have to label each image individually! This Lab provides a helper script as a short cut to help you efficiently label every image based on the way the images are pre-sorted.

After your data has been labeled, you will be able to move on with training your custom AI Vision model in style.

The Tasks in this Lab are organized as follows:

* **Task 1**: Create Identity and Access Management (IAM) Compartment, Policy, Group, and Dynamic Group to enable necessary permissions for this LiveLab
* **Task 2**: Create an Object Storage Bucket
* **Task 3**: Downloaded the training data using Cloud Shell, and bulk-upload the biomedical training data to your Object Storage Bucket
* **Task 4**: Create a Dataset in OCI Data Labeling, which imports the training images from your Object Storage Bucket as records
* **Task 5**: Leverage a helper script to bulk-label the records in your OCI Data Labeling Dataset

## **Primary Objectives**

In this Lab, you will:

* Learn how to navigate in the OCI web console and be able to demo key Data Labeling features
* Learn how to leverage a helper script to bulk-label a dataset of biomedical images, i.e. efficiently label a large volume of images

## **Prerequisites**

* An Oracle Free Tier, or Paid Cloud Account
* You are either a tenancy administrator, or has access to a tenancy administrator for the policy setup described in *Lab 1, Task 1*
    * *Note:* If you are not a tenancy administrator, begin with *Lab 1, Task 2* after the tenancy administrator has assigned permissions in *Lab 1, Task 1*
* Accessibility to your tenancy's [home region](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingregions.htm)
* Sufficient resource availability within your home region for 1 Object Storage Bucket, 1 Data Labeling Dataset, 1710 Data Labeling Dataset Records, 1 Compartment, 1 Policy, 1 Group, and 1 Dynamic Group

## **Task 1:** Identity and Access Management (IAM) Setup
*\[10 minutes\]*

Before you start using OCI Data Labeling, you or your tenancy administrator should set up the following Identity and Access Management (IAM) configuration:

1. Create a new compartment where you will provision the resources used for this lab.

  a. From the OCI Services menu, click **Identity & Security** > **Compartments**

  ![OCI Services Menu](./images/1-1-menu-identity-and-security-compartments.png)

  b. Click **Create Compartment**.

  ![Create compartment window](./images/1-2-create-compartment.png)

  c. **Name**: Provide a name for your Compartment, e.g. **Image\_Classification**

  d. **Description**: Provide a description for your Compartment, e.g. *Compartment for image classification OCW23 LiveLab*

  e. **Parent Compartment**: Select the root-level compartment, which has the same name as your tenancy.

  f. Click **Create Compartment**.

  ![Create compartment window](./images/2-create-compartment-details.png)

2. Find the compartment's Oracle Cloud Identifier (OCID), as shown in the below image. Then, copy and paste this value into a new line on a digital notepad app. You will retrieve this value when building your IAM Policy statements.

  ![Find the compartment OCID](./images/3-copy-compartment-ocid.png)

3. Create a Group and add users to it.

  a. From the OCI Services menu, click **Identity & Security** > **Domains**

  ![OCI Services Menu](./images/4-menu-identity-and-security-domains.png)

  b. Select the root compartment from the dropdown menu on the left-hand side of the screen, and select the **Default** domain.

  ![Domains](./images/5-identity-domains.png)

  c. Click **Groups** on the left-hand side of the page. Then, click **Create group**.

  ![Create Group](./images/6-groups-in-default-domain.png)

  d. **Name**: Provide a name for your Group, e.g. **Image\_Classification\_Group**

  e. **Description**: Provide a description for your Group, e.g. *Group for image classification OCW23 LiveLab users*

  f. Select the name of the user who will proceed with the lab tasks after the Policy Setup.

  ![Create Group](./images/7-create-group.png)

  ![Create Group Done](./images/8-create-group-done.png)

4.  Create a Dynamic Group. The Dynamic Group will serve as a reference to a collection of resources that is determined by the matching rule logic associated with the Dynamic Group. You will write a matching rule that will match all Data Labeling Datasets in your new compartment.

  a. Click **Default domain** on the upper-left of the screen.

  ![Click Default Domain](./images/9-click-default-domain.png)

  b. Click **Dynamic groups**.

  ![Click Dynamic Group](./images/10-default-domain-dynamic-group.png)

  c. Click **Create dynamic group**.

  ![Click Create Dynamic Group](./images/11-create-dynamic-group-button.png)

  d. **Name**: Provide a name for your Dynamic Group, e.g. **Image\_Classification\_Dynamic_Group**

  e. **Description**: Provide a description for your Dynamic Group, e.g. *Dynamic Group for image classification OCW23 LiveLab resources*

  f. Paste the following matching rule into the text field. Replace the placeholder value **&ltcompartment OCID&gt** with your own compartment OCID from your notepad. Be sure to preserve the quotation marks from the template.
      
      ```
      <copy>ALL {datalabelingdataset.compartment.id='<compartment OCID>'}</copy>
      ```
  g. Click **Create**.

  ![Create Dynamic Group window](./images/12-1-create-dynamic-group.png)

5. Create a Policy. The Policy will contain a series of statements. Each statement will allow a Group (and associated users) or Dynamic Group (and associated resources that are matched by the matching rule) to access specified resources to specified degrees of privilege.

  a. From the OCI Services menu, click **Identity & Security** > **Policies**.

  ![OCI Services Menu](./images/12-2-menu-identity-and-security-policies.png)

  b. Select the root compartment from the dropdown menu on the left-hand side of the screen.

  c. Click **Create Policy**.

  d. **Name**: Provide a name for your Policy, e.g. **Image\_Classification\_Policy**

  e. **Description**: Provide a description for your Policy, e.g. *Policy for image classification OCW23 LiveLab*

  f. **Compartment**: Ensure that the policy is scoped at the root-level compartment. Click the toggle switch labeled **Show manual editor** to enable entry of free-form text into a text field. You will use this text field to build your Policy logic.

  g. Toggle the **Show manual editor** switch. Then, copy and paste the following statements into the Policy Builder editor. Replace the placeholder value **&ltcompartment OCID&gt** with your own compartment OCID from your notepad.
      
      ```
      <copy>Allow dynamic-group Image_Classification_Dynamic_Group to read buckets in compartment id <compartment OCID>
      Allow dynamic-group Image_Classification_Dynamic_Group to read objects in compartment id <compartment OCID>
      Allow dynamic-group Image_Classification_Dynamic_Group to manage objects in compartment id <compartment OCID> where any {request.permission='OBJECT_CREATE'}
      Allow group Image_Classification_Group to manage object-family in compartment id <compartment OCID>
      Allow group Image_Classification_Group to read objectstorage-namespaces in compartment id <compartment OCID>
      Allow group Image_Classification_Group to manage data-labeling-family in compartment id <compartment OCID>
      Allow group Image_Classification_Group to use cloud-shell in tenancy
      Allow group Image_Classification_Group to manage ai-service-vision-family in compartment id <compartment OCID></copy>
      ```
    h. Click **Create**.

    ![Policy](./images/13-create-policy.png)

## **Task 2:** Create an Object Storage Bucket
*\[2 minutes\]*

1. From the OCI services menu, click **Storage** > **Buckets**

  ![OCI services menu](./images/14-menu-storage.png)

2. Select your new compartment using the dropdown menu under **List Scope**.

3. Click **Create Bucket** and enter details for your Bucket:

  ![Select compartment](./images/15-select-compartment-on-object-storage-page-and-click-create-bucket.png)

  a. **Bucket Name**: Enter a name for your Bucket that you can recognize, e.g. *image-classification-bucket*. Make a note of this name for later use in this lab.

  b. Click **Create**.

  c. Navigate to the detailed view of your bucket by clicking on the hyperlinked listing named after your bucket, and see the details associated with your bucket.

  ![Create Object Storage Bucket](./images/16-create-bucket.png)

  ![Create Object Storage Bucket Complete](./images/17-create-bucket-done.png)

  ![Click Into Object Storage Bucket](./images/17-2-click-into-bucket.png)


## **Task 3:** Load the Biomedical Training Data into Object Storage
*\[3 minutes\]*

1. Open Cloud Shell.

  ![Open Cloud Shell](./images/18-from-bucket-navigate-to-cloud-shell.png)

2. Feel free to dismiss the tutorial by entering *N*, or enter *Y* if you wish to follow the tutorial. Note your ability to minimize, maximize, and restore the Cloud Shell window as is convenient for intermittent interaction with the OCI Console UI.

3. Run the following command on your Cloud Shell command line interface (CLI) to download the image files necessary this lab, which is the training data that will be used to train the computer vision machine learning model:
    
    ```
    <copy>wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/R2GriGitNq-0NmTYGez0fop69aXx4SniJhyOjYpKXQyvQtaRtWU3yPgB8DaUzjey/n/orasenatdpltintegration03/b/all-images-live-lab-ocw23/o/Biomedical_Image_Classification_Training_Data.zip</copy>
    ```
4. Run the following command to unzip the download, extracting the enclosed folder containing the image files:
    
    ```
    <copy>unzip Biomedical_Image_Classification_Training_Data.zip</copy>
    ```
5. Execute the following command to bulk-upload the training image files to your bucket. Note that if you provided a different name than **image-classification-bucket**, then replace this name in your command before you run it.
    
    ```
    <copy>oci os object bulk-upload --bucket-name image-classification-bucket --src-dir ~/Biomedical_Image_Classification_Training_Data --content-type 'image/jpeg'</copy>
    ```

  ![Bulk-Upload Training Images](./images/19-bulk-upload-done.png)

6. Once the bulk-upload process has completed, refresh the bucket page as indicated in the below screenshot.

  ![Bulk-Upload Training Images](./images/20-bulk-upload-done-refresh-bucket.png)

7. Confirm that your training images have been uploaded to your Object Storage bucket within their respective folders.

  ![Bulk-Upload Training Images](./images/21-bulk-upload-done-expand-folder.png)

## **Task 4:** Create a Data Labeling Dataset
*\[3 minutes\]*

1. From the OCI services menu, click **Analytics & AI** > **Data Labeling**

  ![OCI services menu](./images/22-menu-analytics-and-data-labeling.png)

2. Click on **Datasets**.

3. Select your new compartment using the dropdown menu under **List Scope**.

4. Create your Data Labeling Dataset by clicking **Create dataset**.

  ![Data Labeling Datasets](./images/23-data-labeling-datasets.png)

  a. **Name**: Enter a name for your Data Labeling Dataset, e.g. *image-classification-dataset*

  b. **Dataset format**: *Images*

  c. **Annotation Class**: *Single Label*

  d. Click **Next**.

  ![Name, Dataset format, Annotation Class](./images/24-create-dataset-page-1-dataset-format-annotation-class.png)

  e. Retrieve files from Object Storage by choosing **Select from Object Storage**.

  f. **Compartment**: Select the name of compartment where your Object Storage bucket exists.

  g. **Bucket**: Select your Bucket by name.

  ![Select Bucket](./images/25-create-dataset-page-2-select-bucket.png)

  h. **Add Labels**: You will enter all possible labels into this field. In our case, our labels will be as shown below. Be sure that the *first letter* of each label is *uppercase*, and the *remaining letters* are *lowercase*. Take care to leave no space characters in the label names.
    
    * Cell
    * Debris
    * Stripe

  i. Click **Next**.

  ![Add Labels](./images/26-create-dataset-page-2-add-labels.png)

  j. Review the information and deploy your Data Labeling Dataset by clicking **Create**.

  ![Review](./images/27-create-dataset-page-3-review.png)

5. Find the Dataset OCID as shown in the screenshot. Then, copy and paste this value into a new line on your digital notepad app. You will retrieve this value in the next Task when configuring the bulk-labeling tool.

  ![Identifying dataset OCID](./images/28-labels-importing-copy-dataset-ocid.png)

6. Note that It will take about *10 minutes* for the the data to be fully imported into your Data Labeling Dataset, as records, from your Object Storage Bucket. Once the records have been fully imported, the page will appear similar to the below screenshot, and the **Status** of the Dataset will show as *Active*. Move onto the next Task while your images are importing.

## **Task 5:** Populate Your Data Labeling Dataset With the Data From Your Object Storage Bucket
*\[17 minutes\]*

1. On Cloud Shell, run the following command to download the bulk-labeling script to the home directory on your Cloud Shell machine.
    
    ```
    <copy>cd; git clone https://github.com/oracle-samples/oci-data-science-ai-samples.git</copy>
    ```
2. Run the following command to change your directory to the folder where the configuration files and main executable script are located.
    
    ```
    <copy>cd oci-data-science-ai-samples/data_labeling_examples/bulk_labeling_python</copy>
    ```
3. Run the following command to obtain the identifier of your tenancy's home region. Copy and paste the returned value into a new line on your digital notepad app.
    
    ```
    <copy>echo $OCI_REGION</copy>
    ```
4. Open the file named **config.py** from the bulk-labeling tool contents with a CLI-based text editor of your preference (e.g. vi, nano, emacs), and then edit the variables as indicated below. Be sure to replace the **&ltplaceholder values&gt** with your own values. Preserve the quotation marks in the template. Instructions on how to make these edits using vi are provided, and are recommended for users who are unfamiliar with CLI-based text editors.
    
    ```
    CONFIG_FILE_PATH = "/etc/oci/config"
    REGION_IDENTIFIER = "<Region identifier from your notepad app>"
    DATASET_ID = "<OCID of your Data Labeling Dataset from your notepad app>"
    ```
  a. Open **config.py** by running the following command:

    ```
    <copy>vi config.py</copy>
    ```

  b. Use the **arrow keys** to navigate your cursor to the end of the value to the right of: *CONFIG\_FILE\_PATH =*
  
  c. Enter *insert* mode by typing **i**.
  
  d. Delete the value within the quotation marks using the **delete** button.
  
  e. Enter the value to be assigned to **CONFIG\_FILE\_PATH** in our example, which is: **"/etc/oci/config"**. Be sure to include the quotation marks where indicated.
  
  f. Press **ESC** to escape *insert* mode.
  
  g. Repeat steps **b.** through **e.**, for the remaining variables (**REGION\_IDENTIFIER** and **DATASET\_ID**) and their respective values, as indicated above.
  
  h. Save your edits and exit the vi editor by typing **:wq** (*write* followed by *quit*), then pressing **Enter**.

5. Open the file named **classification\_config.py** from the bulk-labeling tool contents, and then edit the variables as indicated below, in a fashion similar to the previous step:
    ```
    LABELS = ["Cell", "Debris", "Stripe"]
    LABELING_ALGORITHM = "FIRST_REGEX_MATCH"
    ```
  a. Similarly, open **classification\_config.py** by running the following command:

    ```
    <copy>vi classification_config.py</copy>
    ```

  b. Use the **arrow keys** to navigate your cursor to the end of the value to the right of: *LABELS =*
  
  c. Enter *insert* mode by typing **i**.
  
  d. Delete the value within the quotation marks using the **delete** button.
  
  e. Enter the value to be assigned to **CONFIG\_FILE\_PATH** in our example, which is: **["Cell", "Debris", "Stripe"]**. Be sure to include the quotation marks where indicated.
  
  f. Press **ESC** to escape *insert* mode.
  
  g. Repeat steps **b.** through **e.**, for **LABELING\_ALGORITHM** and its respective value, as indicated above.
  
  h. Save your edits and exit the vi editor by typing **:wq**, then pressing **Enter**.

6. Install pandas for your user on Cloud Shell, which is a prerequisite for running the bulk-labeling script:
    ```
    <copy>pip install --user pandas</copy>
    ```
7. Run the script once the images have been imported:

  a. Check whether your page appears similar to the below screenshot, with the **Status** of your Dataset showing as *Active*, and the value next to **Labeled:** appearing as *0/1710*, indicating that while *1710* images have been imported as records, none (*0*) of them have been labeled. You can track progress by clicking **Dataset list** and then clicking your Dataset listing to return to this page. Once you have confirmed that your page appears similar, move onto *b.*

  ![All records imported](./images/29-records-imported.png)

    * *Note:* Until this is the case, you may use the buttons on the web console UI as shown in the below screenshots to check on the progress of the importing of records from Object Storage. For this lab, we recommend this method of checking progress rather than by refreshing the browser tab. Refreshing the browser tab will force a reconnect to your Cloud Shell session. If you refresh the browser tab, then before proceeding with subsequent steps, you will need to run *cd oci-data-science-ai-samples/data_labeling_examples/bulk_labeling_python* on Cloud Shell to change your directory to the directory containing the bulk-labeling script.

    ![Use Console Buttons click out of dataset](./images/31-console-buttons-click-out-of-dataset.png)

    ![Use Console Buttons click back into dataset](./images/32-console-buttons-click-back-into-dataset.png)

  b. Run the following command to bulk-label the records in your Data Labeling dataset. This process is expected to complete after about **5 minutes**.
    
    ```
    <copy>python bulk_labeling_script.py</copy>
    ```
8. If you notice that the bulk-labeling process halts or fails out, as shown in the below screenshot, simply run the following command again to resume the bulk-labeling process.
    
    ```
    <copy>python bulk_labeling_script.py</copy>
    ```

  ![Troubleshooting Bulk Labeling](./images/33-bulk-labeling-troubleshooting.png)

9. Use the buttons on the web console UI as shown in the below screenshots to check on the progress of the the bulk-labeling. For this lab, we recommend this method of checking progress rather than by refreshing the browser tab. Refreshing the browser tab will force a reconnect to your Cloud Shell session, and halt the bulk-labeling process. If you refresh the browser tab, then before proceeding with subsequent steps, you will need to run *python bulk\_labeling\_script.py* on Cloud Shell to resume the bulk-labeling process.

  ![Use Console Buttons click out of dataset](./images/31-console-buttons-click-out-of-dataset.png)

  ![Use Console Buttons click back into dataset](./images/32-console-buttons-click-back-into-dataset.png)

10. Notice that the number of labeled records will increase on the dataset page similarly to as shown in the below screenshot. Notice that in this example, *1082* of the *1710* records have so far been labeled.

  ![Records Unlabeled](./images/30-labeling-progress.png)

11. After the bulk-labeling process has completed, a report detailing the duration of the labeling process will print to the screen, and the dataset page will reflect that *1710/1710* records have been labeled.

  ![Records Labeled](./images/35-all-records-labeled.png)

12. Verify that your images have been labeled by clicking into one of the records, and checking that the label is as you would expect it. In the example shown in the below screenshots, we can see that this record was sourced from the *Stripe* folder, based on the image name, *Stripe/\*-998.jpg*, and was labeled correspondingly as part of the bulk-labeling process.

  ![Pointing to an image in the dataset](./images/36-verify-label-click-listing.png)

  ![Verifying Image has Label](./images/37-verify-label-check-label.png)

**Congratulations on completing Lab 1!** Now that you have a labeled dataset, you are ready to [**progress to Lab 2**](#next) to train your own cell classifier.

## Acknowledgements

* **Authors**
    * Samuel Cacela - Senior Cloud Engineer
    * Gabrielle Prichard - Product Manager, Analytics Platform
    * Xin-hua Hu - Professor, Dept. of Physics at East Carolina University
    * David Chen - Master Principal Cloud Architect

* **Last Updated By/Date**
    * Samuel Cacela - Senior Cloud Engineer, June 2023
