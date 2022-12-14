# Test, Deploy, and Validate a Semantic Model

## Introduction

In this lab, you run the consistency checker on the Sample Sales semantic model, deploy the semantic model, and validate the subject area by creating visualizations in Oracle Analytics Cloud.

Estimated Time: -- minutes

### Objectives

In this lab, you will:
* Run the consistency checker
* Deploy the Sample Sales semantic model
* Validate the subject area by creating visualizations in Oracle Analytics Cloud

### Prerequisites (Optional)

*List the prerequisites for this lab using the format below. Fill in whatever knowledge, accounts, etc. is needed to complete the lab. Do NOT list each previous lab as a prerequisite.*

This lab assumes you have:
* Access to Oracle Analytics Cloud
* Access to DV Content Author, BI Data Model Author, or a BI Service Administrator role
* Access to the Sample Sales Semantic Model
* All previous labs successfully completed


## Task 1: Run the Consistency Checker

Begin with step 3 if you're continuing this tutorial directly after completing the steps in Create the Presentation Layer tutorial.

1. If you closed your semantic model, sign in to Oracle Analytics Cloud using one of DV Content Author, BI Data Model Author or service administrator credentials. On the Home page, click the Navigator Navigator icon, and then click Semantic Models.

	![Image](images/image.png)

2. In the Semantic Models page, select Sample Sales, click Actions menu Actions menu icon, and then select Open.

	![Image](images/image.png)

3. Click Check Consistency Consistency Checker icon and select Errors and Warnings. Oracle Analytics didn't find any errors in the Sample Sales semantic model.

	![Image](images/image.png)

## Task 2: Deploy the Semantic Modeler

1. In the semantic model, click the Page Menu Page Menu icon, and select Deploy.

	![Image](images/image.png)

2. Click Deploy. The message, "Deploy successful" appears when the deployment process is complete.

	![Image](images/image.png)

3. Click Go back icon.

	![Image](images/image.png)

## Task 3: Validate the Semantic Model

1. On the Semantics Models page, click Create, and then click Workbook.

	![Image](images/image.png)

2. In Add Dataset, click Select Data, and select Subject Areas. In Subject Areas, click Sample Sales, and then click Add to Workbook.

	![Image](images/image.png)

3. In the Data pane, expand Time, Base Facts, and Products. Hold down the Ctrl key, select Per Name Year from Time, select Revenue from Base Facts, and select Type from Products. Right-click, select Pick Visualization, and then select Table.

	![Image](images/image.png)

4. Click Save Save icon. In Save Workbook, enter Validate SM in Name, and then click Save.

	![Image](images/image.png)


## Learn More
* [Deploy a Semantic Model](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acmdg/deploy-semantic-model.html)
* [Work with the Consistency Checker](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acmdg/work-consistency-checker.html#GUID-DBBDF46F-2CB0-4EBD-BD98-0B75D9F0FD3E)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
