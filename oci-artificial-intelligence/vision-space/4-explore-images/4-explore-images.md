# Explore space images

## Introduction

In the previous labs we learned how to label images and use them to create a custom OCI Vision AI model. In this lab, we'll put a custom model to use to analyze space images. 

The features of OCI Vision are exposed through an API, which makes those features consumable by any application that can benefit. Consuming the API requires writing code to invoke the API, pass in the required data, and process the response. However, it is not always necessary to write code to use OCI Vision. Oracle provides the OCI Console user interface to exercise the Vision service as experienced in a previous lab, and Oracle Analytics Cloud (OAC) also provides a codeless interface for consuming OCI Vision. It's this OAC capability that will be used in this lab.

*Estimated Time*: 30 minutes

Watch the video below for a quick walk-through of the lab.
[Explore space images](videohub:1_8nka97yh)

### Objectives

* Create a source dataset of images to be processed by OAC
* Create an OAC data flow to process the images through OCI VIsion
* Create an OAC workbook to view images processed through OCI Vision

### Prerequisites
* You are using a LiveLabs sandbox environment

> **Note:** The LiveLabs sandbox environment has a pre-configured OAC instance that is used for this lab. In other environments, OAC would need to be provisioned and configured.

## **Task 1:** Download a file representing the source dataset
You'll download a csv file that contains the name and location of the space images to be processed through the OCI Vision custom model. This file is needed for the data flow that will be created in this lab.

1. Use the OCI console to navigate to **Storage** and then **Buckets**.

    ![Navigate to storage buckets](./images/console-storage-buckets.png)

1. Set compartment to **vision\_galaxy\_ws\_read\_only**, then click the bucket named **data-flow**.

    ![Set storage compartment](./images/buckets-data-flow.png)

1. Find the row containing *space-images-source.csv* and click the **3 dot icon** at the end of the row, then click **Download**. Save the file on your local machine to be used in a later step.

    ![Download csv file](./images/download-csv.png)

1. Open *space-images-source.csv* on your local machine. You don't need to edit it but notice what it contains.

    a. The name of a bucket that contains the images to be processed, i.e. *object-detection-read-only*

    b. The url for the bucket, i.e. *https://cloud.oracle.com/object-storage/buckets/idxv5eebn2fx/object-detection-read-only/objects?region=us-ashburn-1*

    > **Note:** The bucket containing the images was prepared in advance, as was the csv file.

1. Close the csv file (and don't save if prompted).


## **Task 2:** Access Oracle Analytics Cloud (OAC) and register the Vision model
Login to OAC then register the OCI Vision model with OAC so that it can be used in a data flow to process images.

1. Keep your OCI tab/window open and open the url below in a new tab in your web browser to access the OAC user interface: 

    [https://analyticscloudlivelabs-idxv5eebn2fx-ia.analytics.ocp.oraclecloud.com/ui/](https://analyticscloudlivelabs-idxv5eebn2fx-ia.analytics.ocp.oraclecloud.com/ui/)

    ![OAC home page](./images/oac-home.png)

    > **Note:** If you are prompted to login, use the same credentials as you used for the OCI console.

1. In OAC, click the **3 dot icon (page menu)** next to *Create* button in the upper right corner, then select **Register Model/Function**, and in the submenu select **OCI Vision Models**. 
    
    ![Register model](./images/oac-register-model1.png)

1. In the *Register a Vision Model* dialog, select the **Livelabs Galaxy** connection. (You may need to wait several seconds for the connection to be listed.)

    ![Select OCI connection](./images/oac-register-model2.png)

1. In the *Select a Model* dialog, select your custom Vision model: **custom-model-read-only**
    
    ![Select model](./images/oac-select-model.png)

1. In the *Select a Model* sub-dialog for *custom-model-read-only*, set *Staging Bucket Name* to **vision-staging-bucket**, then click **Register**.

    ![Enter staging bucket name](./images/oac-register-model3.png)

1. To confirm the model was registered, click the 3 bar icon in the upper left corner of the page and then select *Machine Learning*. The registered model is listed.
    ![Confirm the model registration](./images/oac-machine-learning.png)


## **Task 3:** Create an OAC dataset for the images to be processed
Create a dataset that will be the input to the OAC data flow.

1. In OAC, click the 3 bar icon in the upper left corner of the page and then select *Data*. 

    ![Select Data view](./images/oac-data1.png)

1. Drag and drop *space-images-source.csv* from your local machine (downloaded earlier) to the Oracle Analytics page. This will trigger it to be added as a dataset.

1. In the *Create Dataset from space-images-source.csv* dialog, click **OK**.

    ![Save created dataset](./images/oac-create-dataset.png)

1. The dataset is now listed.

    ![View dataset](./images/oac-data2.png)    


## **Task 4:** Create an OAC data flow to process images
Create a dataflow that ingests the space images from object storage, submits them to OCI Vision for object detection using the custom model, and outputs a new dataset that can be used for visualization in OAC.

1. In the upper right corder of the OAC screen, click **Create** and then **Data Flow**.
    
    ![Create data flow](./images/oac-create-dataflow.png)

1. A new data flow screen opens with the *Add Data* dialog on top. Find *space-images-source*, select it, then click **Add**. This adds the image source as the first step of the data flow.
    
    ![Add data](./images/oac-add-data.png)

1. Click the **+** button next to *space-images-source* and select **Apply AI Model**.
    
    ![Apply AI model](./images/oac-apply-ai-model.png)

1. In the *Select AI Model* dialog, select **custom-model-read-only**, then click **OK**.

    ![Select AI model](./images/oac-select-ai-model.png)

1. In the *Apply AI Model* configuration, scroll down to *Parameters* and click **Select a column**, then in the pop-up, select **Bucket Location**.

    ![Select input column](./images/oac-configure-ai-model.png)

1. Change *Maximum Number...(of results)* from 5 to 10.

    ![Change maximum number of results](./images/oac-configure-ai-model-max-number.png)

1. In the *Outputs*, uncheck **Vertex 2**, **Vertex 4**, **Synonyms**, and **Status Summary**, as these fields are not needed.

    ![Remove unneeded output columns](./images/oac-output-columns.png)

1. In the data flow diagram, click the **+** next to *Apply AI Model* to add another step, then select **Save Data**.

    ![Add save data](./images/oac-data-flow-add-final.png)

1. In the *Save Dataset* configuration, set the configuration as follows.

    ![Enter dataset name](./images/oac-save-data-configure.png)

    a. Change the *Dataset* to **Galaxy Object Detection Results**.

    b. Under *Columns*, change *Treat As* for *ID* to **Attribute**. 
    
    c. Under *Columns*, change *Default Aggregation* for *Confidence* to **Maximum**.

1. Click the **Save** icon on the top bar of the page and set the Data Flow *Name* to **Galaxy Object Detection Data Flow**. Then click **OK**  

    ![Save the data flow](./images/oac-save-data-flow.png)

1. Click the **Run** icon on the top bar of the page to run the data flow. Wait for the data flow to complete. This may take 1-2 minutes.

    ![Run the data flow](./images/oac-run-data-flow.png)


## **Task 5:** Create an OAC workbook to view processed images
Create an OAC workbook to view the objects detected in the space images.

1. Click the **Go back** icon in the upper left corner of the page.

    ![Go back](./images/oac-go-back.png)

1. In the *Datasets* list, click **Galaxy Object Detection Results** to open it in a new workbook.

    ![Click results dataset](./images/oac-results-dataset.png)

1. You now see a new workbook with the dataset contents listed on the left and an empty visualization palette on the right.

    ![View new workbook](./images/oac-new-workbook.png)

1. In the data listing on the left, click and drag **Image File from Bucket** onto the visualization palette on the right. This adds a table visualization. These are the images processed by the data flow.

    ![Add table of image files](./images/oac-workbook-table.png)

1. Switch to the visualizations list by clicking the **Visualizations** icon.

    ![Switch to visualizations](./images/oac-workbook-viz-icon.png)

1. Scroll down to the bottom of the list and drag **Vision Plugin** to the canvas to the right of the table.

    ![Add vision plugin](./images/oac-workbook-vision-plugin.png)

1. Switch back to the data list by clicking the **Data** icon.

    ![Switch to data](./images/oac-workbook-data-icon.png)

1. Drag **Image File from Bucket** to **Image Location** under *Vision Plugin*. 

    ![Add image file to Vision plugin](./images/oac-workbook-viz-image-location.png)

1. Drag **Vertex 1** and **Vertex 3** to **Vertices** under *Vision Plugin*.

    ![Add vertices to Vision plugin](./images/oac-workbook-viz-vertices.png)

1. Right click on any row of the table and, in the popup menu, click **Use as Filter**. Now, whichever row you select in the table will be displayed in the image viewer.

    ![Use as filter](./images/oac-workbook-table-use-as-filter.png)

1. Save your workbook by clicking the **Save** icon in the upper right corner of the page.

    ![Save workbook](./images/oac-workbook-save-icon.png)


1. In the *Save Workbook* dialog, provide a *Name* such as **My Galaxy Workbook** and click **Save**.

    ![Enter workbook name](./images/oac-save-workbook.png)

1. You can now cursor down through the table to view all of the images in the dataset and see what galaxies were detected. Not every image will contain a galaxy, but they are all beautiful and interesting to look at. 

    ![View images with object detection](./images/oac-workbook-final.png)

> **Note:** If you want to add the Vision Plugin to your own environment, you can download it from the Analytics visualization extensions page available here:
https://www.oracle.com/business-analytics/data-visualization/extensions/
>
>This video shows how to install the visualization (or any) plugin:
https://www.youtube.com/watch?v=JjuOWm8whgQ


**Congratulations, you have completed this lab and the workshop!**

## **Bonus Task:** Analyze images with your custom model

If you have time after completing the workshop, test your learning to see if you can complete the following task without being given all the steps in detail.

1. Go the custom-trained model you created in Lab 3 (galaxy-detection-model-1) and see if it is now active. If it is, use it to analyze one or more images in object storage. You can copy an image URL from the table visualization in your Galaxy Workbook in OAC. Then paste that URL into the Image URL box in Vision to analyze that image.

    Watch the video below for a quick walk-through to complete the bonus task.
    [Analyze images with your custom model](videohub:1_hnrkiv5f)

## Acknowledgements

- **Author** - Wes Prichard, Sr Principal Product Manager, Data Science & AI
- **Contributors** -  Mark Heffernan, Sr Principal Product Manager, Data Science & AI
- **Last Updated By/Date** - Name, Month Year
