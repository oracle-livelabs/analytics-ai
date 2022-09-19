# Use OCI Data Labeling to label images

## Introduction
Training a custom OCI Vision model requires a set of images that have been labeled for the type of model that is to be created. For example, if you want to train a model to detect sharks, you need pictures of sharks and then the shark(s) in each image must be identified with a bounding box and the box is labeled with the name "shark". If you want to train a model to classify an image according to the contents of the scene, you will need to assign labels to each image in the training dataset.

In this lab, you will get some experience with labeling images. You will label some of the space telescope images to identify the galaxies that appear in the images.

*Estimated Time*: 15 minutes

### Objectives
- Create an OCI Data Labeling dataset containing images to be labeled
- Label the images in the dataset

### Prerequisites
- Access to a LiveLabs sandbox environment


## **Task 1:** Create a Data Labeling Dataset
The images to be labeled have already been staged in an object storage bucket in the LiveLabs sandbox environment. You'll create a dataset from those images.

1. From the OCI services menu, select *Analytics & AI*, then under *Machine Learning* click **Data Labeling**.
![OCI services menu](./images/dls.png)

1. On the *Data Labeling* page, click **Datasets**.
![Clicking on datasets from Data Labeling Service](./images/datasets.png)

1. On the *Dataset list* page, set your Compartment to **vision_galaxy_ws**.

    ![Selecting the compartment](./images/compartment-dls.png)

1. Begin creating your dataset by clicking the **Create dataset** button.

1. In the *Create Dataset* dialog, set the following values:

    ![Create dataset window - add dataset details](./images/create-dataset-p1.png)

    a. Enter a **Name** for your dataset, e.g. *dl-lab-dataset*

    b. Set *Dataset format* to **Images**

    c. Set *Annotation class* to **Object Detection**

1. Click **Next**
  
1. In the next page of the *Create dataset* dialog, set the following values:

     ![](./images/create-dataset-p2.png)
 
    a. Retrieve files from Object Storage by choosing **Select from Object Storage**.
 
    b. Choose compartment **vision_galaxy_ws_read_only**, if not already selected.
    
    c. Choose Bucket **labeling-read-only**

    d. Add Labels: type the word ***spiral galaxy*** in the box, then click the **galaxy (New)** in the drop-down list

    ![Adding labels](./images/dataset-labels.png) TODO update

1. Click 'Next'
  
    ![Clicking next](./images/dataset-next.png)

1. In the next page of the *Create dataset* dialog, review the information and click **Create**.
  ![Create dataset window - review information](./images/click-create-dataset.png)

1. You will return to the *Dataset list* page. Wait until your new dataset's status is **Active**. This will take about 4-5 minutes.

    ![](./images/dataset-active.png) TODO update?


## **Task 2:** Label the images in your dataset
Now that you have a dataset created for the data labeleing services, you'll proceed with labeling those images.

1. On the page showing your active dataset, the data record view is listed by default. This is a list of all the image files in the dataset. (Note - there is also a *Gallery view* that displays the files as images.) **Click the top file name** to open it.

    ![](./images/start-labeling.png)

1. The *Add labels* page is displayed for the selected image.
    
    ![](./images/add-labels1.png)

1. Add a bounding box tightly around each distinguishable galaxy. If you make a mistake, use *Remove box* (under Tools). Don't put a box around bright spots that have no shape. **Label at least 10** of the larger galaxies with different shapes and orientations that don't overlap other objects. When done, click **Save & next**.

    ![](./images/label-galaxies1.png) TODO update?

1. Add bounding boxes to galaxies in the remaining images in the dataset. There are galaxies of different sizes in the other images. For larger galaxies with a faint halo, put the box around the inner structure. Positioning the box is a judgement call but it can affect how the model detects galaxies in new images.

    ![](./images/label-galaxies2.png) TODO update?

    ![](./images/label-galaxies3.png) 

    ![](./images/label-galaxies4.png)

    ![](./images/label-galaxies5.png)

1. After the last image is labeled, the data set page is displayed, but this time, the image status for each is listed as *Labeled*.

    ![](./images/dataset-labeled.png)

Congratulations, you have completed labeling a set of images for object detection.

## Please proceed to the next lab.

***
### Acknowledgements
* **Author** - <Wes Prichard, Sr Principal Product Manager, Data Science & AI>
* **Contributors** -  <Mark Heffernan, Sr Principal Product Manager, Data Science & AI>
* **Last Updated By/Date** - <Name, Month Year>
