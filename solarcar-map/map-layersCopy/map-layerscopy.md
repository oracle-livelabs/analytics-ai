# Build Australia route race map: Add layers and background

## Introduction

In this exercise, you will generate a map of Australia and apply a background color. You will then add multiple layers to the map, including the route, speed, labels, and the car’s live location.

_Estimated Time:_ 30 minutes

### Objectives

In this lab, you will:

- Generate a map of Australia and give it a color
- Add multiple layers to the map
- Add layers to the map
- Add color background

### Prerequisites

This lab assumes you have:

- An Oracle Free Tier, Always Free, Paid or Live Labs Cloud Account
- Provisioned Oracle Analytics Cloud
- All previous labs successfully completed

## Task 1: Import the data sets created in lab 2

1. Go to Create and select workbook (**Create**)

    ![Create workbook](./images/51-CreateWorkbook.jpg)

2. Import the data sets created in lab 3 , using the + icon . **Use the Add Data to upload the data sets one by one in this workbook**

    ![Drag data file](./images/52-Add-both-data.png)

3. The data pane looks like this when the data sets get uploaded.

    ![Data Pane](./images/53-The-data-pane-should-look-like-this.png)

## Task 2: Create Australia map and add map color to it

1. Double Click Country column from live locations data set and change viz to maps

    ![map](./images/54-Add-country-and-change-viz-to-maps.jpg)

2. Select the Map layer and change it to world countries and change color to #fbcb05

    ![Map color](./images/55-Map-change-layer-and-add-color.jpg)

    You have now created a map of Australia and applied color to it.
    Next we will layer it with speed, route and add labels.

## Task 3: Add layers to the map

1. Add a new layer to the map by selecting the three dots. Select add Data Layer

    ![Add data layer](./images/56-Add-Layer-2-to-Map.jpg)

2. Add Route_WKT column in the category and Avg_vehicle_velocity to the Color section

    ![add route and speed](./images/57-Add-Route-and-Speed-to-layer-2.jpg)

3. Go to Layers and rename the layer to Route and change color to #0b4574

    ![add route](./images/58-Add-color-to-Layer-2-and-rename-layer-2-as-route.jpg)

4. Add another layer by selecting the three dots

    ![add layer 3](./images/59-Add-layer-3.jpg)

5. Add Segment name in the Category

    ![segment name](./images/59.1-Add-Segment-name-to-Layer-3.jpg)

6. Go to the layers and change the name to Segment Name , color to Black and outline to custom size of 8, change the data labels option to  right and set columns to SEGMENT_NAME

    ![add layer 3 properties](./images/60-Add-layer-3-Properties.jpg)

7. Add layer 4 to the map

    ![add layer 4](./images/61-Add-Layer-4.jpg)

8. Add latitude and longitude to layer 4

    ![add layer 4 attributes](./images/62-Add-elements-to-Layer4.jpg)

9. In the shape section, select the down arrow to reset the custom shapes and change the shape to down triangle

    ![add shape to layer 4](./images/63-Custom-shape-of-Car.jpg)

10. Go to layers and rename this layer to live race position, change color to #fbcb05, change outline to custom and size it to 18

    ![add shape to layer 4](./images/64-Live-Race-properties-add.jpg)

## Task 4: Add color background

1. Go to canvas properties.

    ![add color background](./images/65-Canvas-Properties-for-background.jpg)

2. Select the custom option for the background and change the color as #0b4574

    ![change color to blue](./images/66_Change_background_to_blue.jpg)

    Your visualization should look like this.

    ![final map](./images/Final-Map.jpg)

Congratulations on completing this workshop!

## **Acknowledgements**

- **Author** - Anita Gupta (Oracle Analytics Product Strategy)
- **Contributors** - Gautam Pisharam (Oracle Analytics Product Management)
- **Last Updated By/Date** -