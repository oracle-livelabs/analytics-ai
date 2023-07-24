# Construct the Dashboard

## Introduction

In this lab you will construct visualizations and build a dashboard.

Estimated Time: 20 minutes

### Objectives

In this lab, you will:
* Construct visualizations
* Build a dashboard

### Prerequisites (Optional)

This lab assumes you have:
* An Oracle Cloud account
* All previous labs successfully completed


## Task 1: Add a Column to the Data Layer 
Visualizations allow us to tell a story with the data that will resonate and stay with the end user. This creates a lasting impact beyond the capabilities of the data alone. In this section you will create a map and bar chart from the data. Together, these visuals will illustrate the data's contextual narrative. Since the data does not include a count of Penalties Scored, we will have to add it manually in the data layer. 

1. Select 'Data' at the top of the page. 

	![Click on Data](images/data-layer1.png)

2. Click the pencil icon on the dataset to edit the data. This will open the data in a new tab.

  ![Click on the pencil icon](images/data-layer2.png)

3. On the left side of the window (next to the search bar) click the **+** icon. 

  ![Select the plus icon to create a new column](images/data-layer3.png) 

5. Clicking the **+** will open an edit panel to create a new column. We will name this column *Penalties Scored*. Since the data only includes successful penalties, this will be treated like a row count and in the value box. Just type "1" and click Validate and then and Add Step".

  ![Edit and validate the new column](images/data-layer4.png)

6. In the bottom left of the window change the Penalties Scored column to be treated as a measure. 

  ![Change the penalties scored column to a measure](images/data-layer5.png)

7. Save the data layer and return to the workbook tab. Click on Visualize in the top center of the window. After you save the data layer the workbook will automatically refresh to include the new data. 

## Task 2: Create a Bar Chart

1. Select PL Name, Penalties Scored, and TEAM and drag them to the left of the table on the workbook. You will see a green bar indicating that a new visualization is being added. 

  ![Drag the selected data to a new visualization](images/create-barchart1.png)

2. The visualization automatically populated as a bar chart. You will need to change it to a horizontal stacked bar chart. 

  ![Change the visualization type](images/create-barchart2.png)

3. Add Match Date and Description to the Detail of the bar chart. This will change each bar into individual blocks representing each match. 

  ![Add the selected data to detail](images/create-barchart3.png)

4. Sort the bar chart by the number of penalties scored from High to Low. To do this, click on the 3 dot menu icon in the top right of the visualization, select sort by, select penalties scored, and finally click high to low 

  ![Sort the bar chart](images/create-barchart4.png)

5. At this point, your canvas should look like this:

  ![Your canvas should look like this](images/create-barchart5.png)

## Task 3: Assemble the map

1. Select the table visualization and change the visualization type to a **Map**. 

  ![Change visualization type](images/create-map1.png)

2. Move MapLat and MapLon from Shape to Category (Location). 

  ![Move MapLat and MapLon](images/create-map2.png)

3. Select Properties and the Map tab and change the Background Map to the name of the background map layer that you previously uploaded. It should  be named pl-goalmouth.

  ![Set the custom map background layer](images/create-map3.png)

4. Add Description and Team to the map. 

  ![Add Description and Team to the map](images/create-map6.png)

5. At this point, your map should look like this.

  ![Your map should look like this](images/create-map4.png)

6. Your canvas should look like this.
  
  ![Your canvas should look like this](images/create-map5.png)

## Task 4: Add filters

1. Filters add interactivity and the ability to see a clearer picture of a specific portion of the data. Begin by adding **Team** to the filter bar at the top of the canvas. 

  ![Add Team to the filter bar](images/add-filter1.png)

2. Now, click the 3 dot menu in the top right corner of the bar chart. From here, click **Use as Filter** 

  ![Select Use as Filter on the bar chart](images/add-filter2.png)

3. Let's take a look at all penalty goals scored during away games. To do this, click on the Team filter and select **Away**.  

  ![Select Away from the Team filter](images/add-filter3.png)

Now, imagine you are a broadcaster and you're researching for upcoming matches and want to discuss players who have scored more than two penalty goals during away games this season. By clicking on the top player name on the bar chart and then while holding ctrl on your keyboard click to multi-select the next two player names. The penalty goals represented by these players will become highlighted on the map.  

  ![Multi-select the top three players](images/add-filter4.png)

4. Bring the canvas back to showing all of the data. To do this you can click any blank space within the bar chart and then click on the selected value in the team filter (at the top of the page) to remove the selections. 

7. Explore the data by experiencing different filter options. Observe the changes to the goal map. 

## Task 5: (Optional) Customize your Dashboard 

1. Start by selecting the bar chart. Click on the properties tab and change the title to "Penalties Scored by Player"

  ![Change the Bar Chart title](images/customize1.png)

2. Now change the axis from PL NAME to Player Name. Navigate to the Axis tab in Properties and change the Label axis from Auto to Custom. 

  ![Change the Label Axis title](images/customize2.png)

3. Now following the above steps change the Title of the Map to Penalty Map and remove the legend. 

  ![Change the Label Axis title](images/customize3.png)

4. At this stage, your canvas should look like this:

  ![Final canvas](images/customize4.png)

Congratulations on completing this workshop! 


## Acknowledgements
* **Author** - Andres Quintana, Senior Product Manager, Analytics Product Strategy
* **Contributors** -  Carrie Nielsen, Analytics Product Strategy
* **Last Updated By/Date** - Quintana, July 2023
