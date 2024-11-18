# Basic Data Visualization

## Introduction

In this lab, you will learn how easy it is to create data visualizations and understand how brushing works in Oracle Analytics Cloud.

  ![DV Overview](images/dv-overview.png)

Estimated Time: 15 minutes

### Objectives

In this lab, you will:
* Create basic visualizations
* Understand how Brushing works in Oracle Analytics


### Prerequisites

This lab assumes you have:
* Access to Oracle Analytics Cloud
* [Sample Order Lines DS](https://objectstorage.us-ashburn-1.oraclecloud.com/p/x4wryiFOjhANhy2yDOy08kMOKKaR_b3jW6KX2Dpbi3cN3QCcdradiPZ7BJBNmtAM/n/idmqvvdwzckf/b/LiveLabs-Files/o/Sample%20Order%20Lines%20DS.xlsx) dataset


## Task 1: Basic Data Visualization
In this section, you will upload the Sample Order Lines DS and apply data transformations to enhance your dataset.

1. Log in to your Oracle Analytics instance.

2. From the homepage, click **Create** and then select  **Workbook**.

  ![Create workbook](images/create-workbook.png =400x*)

3. Select the **Sample Order Lines DS** dataset and click **Add to Workbook**.

  ![Add to workbook](images/add-to-workbook.png =600x*)

4. If auto-insights are enabled for your dataset, you will get auto-generated visualizations as suggestions on the right side of your screen. We won't focus on Auto-Insights in this lab but feel free to explore the suggested visualizations. Close the auto-insights pane.

  ![Close auto insights](images/close-auto-insights.png =400x*)

5. CTRL + click **Sales** and **Customer Segment**. Right-click and select **Create Best Visualization**. This lets Oracle Analytics pick the best visualization based on the metrics selected.

  ![Create best viz](images/create-best-viz.png =400x*)

6. A Vertical Bar Chart is created based on the preconfigured logic, and we understand that Corporate is the Top Performing Customer Segment.

  ![Bar chart](images/bar-chart.png)

7. Now, let's create our own visualization and pick from the vast number of visualization types available. CTRL+click **Sales**, **Profit**, and **Customer Segment**. Right-click and select **Pick Visualization...**.

  ![Pick visualization](images/pick-viz.png =400x*)

8. Oracle Analytics has over 40 visualizations types out of the box. Select the **Scatter** plot.

  ![Select scatter](images/select-scatter.png =400x*)

9. A **Scatter** plot is added as a second visual in the canvas.

  ![Scatter results](images/scatter-result.png)

10. Click the drop-down on **Order Date**. Select **Year** and drag it to the canvas filter pane to create a year filter for all the visualizations on the canvas.

  ![Year filter](images/year-filter.png)

11. From the list of years, select **2022**. This will give us the visualizations using 2022 data. Click on the canvas to exit the filter.

  ![Filter year 2022](images/year-2022.png =400x*)

12. Now let's create a filter for our Sales by Customer Segment visualization. Click the Bar chart visualization. Select **Product Category** and drag it to the **Filters** section of the grammar pane.

  ![Product category filter](images/product-category-filter.png)

13. From the filter values, select **Office Supplies**. This will filter our Sales by Customer Segment visualization to show us the data for the Office Supplies Product Category. Click on the canvas to exit the filter selection.

  ![Office supplies](images/office-supplies.png =400x*)

14. Your canvas now has a canvas filter for the year 2022 and the Sales by Customer Segment visualization is filtered to the Office Supplies Product Categories.

  ![Office supplies filter results](images/office-supplies-result.png)

15. Rename the canvas by clicking the canvas option drop-down and selecting **Rename**. Enter <code>Sales Analysis</code> as the canvas name.

  ![Rename canvas](images/rename-canvas.png)


## Task 2: Brushing
In this section, we will explore brushing, which automatically highlights datapoints that are selected in one visualization in other visualizations.

1. Click the **Add Canvas** button to add a new canvas.

  ![Add canvas](images/add-canvas.png)

2. Ctrl (Command on Mac) + Select  **Sales** and **Customer Segment** from the **Sample Order Lines DS** dataset. Right-click and select **Pick Visualization**.

  ![Pick visualization](images/pick-visualization.png =300x*)

3. Select the **Donut** chart.

  ![Select donut chart](images/donut-chart.png =300x*)

4. Ctrl (Command on Mac) + Select  **Sales**, **Customer Segment**, and **Product Category** from the **Sample Order Lines DS** dataset. Right-click and select **Pick Visualization**.

  ![Pick visualization](images/pick-viz-again.png)

5. Choose the **Horizontal Stacked** chart.

  ![Select Horizontal Stacked chart](images/pick-horizontal.png =300x*)

6. Swap **Customer Segment** with **Product Category**.

  ![Swap attributes](images/swap-cus-seg-prod-cat.png)

7. Your final canvas will look like the following:

  ![Final canvas](images/results.png)

8. Click on the **Small Business** customer segment in the donut chart. When you click on one data point in a visual, the same data point gets highlighted in the other visual. We understand that out of 6M Sales generated, the Small Business Customer Segment generates 19.05% of Sales.

    >**Note:** Brushing is enabled by default. You can enable/disable this in the [Canvas Properties](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acubi/update-canvas-properties.html).

  ![Highlight visuals](images/highlight.png)

9. If you hover over the highlight in **Furniture** on the second visual, we also understand that the **Furniture Product Category** contributes **$341,098** to the **Small Business Customer Segment**. Brushing helps us learn more about our data points in other contexts.

  ![Highlight visuals](images/highlight2.png)


## Task 3: Reorder and Format Your Visualizations

1. Select **Product Category**, **Sales**, and **Month (Order Date)**. Drag these three columns to under the two visuals and drop it when a green bar appears under both existing visualizations.

  ![Line chart placement](images/line-chart-placement.png)

2. To reorder your visualizations, you can drag them by the title and drop them anywhere on the canvas as long as a green bar appears indicating where the visualization will be placed. Drag the horizontal stacked chart to the right side of the donut chart. Make sure you drop the chart where the shorter green bar which aligns with the donut chart appears.

  ![Align charts](images/align-charts.png)

3. Let's change the title of our line chart. Select the **Sales by Order Date (Month), Product Category** line chart and click the **Properties** panel.

  ![Properties panel](images/properties-panel.png)

4. This is the properties panel which allows your to format your visualizations. You can format things like the title, font, legend, axis labels, values, date format, filters, and add statistics to your visualizations. For this lab, we will only change the title.

  ![Properties](images/properties-options.png =300x*)

5. Click the **Title** setting and choose **Custom**. Here, you can input your custom title but for now, let's just input "How are sales for the product categories trending over time?" and hit Enter.

  ![Input new title](images/new-title.png)

6. Save the workbook by clicking the **Save** icon.

  ![Save workbook](images/save-workbook.png =500x*)

7. Enter <code>Sample Analysis</code> for **Name** and click **Save**.

  ![Save workbook](images/save.png =500x*)

## Task 4: Share Your Insights

1. To share your insights, click the **Export** icon on the top right of the page.
  ![Export icon](images/export-icon.png =500x*)

2. You have the option to export a digital **File** or **Print** a physical copy. Select **File**.

  ![Export file](images/export-file.png =200x*)

3. Here, you have a few options such as the format, which canvas you want to export, where you want to include filters, titles, the size, and orientation of the file.

  ![File options](images/file-options.png =300x*)

4. Click the dropdown for **Format** options. Oracle Analytics currently allows you to export five different formats. PowerPoint, Acrobat, and Image are all visual options while Data and Package allows you to export the underlying data and the whole workbook.

  ![Format options](images/format-options.png =300x*)

5. The **Include** setting lets you either choose the active visualization, the active canvas, or all canvases depending on the type of format you select.

  ![Active canvas](images/include-options.png =300x*)

6. The other options allow you to include filters used in the visualization, include titles, choose the size and finally the orientation of your file. Choose the following settings and click **Save**. This will export the file which you can distribute to your audience to share your insights!

  ![Save](images/save-file.png =300x*)

Congratulations, you have completed the basic data visualizations in Oracle Analytics lab. To learn more, check out the resources listed below!

You may now **proceed to the next lab**.

## Learn More
* [Getting Started with Oracle Analytics Cloud](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acsgs/what-is-oracle-analytics-cloud.html#GUID-E68C8A55-1342-43BB-93BC-CA24E353D873)
* [About Visualizaton Types](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acubi/visualization-types.html)
* [About Brushing Between Visualizations on a Canvas](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acubi/brushing-visualizations-canvas.html)
* [Export Content from Analyses and Dashboards](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acubi/export-content-analyses-and-dashboards.html#GUID-317A5C27-0C7C-4026-9D4D-3AF4773C9725)

## Acknowledgements
* Author - Nagwang Gyamtso, Product Manager, Analytics Product Strategy
* Contributors - Shiva Oleti
* Last Updated By/Date - Nagwang Gyamtso, February 2023
