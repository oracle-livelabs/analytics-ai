# Provision Analytics Cloud

<!--![Banner](images/banner.png)-->

## Introduction

During this lab you will deploy an Oracle Analytics Cloud instance on Oracle Cloud Infrastructure.

Estimated Lab Time: 15 minutes (provisioning time may vary)

### Objectives
In this lab, you will:
- Login as a federated user.
- Create an Oracle Analytics Cloud Instance.

### Prerequisites
- Oracle Free Trial Account.


## **Task 1:** Create an Oracle Analytics Cloud (OAC) Instance

1. Return to the Home Page and go to the **Menu** > **Analytics & AI** > **Analytics Cloud**.

   ![OAC Menu](images/analytics-oac.png)

2. Make sure you select the `root` compartment (unless you have permissions and experience selecting a different one) and click **Create Instance**.

   ![OAC Create Button](images/oac_create_button.png)

3. Fill the web form with the following information and click **Create**:

   - **Compartment**: `root` compartment, unless you have permissions and experience selecting a different one.
   - **Name**: `WorkshopAnalytics`
   - **Description**: `Analytics Instance for Data Science workshop`
   - **Capacity**: `OCPU` and `1 - Non Production`
   - **License Type**: `License Included` and `Enterprise Analytics`

   ![OAC Form](images/oac_form.png)

   Your Analytics Instance will start provisioning.

   ![pic3](images/oac_creating.png)
4. Deploy the DVX file to OAC project
- Collect the OAC dashbaord extract file (.DVA) file from this location.[MYSQLLakehouse_labfiles\Lab5\OAC]
- Upload these files to OAC console and Visualize Dashbaords .
- Predictive Streaming Analytics.dva
  
   - **DVA password - Admin123
   ![DVA File Deployment](images/oac_dashbaord.png)
   ![DVA File Deployment](images/oac_import.png)
- NOTE: Provisioning an Oracle Analytics Cloud instance can take from 10 (most likely) to 40 minutes.

   We will get back to your Oracle Analytics Cloud instance later in the workshop.

You may now **proceed to the next lab**

## Acknowledgements
* **Author** - Biswanath Nanda, Principal Cloud Architect, North America Cloud Infrastructure - Engineering
* **Contributors** -  Biswanath Nanda, Principal Cloud Architect,Bhushan Arora ,Principal Cloud Architect,Sharmistha das ,Master Principal Cloud Architect,North America Cloud Infrastructure - Engineering
* **Last Updated By/Date** - Biswanath Nanda, March 2024