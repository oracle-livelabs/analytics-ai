# Create a custom AI Vision model

## Introduction

In this Lab, you will use the labeled dataset you created in Lab 1 to custom-train an OCI AI Vision model, producing your own cell classifier. After the training process, you will be able to see the determined accuracy of your model. You will also be able to experiment with the model serving capability of your cell classifier on your own, using an included set of test images.

![Diagram illustrating that the research cycle can be accelerated with OCI AI Vision, enabling teams to accomplish more, faster, where time is critical, as with patient diagnosis.](./images/0-accelerate-research-cycle.png)

The Tasks in this Lab are summarized as follows:

* **Task 1**: *\[2m\]* Create a logical container for your Vision models, called a Project
* **Task 2**: *\[35m\]* Custom-train an OCI AI Vision model using the labeled records in your Data Labeling Dataset as training data
* **Task 3**: *\[3m\]* Upload test data via the OCI web console, and witness your model serve your input in real-time, demonstrating model accuracy
* **Task 4** (Optional): *\[5m\]* Deprovision the resources you provisioned during this Workshop

**Estimated Time**: *45 minutes*

[Lab 2](videohub:1_ldvz8ts0)

### Objectives

In this Workshop, you will:

* Learn how to navigate in the OCI web console and be able to demo key OCI AI Vision features
* Custom-train your own image classification model using your labeled dataset and OCI AI Vision

### Prerequisites

* An Oracle Free Tier, or Paid Cloud Account
* Lab 1 has been completed
* Your OCI user is a member of the group that was created in Lab 1
* Accessibility to your tenancy's [home region](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingregions.htm)
* Sufficient resource availability within your home region for: 1 Project for AI Vision models, 1 AI Vision model

## Task 1: Create a Project for AI Vision models

1. Create a Project, which is a logical container for AI Vision models. From the OCI services menu, click: **AI Services** > **Vision**

  ![Navigate to AI Vision.](./images/1-menu-analytics-and-ai-vision.png)

2. Click on *Projects* under *Custom Models*.

  ![Click Projects.](./images/2-vision-project.png)

3. Click **Create Project** and enter details for your Project:

    1. **Compartment**: Select your new compartment using the dropdown menu under **List Scope**.

    2. **Name**: Enter a name for your Project, e.g. *image-classification-project*

    3. **Description**: Optionally, provide a description for your Project, e.g. *Project for image classification OCW23 Workshop*

    4. Click **Create project**

      ![Enter details for creating a Project](./images/3-vision-create-project.png)

    5. Wait for the **Status** of your Project to update to *ACTIVE*. Then, click into your hyperlinked Project listing.

      ![Click into your Project.](./images/4-vision-click-project.png)

## Task 2: Custom-train your own AI Vision model

1. To custom-train your own AI Vision model, you will use the dataset that you labeled in the previous Lab:

    1. Click **Create Model** and enter details for your model:

    2. **Type**: *Image Classification*

    3. **Training data**: *Choose existing dataset*

    4. **Data source**: *Data labeling service*

    5. Choose the Data Labeling Dataset that you created in Lab 1.

    6. Click **Next**.

      ![Enter details for creating your AI Vision model.](./images/5-vision-create-model-page-1-select-data.png)

2. Enter training details for the model.

    1. **Model display name**: Enter a name for your Vision model, e.g. *image-classification-model*

    2. **Model description**: Enter a description for your Vision model, e.g. *Vision model for image classification OCW23 Workshop*

    3. **Training duration**: *Quick mode*

        > **Note**: Although the web console indicates 1 hour of training duration, *the work request will require about 30 minutes to complete*. This will include the process of back-end infrastructure deployment, model training, and model deployment to the endpoint that will be made accessible to your environment via the web console and APIs.

    4. Click **Next**.

      ![Enter details for creating your AI Vision model.](./images/6-vision-create-model-page-2-train-model.png)

3. Review that the model information is correct and click **Create and train**.

  ![Review the details, then create and start training your AI Vision model.](./images/7-vision-create-model-page-3-review.png)

  ![Your AI Vision model is creating and training.](./images/8-vision-model-creating.png)

4. After about *30 minutes*, the **State** of your model will update to *Active*, indicating that it is available for use. You can monitor the training progress by checking on the **% Complete** indicated on-screen. Once your model is *Active*, navigate to the model serving page by clicking **Analyze**, and move onto the next Task.

  ![Your AI Vision model is now available.](./images/9-vision-model-active.png)

## Task 3: Test the model on new images

1. Now that your model is available, observe the performance metrics on the Model Details page, as well as the training duration.

  The model performance metrics, defined below, indicate to end-users how apt your new model is at classifying cells (labeled *Cell*) from non-cells (labeled either *Debris* or *Stripe*), based on analysis of the visual properties of the coherent diffraction images.

    * **Precision**: Number of images that were classified correctly, divided by the number of images that should not have been classified with the label, but were.
    * **Recall**: Number of images that were classified correctly with a label, divided by the number of images that should have been classified with that label, but were not.
    * **F1 Score**: Harmonic mean of precision and recall values. This metric represents the overall accuracy of our model, as it factors in both *Precision* and *Recall*.

2. [Click to download](https://objectstorage.us-ashburn-1.oraclecloud.com/p/hah9GOfzzUI67R2a1X93shi9j1C7OFUFSqbfYtLDBe1waj5d6HL70RR26mkDCWWS/n/orasenatdpltintegration03/b/all-images-live-lab-ocw23/o/Biomedical_Image_Classification_Test_Data.zip) this 8 MB dataset to your local machine. This dataset contains a test set of coherent diffraction images of blood samples. As these images were not present in the training dataset, they were not used to train your Vision model, and will enable you to simulate the model serving process.

3. Upload one image from the test dataset on your local machine to test the newly created model.

    1. Select **Local file** under **Image source**.

    2. Click **select one...** in the **Upload image** section. Navigate to the folder containing the test images on your local machine and select an image to upload.

      ![Click select one... to select an image for model serving.](./images/11-vision-model-select-image.png)

      ![Select an image from the Cell folder, for example, to upload for model serving.](./images/12-vision-model-upload-cell-image.png)
    
    3. Examine confidence measurements under the **Results** pane. These scores reveal how confident your model is that the test image belongs to a given class.

      ![Analyzing the confidence measures in the results pane](./images/13-vision-model-analyze-cell-image-confidence-scores.png)

    4. Click on **Request** to see a preview of how the JSON-formatted API request for analyzing your image may appear. As you have conducted model serving via the web console, you have invoked a synchronous API request. Furthermore, as you have uploaded the image as a local file, the API request has sourced your image as inline data, as opposed to sourcing the image from an Object Storage Bucket.

        > **Note**: Synchronous and asynchronous (batch) model serving for image analysis are supported via OCI-CLI, REST API, and SDK.

      ![Analyzing the JSON request in the results pane](./images/14-1-vision-model-analyze-cell-image-json-request.png)

    5. Click on **Response** to see how the JSON-formatted analysis appears. The industry-standard JSON format makes downstream processing easy.

      ![Analyzing the JSON response in the results pane](./images/14-2-vision-model-analyze-cell-image-json-response.png)

    6. Try analyzing other images in the test dataset by repeating steps **3.2.** through **3.5.**

      ![Analyze an image from the Debris folder.](./images/15-vision-model-analyze-image-debris-example.png)

      ![Analyze an image from the Stripe folder.](./images/16-vision-model-analyze-image-stripe-example.png)

## Task 4 (Optional): Cleanup

1. Delete your Object Storage Bucket:

    1. From the OCI services menu, click: **Storage** > **Buckets**

    2. Click on the 3 dots to the right of the listing corresponding to your Bucket > Click **Delete** > Enter the name of your Bucket > **Delete**

      ![Navigate to Buckets.](../dls-bulk-label/images/14-menu-storage.png)

2. Delete your Data Labeling Dataset:

    1. From the OCI services menu, click: **Analytics & AI** > **Data Labeling**

    2. Click on the 3 dots to the right of the listing corresponding to your Dataset > Click **Delete** > Enter the name of your Dataset > **Delete**

      ![Navigate to Data Labeling.](../dls-bulk-label/images/22-menu-analytics-and-data-labeling.png)

3. Delete your AI Vision model and Project:

    1. From the OCI services menu, click: **Analytics & AI** > **Vision**

    2. Click into your hyperlinked Project > Click into your hyperlinked model

    3. Delete your AI Vision model: Click on the 3 dots to the right of the listing corresponding to your AI Vision model > **Delete** > Type *DELETE* > **Delete**

    4. Delete your Project for AI Vision models: Wait for your AI Vision model to finish terminating. Then, click **Delete** > Type *DELETE* > **Delete**

      ![Navigate to AI Vision.](./images/1-menu-analytics-and-ai-vision.png)

4. Delete your Policy:

    1. From the OCI services menu, click: **Identity & Security** > **Policies**

    2. Select the root-level compartment from the dropdown menu on the left-hand side of the screen.

    3. Click on the 3 dots to the right of the listing corresponding to your Policy > **Delete** > **Delete**

      ![Navigate to Policies.](../dls-bulk-label/images/12-2-menu-identity-and-security-policies.png)

5. Delete your Dynamic Group and Group:

    1. From the OCI Services menu, click: **Identity & Security** > **Domains**

    2. Select the root compartment from the dropdown menu on the left-hand side of the screen, and select the **Default** domain.

    3. Click **Dynamic groups** on the left-hand side of the page.

    4. Click on the 3 dots to the right of the listing corresponding to your Dynamic Group > **Delete** > **Delete dynamic group**

    5. Click **Groups** on the left-hand side of the page.

    6. Click on the 3 dots to the right of the listing corresponding to your Group > **Delete** > **Delete group**

      ![Navigate to Domains.](../dls-bulk-label/images/4-menu-identity-and-security-domains.png)

6. Delete your Compartment:

    1. Ensure that all resources within the compartment have finished terminating.

    2. From the OCI services menu, click: **Identity & Security** > **Compartments**

    3. Click on the 3 dots to the right of the listing corresponding to your Compartment > **Delete** > **Delete**

      ![Navigate to Compartments.](../dls-bulk-label/images/1-1-menu-identity-and-security-compartments.png)

[Proceed to the next section](#next).

## Conclusions

**Congratulations on completing Lab 2, as well as this Workshop!**

In this Lab, you have:

* Custom-trained an OCI AI Vision model
* Witnessed your model serve your input in real-time, demonstrating model accuracy

In this Workshop, you have successfully implemented a highly transferrable OCI solution pattern à la Professor Hu, and simulated the experience of automating, accelerating, and enhancing a biomedical research process by producing your own cell classifier.

The next step in this solution pattern would be to process the JSON representation of the model analysis for end-user consumption.

In addition to image classification, OCI supports AI-driven automation of a variety of tasks, including:

* **Object Detection**: Identify pre-defined or custom-defined objects within images

* **Optical Character Recognition**: Recognize characters in documents and images

* **Document Understanding**: Extract units of information from documents such as text, tables, key-value pairs, pages, custom-defined or pre-defined document type

* **Speech Transcription**: Transcribe spoken language from audio files to transcripts

* **Sentiment Analysis**: Automatically decipher sentiment of a volume of text or sentences within it

* **Named-Entity Recognition**: Extraction of people, places, and things that are publicly recognized

* **Key-phrase extraction**: Extract key-phrases that can be considered as tags related to a volume of text

* **Translation**: Translate between any of 21 languages

Learn more about [AI Vision](https://www.oracle.com/artificial-intelligence/vision/) and [additional AI Services](https://www.oracle.com/artificial-intelligence/ai-services/) that support these tasks and learn about how the tools that are available today can enable you to streamline and optimize the processes that are required for your business.

Apply your new knowledge to [your own industry](../workshops/freetier/index.html?lab=intro), and we hope to see you in future Workshops!

Don't forget to visit **Task 4** to deprovision the resources you provisioned during this Workshop.

[Proceed to the next section](#next).

## Acknowledgements

* **Authors**
    * Samuel Cacela - Senior Cloud Engineer
    * Gabrielle Prichard - Product Manager, Analytics Platform
    * David Chen - Master Principal Cloud Architect
    * Dr. Xin-hua Hu - Professor, Dept. of Physics at East Carolina University

* **Last Updated By/Date**
    * Samuel Cacela - Senior Cloud Engineer, August 2023
