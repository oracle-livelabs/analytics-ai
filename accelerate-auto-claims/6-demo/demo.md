# implement OAC Instance

## Introduction

This lab will walk you thru staging and loading of autoclaims data into the Autonomous Database created in previous steps. You will stage data in an object storage bucket, use the api key to create a cloud store for the object storage bucket, load data from the bucket into the autonomous database and create an auto table using parquet files in object storage bucket.

Estimated Time: 15 minutes

### Objectives


In this lab, you will:

### Prerequisites

 
This lab assumes you have:
* An Oracle Cloud account with privileges to access Generative AI services, provision Autonomous Database and add API keys
 

## Task 1: Check Auto Claims Predicted to be Approved

1. From the OAC Instance console, open the Justin Claims report 

![open report](./images/open_justin_report.png)

2. Select the Open in the Claims Status dropdown Filter and Yes in the Prediction in the drop down filter

![open claims predicted yes](./images/open_claim_yes.png)

## Task 2: View Insights

1. From the OAC Instance console, open the Justin Claims report 

![open report](./images/open_justin_report.png)

2. Click the Edit Report button

![edit report](./images/edit_report.png)

3. Click the Auto Insights button

  ![open auto insights](./images/open_auto_insights.png)

4. Select the insights tab to view and/or add insights 

  ![insights](./images/insights.png)


## Task 3: Use Assistant to ask questions about Report

1. From the OAC Instance console, open the Justin Claims report 

![open report](./images/open_justin_report.png)

2. Click the Edit Report button

![edit report](./images/edit_report.png)

3. Click the Auto Insights button

  ![open auto insights](./images/open_auto_insights.png)

4. Select the Assistant tab and type the following question:

![oac assistant](./images/oac_assistant.png)

```text
<copy>
what is the average closure days for claims in year 2025 broken down by rpoduct in descending order?
</copy>
```