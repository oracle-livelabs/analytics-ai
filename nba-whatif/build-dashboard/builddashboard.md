# Build the Dashboard

## Introduction

The data visualization endeavor is invaluable. The tools and mechanisms available in Oracle Analytics Cloud allow for users to tell data stories with clarity and deep insights. This lab will walk through the steps to construct a dashboard which will facilitate the what-if analysis of this data. 

Estimated Time: 20 minutes

### Objectives

In this lab, you will:
* Use Oracle Analytics Cloud to build a dashboard 
* Begin to see the relationships in the data 

### Prerequisites 

This lab assumes you have:
* An Oracle Cloud account


## Task 1: Establish the Filters

1. Select the Filter Elements. Ctrl + Click to select Season, Game Date, and Home Team Name 

2. Drag the selection to the filter bar. 

	![Drag to add filters](images/dashboard1.png)

3. Modify the Filters. Hover the mouse over Game Date in the filter bar. Click the 3 dots. Select “Filter Type” and change selection to **List** 

  ![Modify the Filter](images/dashboard2.png)

4. Set the Filters: Change Season to 2020, Select Golden State Warriors in Home Team Name. In the Game Date filter, select 05/21/2021

## Task 2: Build the Table 

1. Build the Table. CTRL click to select:
    - Home Team Name 
    - Home Team Score 
    - Visitor Team Score
    - 3-point Pct
    - 3-point attempt 
    - 3-point Made 
    - 3-Point Missed 
    - 3-Point Potential 
    - 2-Point Pct
    - 2-point attempt 
    - 2-point Made 
    - 2-point missed
    - 2-point potential 

2. Drag the selections to the visualizations pane and select “Table” as Visualization type 

  ![Build the table](images/dashboard3.png)

3. Modify the Table. With the table selected, navigate to the bottom left of the page to the Gear shaped “General” icon 

4. Click on “Auto” next to “Title”, select “Custom” and change the title to “Home Team In-Game Stats”

  ![Change the Title](images/dashboard6.png)

## Task 3: Add Bar Charts 

1. Develop Bar Charts. CTRL click to select: 
    - 3-Point Missed
    - 3-Point Potential 
    - Player Name 

2. Drag to visualization pane above the table 

3. A green bar will appear indicating that a new visualization is being created 

  ![Green bar indicating a new visualization](images/dashboard4.png)

4. Change visualization type to Horizontal Bar 

5. 3-Point Missed and 3-Point Potential should be in the Values (X-Axis) and Player Name should be in the Category (Y-Axis)

6. Select and Move the following to Tooltips
    - 3-point Pct
    - 2-point Pct
    - 3-point Potential 
    - 2-point Potential 

7. Complete the 2nd Bar Chart. Repeat the step 1 process in a second Horizontal Bar with 
    - 2-Point Missed
    -	2-Point Potential 
    - Player Name 

## Task 4: Add a Tile

1. Add a Tile. Select and drag Potential Home Team Score to the visualization pane to create a til. 
  
2. With the tile selected navigate to the bottom left corner of the screen and click on the numeric symbol “#” 

3. Click on “Auto” next to Number Format 

4. Select “Number”

5. Scroll to “Decimal Places” 

6. Change “2” to “O”

  ![Change number format](images/dashboard5.png)

7. Establish Conditional Formatting. Right click on the tile and select “Conditional “Formatting”

  ![Create a conditional formatting rule](images/conditionalformat1.png)

8. Select “New Rule” and create a rule that changes the color of the tile to: Gold - # FFC72C when Potential Home Team Score > Visitor Team Score 

9. Click Save

  ![Save the conditional formatting rule](images/conditionalformat2.png)

## Task 5: Set Filter Controls

1. Establish Filter Controls on the Dashboard 

2. Select and Drag 3-point Potential and 2-point Potential to the visualization pane 

3. Select “filter controls” as the visualization type. 

  ![Your Dashboard](images/dashboard7.png)

This concludes the Build a Dashboard lab. You may proceed to the next lab.

## Acknowledgements
* **Author** - <Andres Quintana, Senior Product Manager, Analytics Product Strategy>
* **Contributors** -  <Carrie Nielsen, Senior Director, Analytics Product Strategy>
                   -  <Luke Wheless, Data Analyst BI-SCF>
* **Last Updated By/Date** - <Andres Quintana, October 2022>
