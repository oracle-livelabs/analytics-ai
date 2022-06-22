# Exercise 5: Adding more Datasets

## Scenario

“Wait a sec! I remember this Hotel. And I know we have a discount on it because I spent my last summer holidays there. I can save a good money to the company. I’m sure this is my ticket to a management position… well knowing my boss I might just get a kudos email if anything :-) ”

__SUMMARY__

In this exercise you will incorporate a new dataset to finalize your analysis. 

OAC provides a very easy way of joining different datasets to combine information from several sources. After that you will work on creating a calculation and finally arranging the results and personalizing the outcomes to end with a nice analysis that can be now share back.

Estimated Lab Time: 30 minutes

### Objectives

* Add additional data set
* Join different datasets
* Use calculations on your datasets

### Prerequisites
* User logged in to OAC and using canvas developed in previous lab.

## **Task 1**: Add additional data set

Download the file: [OAC_TD_Agreements.xlsx](https://objectstorage.us-ashburn-1.oraclecloud.com/p/jyHA4nclWcTaekNIdpKPq3u2gsLb00v_1mmRKDIuOEsp--D6GJWS_tMrqGmb85R2/n/c4u04/b/livelabsfiles/o/labfiles/OAC_TD_Agreements.xlsx)

To confirm that Hotel had already an agreement and the savings they have to claim to the hotel chain, you need to add that information from another excel with the list of vendor agreements.
1. Click on the plus icon at the top right of the Data menu and select “Add Data Set”

![](images/1_add_data_set.png " ")

You need to upload this new file.
2. Click “Create Data Set”

![](images/2_create_data_set.png " ")

3. Click on “Drop data file here or click to browse”

![](images/3_upload_file.png " ")

4. Search for the other excel file on your exercises folder by the name of “OAC_TD_Agreements.xlsx”
    Click “Open”

![](images/4_upload_file.png " ")


You see a preview of the data. Note that this file has the country column with ISO3 code. It is really good that we got the recommendation to add ISO3 code to the expenses one.
5. Change the Name of the dataset adding your initials at the end, to avoid clashing with other attendees, for instance: OAC_TD_Agreements_JAMP .Click on “Add”.


![](images/5_add_dataset.png " ")

## **Task 2**: Join different datasets

New Data Set gets uploaded to instance.
Navigate to previous tab in browser.

1. Click on the plus icon at the top right of the Data menu and select “Add Data Set”.

![](images/1_add_data_set.png " ")

2. Select OAC_TD_Agreements_ yourName.xlsx file from list. Click on Add to Project button.

![](images/6_select_data_set_agreements.png " ")

3. New Data set gets added to project. Navigate to Data tab.

![](images/6_navigate_data_tab.png " ")

4. Click on “Data Diagram” tab

![](images/6_add_data.png " ")

As files are not related you see them as isolated boxes on the canvas. You will define the join.
5. Hover over the imaginary line between the datasets and click on the 0 that will appear


![](images/7_dataset_connection.png " ")

On the pop-up menu, define the join.
6. Click on “Add Another Match”


![](images/8_add_match.png " ")

Join of these files are between “Provider Name” = “Vendor” and “Provider Country” = “Destination Country_ISO3” because a hotel chain might have the same name in different countries.
7. Click on the small down arrow to expand the list of columns of the first data set and Click “Provider Name”

![](images/9_select_provider_field.png " ")

8. Now click on the down arrow on the second dataset to expand the drop-down list.
   Click on “Vendor” Now you have defined a join between “Provider Name” and “Vendor”.

![](images/10_select_vendor_field.png " ")

9. Click Add Another Match button. Repeat the steps and select “Provider Country” and “Destination Country_iso3”.
You should have something like the screenshot. Then click OK.

![](images/11_submit_connection.png " ")

Once the join has been defined you can go back to the Visualize tab to continue your analysis.
10. Click on “Visualize” at the top center.

![](images/12_vizualise.png " ")

On the Data menu at the left you note that the new Data Set has been added.

11. Click on the arrow on the left to the data set to expand it.

![](images/13_explorer_data_set.png " ")

You want to compare the total Hotel Expenses with the amount that can be saved if the company claims the Hotel Chain to apply the agreement.
12. Click and Drag “Expenses Amount” to the top of the canvas. Check that a green bar appears at the top covering the whole canvas and not only a small part of it.

![](images/14_tile.png " ")



## **Task 3**: Use calculations on your datasets

To obtain the savings you need to calculate the expenses multiplied by the agreement discount (that has not been applied).
1. Select “My Calculations” and Right-click on it.Select “Add Calculation”

My calculations are at the bottom of the Data Pane, use the slider to find it if your screen resolution is too small and it is not appearing.

![](images/15_Add_Calculation.png " ")

On the pop-up window you can define the formula of the calculation using the editor.
2. Put the name “Savings” to the calculation. On the expression box start typing “Expense” and choose “Expense Amount” from the dropdown list.

![](images/16_savings_calculation.png " ")

3. Now type “*” (asterisk) to multiply the value and start typing and select “Agreement Discount”
    Your formula should look like the screenshot.
    Click on “Validate” to confirm everything is ok.
    Click on “Save”

![](images/17_validate_save.png " ")


4. Click and Drag the new calculation “Saving” to the top right part of the canvas.
Check that the vertical green bar only covers the “Expenses Amount” right border. This means the visual will be placed next to it.

![](images/18_drag_saving.png " ")

Great. Now you would like to make this more appealing so you will work on the look and feel.
5. On the properties box select the 2nd tab with the hash icon.

![](images/19_select_properties.png " ")

6. Look for the “Number Format” parameter and click on “Auto” . Select “Currency”

![](images/20_select_currency.png " ")

7. Look for the “Currency” parameter and click on the value “$”. Search for your currency in the list and select it.

![](images/21_euro.png " ")

8. Look for the “Abbreviate” parameter and click on the “Off” value to make it “On”.

![](images/22_abbreviate_off.png " ")

Repeat the steps for the “Expense Amount” tile (remember to first select the visual by clicking on it. Selected visual has a thin blue border).

![](images/23_tiles.png " ")

9. Click on the Map and Drag it to the right border of the canvas.

![](images/24_select_map.png " ")

10. Drop it when the green bar shows that Map will be placed next to the Horizontal Bar visual but not covering the whole right border.

![](images/25_drag_map.png " ")

11. Click on the Horizontal Bar visual and drag it to the bottom left, under the Line Chart

![](images/26_drag_bar_graph.png " ")

12. Drop it when the green bar shows that will be under the line chart but not the whole bottom line.

![](images/27_drop_bar_graph._bottom.png " ")

13. Click on the Savings visual to select it.

![](images/28_select_savings.png " ")

14. On the properties box, search for the “Background” parameter and click on “Auto” to switch to “Custom”.

![](images/29_background.png " ")

15. Under the new options of “Custom” search for the “Fill Color” parameter and click on the white box.
    Select a blue color (no need to be the same, but if you like you can copy the code on the hex box: #659aad)
    Click on OK to apply the changes.

![](images/30_fill_color.png " ")


16. On the properties box, search now for the “Value Font” parameter and click on “Auto”.
    On the pop-up click on the Font Color Icon and choose appropriate color from the available colors.

![](images/31_select_value_font_color.png " ")

Great. This is a nice dashboard now. You can save your work.
17. Click on “Save” at the top right corner.

![](images/32_save_project.png " ")

18. Put a name to your project. Click on “Save”

![](images/33_name_save.png " ")

**Well done!** You have completed all exercises. Now you are ready to show this info to your manager.

![](images/34_final_project.png " ")


## End of Exercise 5

## Acknowledgements

- **Author** - Mahira Galal, Aydin Heydari and Sushil Mule
- **Adapted by** -  Mahira Galal, Aydin Heydari, Alex Chiru
- **Last Updated By/Date** - Sushil Mule, August 2021