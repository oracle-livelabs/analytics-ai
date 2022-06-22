# OCI Vision

## Introduction

Vision is a serverless, multi-tenant service, accessible using the Console, or over REST APIs. It enables you to upload images to detect and classify objects in them. If you have lots of images, you can process them in batch via asynchronous API endpoints.

Vision service features are thematically split between Document AI for document-centric images and Image Analysis
for object and scene-based images.

*Estimated Workshop Time*: 100 minutes

### Objectives

In this workshop, you will:

* Get familiar with the OCI console and be able to demo key vision features with it
* Learn how to train an image classification or object detection model through the OCI console
* Learn how to use REST API to communicate with our vision service endpoints.

### 1. Image Analysis

* Object Detection is a fundamental image analysis feature. You can detect and locate the objects in an image. For example, the image is of a living room, Vision locates the objects therein, such as a chair, a sofa, and a TV. It then draws bounding boxes around the objects and identifies them. You can also use it for visual anomaly detection.
* Image Classification is a fundamental image analysis feature. Upload an image to Object Storage and you can put it in pre-determined classes, based on the objects within it.

### 2. Document AI

* Text Recognition (also known as Optical Character Recognition) means Vision can detect and recognize text in a document. Vision draws bounding boxes around the printed or hand-written text it locates in an image, and digitizes the text.
* Document classification: OCI Vision can classify a document, for example, whether the document is a tax form, an invoice, or a receipt.
* Language classification: OCI Vision detects the language of document based on visual features.
* Table extraction: OCI Vision extracts content in tabular format, maintaining row/column relationships of cells.

Document AI is a key building block for scenarios like business process automation (also called RPA for Robotic Process Automation), automated receipt processing, semantic search, and the automatic extraction of information from unstructured content like scanned documents.

Custom model training lets you tailor base models (through transfer learning approaches) to make deep learning models tuned to your data. Model selection, resource planning, and deployment are all managed by Vision.

In order to view in the console and complete the following labs, you can check the Get Started section [here](https://preview.content.oci.oracleiaas.com/en-us/iaas/vision/vision/using/home.htm?bundle=8941).

### Prerequisites
* An Oracle Free Tier, or Paid Cloud Account
* Additional prerequisites (cloud services) are mentioned per lab
* Familiar with OCI Policy.
* Familiar with Python programming for SDK usage is recommended.
* Request access to OCI Vision + review policy requirements


[Proceed to the next section](#next).

## Acknowledgements
* **Authors**
    * Kate D'Orazio - Oracle OCI Vision Services
    * Vaishnavi Kotturu - Oracle OCI Vision Services

* **Last Updated By/Date**
    * Vaishnavi Kotturu - Oracle OCI Vision Services, February 2022
