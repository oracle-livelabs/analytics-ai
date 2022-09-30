# Setup Data and Workbook

## Introduction

In this lab you will upload a dataset to Oracle Analytics Cloud, clean and format the data, and create the workbook environment from which the analyses will be completed. 

Estimated Lab Time: 10 minutes

### Objectives

*List objectives for this lab using the format below*

In this lab, you will:
* Upload a provided dataset 
* Clean and format the data
* Create the analytics workbook

### Prerequisites 

This lab assumes you have:
* An Oracle Cloud account
* Downloaded the attached dataset: [NBA Data](files/nbalivelab2020data.xlsx)
* All previous labs successfully completed


*This is the "fold" - below items are collapsed by default*

## Task 1: Upload Dataset 

To begin this lab you will upload the provided dataset, and format the data. These steps are essential in ensuring that the future analyses are successful. The data format steps are the foundation that supports all analytic processes. 

1. Create the Dataset 
    - Navigate to the top right corner of the screen and click **Create** 
    - Select Create Dataset

	![Select Create dataset](images/createdataset.png)

2. Browse to Upload the Data 
    - On the option screen displayed, click on Drop Data File Here or Click to Browse 

  ![Upload your dataset file](images/createdataset2.png)

3. Preview the Data
    - Once the file is uploaded, preview the file and click *OK*

  ![The uploaded dataset](images/createdataset3.png)

## Task 2: Prepare the Data 

1. Prepare the Data 
    - Convert 3-point Pct column to Measure by navigating to the bottom left corner of the page. Look for the label that says *Treat As*. Click on Attribute and change the selection to **Measure**.
    - Below that in *Data Type* change the selection to **Number** and Aggregation to **Average** from Count. 

  ![Use the menu at the bottom of the page](images/createdataset4.png)

2. Format Shooting Percentages
    - Click on the numeric symbol in that menu "#" and change Number Format from Auto to **Percent**
    - Repeat those steps for the 2-point Pct Column. 

  ![Change to Percent](images/createdataset5.png)

3. Convert Attribute Types 
    - Convert Visitor Team Score column to a **Measure** from an attribute. 
    - Select the Visitor Team Score column and change the treat as selection (in the bottom left menu) from Attribute to Measure 
    - Change the Data Type from Text to **Number**
    - Change Aggregation to **Average**
    - Repeat these steps for the Home Team Score column. 

## Task 3: Create the Workbook 

1. Save the Dataset 
    - Click the save icon to save and name the dataset 

  ![Save the Dataset](images/createdataset6.png)

2. Create the Workbook 
    - Click on **Create Workbook**
    - This will bring you to a blank workbook page. 

  ![Create the workbook](images/createworkbook.png)

## Task 4: Create Calculations 

1. Create Calculations 
    - To accomplish the analysis in later labs you will need to create three custom calculations. These calculations will be the foundation upon which the scenarios are tested. 
    - Click on the + sign to the right of the search field at the top left of the workbook. 
    - Select **Add Calculation** this will bring up a calculation box. 

  ![Add a calculation](images/addcalculation1.png)

2. First Calculation 
    - You will need to create four calculations. The first will be the Potential 3 point shots based on missed 2 point shots. 
    - Title the calculation *3-point Potential* 
    - Copy the below calculation: 
    ```
    <copy>((2-point missed)*(3-point Pct)) *3</copy></copy>
    ```
    - Click validate 
    - Click Save 

  ![Validate your calculation](images/addcalculation2.png)

3. Validate the Calculations 
    - Repeat that process for the next calculations.
    ```
    2-point Potential 
    <copy>((3-point missed)*(2-point Pct)) *2</copy></copy>
    ```
    ```
    Potential Home Team Score 
    <copy>((2-point Potential) + (3-point Potential)) + home team score</copy></copy>
    ```
    
This concludes the setup and preparation lab. You may proceed to the next lab.



## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Andres Quintana, Senior Product Manager, Analytics Product Strategy>
* **Contributors** -  <Carrie Nielsen, Analytics Product Strategy>
                   -  <Luke Wheless, Data Analyst BI-SCF>
* **Last Updated By/Date** - <Andres Quintana, September 2022>
