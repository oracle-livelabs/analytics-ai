# Visualize Data in Oracle Analytics Cloud (OAC)

## Introduction
This lab walks you through the steps of creating self-service data visualizations in Oracle Analytics Cloud.

Estimated time - 20 minutes



### Objectives
In this lab, you will learn how to:
* Upload custom map layers using the Oracle Analytics Cloud Console
* Get familiar with parameters and filter binding
* Get familiar creating custom calculations

###Prerequisites
* A provisioned Oracle Analytics Cloud Instance
* BIServiceAdministrator Role assigned

## Task 1: Provision an Oracle Analytics Cloud Instance

1. Log into your OCI tenancy
2. In the region dropdown, select the correct region you'd like to provision your instance in
3. In the OCI console, open up the navigation menu and navigate to 'Analytics & AI' then 'Analytics Cloud'
4. Using the dropdown, select the compartment you want to provision OAC in
5. Use the 'Create Instance' to open the create analytics instance form
6. In the form, input the following for the required fields:
   - Name: NBAOACLivelab
   - Compartment: Make sure this compartment matches your desired compartment for the instance
   - Capacity Type: OCPU
   - Capacity OCPU Count: 1
   - License: License Included
   - Edition: Enterprise Edition
7. Press 'Create.' It may take approximately 20 minutes for your instance to be provisioned.

## Task 2: Import Custom Maps in OAC

1. CLICK HERE to download a zip file with the map layers and map backgrounds we will use in this task
2. From the OAC homepage, navigate to the console.
3. From the console, open 'Maps' under 'Visualizations and Sharing'
4. In the Maps page, navigate to the 'Backgrounds' tab and expand 'Image Backgrounds'
5. Add your images for NBA shot zones and NBA half court
6. Navigate to the 'Map Layers' tab and expand 'Custom Map Layers'
7. Upload your custom map layer 'NBA Shot Zones' 

## Task 3: Create a Data Connection in OAC
1. From the OAC homepage, click on the 'Create' button in the top right corner and select 'Creation'
2. Select 'Oracle Autonomous Data Warehouse' from the available connectors
3. In the window, insert details for the required field and import your wallet

## Task 4: Create a Data Set in OAC

## Task 5: Use Self Service DV to Create a Workbook
We will now develop a workbook with 3 canvases that will be used throughout the lab. 

1. From the OAC homepage, click on the 'Create' button in the top right corner and select 'Workbook.'
2. In the creation 

## Task 6: Create a Safe Domain in OAC

1. From the OAC homepage, navigate to the console.
2. In the console, open 'Safe Domains' under 'Configuration and Administration'
3. Add a new domain and copy and paste your visual builder domain URL
4. For your newly added domain, check the box allowing for embedding

You may now **proceed to the next lab**.

## Acknowledgements

* **Authors:**
   * 
