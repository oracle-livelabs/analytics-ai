# Create a Dataset

## Introduction

In this lab, you will create and prepare a dataset in Oracle Analytics Cloud that serves as the foundation for your AI agent. You’ll ensure the data is clean, well-structured, and uses business-friendly naming so it can be easily understood by both users and AI. This is a critical step, as the quality and clarity of your dataset directly impact the accuracy of insights generated later.

Estimated Time: 20 minutes

### Objectives

In this lab, you will:
* Create a Data Set from a File
* Enrich and Transform the dataset
* Use Developer tools to analyze the queries.

### Prerequisites 

This lab assumes you have:
* Working knowledge of the Semantic Modeler
* Modeled a few tables to apply the Row-Level Security

## Task 1:  Create a Data Set from a File

In this step you shall load a file data set provided here **Sales Data for AI** from your local machine into the OAC.

1. Navigate to **Create** menu then **Dataset**.

	![Create](images/builddataset1.png)

	> **Note:** The **COUNTRIES** table is secured.  It is also secured with a join to the **SALES** table. The **COUNTRY ISO CODE** values are used to filter the data returned to an Oracle Analytics query.

2. Click Upward Arrow **Drop data file here or click to browse** then select the file

  ![Upload File](images/builddataset2.png)

3. Verify the correct tab is loaded then **Click** OK

 ![Verify File](images/builddataset3.png)

 > **Note:** The page opens to the Dataset Editor pane which shows quality insigght tile for each column, dataset table page tabs and toggle buttons at the bottom.  

       
## Task 2:  Enrich and Transform the dataset

In this task we will discover the powerful data enrichment and transformation capabilities such as recommendations, auto column naming and etc. You'll ensure the data is clean, well-structured and uses business friendly names so the AI can easily understand it to improve accuracy.

1. Click **Sales Data for AI** tab to navigate to the transform editor.

 ![Dataset Editor](images/builddataset4.png)

2. From the Add the below using the expression builder:

 ![Validate Expression Filter](images/configsecurity5.png)

3. Click **Validate** and **Save**. 

 ![Verify Data Filter](images/configsecurity7.png)

   > **Note:** A data filter is created on the **Sales** table with joins to the **Customers** and **Countries** tables.

4. **Save** the Semantic Modeler, **Check Consistency** and **Deploy**.

  ![Deploy Semantic Model](images/configsecurity6.png)


## Task 3:  Validate Data-Level Security

 1. **Sign in** as one of the users defined in the security table.

 ![Sign into OAC](images/testsecurity1.png)

 2. Create a **Workbook**.

 ![Create Workbook](images/testsecurity2.png)
 
 3. In **Add Data** select the Subject Area in which you configured security, click **Add to Workbook**.

 ![Select Subject Area](images/testsecurity3.png)

 4. In the **Data pane**, expand **Countries** , select **Country Name** and select **Amount Sold** from **Sales**. Right-click, select **Pick Visualization**.

 ![Create Visualization](images/testsecurity5.png)

 5. Select the **Table visualization** type.

 ![Add Table](images/testsecurity6.png)

 6. The results show user **LocalUserOne** can view sales data for Japan.

  ![Verify Results](images/testsecurity7.png)

   > **Note:** This is based on the User Responsibilities security table that was set up in the Database.

   ![Database Query](images/testsecurity9.png)
 
 7. Click **Save**. In Save Workbook, enter **Name**, and then click **Save**.

  ![Save Workbook](images/testsecurity8.png)

 8. View the Session Log using **Developer**.

 ![Open Developer Tools](images/testsecurity10.png)
 
 9. Under **Performance Tools** click **Refresh**.

 ![Refresh Report](images/testsecurity11.png)

 10. Click **Execution Log** then scroll to view the **Physical Query** sent to the Database. Notice the assigned country in the **where** clause.

 ![Execution Log](images/testsecurity12.png)

 11. Login with a user with **BI Service Administrator**, run same report.

 ![Run Workbook](images/testsecurity13.png)

   > **Note:** The report displays all the countries.

 12. View the Session Log using **Developer**.

 ![Analyze Log](images/testsecurity14.png)

   > **Note:** Data Filters are not executed for users who explicitly or implicitly have the BI Service Administrator role.


## Learn More
* [Build a Semantic Model](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acmdg/build-semantic-models-physical-layer.html)
* [Deploy Semantic Model](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acmdg/deploy-semantic-model.html)
* [Build a Workbook in OAC](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acubi/begin-build-workbook-and-create-visualizations.html)
* [Developer Options in OAC](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acubi/developer-options.html#GUID-5A0BD6CE-EEB3-4028-B64C-BE3178B69C21)


## Acknowledgements
* **Author** - Chenai Jarimani, Cloud Architect, ONA
* **Last Updated By/Date** - Chenai Jarimani, May 2026
