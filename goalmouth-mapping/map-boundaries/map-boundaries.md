# Establish Map Boundaries

## Introduction

In this lab you will explore the data to establish the upper and lower limits of the latitude and longitude values in order to create the map boundaries. You will also upload the background map image. 

Estimated Time: 30 minutes

### Objectives

In this lab, you will:
* Use the data to build a table 
* Use the table to establish the upper and lower limits of the latitude and longitude values
* Upload the background map image

### Prerequisites

This lab assumes you have:
* An Oracle Cloud account
* All previous labs successfully completed
* Permission to create Datasets in Oracle Analytics Cloud (OAC)
* Access to the Console of OAC

## Task 1: Create a table.
Creating a table from the latitude and longitude data will allow you to explore the upper and lower limits of the values. This step is important because these limits will allow you to accurately define the map boundaries. 

1. In your Oracle Analytics Cloud workbook, select Match Date, PL Name, MapLat, and MapLon from the data and drag them into the visualizations pane. This will automatically return a table. 

	![Create a table with the data](images/create-table1.png)

2. Hovering your mouse over the **MapLat** column header will reveal sorting arrows. Click on the up arrow to sort from lowest to highest, and the down arrow to sort from highest to lowest. These are the upper and lower limits for Latitude. 

  ![Use the arrows to sort the column](images/create-table2.png)

3. Repeat the above step for the **MapLon** column to find the upper and lower limits for the Longitude column. 

4. The data limits are reflected in the table below. 

  ![The upper and lower limits of the coordinates](images/table-output1.png)
  
5. Click the save icon in the upper right corner of the page to save your workbook. Save it as goalmouth-lab.

  ![Click to save the workbook](images/create-table3.png)

  ![Name the workbook](images/save-workbook1.png)

## Task 2: Upload the map image.

1. Download the attached image that will be used for the background map layer. 

  [Goalmouth Map](files/pl-goalmouth.png)

2. With the workbook saved, use the back arrow at the top left of the workbook page to navigate back to the Oracle Analytics Cloud home page. 

  ![Use the back arrow](images/map-navigate1.png)

3. Select the 'hamburger' menu in the top left of the page and navigate to **Console**.

  ![Use the hamburger menu and select console](images/map-navigate2.png)

4. In the Console select **Maps**. 

	![Select maps](images/map-navigate3.png)

5. Click on Backgrounds to navigate to the backgrounds tab. 

  ![Navigate to the backgrounds tab](images/map-navigate4.png)

6. Click on **Image Backgrounds** and select the **+** icon to upload the attached background image from Step 1. 

  ![Click to upload the background map image](images/map-navigate5.png)

7. Browse to your downloaded file.

  ![Upload the file](images/map-navigate6.png)

8. In the map image edit window, select the drop-down menu next to **Coordinates** and change the selection from Auto to Custom (Lat, Long).

  ![Select Custom Lat, Long](images/map-navigate7.png)

9. Knowing our upper and lower latitude and longitude limits allows us to establish a frame. Use the below coordinates to standardize your map image. 

  ![The standardized coordinates](images/table-output2.png)

We use standardized coordinates to account for the image layer. This ensures that the points representing the penalty goals are placed inside of the goal posts and above the goal line. 

  ![Plug in the standardized coordinates](images/map-navigate8.png)

10. Save and Close the Image Background dialog box. 

  ![Save and close the dialog box](images/map-navigate9.png)

11. Navigate back to your workbook. Your canvas should look like this: You will see the table created to establish the upper and lower limits of the geographic coordinates. 

  ![Your canvas should look like this](images/canvas-status1.png)


This concludes the Map Boundaries lab. You may proceed to the next lab.


## Acknowledgements
* **Author** - Andres Quintana, Senior Product Manager, Analytics Product Strategy
* **Contributors** -  Carrie Nielsen, Analytics Product Strategy
* **Last Updated By/Date** - Quintana, July 2023
