# Prepare the dataset

## Introduction

This lab will walk you through how to upload data to be ingested and indexed by the OCI Generative AI Agents service.
The dataset is the fuel for the service. After the data has been indexed, you will be able to ask complex questions about it and have the service answer those questions like a human would.
In this lab, you will be using a dataset we have created for you which contains parts of the OCI Generative AI service documentation. This will allow the Agent to answer user questions about the service.

Estimated Time: 10 minutes

### Objectives

In this lab, you will:

* Create a storage bucket to store the dataset.
* Upload the dataset to the storage bucket.

### Prerequisites

This lab assumes you have:

* An Oracle Cloud account
* All previous labs successfully completed

## Task 1: Create a storage bucket & upload the dataset

1. On your OCI tenancy console, click the **Navigation Menu**.

1. Click **Storage**.

1. Click **Buckets** on the right, under **Object Storage & Archive Storage**.

  ![Buckets navigation](./images/buckets-navigation.png)

1. Under **List scope**, make sure that the **root** compartment is selected.

1. Click the **Create Bucket** button on the top of the **Buckets** table.

  ![Buckets navigation](./images/buckets-list.png)

1. Provide a name for the bucket (example: oci-generative-ai-agents-service-cw24-hol-dataset).

1. For the purpose of this workshop, we are going to accepts the default values for the rest of the form.

  Click the **Create** button on the bottom of the panel.

  ![Create bucket](./images/create-bucket.png)

1. Click the new bucket's name in the **Buckets** table.

  ![Select bucket](./images/bucket-navigation.png)

1. Under the **Objects** section of the page, click the **Upload** button.

1. Click the **select files** link in the **Choose Files from your Computer** section.

  ![Select files navigation](./images/select-files-navigation.png)

1. In your `File Explorer` or `Finder`, navigate to the folder containing all of the `.txt` files extracted in the previous task.

1. Select all of the files from the folder and click `Open`.

  ![Select all files](./images/select-all-files.png)

1. Click the **Upload** button at the bottom of the panel.

  ![Upload files](./images/upload.png)

1. Click the **Close** button at the bottom of the panel.

  ![Upload done](./images/upload-done.png)

If everything went to plan, you should see all of the files listed under the **Objects** section of the page.

![Objects list](./images/objects-list.png)

## Acknowledgements

* **Author** - Anshuman Panda, Principal Generative AI Specialist, Alexandru Negrea, AI and App Integration Specialist Leader