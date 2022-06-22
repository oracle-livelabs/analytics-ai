# Use Analytics Cloud on MySQL Database Service Powered by HeatWave

## Introduction

In this lab we will use the Oracle Analytics Cloud instance we created in the Infrastructure lab. Oracle Analytics Cloud is embedded with machine learning that will provide you intelligent insights using natural language generation that automatically creates smart textual descriptions of visualizations and instantly visualize your data, which helps organizations with root cause investigation, troubleshooting and decision-making process.

Estimated Time: 30 minutes

### Objectives

In this lab, you will:
- Learn how to create your Analytics dashboards using Oracle Analytics Cloud on MySQL Database Service powered by HeatWave

### Prerequisites

- All previous labs have been successfully completed.

[Lab 4 Demo](youtube:DCc8FM6ZHtA)

## Task 1: Create Oracle Analytics Cloud Instance 

1. From the Cloud shell connect to MySQL DB System:
	
	 Note: replace the `**PASSWORD**` with the password you have used creating MySQL DB System at Lab1/Task5.4.

    ```
    <copy>mysqlsh --user=admin --password=**PASSWORD** --host=<mysql_private_ip_address> --port=3306 --database=airportdb --sql</copy>
    ```
  
  	![connect to mysql shell](./images/Lab4-task1.1.png)

  	Run the following query to create a virtual table **`view_analytics`** that will include data from other tables from the database:

    ```
    <copy>
    CREATE VIEW view_analytics AS
    SELECT b.booking_id,
    f.flight_id,
    pd.passenger_id,
    pd.sex,
    pd.country,
    b.seat,
    b.price,
    f.flightno,
    f.departure,
    f.arrival
    FROM booking b
    JOIN passengerdetails pd ON pd.passenger_id = b.passenger_id
    JOIN flight f ON f.flight_id = b.flight_id
    JOIN airport ato ON ato.airport_id = f.to
    LIMIT 200000;
    </copy>    
    ```
  
  	![creating view analytics for OAC](./images/Lab4-task1.1-1.png)

2. Now going back to the main page click on the _**hamburger menu**_ in the upper left corner and click on _**Analytics & AI -> Analytics Cloud**_.

	![OCI Console](./images/Lab4-task1.2.png)

	By now the status of the instance should have changed to _Active_, click on the button _**Analytics Home Page**_ to access Oracle Analytics Cloud.

	![OAC Active](./images/Lab4-task1.2-1.png)

3. On the new tab, you can see the Oracle Analyitcs page where we will connect to MySQL Database Service, but before you can choose to preview the new Redwood look by pressing on **preview it**.

    ![Oracle Analytics dashboard](./images/Lab4-task1.3.png)

  	On the top right corner click _**Create**_, then click _**Connection**_.
    
    ![Oracle Analytics dashboard connection](./images/Lab4-task1.3-1.png)

4. Browse the connection type or simply type in the search section _**MySQL**_, and Click it.
  
  	![Oracle Analytics dashboard connection creation](./images/Lab4-task1.4.png)

 	In the new window we have a lot of information we need to provide. Host name is a little bit tricky, we need to provide the Internal FQDN (fully qualified domain name) of the MySQL Database Instance. To find this out, you need to go back to the MySQL instance details.

  	Go to Databases section on your Cloud Home Page and select **DB Systems** and finally select **mysql-analytics-test** instance that we created previously and you will find all the information required such as **Internal FQDN** and **MySQL Port** in the _Endpoint section_.

  	![MySQL DB system dashboard](./images/Lab4-task1.4-1.png) 

5. To create the connection, fill out with the following information:

	 Note: replace the `**PASSWORD**` with the password you have used creating MySQL DB System at Lab1/Task5.4.

    ```
    Connection Name: <copy>MySQL_Connection</copy>
    ```
    ```
    Host: Copy the information from Internal FQDN here. ex: mysql-analytics-test.@#$%^&*0.analyticsvcntes.oraclevcn.com
    ```
    ```
    Port: Copy the information from MySQL Port. It should be <copy>3306</copy>
    ```
    ```
    Database Name: <copy>airportdb</copy>
    ```
    ```
    Username: <copy>admin</copy>
    ```
    ```
    Password: **PASSWORD**
    ```
  
  	After you filled out the information, click _**Save**_.

  	![Oracle Analytics dashboard connection form](./images/Lab4-task1.5.png)

  	Your Oracle Analytics Instance is now connected to your MySQL Database Service powered by HeatWave.


## Task 2: Create your first dashboard


1. Let's now use this connection to create a very simple dashboard! From the top right corner click _**Create**_ and this time click on _**Data Set**_.

  	![Oracle Analytics dashboard creating data set](./images/Lab4-task2.1.png)

2. From the new window select the connection we just created **MySQL_Connection.**

  	![Oracle Analytics dashboard dataset connection](./images/Lab4-task2.2.png)

  	Click on the _**airportdb**_ database in the left side of the dashboard.

  	![Oracle Analytics dashboard dataset](./images/Lab4-task2.2-1.png)

  	> **Note:** As a general note, keep in mind that you can use the Undo/Redo buttons at the top right of the screen if you make any mistake in this section.

  	![undo button Oracle Analytics dashboard](./images/Lab4-task2.2-2.png)

3. Now, you will see all the database's tables and views. Select the view we created for this lab called **`view_analytics`** on the first step of the Analytics Lab. Drag and Drop that view to the main canvas of OAC dashboard.

  	![view analytics drag&drop Oracle Analytics dashboard](./images/Lab4-task2.3.png)

  	![Oracle Analytics dashboard view analytics](./images/Lab4-task2.3-1.png)

   	Save the Data Set by click on the disk icon on the top right corner of the page, Call it **`view_analytics`** and then click **OK**.

  	![Oracle Analytics dashboard save view](./images/Lab4-task2.3-2.png)

   To view the dataset click on the **`view_analytics`** tab at the bottom.

  	![view dataset Oracle Analytics dashboard](./images/Lab4-task2.3-3.png)

4. Now you can see the data that has been retrieved. From the _**Recommendations**_ column on the right we could use the suggestions to clean the data. We will leave this topic for another time but feel free to check **[Oracle's documentation](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acubi/data-enrichment-and-transformation-oracle-analytics.html)** on how to use this useful feature!

   	To move forward click on _**Create Project/Workbook**_  button on the top right corner. You will see the Visualisation screen where you can start building your dashboards! 
   
   	If **Create Project/Workbook** button is not activated, make sure you have saved the Data Set name as shown in the _Task 2.3_ .

  	![Oracle Analytics dashboard create project](./images/Lab4-task2.4.png)

5. From the left side of the dashboard, select the column **`passenger_id`**, and then while pressing CTRL (or Command if you are on Mac) click **`country`**, and right click and select _**Create Best Visualization**_.

  	![Oracle Analytics dashboard create best visualization](./images/Lab4-task2.5.png)

   	A Bar Chart will appear after few seconds and we will see the distribution of the passengers over countries. 

  	![Oracle Analytics dashboard create best visualization](./images/Lab4-task2.5-1.png)

   	As you can notice that the information is by country names, so a better way to visualize this data would be on a map. With OAC you can use maps without the need of complex geo-coding data, just out of the country names. Let's create that map.
   
   	Right-click on the visualization and go to **Edit--> Duplicate Visualization**.
   
  	![Oracle Analytics dashboard create best visualization](./images/Lab4-task2.5-2.png)

   	On the duplicated visual, click on **Visualization Type** and choose **Map**.

  	![Oracle Analytics dashboard create best visualization with map](./images/Lab4-task2.5-3.png)

  	![Oracle Analytics dashboard create best visualization with map](./images/Lab4-task2.5-4.png)

   	Our new map appears on the screen. Now let’s analyze the trend of prices by time. On the Explorer panel on the left, expand the column **`departure`** then click on **`Month of Year`**, hold CTRL and click on **`price`**. Right-click and choose _**Create Best Visualization**_.

  	![Oracle Analytics dashboard create best visualization query](./images/Lab4-task2.5-5.png)

  	![Oracle Analytics dashboard create best visualization query](./images/Lab4-task2.5-6.png)

  	A line chart will be created at the bottom. We see the historical trend and a drop in the latest year. It would be awesome to know if this drop was a one off, and the embedded Machine Learning within OAC can help you predict the future behavior. Right-click on the Line graphic and go to **Add Statistics --> Forecast**. 

  	![Oracle Analytics dashboard forcast pridiction](images/Lab4-task2.5-7.png)

   	The visual now shows the forecasted **`price`** based on the Machine Learning applied to the data from the MySQL database. 
   It looks like we will recover from this drop.

  	![recover pridiction Oracle Analytics dashboard best visualization](./images/Lab4-task2.5-8.png)

   	Finally, save the project/workbook by clicking on the Disk icon at the top right of the screen. Give it a name like **Departure Flights Revenue**.

  	![save Oracle Analytics dashboard best visualization](./images/Lab4-task2.5-9.png)

  	You can see the name of the Project/Workbook on the top left corner of the dashboard.

  	![save Oracle Analytics dashboard best visualization](./images/Lab4-task2.5-10.png)


6. You can also share your project/workbook by email or social media. Have a look at the possibilities.

   	Select the **Export** icon and select **File** or **Print**.

  	![export Oracle Analytics dashboard best visualization](./images/Lab4-task2.6.png)

   	You can choose to **Save** your project/workbook in a wide variety of standard formats such as PowerPoint (pptx), Acrobat (pdf), Image (png), Data (csv), Package (dva).  Also, you can choose which parts of your project/workbook to include, such as All Canvas, only the Active Canvas or the Active Visual. 

  	![save Oracle Analytics dashboard best visualization](./images/Lab4-task2.6-1.png)

   	The file will be downloaded locally on your machine.

  	![download Oracle Analytics dashboard best visualization](./images/Lab4-task2.6-2.png)

   	When you select **Print**, you can choose which parts of your project/workbook to include in the Printed output, such as All Canvas, only the Active Canvas or the Active Visual, etc.

  	![print Oracle Analytics dashboard best visualization](./images/Lab4-task2.6-3.png)


**Well done, Congratulations!** You now have all the tools to discover insights in your data!

[Recap](youtube:faYdjp-r__4)

## Learn More

- If you want to discover more on how to use Oracle Analytics Cloud check our **[Tutorials](https://docs.oracle.com/en/cloud/paas/analytics-cloud/tutorials.html)** and **[Live Labs!](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/livelabs-workshop-cards?p100_focus_area=28&me=117&clear=100&session=107258786260970)**


## Acknowledgements
  - **Author** - Rawan Aboukoura - Technology Product Strategy Manager, Vittorio Cioe - MySQL Solution Engineer
  - **Contributors** - Priscila Iruela - Technology Product Strategy Director, Victor Martin - Technology Product Strategy Manager
  - **Last Updated By/Date** - Anoosha Pilli, September 2021
