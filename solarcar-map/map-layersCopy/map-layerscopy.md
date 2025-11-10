# Build Australia route race map: Add layers and background

## Introduction

In this exercise, you will generate a map of Australia and apply a background color. You will then add multiple layers to the map, including the route, speed, labels, and the car’s live location.

_Estimated Time:_ 30 minutes

### Objectives

In this lab, you will:

- Generate a map of Australia and give it a color
- Add multiple layers to the map
- Add color background

### Prerequisites

This lab assumes you have:

- An Oracle Free Tier, Always Free, Paid or Live Labs Cloud Account
- Provisioned Oracle Analytics Cloud
- All previous labs successfully completed

## Task 1: Import the data sets created in lab 2

1. Go to Create and select workbook. Once workbook is selected , a dialogue box  titled 'Add Data' will appear—click Cancel.

    ![Create workbook](./images/51-createworkbook.jpg)

2. Add the data sets created in lab 2, using the '+' icon. Use the Add Data to upload the two data sets (route, live location) one by one in this workbook

    ![Drag data file](./images/52-add-both-data.png)

3. The data pane looks like this when the data sets get uploaded

    ![Data Pane](./images/53-the-data-pane.png)

## Task 2: Create Australia map and add color to it

1. Expand the live location dataset and double click Country

    ![expand_live_location](./images/54.1expandlivedataset.png)

2. From the visualization pane, change the viz type to Map

    ![map](./images/54.2select_map_viz.png)

3. Select the properties panel

    ![properties_panel](./images/54.3proerties_panel.png)

4. Go to Layers and then change the Map Layer to world countries and color to #fbcb05

    ![Map_color](./images/55-map-change-layer-and-add-color.jpg)

    You have now created a map of Australia and applied color to it.
    Next we will layer it with speed, route and add labels.

## Task 3: Add layers to the map

1. Return to the grammar pane

    ![return_to_grammar](./images/54.4retrun_to_grammar_pane.png)

2. Add a new layer to the map by selecting the three dots. Select add Data Layer

    ![Add data layer](./images/56-add-layer-2-to-map.jpg)

3. Expand the route dataset and drag Route WKT column in the category and expand the speed dataset and add Avg vehicle velocity to Color.

    ![add route and speed](./images/57-add-route-and-speed-to-layer-2.jpg)
Notice that the Route WKT is marked with a globe icon, indicating that it is a geometry data type supported by OAC.

4. Go to properties and then Layers. Expand Route WKT.

    ![properties_again](./images/56.1properties_again.png)

5. For the Name, select Auto and then choose Custom option.

    ![add route](./images/56.2change_name.png)

6. Rename the layer to Route

    ![rename layer](./images/58-rename-the-layer.jpg)

7. Change color of the race track by right clicking any point on the race track. Select Color and then Manage Assignments

    ![add route](./images/56.3color_route.png)

8. Once the pop up window appears, enter the color #0b4574

    ![add route color](./images/56.4changecolorofroute2.png)

9. Return to Grammar pane and add another layer by selecting the three dots

    ![add layer 3](./images/59-add-layer-3.jpg)

10. From the route dataset, select both Start Latitude and Start Longitude and drag to Category and drag Segment name in to Tooltip

    ![segment name](./images/segmentcontrolstops.png)

11. Go to the properties and then to layers. Expand this new layer and change name to Segment Name , color it black and set outline to custom and set Size to 8, set data labels position to right and set Columns to SEGMENT NAME

    ![add layer 3 properties](./images/60-add-segment.jpg)

12. Go back to grammar and add layer 4 to the map

    ![add layer 4](./images/61-add-layer-4.jpg)

13. Expand the live location data set. Select latitude and longitude and drag to category and driver to shape. Then click the arrow in the shape section.

    ![add layer 4 attributes](./images/62-add-elements-to-layer4.jpg)

14. Select the custom shapes and change the shape to down triangle

    ![add shape to layer 4](./images/63-custom-shape-of-car.jpg)

15. Go to properties and rename this layer to live race position, change color to #fbcb05, change outline to custom, outline color to black and size to 18

    ![add shape to layer 4](./images/64-live-race-properties-add.jpg)

## Task 4: Add color background

1. Right click canvas tab at the bottom of the workbook and go to canvas properties

    ![add color background](./images/65-canvas-properties-for-background.jpg)

2. Select the custom option for the background and change the color as #0b4574. Click ok

    ![change color to blue](./images/66_change_background_to_blue.jpg)

    Your visualization should look like this.

    ![final map](./images/final-map.jpg)

Congratulations on completing this workshop!

## **Acknowledgements**

- **Author** - Anita Gupta (Oracle Analytics Product Strategy)
- **Contributors** - Gautam Pisharam (Oracle Analytics Product Management)
- **Last Updated By/Date** - Anita Gupta, November 2025
