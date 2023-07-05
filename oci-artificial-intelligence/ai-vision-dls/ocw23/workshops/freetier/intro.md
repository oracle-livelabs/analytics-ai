# Use the OCI Vision and Data Labeling Service

## Introduction

In this Live Lab, you will create a machine learning model that automatically identifies cells from blood samples from Professor Xin-hua Hu's experiment in the Physics department at East Carolina University. The application of such a model in the medical field can expedite the research cycle by offloading processes that may demand hours of repetitive and tedious work to a machine. In this lab, you will quick-train a computer vision model on a volume of provided images (the model will train using 90% of the 570 images in each of 3 categories) to achieve high accuracy (after 8 minutes of training, will achieve ~92% accuracy when inferring the labels of the remaining 10% of the 570 images in each category), and infer whether an image represents a cell or non-cell depending on the characteristics of the image.

The machine learning engine used in this lab is OCI Vision. Vision is a serverless, multi-tenant service, accessible using the Console, REST APIs, SDK, or CLI. It is used for performing deep-learning–based image analysis at scale. With prebuilt models available out of the box, developers can easily build image recognition and text recognition into their applications without machine learning (ML) expertise. For industry-specific use cases, developers can automatically train custom vision models with their own data. These models can be used to detect visual anomalies in manufacturing, organize digital media assets, and tag items in images to count products or shipments.

You can upload images to detect and classify objects in them. If you have lots of images, you can process them in batch using asynchronous API endpoints. Vision's features are thematically split between Document AI for document-centric images, and Image Analysis for object and scene-based images. Pretrained models and custom models are supported.

Zooming out from our biomedical use case, AI Vision can automate time-consuming, attention-demanding tasks across many industries, such as:

- Scene monitoring
- Visual anomaly or fraud detection
- Quality inspection, scene monitoring
- Categorize a document as a predefined type such as resume, invoice, receipt, or tax form
- Information extraction
- Digital asset management, media indexing, inventory analytics
- Understanding handwritten, tilted, shaded, rotated text

The engine you will use to label your data is OCI Data Labeling, which is a service for building labeled datasets to more accurately train AI and machine learning models. With OCI Data Labeling, developers and data scientists assemble data, create and browse datasets, and apply labels to data records through user interfaces and public APIs. The labeled datasets can be exported for model development across Oracle’s AI and data science services for a seamless model-building experience.

### Live Lab Steps Overview

**Total Estimated Workshop Time**: *67-88 minutes*

## Lab 1
*\[45-60 minutes\]*

* Create Identity and Access Management (IAM) Compartment, Policy, Group, and Dynamic Group to enable necessary permissions for this LiveLab.
* Create an Object Storage Bucket.
* Downloaded biomedical training data using Cloud Shell, and bulk-upload the biomedical training data to the Object Storage bucket.
* Create a Data Labeling dataset, which imports the training images from Object Storage as records.
* Bulk-label the images that were loaded into Object Storage using a provided script that takes a labeling scheme as input. In this lab, the labeling scheme will be based on the names of the folders containing the training images (e.g. images in the *Cell* folder will be labeled with *Cell*, and so on)

## Lab 2
*\[22-28 minutes\]*

* Create a Vision Project, which is a logical container for your Vision models.
* Custom-train a Vision model using the labeled records in the Data Labeling dataset.
* Upload test data via the web console and see the model inference in action.

### About the data

The image data used in this lab consists of coherent diffraction images of blood samples. The model will learn to distinguish between images that show viable and intact cells, and images that show noise. You will author a set of labels that your model will use to train and infer the classification of an image. In this lab, the model will distinguish between each cell and non-cell image using one of the following 3 labels:

- **Cell**: This label will be used to indicate an image if it appears to shows an intact and viable cell
- **Debris**: This label will be applied to an image if it appears to show cell debris and small particles, collectively. This label is used to classify non-cell, i.e. noisy, images.
- **Stripe**: The model will use this label to classify an image that shows ghost cell body and aggregated spherical particles. Like Debris, this label is used to classify non-cell images. This second label for non-cell images is used in addition to Debris to achieve optimal classification accuracy for your cell classifier.

In this lab, you will upload data from a provided .zip file that are separated into 3 subfolders, each of which corresponds to a label (i.e. a *Cell* folder, a *Debris* folder, and a *Stripe* folder), and contains images that have already been associated with their corresponding label by medical professional personnel.

### Primary Objectives

In this workshop, you will:

* Get familiar with the OCI Console and be able to demo key OCI Vision AI and Data Labeling features
* Learn how to leverage the Data Labeling service and custom code to bulk-label a dataset of biomedical images
* Custom-train an image classification model using the labeled dataset and the Vision AI service

### Prerequisites

* An Oracle Free Tier, or Paid Cloud Account
* User is either a tenancy administrator, or has access to a tenancy administrator for the *Policy Setup* step.
    Note: If you are not a tenancy administrator, begin with **Task 1** after the tenancy administrator has assigned permissions in **Policy Setup**, for each Lab
* Lab steps assume usage of home region.
* Familiarity with a command-line interface (CLI) text editor is recommended, e.g. vi, nano, emacs
* Some familiarity with OCI-CLI is desirable, but not required
* Some familiarity with Python is desirable, but not required

[Proceed to the next section](#next).

## Acknowledgements

* **Authors**
    * Samuel Cacela - Senior Cloud Engineer
    * Gabrielle Prichard - Product Manager, Analytics Platform
    * Xin-hua Hu - Professor, Dept. of Physics at East Carolina University
    * David Chen - Master Principal Cloud Architect

* **Last Updated By/Date**
    * Samuel Cacela - Senior Cloud Engineer, June 2023
