# Use the OCI Vision and Data Labeling Service

## Introduction

Vision is a serverless, multi-tenant service, accessible using the Console, REST APIs, SDK, or CLI.

You can upload images to detect and classify objects in them. If you have lots of images, you can process them in batch using asynchronous API endpoints. Vision's features are thematically split between Document AI for document-centric images, and Image Analysis for object and scene-based images. Pretrained models and custom models are supported.

Oracle Cloud Infrastructure (OCI) Data Labeling is a service for building labeled datasets to more accurately train AI and machine learning models. With OCI Data Labeling, developers and data scientists assemble data, create and browse datasets, and apply labels to data records through user interfaces and public APIs. The labeled datasets can be exported for model development across Oracle’s AI and data science services for a seamless model-building experience.


*Estimated Workshop Time*: 90 minutes

### About the data:

We obtained coherent diffraction images generated from cancerous blood samples from East Carolina University. Each of these JPG images is labeled with one of three classifications based on the features present in the image. The three classifications are: cell, debris, and stripe.

### Objectives

In this workshop, you will:

* Get familiar with the OCI Console and be able to demo key OCI Vision AI and Data Labeling features with it
* Learn how to leverage the Data Labeling Service and custom code to bulk label a dataset of biomedical images
* Train a custom image classification model using the labeled dataset and the Vision AI Service

### Prerequisites
* An Oracle Free Tier, or Paid Cloud Account
* Assumes that the end-user has full administrative privileges in the tenancy
* Some familiarity with OCI CLI is desirable, but not required
* Some familiarity with Python is desirable, but not required

[Proceed to the next section](#next).

## Acknowledgements
* **Authors**
    * Samuel Cacela - Staff Cloud Engineer
    * Gabrielle Prichard - Cloud Solution Engineer

* **Last Updated By/Date**
    * Gabrielle Prichard - Cloud Solution Engineer, March 2022
