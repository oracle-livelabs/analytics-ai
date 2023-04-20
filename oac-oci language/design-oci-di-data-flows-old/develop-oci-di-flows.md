# Design Data Flows in OCI Data Integration

## Introduction

This lab walks you through the steps to create the components necessary to create a data flow like the one shown in the graph below. To create source and target components, first, we need to create a set of “data assets”. The data assets represent each of the elements in the diagram. We’ll start by creating the data asset for the source, and then the target.

   ![Data Flow](./images/odidataflow.png " ")

Estimated Time: 90 minutes

### Objectives

In this lab, you will:
* Create a data asset for your source and staging data
* Create a data asset for your target
* Create the Data flow.
* Run the Data flow


### Prerequisites

This lab assumes you have:
* All previous labs completed
* You have the right to use OCI Data Integration. Below are steps to check your access:
    - Work with your administrator to create your DI Workspace and the policies that will allow you to use the data integration service and grant your DI workspace the ability to read data from storage buckets. Follow the setup steps that are described at [Connect to Data Integration](https://docs.oracle.com/en-us/iaas/data-integration/tutorial/tutorials/01-connecting-to-dis.htm#getting-workspace-ocid)
    - If you are the administrator you can follow this [Create Workspace](https://docs.oracle.com/en-us/iaas/data-integration/using/workspaces.htm#workspaces) on steps to create a workspace
    - If you chose 'Enable Private Network' and If your source and target data sources are in a different network or region, you must separately configure appropriate gateways to establish routing between the networks. If you don't see your subnets, it could be because they weren't created as regional subnets.
    - From the Console, click **Analytics & AI** > **Data Integration**.
    - Identify the workspace you created and ensure it is already in the **Active** state.

    ![Data Flow](./images/creatediworkspace.png " ")




## **Task 1**: Create a data asset for your source and staging data

1.	From the Console, click **Analytics & AI** > **Data Integration**, and navigate to the workspace you just created.

   ![Workspace](./images/odiworkspace.png " ")

2.	On your workspace Home page, click **Create Data Asset** from the Quick Actions tile.

3.	On the **Create Data Asset** page, complete the General Information fields:
    - For **Name**, enter reviews-data-source without any spaces. You can use alphanumeric characters, hyphens, periods, and underscores only.
    - For **Description**, enter a description of your data asset.
    - From the **Type** dropdown, select **Oracle Object Storage**.
    - For **Tenant OCID**, enter the tenancy OCID. If needed, you can navigate to your tenancy information from the Profile icon on the top right corner of your cloud console.
    - For **OCI region**, you can copy the code that is shown in the url for instance “us-phoenix-1”

   ![Source Data Asset](./images/sourcedataasset.png " ")

4.	Test the connection and **Create** the data asset.

   Repeat the same steps for your “staging” bucket location (if it is different). Currently, the name of the data asset for the staging location needs to be capitalized.


## **Task 2**: Create a data asset for your target

In Data Integration, we need to create a data asset for the data warehouse we just created. Once we transform, enrich and analyze your data, we will save the structured data to a set of tables in the autonomous data warehouse.

1.	In the Oracle Cloud Infrastructure Console navigation menu, go to **Analytics & AI**, then select **Data Integration**.

2.	Navigate to the compartment where you created the workspace and select your workspace.

3.	On your workspace **Home** page, click **Create Data Asset** from the **Quick Actions** tile.
   You can also click **Open** tab (plus icon) in the tab bar and select **Data Assets**, then click **Create Data Asset**.

4.	On the **Create Data Asset** page, for **General Information**, set the following:
    - **Name**: Data_Warehouse (You can use alphanumeric characters, hyphens, periods, and underscores only).
    - **Identifier**: Auto-generated based on the value you enter for Name. You can change the auto-generated value, but after you save the data asset, you cannot update the identifier again.
    - **Description**: Optional
    - **Type**: Oracle Autonomous Data Warehouse
    - **Wallet File**: Drag and drop or browse to select the wallet file. See [Download a Wallet](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/cswgs/autonomous-connect-download-credentials.html)
    - **Service Name**: Service level to connect to your Autonomous Data Warehouse database

    ![Target Data Asset](./images/targetdataasset.png " ")

5.	In the **Connection** section, enter the following:
    - **Name**: Default connection (Optionally, you can rename the connection)
    - **Description**:  Optional (For example, Connect with BETA user)
    - **User Name**: USER1
    - **Password**: The password you created for USER1

    ![Configure DB Connection](./images/configureconnection.png " ")

6.	Click **Test Connection** to verify that you can connect to the data warehouse using the credentials you just provided.

7.	Assuming your test was successful, click **Create**.

## **Task 3**: Create the Data flow

  To create a data flow, first, you need to create a project in Data Integration. To create a project and a data flow:

1.	On your workspace **Home** page, click **Projects**. You can also click **Open** tab (plus icon) in the tab bar and select **Projects**.

2.	On the Projects page, click **Create Project**.

    ![Create Project](./images/creatediproject.png " ")

3.	On the **Create Project** page, enter “language-lab” for **Name**, and then click **Create**.

   Now we will create a data flow to ingest data from the hotels' review file we just ingested.
4.	On the **language-lab** project details page, click **Data Flows** in the submenu on the left.

5.	Click **Create Data Flow**. The data flow designer opens in a new tab.

  ![Create Data Flow](./images/createdataflowone.png " ")

6.	In the **Properties** panel, for **Name**, enter lab-data-flow, and click **Create**.
   The designer remains open for you to continue editing.

   ![Create Data Flow](./images/createdataflowtwo.png " ")

   Add a data source:

7.	Add a Source by dragging the **Source** icon into the data flow workspace area. Select the source you just added and navigate to the **Details** tab in the Properties pane.

8.	Fill the properties as follows:
    - Enter **HOTEL\_REVIEWS\_CSV** as the identifier. Enter the following fields:
    - In **Details**, select the source asset your created (data-lake)
    - **Connection**: Keep “Default connection”
    - In **Schema**, select the bucket with the hotel reviews file.
    - In **Data Entity** select the hotels' review data file and enter **CSV** as the File Type.

    ![Create Data Flow](./images/createdataflowthree.png " ")

9.	You can confirm that you loaded the data correctly by going to the Data section. It takes a minute or two for the data to appear there.

    ![Data Flow Source](./images/dataflowsource.png " ")

10.	First, we will add an expression to change the format of our **REVIEW\_ID** field.
    - Right-click on the 3 vertical dots next to the **data source name.review\_id** field
    - Select **Change Data Type** and select Integer and click **Apply**
    - This will create a new expression step in your dataflow
    - Set the **Name** to REVIEW\_ID

11.	Now we will perform a second transformation.  We will make sure that the date is treated as a Date. Start by navigating to the Data tab in the Properties pane while selecting the Expression.
    - Right-click on the 3 vertical dots next to the **data source name.review\_date** field
    - Select **Change Data Type** and select Data Type **Date** and the Date Format that matches the CSV format (in this case yyyy-MM-dd)
    - Set the **Name** to REVIEW\_DATE

13.	Clicking on the Data tab of the expression will allow you to see the newly created fields.

    ![Verify Expression](./images/expressionone.png " ")


   Now we will connect the function you created in **Lab 2** to extract the aspect level sentiment from the review text.

14.	From the operators' toolbar, drag the Function (fn) operator into the canvas and connect the output of your expression as the input into the function.

    ![Verify Expression](./images/expressiontwo.png " ")

15.	Select the function you just added, in the **Properties** pane and navigate to the **Details** Pane. Change the identifier to SENTIMENT_FUNCTION

16.	Click the **Select** button to select the OCI Function. Select the application you created earlier in **Lab 2** and pick the “sentiment” OCI Function. Click **OK** to confirm your changes.

17.	Now you will need to add or edit the properties below. Except for the BATCH\_SIZE property (which you can edit), you can do this by clicking the Add Property button for each field.

   | Name | Type | Data Type | LENGTH | Value |
   | --- | --- | --- |
   | info | Input Attribute | VARCHAR  |2000|   |
   | column |Function Configuration | VARCHAR |    | info |
   | BATCH_SIZE | Function Configuration | NUMERIC|    | 1|
   | text | Output Attribute | VARCHAR|  2000  |  |
   | sentiment | Output Attribute | VARCHAR| 2000   |  |
   | offset | Output Attribute | INTEGER|    |  |
   | length | Output Attribute | INTEGER|    |  |

   ![Function Parameters](./images/functionparameters.png " ")

18.	Once you are done, navigate to the **Map** tab, and map the review field from the source attributes into the info field Function Input. You do this by “dragging” the review in the left table into the info field.

    ![Function Mapping](./images/functionmapping.png " ")

   Now we will map the output of the sentiment analysis to the Data Warehouse Table we created for this purpose during **Lab 3**

19.	From the operator’s toolbar, drag the **Target** operator into the canvas and connect the output of your sentiment function as the input into the target operator.


20.	In the details properties tab for the target, set the following fields:
    - Identifier: TARGET\_SENTIMENT
    - Integration Strategy: Insert
    - Data Asset: Select the data warehouse asset you created in **Lab 3**
    - Connection: Default connection
    - Schema: USER1
    - Data Entity: SENTIMENT

    ![Configure Target Sentiment](./images/targetsentiment.png " ")

21. For staging Location you just need to provide an object storage location where intermediate files can be created during the data flow:
    - Data Asset: DATA\_STAGING
    - Connection: Default connection
    - In Schema, select the object storage location that you want to use for staging purposes.

22.	Now we need to do a mapping exercise again, mapping the output of the function to the right fields in the target database table.

    Make sure the fields are mapped as follows:

     ![Function Mapping](./images/functionmappingtwo.png " ")


   When you are done with your data flow it will look something like this:

   ![Create Task](./images/completedataflow.png " ")

23. Follow steps 19 - 22 to configure the Target table for the Raw Reviews table. When done your mappings should look like the below image.

    ![Raw Reviews Details](./images/rawreviewstargetone.png " ")

    ![Raw Reviews Mappings](./images/rawreviewstargettwo.png " ")

## **Task 4**: Run the Data Flow

Now we need to execute the data flow. The process is as follows.

1.	Navigate back to your workspace and click **Create Integration Task** in the **Quick Actions** menu.

    ![Integration Task](./images/integrationtask.png " ")

   As part of the process of creation, you need to select the project and the data flow you just created in **Task 3**. If there are any errors with the data flow you would need to fix those until it successfully validates as shown in the image below.

    ![Create Task](./images/createtasktwo.png " ")

2.	Go to your data integration workspace and select the **Applications** link. Then click **Create an Application**. Give it a name and click **Create**.

3.	Navigate back to the data integration workspace. Click on the **Projects** link in the workspace and select the project you created in **Task 3**.

4.	Click on the Tasks link in the **Details** menu, select the contextual menu for the task you just created, and click **Publish to Application**. Select the application you just created.

    ![Create Task](./images/createtaskone.png " ")

5.	Navigate back to the application you just created, select your integration task, and select **Run** on the contextual menu as shown below.

    ![Run Task](./images/runtasktwo.png " ")


  You will navigate to the **Runs** page where you will be able to monitor the execution of your integration task run. If there are any errors, make sure to check the logs to understand the cause of the run error. Click **Refresh**

    ![Task Status](./images/taskstatus.png " ")


6.	Assuming everything ran successfully, we can now navigate to our database and see if our tables got populated with the insights extracted from the reviews.

    ![Validate Database](./images/validatedatabase.png " ")

This concludes this lab. You may now **proceed to the next lab**.

## Learn More
* [Getting Started with Data Integration](https://docs.oracle.com/en-us/iaas/data-integration/home.htm)

## Acknowledgements
* **Author** - Chenai Jarimani, Cloud Architect, Cloud Engineering, Luis Cabrera-Cordon, Senior Director, AI Services
* **Contributors** -  Paridhi Mathur, Cloud Engineering
* **Last Updated By/Date** - Chenai Jarimani, Cloud Engineering, April 2022
