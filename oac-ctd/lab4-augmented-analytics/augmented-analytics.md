# Exercise 4: Augmented Analytics

## Scenario

“More important than knowing why we had an error is to know if we will have it again. Same way, knowing who overspent is not our only goal. Although would be good to know if the culpable was by any chance the same guy that get you into this… for no special reason, of course.”

__SUMMARY__

In this exercise you will experiment how easy and dynamic is to create your own analysis. Augmented capabilities like System map layers and forecasting will be used.

Estimated Lab Time: 30 minutes

### Objectives

* Working with maps
* Apply one-click forecast
* Exploring all the filtering options

### Prerequisites
* User logged in to OAC and using canvas developed in previous lab.

## **Task 1**: Working with maps 


You are back to Canvas1. The results from previous exercise gives you the topics to analyze deeper.
You want to start by adding detail information of cities to your current map.

![](images/1_canvas_home_page.png " ")

You can combine several layers of information in a map. Create a new one for the city info.
1. Click on the Hamburger icon on the top right of the Layer menu . Select “Add Layer”.

![](images/2_Add_Layer.png " ")


A new layer by the name of “Layer 2” is created. You can change the name and edit its properties. But for this excercise purpose it is enough as it is.
You add the city to the map.

2. Click and Drag “Destination City” to the Category (Location). A small green plus icon appear informing that it will be added.

![](images/3_destination_city.png " ")

Location of the destination cities appear on the map. You now want to add the Expense information to see how much was spent by city.

3. Select and Drag “Expense Amount” to “Size” The size of the bubble represents the amount spent on each city.


![](images/4_expense_account.png " ")


## **Task 2**: Apply one-click forecast

Now you want to see the overall trend of expenses by date.

1. Hold control key of your keyboard (Ctrl) and Click on “Date”
   Keep Ctrl hold and now click on “Expense Amount”
   Right click and choose “Create Best Visualization”

![](images/5_expenseamount_date_viz.png " ")


This will create a new analysis using the best type of visualization for the information selected. In this case a Line Chart.
Line chart will appear next to Map visualization, you can drag Line chart below map visualization.

This graphic shows that there was an increase in expenses in the past few months.
Now you want to see the prediction of Expenses for the future using Machine Learning.

2. Right-click on the line chart (on any empty space) and select “Add Statistics”
   Select “Forecast”

![](images/6_forecast.png " ")


You get a prediction for the next 3 periods (months). And you see that
The tool allows you to choose from different Forecast Algorithms.
On the properties menu at the top left (near the Filter bar) you can configure more aspects of the visual.

3. Click on the “Analytics” icon on the properties menu (most right icon)
    Under “Method” click on “Seasonal ARIMA” and choose “ARIMA” (company expenses are not seasonal, so makes more sense to use normal ARIMA model)

Note that the forecast changes as now is using ARIMA method.

![](images/7_Arima.png " ")

## **Task 3**: Exploring all the filtering options

Prediction is adjusted but still bad. You want to focus now on Hotel expenses.
1. Select “Expense Type” and drag it to the Filter Bar at the top

![](images/8_filter.png " ")

2. Find “Hotel” and click on it

![](images/9_select_hotel.png " ")


All visuals on the canvas get filtered to “Hotel”
You clearly see that the city with higher hotel expenses was Porto (you can hover the bigger bubble to see the detailed pop-up)
On the graph below, the increase trend of expenses for hotels is still there.
A solid proof that Hotels is one of the root issues here.

![](images/10_porto.png " ")

To confirm your analysis, you want to check if expenses were out of policy.
3. Click on the Grammer tab, select “In Policy” and drag it to “Color”

![](images/11_inPolicy_color.png " ")

Out of policy expenses in hotels had a peak around July. You wonder which hotels are causing this.

4. Hold control key of your keyboard (Ctrl) and Click on “Vendor”
   Keep Ctrl hold and now click on “Expense Amount”
   Right click and choose “Pick Visualization”

![](images/12_vendor_expense_selection.png " ")

A wide variety of visualization are available to you.

5. Click on the “Horizontal Bar” Visualization

![](images/13_horizontal_bar.png " ")

The list of Hotel vendors appears. Now you need to filter it to Porto and to find the related ones.

6. Click “Destination City” and drag it to “Filters”. Please note this filter is specific to visualization and not to entire canvas.

![](images/14_destination_city_filter.png " ")


7. On the filters menu find and choose “Porto”. You can use the search box at the top to short the list of options.

![](images/15_select_porto_city.png " ")


You see only 3 hotels in Porto. You want to see if our company already has an agreement with them or they are out of policy.

8. Select and Drag “In-Policy” to Color

![](images/16_inPolicy_color.png " ")


Great. Now you know that overspending issue was due to Hotel bookings in Porto in the “Porto City Center” hotel by Sales Department (remember Sales department
was highlighted by the Explain).

Someone could say you have finish, but you are a professional that looks for outstanding results.
You try to walk the extra mile in the next exercise.
But before, let’s save our work.
1.	Click on the Save Icon.

![](images/17_root_cause_final.png " ")

2.	Give it a name, ie: OAC\_TD\_Analysis\_IF
3.	Click Save

![](images/18_save_project.png " ")

## End of Exercise 4

## Acknowledgements

- **Author** - Mahira Galal, Aydin Heydari, Sushil Mule and Ionut Forlafu
- **Adapted by** -  Mahira Galal, Aydin Heydari, Alex Chiru
- **Last Updated By/Date** - Ionut Forlafu, March 2023