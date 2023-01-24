# Basic Data Visualization

## Introduction

In this lab, you will learn how easy it is to create data visualizations in Oracle Analytics Cloud.

  ![DV Overview](images/dv-overview.png)

Estimated Time: __ minutes

### Objectives

In this lab, you will:
* Create basic visualizations


### Prerequisites

This lab assumes you have:
* Access to Oracle Analytics Cloud
* Sample Order Lines DS dataset


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

16. Save the workbook by clicking the save icon.

  ![Save workbook](images/save-icon.png =500x*)

17. Enter <code>Sample Analysis</code> for **Name** and click **Save**.

  ![Save workbook](images/save-workbook.png =600x*)

You just learned how to create basic visualizations and filters in Oracle Analytics.


## Learn More
* [Getting Started with Oracle Analytics Cloud](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acsgs/what-is-oracle-analytics-cloud.html#GUID-E68C8A55-1342-43BB-93BC-CA24E353D873)
* [About Visualizaton Types](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acubi/visualization-types.html)

## Acknowledgements
* Author - Nagwang Gyamtso, Product Manager, Analytics Product Strategy
* Contributors -
* Last Updated By/Date -
