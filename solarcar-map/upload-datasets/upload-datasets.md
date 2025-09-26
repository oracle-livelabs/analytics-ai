# Upload the csv file in OAC as datasets

## Introduction

In this lab, you will **upload the csv files** required to create the map provided in the resources section. First, we will upload the live race csv file and save it. Next, we will create another dataset by integrating two csv files (route and speed) into OAC using an inner join to produce a combined dataset.

_Estimated Time:_ 10 minutes

### Objectives

In this lab, you will:

- Upload the csv files in OAC as datasets

### Prerequisites

This lab assumes you have:

- An Oracle Free Tier, Always Free, Paid or Live Labs Cloud Account
- Provisioned Oracle Analytics Cloud
- All previous labs successfully completed
- All three csv files provided in the resources have been downloaded

## Task 1: Upload the live location csv file

1. Go to Create and select Dataset (**Create**)

    ![Select the create icon](./images/1%20Create%20Dataset.jpg)

2. A dialog box will open. Select the option Drag data file, then choose the live location csv file from your computer. **Drag data file here or click to browse**

    ![Drag data file](./images/2.%20Drag%20Data%20set%20.jpg)

3. Once the live location data loads, click **OK**

    ![Select "OK"](./images/3%20Upload%20Click%20OK.jpg)

4. Go to the live location tab, select the columns Latitude and Longitude, and change their data type to Attribute.

    ![Data Type change](./images/4%20Change%20Data%20Type%20to%20Attribute.jpg)

5. Save the file and name it live location. Your live location file is now ready.

    ![live location file](./images/5%20Save%20the%20file.jpg)

## Task 2: Upload the route and speed csv files as one joint file

1. Go to Create and select Dataset (**Create**)

    ![Select the create icon](./images/1%20Create%20Dataset.jpg)

2. A dialog box will open. Select the option drag data file, then choose the route csv file from your computer. **Drag data file here or click to browse**

    ![Drag data file](./images/2.%20Drag%20Data%20set%20.jpg)

3. Once the route data loads, click **OK**. Note that RouteWKT is geometry data type column. You can read this geometry data by creating a calculation using GeometryAsText(RouteWKT). Steps 4 to 7 are provided to demonstrate how to read this geometry data. This is optional, and you may go directly to Step 7 if you prefer to skip it.

    ![Select "OK"](./images/2%20Upload%20joint%20excel%20file/3%20Select%20the%20route%20data%20set%20and%20name%20it%20route.png)

4. Create a calculation to read the geometry data type

  ![Create a calculation](./images/2%20Upload%20joint%20excel%20file/Create%20Calculation.png)
5. A dialogue box will open, select the GeometryAsText function

  ![GeomTextFunction](./images/2%20Upload%20joint%20excel%20file/GeomText%20Function.png)
6. Double click the GeometryAsText Function and add the route_wkt column in the formula and give the calculation a name as geometry and save.

  ![calculation](./images/2%20Upload%20joint%20excel%20file/write%20formula.png)
7. Open a new canvas and double click the calculated column, geometry. We observe that the data is in linestring format.

  ![Linestring_format_check](./images/2%20Upload%20joint%20excel%20file/linestring_format_check.png)

This demonstrates that GeometryAsText() enables reading geometry data types, indicating whether the data is a point, linestring, or polygon. In this case, the data type is a linestring.
8. Open the route data tab and go to **meta data icon**

    ![metadata](./images/2%20Upload%20joint%20excel%20file/4%20Select%20the%20route%20and%20go%20to%20meta%20data.png)

9. Change all columns to Attribute (they should not be numerical)

    ![Change data type](./images/2%20Upload%20joint%20excel%20file/5%20Select%20all%20the%20highlighted%20columns%20and%20change%20the%20property%20to%20Attribute%20from%20numeric.gif)

10. Go back to the Join Diagram tab and, at the top of the page, select the **+** button and Add File

    ![Add data](./images/2%20Upload%20joint%20excel%20file/6%20Go%20back%20to%20join%20diagram%20tab%20and%20add%20File%20.jpg)

11. Select the csv file speed from your computer. Once the speed file populates, click **OK**

    ![import data](./images/2%20Upload%20joint%20excel%20file/7%20Add%20speed%20file%20and%20click%20ok.png)

12. Open the speed tab and change the highlighted column Segment ID to Attribute.

    ![Change data type](./images/2%20Upload%20joint%20excel%20file/8%20Speed%20Tab%20and%20change%20the%20data%20type.jpg)

13. Go to the Join Diagram tab and create an inner join by selecting Segment from route data and Segment ID from speed data.

    ![Inner join](./images/2%20Upload%20joint%20excel%20file/9%20Inner%20Join.gif)

14. Save this file as route.

    ![save](./images/2%20Upload%20joint%20excel%20file/10%20Save%20the%20file.jpg)

You have now loaded the csv files as **datasets** into OAC.
Next we will build the map and add layers to it.

Congratulations on completing this lab!

You may now _proceed to the next lab_.

## **Acknowledgements**

- **Author** - Anita Gupta (Oracle Analytics Product Strategy)
- **Contributors** - Gautam Pisharam (Oracle Analytics Product Management)
