# SailGP Data Analysis

## Introduction

In this lab, you will get a taste of what it is to be a Data Athlete for SailGP! The goal of your analysis will be to find out what factors exist that make one team perform better than the other. You'll do this by looking for clues in the data and calculate various performance metrics. 

We will use **Oracle Analytics Cloud (OAC)** to access and analyze data from the **MySQL HeatWave Lakehouse**. We will use the data from the External Table that we uploaded to Object Storage earlier.

We'll start with some basic statistics such as the time that it takes each team to finish the race, the maximum speed that the teams achieve and the amount of time that they are able to foil (let the boat rise out of the water).

Have a look at this introduction to SailGP by Performance Analyst Cyrille Douillet!

[](youtube:T-DUAasfubk)

_Estimated Time:_ 20 minutes

<!--![Banner](images/banner.jpg)-->

### Objectives
In this lab, you will:

- Learn how a SailGP Data Athlete extracts valuable insights from sensor data
- Learn how to use Oracle Analytics Cloud to prepare and analyze data

### Prerequisites
This lab assumes you have completed the lab for configuring the infrastructure.

## Task 1: Create the Connection from Oracle Analytics Cloud to MySQL HeatWave

First we need to create a connection from Oracle Analytics Cloud to our MySQL HeatWave Lakehouse instance. 

1. In order for OAC to be able to connect to MySQL HeatWave, we will need to provide our MySQL instance's Hostname. To find this out, you need to go back to the MySQL instance details.

  	Go to Databases section on your Cloud Home Page and select **DB Systems** and finally select **mysql-lakehouse** instance that we created previously and you will find all the information required such as **Hostname** and **MySQL Port** in the _Endpoint section_.

   Copy the Hostname to the clipboard.

  	![MySQL DB system dashboard](./images/endpoint.png)

  	![MySQL DB system dashboard](./images/hostname.png)

2. Open Oracle Analytics Cloud

   In the **Oracle Cloud Infrastructure console** click on the menu icon on the left. Navigate to **Analytics & AI** and then **Analytics Cloud**.

   ![OAC Web Console](images/analytics-oac.png)

3. **Open** the Cloud Analytics **URL** associated with your instance (the one that we created in Lab 2) by using the dots menu button on the right-hand side of your instance information and selecting **Analytics Home Page**.

   ![Cloud Analytics URL](images/select-oac-instance.png)

   The **Oracle Analytics** page will open in a new browser **window/tab**.

4. On the top right-hand side of the screen, click **Create**, and then **Connection**.

   ![Connection Creation](images/oac-create-connection.png)

5. Select the MySQL Connection type.

   ![Connection Creation](images/conn.png)

6. Fill out with the following information:

	 Note: replace the `**PASSWORD**` with the password you have used creating MySQL DB System at Lab 1/Task 2.

    ```
    Connection Name: <copy>SAILGP</copy>
    ```
    ```
    Host: Copy the information from Hostname (step 1) here. ex: <copy>mysql-lakehouse.subXXXXXXXXXX.lakehousevcn.oraclevcn.com</copy>
    ```
    ```
    Port: Copy the information from MySQL Port. It should be <copy>3306</copy>
    ```
    ```
    Database Name: <copy>SAILGP</copy>
    ```
    ```
    Username: <copy>admin</copy>
    ```
    ```
    Password: <copy>**PASSWORD**</copy>
    ```
  
  	After you filled out the information, click _**Save**_.

  	![Oracle Analytics dashboard connection form](./images/setup-conn.png)

  	Your Oracle Analytics Instance is now connected to your MySQL Database Service powered by HeatWave.

## Task 2: Add the Dataset to Oracle Analytics Cloud

We're going to take a deep dive on the SailGP regatta that took place in Bermuda in April 2021. In particular, we are going to have a look at race 4 (out of 7 in total). We're going to do a post race analysis with the goal of helping the teams perform better in the upcoming race.

Earlier, we uploaded the data of this race to Autonomous Data Warehouse. Now, we have to make this available to Oracle Analytics Cloud.

1. On the top right, choose **Create** and then **Data Set**.

   ![Create dataset](images/create-dataset.png)

2. Select the `SAILGP` connection.

   ![Select SAILGP connection](images/select-sailgp-connection.png)

3. Open the `SAILGP` schema and **double click** on the `SAILGP_SGP_STRM_PIVOT` table.

   ![Add dataset](images/add-dataset.png)

   Each record in this data set represents one second of the race for one particular team.
   At each second of the race, we can see the values of many of the sensors of the boat of each team.

   You see how Oracle Analytics is profiling the columns in the data set. It creates histograms and other charts of each of the columns to quickly give you insight into what value there is in them. For example, have a look at column `B_NAME`. This shows you that there are 8 countries that are competing (column `B_NAME`). And have a look at `LENGTH_RH_BOW_MM`, Which shows you how far the boat lifts out of the water, the values appear to hover between 0 and 1.5m above the water.

   These graphs are a great way to quickly get an understanding of your data.

4. Configure the details of the dataset

   Now at the bottom of the screen, click on `SGP_STRM_PIVOT` to configure the details of the dataset.

   ![Details dataset](images/details-dataset.png)

5. Modify `TIME_GRP` column

   This attribute contains the time in the race, in seconds. For example, -30 indicates 30 seconds before the start of the race. Value 0 indicates the start of the race, etc.

   Right now it is classified as a `MEASURE` (visible because of the # symbol). However, we will not use this attribute to calculate, therefore we will convert this into an `ATTRIBUTE`.

   Click the header of the `TIME_GRP` column, then click the value next to **Treat As** and change it to **Attribute**.

   ![Change TIME_GRP to attribute](images/change-timegrp-to-attribute.png)

   The symbol next to the column header changes to `A`.

6. **Pivot** the representation

   Pivot the presentation so it becomes easier to modify the column configuration.

   ![Change TIME_GRP to attribute](images/change-representation.png)

7. Modify the **Aggregation** type of `BOAT_SPEED_KNOTS` (boat speed in knots)

   Later on, we will want to obtain the Maximum Boat Speed for each team. Because of this, we want to set the default aggregation of the `BOAT_SPEED_KNOTS` field to **Maximum**.

   Find the `BOAT_SPEED_KNOTS` column and click it, then change the aggregation to **Maximum**.

   ![Change aggregation to maximum](images/boat-speed-max.png)

<!--
8. Modify the aggregation type of TWS_MHU_TM_KM_H_1 (wind speed)

   Similarly, later on we'll want to obtain the Average Wind Speed.
   Because of this, we want to set the default aggregation of the TWS_MHU_TM_KM_H_1 (wind speed) to "Average".

   Find the TWS_MHU_TM_KM_H_1 column and click it, then change the aggregation to "Average".

   ![Change aggregation to average](images/tws-average.png)
-->

8. Save the data set

   Finally, click the **Save** icon and give the data set a logical name, e.g. **Race Data**.

   ![Set name and save data set](images/save-dataset.png)

## Task 3: Find out Who the Winners of the Race Are

1. Still in the data set editor, on the top right, click **Create Workbook**.

   ![Change aggregation to average](images/create-project.png)

   Now you have prepared your data, you are ready to start creating some visualizations and finally get some insights!

	Now you are in the Visualization area!

	> **Note:** As a general note, keep in mind that you can use the Undo/Redo buttons at the top right of the screen if you make any mistake in this section.

   ![Undo](images/undo.png)

2. Create a chart with race winners

   Let's start with our first visualization challenge: Find out who took the least time to go from start to finish by creating a chart on `B_NAME` (team name) and `TIME_SAILED` (the number of seconds they were sailing).

   Drag `B_NAME` to the canvas.

   ![Drag B_NAME](images/drag-bname.png)

   Find the `TIME_SAILED` column and drag it to the canvas as well.

   ![Drag TIME_SAILED](images/drag-time-sailed.png)

   The result should look like this. You have a simple table with the time that each team took to complete the race.

3. Let's make this a bit easier to interpret: Change the representation to **Horizontal Stacked Bar Chart**.

   ![Change to horizontal stacked bar](images/change-to-horbar.png)

4. We want to see the fastest team first, so let's change the sorting. Click the **Sorting** icon (top right).

   ![Change sorting](images/change-sorting.png)

   Configure the sorting to be by `TIME_SAILED` from low to high. Click **OK**.

   ![Change sorting](images/change-sorting2.png)

   We can see that Great Britain was the winner, followed by Australia.

5. Actually, Japan and the USA did not finish the race because they collided. Let's remove them from the outcome by adding a filter. Drag `B_NAME` to the filter area.

   ![Drag B_NAME](images/drag-bname-to-filter.png)

   Then configure the filter to include all countries apart from `JPN` and `USA`. You see how the chart now contains only the 6 remaining teams.

   ![Configure filter](images/configure-filter.png)

   You can see that the boats that finished last were France and Denmark, we will now compare France and Denmark to Great Britain to see how they are different. Hopefully we will find some indicators on where France and Denmark can make improvements.

## Task 4: Compare Maximum Boat Speeds

1. Find out which teams are able to obtain the maximum boat speed.

   Right click on the `BOAT_SPEED_KNOTS` field and choose **Create Best Visualization**.

   ![Compare maximum boat speed](images/visualize-knots.png)

   This shows the maximum speed across all boats in this race. In fact, at the time, this was a new record for all SailGP races so far! 51 knots per hour is over 94 kilometers per hour or 59 miles per hour!

   Have a look at this video that shows the speed record being broken:

   [](youtube:TUWFUzorUp0)

2. Show what the maximum speeds are for all countries, by dragging `B_NAME` onto the same chart.

   ![Drag B_NAME](images/drag-bname2.png)

3. Change the chart type to **Horizontal Stacked**.

   ![Change to Horizontal Stacked](images/change-chart-type.png)

4. **Sort** the chart by boat speed, **High to Low**.

   ![Sort High to Low](images/sort-icon.png)
   ![Sort High to Low](images/sort-by-boat-speed.png)

	 In this case, the teams that have the higher maximum speed also are the teams that are finishing highest. However we have to be careful drawing any conclusions from this. Remember, in sailing the highest speed doesn't necessarily mean the best track taken through the course, nor that you will be the winner.

   ![Conclusion](images/conclusion.png)

## Task 5: Investigate How Much the Teams Are Foiling

1. Introduction

   Foiling is the phenomenon where boats go fast enough to rise out of the water. Because they rise of the water, they have less water resistance, resulting in even higher speeds. Because of this, teams will always try to foil as much as possible. Let's see how well the teams are able to foil.

   Watch this video that explains the benefits (and the dangers) of foiling!

    [](youtube:5MlLfw6jcpk)

2. Create a calculation

   First create a calculation to calculate the percentage of time that teams are foiling. We can use the `TIME_SAILED` (total time to complete race) and `TIME_FOILING` for this. Add a calculation (right click on **My Calculations**) with the name `Foiling Percentage` and create the following formula. 
   
   Remember that you can drag the fields in from the left to add them to the formula.

   **Do not copy-paste this formula. Instead, type the formula and wait for the column names to be recognized, or drag in the columns from the left.**

   It should look like this:

	 ```
   <copy>
   (TIME_FOILING / TIME_SAILED)*100
   </copy>
   ```

   ![Foiling percentage](images/foiling-percentage.png)

3. Create a basic chart

   Now create a chart to display the foiling percentage for all the teams. First, create a new chart with overall foiling percentage by right clicking on the new Foiling Percentage field and choosing **Create Best Visualization**.

   ![Foiling percentage](images/foiling-percentage2.png)

4. Add the `B_NAME` column in the visualization to show the foiling percentage per team.

   ![Drag B_NAME](images/drag-bname3.png)

5. Change the chart type to **Horizontal Bar Stacked**.

   ![Change chart type](images/change-chart-type2.png)

6. Change the sorting to be on Foiling Percentage **High to Low**. Click **OK**.

   ![Change sorting](images/change-sorting3.png)

   We can see that, although Denmark does a good job foiling, they are still the last team to cross the finish line.

   ![Conclusions](./images/conclusion-denmark.png)

7. Save the workbook with name `Basic statistics on Bermuda race 4`.

   ![Save workbook](images/save-project.png)

8. Go back to the **Home Page**.

   ![Go back to homepage](images/to-homepage.png)

Congratulations on completing this lab!

You may now *proceed to the next lab*.

## **Acknowledgements**
- **Author** - Jeroen Kloosterman - Technology Product Strategy Director
- **Last Updated By/Date** - Jeroen Kloosterman - Technology Product Strategy Director, October 2023