# Create a custom AI Vision Model
**Estimated Time**: *39 minutes*

## Introduction

In this Lab, you will use labeled dataset you created in Lab 1 to custom-train an OCI AI Vision model, producing your own cell classifier! After the training process, you will be able to see the determined accuracy of your model, reported as the F1 score. You will also be able to experience the model serving capability of your cell classifier on your own with an included set of test images!

The Tasks in this Lab are organized as follows:

* **Task 1**: Create an AI Vision Project, which is a logical container for your Vision models.
* **Task 2**: Custom-train an AI Vision model using the labeled records in your Data Labeling Dataset.
* **Task 3**: Upload test data via the OCI web console, and witness your model serve your input in real-time.

## Primary Objectives

In this LiveLab, you will:

* Learn how to navigate in the OCI web console and be able to demo key OCI AI Vision features
* Custom-train your own image classification model using your labeled dataset and OCI AI Vision

## Prerequisites

* An Oracle Free Tier, or Paid Cloud Account
* Your OCI user is a member of the group that was created in Lab 1
* Accessibility to your tenancy's [home region](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingregions.htm)
* Sufficient resource availability within your home region for Vision

## **Task 1:** Create an AI Vision Project
*\[2 minutes\]*

1. Create a Project, which is a logical container for AI Vision models. From the OCI services menu, click *Vision* under *AI Services*.

![OCI Services Menu](../images/1-menu-analytics-and-ai-vision.png)

2. Click on *Projects* under *Custom Models*.

![Vision Project](./images/2-vision-project.png)

3. Click **Create Project** and enter details for your Project:

  a. **Compartment**: Select your new compartment using the dropdown menu under **List Scope**.

  b. **Name**: Enter a name for your Project, e.g. *image-classification-project*

  c. **Name**: Enter a name for your Project, e.g. *image-classification-project*

  d. **Description**: Optionally, provide a description for your Project, e.g. *Project for image classification OCW23 LiveLab*

  d. Click **Create project**

  ![Create project](./images/3-vision-create-project.png)

  ![Click project](./images/4-vision-click-project.png)

## **Task 2:** Custom-Train your own AI Vision Model
*\[35 minutes\]*

1. To custom-train your own AI Vision model, you will use the dataset that you labeled in the previous Lab:

  a. Click **Create Model** and enter details for your model:

  b. **Type**: *Image Classification*

  c. **Training data**: Choose existing dataset

  d. **Data source**: *Data Labeling Services*

  e. Choose the dataset that you created in Lab 1: *image-classification-dataset*

  f. Click **Next**.

  ![Create and train model window: select data](./images/5-vision-create-model-page-1-select-data.png)

2. Enter training details for the model.

  a. **Model display name**: Enter a name for your Vision model, e.g. *image-classification-model*

  b. **Training duration**: *Quick mode*

  **Note**: Despite the web console indicating 1 hour of training duration, the work request will require about *30 minutes to complete*. This will include the process of back-end infrastructure deployment, model training, and model deployment to the endpoint that will be made accessible to your environment via the web console and APIs.

  c. Click **Next**.

  ![Create and train model window: train model](./images/6-create-vision-model-page-2-train-model.png)

3. Review that the model information is correct and click **Create and train**.

![Create and train model window: review](./images/7-vision-create-model-page-3-review.png)

![Vision model Creating](./images/8-vision-model-creating.png)

4. After about 30 minutes, your model will be in the **Active** state, indicating that it is available for use. When your model has reached this state, navigate to the model serving page by clicking **Analyze**.

![Model is available](./images/9-vision-model-active)

![Vision Model Active](./10-vision-model-active.png)

## **Task 3:** Test the Model On New Images
*\[2 minutes\]*

1. Now that your model is available, observe the performance metrics on the Model Details page, as well as the training duration.

  The model performance metrics, defined below, indicate to end-users how apt your new model is at classifying cells (labeled *Cell*) from non-cells (labeled either *Debris* or *Stripe*), based on analysis of the visual properties of the coherent diffraction images.

    * **Precision**: Fraction of images that were classified correctly / images that should not have been classified with the label, but were.
    * **Recall**: Fraction of images that were classified correctly with a label / images that should have been classified with that label, but were not.
    * **F1 Score**: Harmonic mean of precision and recall values. This metric represents the overall accuracy of our model, as it factors in both *Precision* and *Recall*.

2. [Click to download](https://objectstorage.us-ashburn-1.oraclecloud.com/p/hah9GOfzzUI67R2a1X93shi9j1C7OFUFSqbfYtLDBe1waj5d6HL70RR26mkDCWWS/n/orasenatdpltintegration03/b/all-images-live-lab-ocw23/o/Biomedical_Image_Classification_Test_Data.zip) this 8 MB dataset to your local machine. This dataset contains a test set of coherent diffraction images of blood samples. As these images were not present in the training dataset, they were not used to train your Vision model, and will enable you to simulate the model serving process.

3. Upload one image from the test dataset on your local machine to test the newly created model.

  a. Select **Local file** under **Image source**.

  b. Click **select one...** in the **Upload image** section. Navigate to the folder containing the test images on your local machine and select an image to upload.

  ![Select image](./images/11-vision-model-select-image.png)

  ![Upload image](./images/12-vision-model-upload-cell-image.png)
  
  c. Examine confidence measurements under the **Results** pane.

  ![Analyzing the confidence measures in the results pane](./images/13-vision-model-analyze-cell-image-confidence-scores.png)

  ![Analyzing the JSON response in the results pane](./images/14-vision-model-analyze-cell-image-json.png)

  Click on **Response**, to see how the analysis appears when represented as JSON, which makes downstream processing easy as JSON is an industry-standard data format.

  *Note*: Batch processing of interence data is supported via OCI-CLI, REST API, and SDK.

  d. Try analyzing other images in the test dataset by repeating steps **b.** and **c.**

  ![Analyze Debris image](./images/15-vision-model-analyze-image-debris-example.png)

  ![Analyze Debris image](./images/16-vision-model-analyze-image-stripe-example.png)

**Congratulations on completing Lab 2 as well as the LiveLab!** Now that you understand the process of producing a serving AI Vision model for cell classification, you are ready to consider the ways in which you can process the model analysis for end-user consumption. You can also apply the principals you discovered in this lab to use cases where similar pattern of labeling data and training models on OCI would yield significant time and cost savings returns.

In addition to image classification, OCI supports AI automation of tasks such as:

- **Object Detection**: Identify pre-defined or custom-defined objects within images
- **Optical Character Recognition**: Recognize characters in documents or images
- **Document Understanding**: extract units of information from documents such as text, tables, key-value pairs, pages, custom-defined or pre-defined document type
- **Speech Transcription**: Transcribe spoken language from audio files to transcripts
- **Sentiment Analysis**: Automatically decipher sentiment of a volume of text or sentences within it
- **Named-Entity Recognition**: Extraction of people, places, and things that are publicly recognized
- **Key-phrase extraction**: Extract key-phrases that can be considered as tags related to a volume of text
- **Translation**: Translate between any of 21 languages

**Learn more** about [AI Vision](https://www.oracle.com/artificial-intelligence/vision/) and [additional AI Services](https://www.oracle.com/artificial-intelligence/ai-services/) that support these tasks and learn about how the tools available today can enable you to streamline and optimize the processes that are required for your use case.

[Proceed to the next section](#next).

## Acknowledgements

* **Authors**
    * Samuel Cacela - Senior Cloud Engineer
    * Gabrielle Prichard - Product Manager, Analytics Platform
    * Xin-hua Hu - Professor, Dept. of Physics at East Carolina University
    * David Chen - Master Principal Cloud Architect

* **Last Updated By/Date**
    * Samuel Cacela - Senior Cloud Engineer, June 2023
