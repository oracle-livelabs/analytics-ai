# Introduction

## About This Workshop

In this Workshop, you will train your own image classification model on Oracle Cloud Infrastructure (OCI) using OCI AI Vision. You will experience the themes of automating, accelerating, and enhancing a biomedical research process where time is critical. You will learn how to implement a highly transferrable, multi-industry OCI solution pattern. The Workshop is divided into two Labs: loading and labeling a provided dataset, followed by model training and serving.

An image classification model will be able to tell you what your image represents, based on all of the shapes and colors present in the image. This experiment will require our image classifier to serve as a cell classifier. As a cell classifier, your machine learning model will be able to discern images of cells from non-cells in the provided dataset, where the images were captured using a technique called coherent diffraction imaging.

The concept of the cell classification story and the dataset used in this Workshop has been provided by Dr. Xin-hua Hu, from his machine learning experiment in the Physics department at East Carolina University. The cell classifier is a practical option for medical professionals during their research process, who would traditionally distinguish images of cells from non-cells by their own visual observation, and record their findings manually.

With large datasets, this process can be incredibly time-consuming and impractical. However, by offloading this important busywork to the cell classifier, and focus on tasks where their broad and deep range of knowledge and skills can be much more economically applied - and derive their analyses much faster where time is of the essence.

This solution pattern will be especially interesting if you can identify processes in your industry where automated and accurate visual analysis will render valuable time and cost savings.

To render your own cell classifier in the style of Dr. Xin-hua Hu's research, you will elevate the scalabiltiy of your data platform on OCI using the following services, in the order in which you will encounter them:

1. [OCI Object Storage](https://www.oracle.com/cloud/storage/object-storage/): A highly scalable and secure storage option for data in its native format
2. [OCI Data Labeling](https://www.oracle.com/artificial-intelligence/data-labeling/): Enables standardized and automated labeling of training data, OCI Vision
3. [OCI AI Vision](https://www.oracle.com/artificial-intelligence/vision/): Includes image classification as a supported computer vision task

This diagram illustrates the flow of the Workshop:

![Diagram illustrating Workshop flow](./images/1-workshop-flow.png)

**Lab 1** *\[35m\]*

In this Lab, you will be provided a dataset consisting of *1710* images. The images have been pre-sorted by medical professionals into folders named *Cell*, *Debris*, and *Stripe*. While images in the *Cell* folder depict intact and viable cellular structures, the *Debris* and *Stripe* folders contain images of two types of non-cell structures. The folders contain the same number of images.

You will load this dataset into Object Storage, and prepare the data for model training by labeling each image. But don't worry - you won't have to label each image individually! This Lab provides a helper script as a short cut to help you efficiently label every image based on the way the images are pre-sorted.

After your data has been labeled, you will be able to move on with training your custom AI Vision model in style.

The Tasks in Lab 1 are summarized as follows:

* **Task 1**: *\[10m\]* Create Identity and Access Management (IAM) Compartment, Group, Dynamic Group, and Policy to enable necessary permissions for this Workshop
* **Task 2**: *\[2m\]* Create an Object Storage Bucket for training data
* **Task 3**: *\[5m\]* Download the training data using Cloud Shell, and bulk-upload the biomedical training data to your Object Storage Bucket
* **Task 4**: *\[3m\]* Create a Dataset in OCI Data Labeling, which imports the image data from your Object Storage Bucket as records
* **Task 5**: *\[15m\]* Leverage a helper script to bulk-label the records in your OCI Data Labeling Dataset

**Lab 2** *\[45m\]*

In this Lab, you will use the labeled dataset you created in Lab 1 to custom-train an OCI AI Vision model, producing your own cell classifier. After the training process, you will be able to see the determined accuracy of your model. You will also be able to experiment with the model serving capability of your cell classifier on your own, using an included set of test images.

The Tasks in Lab 2 are summarized as follows:

* **Task 1**: *\[2m\]* Create a logical container for your Vision models, called a Project
* **Task 2**: *\[35m\]* Custom-train an OCI AI Vision model using the labeled records in your Data Labeling Dataset as training data
* **Task 3**: *\[3m\]* Upload test data via the OCI web console, and witness your model serve your input in real-time, demonstrating model accuracy
* **Task 4** (Optional): *\[5m\]* Deprovision the resources you provisioned during this Workshop

### How can visual AI be used in your business?

Using a custom-trained OCI Vision model can bring significant time and cost savings in various industries by automating and optimizing tasks that would otherwise require manual effort. These are some critical use cases across different industries where a custom-trained OCI Vision model can be highly beneficial:

1. **Retail and E-Commerce**
    * *Automated Product Categorization*: Automatically classify products into categories based on images, streamlining inventory management and online cataloging.
    * *Shelf and Store Monitoring*: Monitor shelves and store layouts to detect stockouts, misplaced items, and optimize shelf space utilization.
    * *Fraud Detection*: Identify fraudulent product returns or label swapping by analyzing product images.
2. **Manufacturing and Quality Control**
    * *Defect Detection*: Inspect products for defects, such as cracks, scratches, or abnormalities, ensuring high-quality standards without manual inspection.
    * *Parts and Component Recognition*: Identify and sort components on assembly lines, reducing errors and speeding up production.
    * *Anomaly Detection*: Spot anomalies in manufacturing processes or assembly lines to prevent costly production errors.
3. **Healthcare and Life Sciences**
    * *Medical Image Analysis*: Automate the analysis of medical images, such as X-rays or MRIs, or coherent diffraction images (as in this Workshop), to assist in diagnosis and treatment planning.
    * *Pathology Slide Analysis*: Analyze pathology slides for cancer detection and disease diagnosis, improving efficiency for pathologists.
    * *Drug Discovery*: Speed up drug discovery processes by identifying potential drug compounds or interactions from molecular images.
4. **Agriculture**
    * *Crop Monitoring*: Monitor crop health, growth, and disease detection through aerial or ground-based imagery, optimizing agricultural practices.
    * *Pest and Disease Detection*: Detect pests or diseases in crops early to enable targeted interventions and minimize crop damage.
    * *Yield Estimation*: Estimate crop yield and optimize resource allocation based on field images, leading to better harvest planning.
5. **Logistics and Transportation**
    * *Object Recognition in Logistics*: Identify and sort packages or items for efficient logistics and warehouse management.
    * *License Plate Recognition*: Automate toll collection, parking management, and security access control by recognizing license plates.
    * *Real-time Traffic Analysis*: Monitor traffic flow and congestion to optimize transportation routes and reduce delivery times.
6. **Financial Services**
    * *Document Processing*: Automate the extraction of information from invoices, receipts, or forms, reducing manual data entry efforts.
    * *Fraud Detection*: Identify fraudulent activities, such as check fraud or credit card misuse, through image analysis.
    * *Authentication*: Use facial recognition for secure and convenient customer authentication in mobile banking or e-commerce applications.
7. **Real Estate and Construction**
    * *Property Inspection*: Automate property inspection by analyzing images to assess property condition and identify maintenance needs.
    * *Construction Progress Monitoring*: Track construction progress by analyzing images to ensure project timelines and quality standards.

**Estimated Workshop Time**: *80 minutes*

### Objectives

In this Workshop, you will:

* Learn how to navigate in the OCI web console and be able to demo key OCI AI Vision and Data Labeling features
* Learn how to leverage a helper script to bulk-label a dataset of biomedical images, i.e. efficiently label a large volume of images
* Custom-train your own image classification model using your labeled dataset and OCI AI Vision

### Prerequisites

* An Oracle Free Tier, or Paid Cloud Account
* One of the following:
    * You are a tenancy administrator
    * Your tenancy administrator will set up Identity and Access Management (IAM) configuration as described in *Lab 1, Task 1*. Then, you may proceed beginning with *Lab 1, Task 2*.
* Accessibility to your tenancy's [home region](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingregions.htm)
* Sufficient resource availability within your home region for: 1 Compartment, 1 Group, 1 Dynamic Group, 1 Policy, 1 Object Storage Bucket, 1 Data Labeling Dataset, 1710 Data Labeling Dataset records, 1 Project for AI Vision models, 1 AI Vision model
* *Not required, though beneficial*: Familiarity with a command-line interface (CLI) text editor (e.g. vi, nano, emacs)
* *Not required, though beneficial*: Familiarity with [OCI-CLI](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cliconcepts.htm)
* *Not required, though beneficial*: Familiarity with Python

[Proceed to the next section](#next).

## Acknowledgements

* **Authors**
    * Samuel Cacela - Senior Cloud Engineer
    * Gabrielle Prichard - Product Manager, Analytics Platform
    * David Chen - Master Principal Cloud Architect
    * Dr. Xin-hua Hu - Professor, Dept. of Physics at East Carolina University

* **Last Updated By/Date**
    * Samuel Cacela - Senior Cloud Engineer, August 2023
