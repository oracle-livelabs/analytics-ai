# Exercise 5: Adding more Datasets

## Introduction

### Scenario

“Wait a sec! I remember this Hotel. And I know we have a discount on it because I spent my last summer holidays there. I can save a good money to the company. I’m sure this is my ticket to a management position… well knowing my boss I might just get a kudos email if anything :-) ”

**SUMMARY**

In this exercise you will incorporate a new dataset to finalize your analysis.

OAC provides a very easy way of joining different datasets to combine information from several sources. After that you will work on creating a calculation and finally arranging the results and personalizing the outcomes to end with a nice analysis that can be now share back.

Estimated Lab Time: 30 minutes

### Objectives

* Add additional data set
* Join different datasets
* Use calculations on your datasets

### Prerequisites

* User logged in to OAC and using canvas developed in previous lab.

## Task 1: Add additional data set

Download the file: [OAC_TD_Agreements.xlsx](https://objectstorage.us-ashburn-1.oraclecloud.com/p/4Au3jJ-t8Wtw3LWyYsDMqQk2FdlXDvXCb1MYRS0J6P4QS-GCrv2YNOolWdtFMLZq/n/c4u04/b/livelabsfiles/o/labfiles/OAC_TD_Agreements.xlsx)

To confirm that Hotel had already an agreement and the savings they have to claim to the hotel chain, you need to add that information from another excel with the list of vendor agreements.

1. Click on the plus icon at the top right of the Data menu and select “Add Data”

    ![Add Data from the workbook Data menu](images/1_add_data_set.png " ")

    You need to upload this new file.
2. Click “Create Data Set”. A new browser tab will open.

    ![Create another dataset for the workbook](images/2_create_data_set.png " ")

3. Click on “Drop data file here or click to browse”

    ![Browse for the additional data file](images/3_upload_file.png " ")

4. Search for the other excel file on your exercises folder by the name of “OAC_TD_Agreements.xlsx”
    Click “Open”

    ![Open the additional data file](images/4_upload_file.png " ")


    A pop-up window shows preview of the data.

    ![Preview the additional dataset](images/4a_upload_file.png " ")

    You see a preview of the data. Note that this file has the country column with ISO3 code. It is really good that we got the recommendation to add ISO3 code to the expenses one.

5. Click OK

    The Editor window for the new dataset appears. This time no changes are needed.

    ![Additional dataset in the data editor](images/4b_upload_file.png " ")

6. Click on the Save icon

7. Change the Name of the dataset adding your initials at the end, to avoid clashing with other attendees, for instance: OAC_TD_Agreements_IF

8. Click OK

    Dataset gets saved and ready. You can get back to the workbook.
9. Click on the previous browser tab. It should have the name you used to save the workbook.

![Return to the workbook to add the dataset](images/5_add_dataset.png " ")

The list of datasets gets updated and the new added one appears selected.

 1. Click “Add to Workbook”

![Add the new dataset to the workbook](images/5a_add_dataset.png " ")

## Task 2: Join different datasets

New Data set gets added to project. Navigate to Data tab.

![Open the workbook Data tab](images/6_navigate_data_tab.png " ")

1. “Data Diagram” tab will be active

    ![Datasets in the workbook Data Diagram](images/6_add_data.png " ")

    As files are not related you see them as isolated boxes on the canvas. You will define the join.
2. Hover over the imaginary line between the datasets and click on the 0 that will appear


    ![Open the connection between the datasets](images/7_dataset_connection.png " ")

    On the pop-up menu, define the join.
3. Click on “Add Another Match”


    ![Add another matching field for the dataset join](images/8_add_match.png " ")

    Join of these files are between “Provider Name” = “Vendor” and “Provider Country” = “Destination Country_ISO3” because a hotel chain might have the same name in different countries.
4. Click on the small down arrow to expand the list of columns of the first data set and Click “Provider Name”

    ![Select Provider Name as the first join field](images/9_select_provider_field.png " ")

5. Now click on the down arrow on the second dataset to expand the drop-down list.
    Click on “Vendor” Now you have defined a join between “Provider Name” and “Vendor”.

    ![Select Vendor as the matching join field](images/10_select_vendor_field.png " ")

6. Click Add Another Match button. Repeat the steps and select “Provider Country” and “Destination Country_iso3”.
    You should have something like the screenshot. Then click OK.

    ![Confirm the join between Provider Name and Vendor](images/11_submit_connection.png " ")

    Once the join has been defined you can go back to the Visualize tab to continue your analysis.
7. Click on “Visualize” at the top center.

    ![Open the workbook Visualize tab](images/12_visualize.png " ")

    On the Data menu at the left you note that the new Data Set has been added.

8. Click on the arrow on the left to the data set to expand it.

    ![Expand the dataset in the data explorer](images/13_explorer_data_set.png " ")

    You want to compare the total Hotel Expenses with the amount that can be saved if the company claims the Hotel Chain to apply the agreement.

9. Click and Drag “Expenses Amount” to the top of the canvas. Check that a green bar appears at the top covering the whole canvas and not only a small part of it.

![Add Expense Amount as a tile on the canvas](images/14_tile.png " ")


## Task 3: Use calculations on your datasets

To obtain the savings you need to calculate the expenses multiplied by the agreement discount (that has not been applied).

1. Select “My Calculations” and Right-click on it. Select “Add Calculation”

    My calculations are at the bottom of the explorer, use the slider to find it if your screen resolution is too small and it is not appearing.

    ![Add a calculation from My Calculations](images/15_add_calculation.png " ")

    On the pop-up window you can define the formula of the calculation using the editor.
2. Put the name “Savings” to the calculation. On the expression box start typing “Expense” and choose “Expense Amount” from the dropdown list.

    ![Define the Savings calculation](images/16_savings_calculation.png " ")

3. Now type “*” (asterisk) to multiply the value and start typing and select “Agreement Discount”
    Your formula should look like the screenshot.
    Click on “Validate” to confirm everything is ok.
    Click on “Save”

    ![Validate and save the Savings calculation](images/17_validate_save.png " ")


4. Click and Drag the new calculation “Savings” below the “Expense mount” tile.

    ![Add the Savings calculation to the canvas](images/18_drag_saving.png " ")

    Great. Now you would like to make this more appealing so you will work on the look and feel.

5. On the properties box select the 2nd tab with the hash icon.

    ![Open number properties for the Savings tile](images/19_select_properties.png " ")

6. Select the 2nd tab with the hash icon and look for the “Number Format” parameter and click on “Auto” . Select “Currency”

    ![Set the tile number format to Currency](images/20_select_currency.png " ")

7. Look for the “Currency” parameter and click on the value “$”. Search for your currency in the list and select it.

    ![Select the currency for the tile](images/21_euro.png " ")

8. Look for the “Abbreviate” parameter and click on the “Off” value to make it “On”.

    ![Enable abbreviated values on the tile](images/22_abbreviate_off.png " ")

    Repeat the steps for the “Expense Amount” tile (remember to first select the visual by clicking on it. Selected visual has a thin blue border).

    ![Expense Amount and Savings tiles with matching formats](images/23_tiles.png " ")

9. Click on “Savings” tile and drag it to the right of the “Expense Amount” tile.

    ![Select and move the Savings tile](images/23_1_select_savings.png " ")

10. The visualization will disappear and move. Drop it when you see the green bar close to the “Expense Amount” tile

    ![Position Savings next to the Expense Amount tile](images/23_2_drag_savings.png " ")

11. Click on the Savings visual to select it.

    ![Select the Savings visual for formatting](images/28_select_savings.png " ")

12. On the properties box, search for the “Background” parameter and click on “Auto” to switch to “Custom”.

    ![Set the Savings tile background to Custom](images/29_background.png " ")

13. Under the new options of “Custom” search for the “Fill Color” parameter and click on the white box.
    Select a green color (no need to be the same, but if you like you can copy the code on the hex box: #317a45)
    Click on OK to apply the changes.

    ![Apply a fill color to the Savings tile](images/30_fill_color.png " ")


14. On the properties box, search now for the “Value Font” parameter and click on “Auto”.

    ![Set a custom font color for the tile value](images/31_select_value_font_color.png " ")

15. On the pop-up click on the Font Color Icon and assign a white color, ie: #ffffff.

    ![Set the value font color to white](images/31__1_fill_color.png " ")


    Now our Workbook is ready to be shared.
    To make it even more easy for others to follow our discovery journey we can add comments to collaborate and better explain.

16. Click on the Notes drop-down arrow and select “Add Note”

    ![Add a note to the workbook](images/35_add_note.png " ")

17. A new note will appear on the center of the canvas.
    Add a text to the note, for example:
    “Porto City Center Hotel” is the outlier as its not applying the agreement discount
    Click outside the note to save it.

    ![Enter and save the note text](images/36_note_text.png " ")

18. Notes can be linked to datapoints to relate the information and explanations.

    Hover close to the note boundaries to see connection dots. Click on one of the dots and drag the line up to the top Scatter Plot point belonging to “Porto City Center”

    ![Link the note to the Porto City Center scatter point](images/37_link_note.png " ")

19. Notes can also be moved to other places in the canvas.
    To see how the resulting workbook will look, a preview option is provided.

    Click on the Play Icon

    ![Preview the completed workbook](images/38_preview_workbook.png " ")

20. Interactivity is still available in the Preview mode.

Click on the scatter point and see how related data is highlighted on all the visualizations. This clearly indicates that is the biggest outlier and expenses from this hotel are processed as out-of-policy.

![Select a scatter point to highlight related expenses](images/39_preview_mode.png " ")


**Well done!** You have completed all exercises. Now you are ready to show this info to your manager.

![Completed expense analysis workbook](images/40_final_project.png " ")


## End of Exercise 5

## Acknowledgements

* **Author** - Mahira Galal, Aydin Heydari, Sushil Mule and Ionut Forlafu
* **Adapted by** -  Mahira Galal, Aydin Heydari, Alex Chiru
* **Last Updated By/Date** - Ionut Forlafu, March 2023
