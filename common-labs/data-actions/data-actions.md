# Data Actions

## Introduction

In this lab, you will build two simple canvases and learn how to create data actions to pass values between different canvases in a workbook.

  ![Data actions overview](images/data-actions-overview.png)

Estimated Time: 20 minutes

### Objectives

In this lab, you will:
* Create two visualization canvases
* Create a data action

### Prerequisites

This lab assumes you have:
* Access to Oracle Analytics Cloud
* [Sample Order Lines DS](https://objectstorage.us-ashburn-1.oraclecloud.com/p/J6wePlhCmLfKoZRTdaMTEKerOCkYrnN3cPd4-g899hTOureVn6tHRZ048xjb4tTv/n/idtlyhmtj68r/b/LiveLabFiles/o/Sample Order Lines DS.xlsx) dataset


## Task 1: Prepare Basic Visualization Canvases
In this section, we will create two canvases with simple visualizations to help us understand how data actions work. The two canvases will be the source canvas and the target canvas.

1. Add a new canvas by clicking the **Add Canvas** button.

  ![Add canvas](images/add-canvas.png)

2. CTRL+click **Customer Segment**, **Product Category**, and **Sales**. Right-click and choose **Pick Visualization...**

  ![Pick visualization](images/right-click-pick-viz.png =300x*)

3. Select the **Pivot** table.

  ![Select pivot table](images/pivot.png =300x*)

4. For the next visualization, CTRL+click **Product Category**, **Profit**, and **Sales**. Right-click and select **Pick Visualization...**

  ![Pick visualization](images/pick-viz.png =400x*)

5. Select the **Bar** graph.

  ![Select bar graph](images/bar.png =300x*)

6. Let's swap **Sales** and **Profit**. Drag **Sales** from **Color** and drop it over **Profit** in the Y-Axis.

  ![Swap profit and sales](images/swap-sales-profit.png =300x*)

7. The Bar graph should now look like this.

  ![Bar](images/bar-results.png)

8. For our third visualization on this canvas, CTRL+click **Customer Segment** and **Sales** and select **Pick Visualization**.

  ![Customer segment visualization](images/customer-segment-viz.png =400x*)

9. Select the **Pie** chart.

  ![Select pie chart](images/pie.png =300x*)

10. Your canvas should have these three visualizations.

  ![First canvas comeplete](images/first-canvas.png)

11. Click the drop-down icon on this canvas and click **Rename**. Type <code>Data Action Source</code> for the name and hit Enter.

  ![Rename canvas](images/rename-source.png)

12. Click **Add Canvas**.

  ![Add canvas](images/add-second-canvas.png)

13. CTRL+click **Product Category**, **Sales**, and **Quarter of Year** from the **Order Date** drop-down. Right-click **Pick Visualization** and select the **Stacked Bar** graph.

  ![Select stacked bar](images/stacked-bar.png =400x*)

14. Drag **Order Date (Quarter of Year)** from **Category** to **Trellis Columns**.

  ![Drag order date to trellis](images/order-date-trellis.png =300x*)

15. Click the visualization **Menu**.

  ![Visualization menu](images/viz-menu.png)

16. Click **Edit** and select **Duplicate Visualization**.

  ![Duplicate viz](images/duplicate-viz.png)

17. Click the **Change Visualization Type** icon and select the **Pivot** table.

  ![Change to pivot](images/change-to-pivot.png)

18. Drag **Customer Segment** from the data panel in the **Rows** section. Then drag **Product Category** from **Color** to Rows under **Customer Segment**.

  ![Drag customer segment](images/drag-customer-segment.png =400x*)

19. Since this second visualization is a duplicate of the first, the **Use As Filter** is enabled. Click the **Toggle button to turn off the Use As Filter setting for the visualization**.

  ![Disable use as filter](images/use-as-filter-disable.png)

20. Rename this canvas to <code>Data Action Target</code>.

  ![Rename canvas](images/rename-target.png =500x*)

21. Now let's go back to the **Data Action Source** canvas.

  ![Navigate to source canvas](images/nav-source-canvas.png)

## Task 2: Create Data Actions
In this section, we will create a data actions to pass values to the target canvas.

1. Click the **Workbook Menu** and select **Data Actions**.

  ![Select data actions](images/data-actions.png =400x*)

2. Click the **+** icon to add an Action.

  ![Add data action](images/add-action.png =400x*)

3. This is where we configure the data action. Enter <code>Nav to Target</code> for **Name** and select **Analytics Link** for **Type**.

    >**Note**: Check the **Use Data Actions** link in the Learn More section at the bottom of this page to learn about other data action types.

  ![Data action type](images/data-action-name-type.png =400x*)

4. In this step, we won't choose data to anchor the Data Action onto. This will allow you to call the data action from any visualization in any canvas. Select the **Data Action Target** canvas for **Canvas Link** and click **OK**.

  ![No data anchor](images/no-data-anchor.png =400x*)

5. Right-click the **Office Supplies** **Sales** value for the **Home Office** **Customer Segment** and click **Nav to Target**. This is the data action we just created.

  ![Call data action](images/call-data-action.png)

6. The Nav to Target data action brings in the attributes (Home Office from Customer Segment and Office Supplies from Product Category) from the previous value we select and filters the Target canvas for those attributes. In this step, filters for Customer Segment and Product Category have been brought in and applied.

  ![Office supplies home office target](images/office-supplies-home-office-target.png)

7. Go back to the **Data Action Source** canvas. Right-click the **Furniture** column and select **Nav to Target**.

  ![Furniture call](images/furniture-call.png)

8. The **Furniture** **Product Category** filter is applied to the target visualization. This helps us drill into the Furniture product category and understand sales for the Quarters of the Year.

  ![Furniture target](images/furniture-target.png)

9. We know that the current Data Action can be called from any visualization. Let's edit the Data Action so it can only be called from specific visualizations. Click the **Workbook Menu** and select **Data Actions**.

  ![Data actions menu](images/data-actions-menu.png =500x*)

10. Click **Select Data** on **Anchor To** and select **Product Category**.

  ![Anchor product category](images/anchor-product-category.png =400x*)

11. The Data Action can only be called on visualizations with the **Product Category** attribute. Click **OK**.

  ![OK](images/ok.png =400x*)

12. In the pie chart, right-click a slice, and you'll notice that the **Nav to Target** data action is no longer visible. This is because this visualization doesn't use the **Product Category** column as a source.

  ![Pie data action](images/pie-data-action.png)

13. Right-click any of the values from the **Sales by Customer Segment, Product Category** visual. You will notice the **Nav to Target** Data Action is available. This is because the **Product Category** column is used in these two visualizations.

  ![Nav to target pivot](images/nav-to-target-pivot.png)

14. Right-click any of the values from the **Sales by Product Category, Profit** visual. You will notice the **Nav to Target** Data Action is available. The Nav to Target data action is available on both of these visuals since they use the **Product Category** column as a data source.

  ![Nav to target bar](images/nav-to-target-bar.png)

In this lab, you have successfully learned how to create data actions. You may now **proceed to the next lab**.

## Learn More
* [Use Data Actions](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acubi/use-data-actions.html)

* [Getting Started with Oracle Analytics Cloud](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acsgs/what-is-oracle-analytics-cloud.html#GUID-E68C8A55-1342-43BB-93BC-CA24E353D873)


## Acknowledgements
* Author - Nagwang Gyamtso, Product Manager, Analytics Product Strategy
* Contributors -
* Last Updated By/Date - Nagwang Gyamtso January, 2023
