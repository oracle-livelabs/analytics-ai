# Create Pipeline

## Introduction
In this lab, we will observe how to build a pipeline in GGSA. All of the components used to elicit Kafka events from a machine learning classification model will be described in detail. Lastly, data will be sent to OAS for analysis. 

Estimated Time: 55 minutes

### Objectives

In this lab, you will complete the following tasks:
- Validate That the Required Services are Up and Running
- Log in to GoldenGate Stream Analytics
- Create File Stream
- Create a pipeline
- Create a GoldenGate Stream
- Add a Query Stage
- Add a Filter to the Query Stage
- Add a OML Stage
- Add a Spending Factor Filter
- Create a Spending Factor
- Add a Filter using the Spending Factor
- Create a Kafka Stage
- Create an OAS Stage
  
### Prerequisites

This lab assumes you have:
- An Oracle Always Free/Free Tier, Paid or LiveLabs Cloud Account

## Task 1: Validate That the Required Services are Up and Running

1. When deploying the stack, access the GGSA Server using the NoVNC link.

## Task 2: Log in to GoldenGate Stream Analytics

1. Use the following login information to access the GGSA portal:
- username: **osaadmin**
- password: **GGSAdm123456!**

    ![Login portal for GGSA](images/ggsa-pipeline-login.png)

## Task 3: View GoldenGate Stream

1. Select the **toggle button** to expand the filter bar. Select **Steams** to filter by streams. Select **DMFinances** to view the GoldenGate stream.  
   
    ![Expand filter bar button](images/expand-filter-bar.png)

2. Observe the GoldenGate Change Data that we viewed in the previous lab. Click the **X** to exit back.

    ![View the GoldenGate Stream](images/goldengate-stream.png)

## Task 4: Create a pipeline

1. Select the **Green button** to create new item and select **Pipeline** from the drop-down options.

    ![Create a pipeline](images/create-pipeline.png)

2. Insert a name for the pipeline, such as **Financials_DataPipeline** and select **DMFinances** from the stream options. Click **Save** to create the pipeline.

    ![Name the pipeline](images/name-pipeline.png)


## Task 5: Add a Query Stage

1. Right click the **DMFinances** and select **Query** from the options.

    ![Add a query stage](images/add-query-stage.png)

2. Name the query stage and select **Save**.
    ```
    $ <copy>DataEnrichment</copy>
    ```

    ![Name the query stage](images/name-query-stage.png)

3. In the workflow section, click on the **Entertainment** stage and make sure it is highlighted blue. This is where the live data is streaming from and acts as a query stage.

    ![Select Entertainment stage](images/entertainment-stage.png)

## Task 7: Add a Source to the Query Stage

1. Select add a source **DMFinances** and **Customers**.

    ![Add a source to Query stage](images/add-a-source-to-query.png)

2. Add a condition to match **CCNUMBER_1** is **equals (case sensitive)** to **CCNUMBER**.
   
    ![Match the CCNUMBER between the datasets](images/match-ccnumber.png)

## Task 8: Add a Data Cleaning stage

1. Right click **DataEnrichment** and add another Query stage.

    ![Add a Query stage](images/add-datacleaning-stage.png)

2. Name the query stage and select **Save**.
    ```
    $ <copy>DataCleaning</copy>
    ```

    ![Name the query stage](images/name-datacleaning-stage.png)

2. Right click **op_type** and select **Remove from output**.

    ![Remove optype from output](images/filter-optype.png)

3. Again, right click **CCNUMBER_1** and select **Remove from output**.

    ![Remove ccnumber_1 from output](images/filter-ccnumber1.png)

## Task 9: Add a ZipLatLong Query stage

1. Right click on **DataCleaning** and select **Query**.

    ![Select spendingfactor stage to view source](images/add-latlong-query-stage.png)

2. Select **Add a source** to join **Zip2Latlon2** to the pipeline.

    ![Addding ziplatlong to source](images/join-ziplatlong.png)

3. Click **Add a condition** and then match **Zip** equals **TXNZIP**.

    ![Match Zip to TXNZIP](images/join-zip-columns.png)

## Task 10: Create a Current and Previous Event Pattern Stage

1. Right click **ZipLatLong** stage and select **Pattern**.

    ![Select Pattern stage](images/select-pattern.png)

2. Select **Trend** category and choose **Current and Previous Events**.

    ![Select Current and Previous Events](images/cur-prev-events.png)

3. Name the stage **CurrPvEvents** and click **Save**.
    ```
    $ <copy>CurrPvEvents</copy>
    ```

4. Select **Partion Criteria** to include the following:
    ```
    CCNUMBER, CCTYPE, FIRSTLAST, EMAIL, HOMEZIP, HOMEIP
    ```
    ![Add Partion Criteria](images/name-currprevevents.png)

## Task 11: Add a Filter using the Spending Factor

1. Click on **NewSpending** stage to see how this source is sent to both Kafka and OAS.

    ![Select spendingpattern to see rules](images/high-rule.png)

## Task 12: Create a Kafka Stage

1. Click on **SpendingKafka** to view the target mapping.

    ![Target mapping of Kafka Topic](images/kafka-stage.png)

## Task 13: Create an OAS Stage

1. Click on **SpendingAnalytics** to view the target mapping for OAS.

    ![Target mapping for OAS](images/oas-stage.png)

## Task 14: Create a visualization

1. Right-click on **SpendingFactor** and add a stage. Select **Query Group** and then **Stream,** which will open a popup window.
    
    ![Query group option](images/query-stream.png)

2. Name the component **StreamCategorization** and click **Next.**

    ![Name option in popup window](images/name-query.png)

3. Click **Groups** tab and then **Add a Summary.**

    ![StreamCategorization Menu options](images/add-a-summary.png)

4. From the first drop-down menu, Select **Count,** then select **SFactor** on the next drop-down menu to the right.

   ![Count of SFactor options](images/count-sfactor.png)

5. Select **Add a GroupBy** to present a new drop-down menu.

   ![Add a GroupBy menu option](images/groupby.png)

6. Select **SFactor** from the menu options.

   ![list of menu options for group](images/group-sfactor.png)

7. Select the **Visualization** tab and scroll down to select **Add Visualization.**

   ![Visualization tab](images/visualizations.png)

8. Select the **Pie Chart** from the drop-down menu.

   ![pie chart menu options](images/pie-chart.png)

9. Name the visualization **Score** and select **COUNT_of_SFactor** from the Measure menu and **SFactor** from the Group menu. Click **Create** when done.

   ![Properties for Pie Chart](images/score-visualization.png)

10. The result will populate a live chart that will update as the pipeline is populated with data.

   ![Live Pie Chart](images/pie-result.png)

You may now **proceed to the next lab.**

## Acknowledgements

- **Author**- Nicholas Cusato, Santa Monica Specialists Hub, July 14, 2022
- **Contributers**- Hadi Javaherian, Hannah Nguyen, Gia Villanueva, Akash Dahramshi
- **Last Updated By/Date** - Nicholas Cusato, Santa Monica Specialists Hub, July 14, 2022