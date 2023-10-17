# Create a Workbook with Detailed Insights

## Introduction

As an analyst you are required to create a Workbook to get detailed insights on a metric that you are monitoring. In your earlier lab exercise you created a dashboard/Workbook to monitor two key metrics, now let us create another Workbook with deeper insights on one of them

**Business Need**: Deeper insights are required for “Revenue”, you would want to know the Top 5 Product Segments and Top 5 Balancing/Business Segments for Revenue. You would also like to see the details of Revenue, by Legal Entity, by Ledger, by Balancing Segment, by Natural Account. Also, you would like for focus on balances below 50 Million.

The focus of our analysis is “US Primary Ledger” & Scenario is “Journal updates actual balances”
Data is available from Fiscal Year 2013 to Fiscal Period Aug 2023. For this activity, you will focus on 2022 and use the “Financials - GL Profitability” subject area.


Estimated Time: 20 minutes

### Objectives

In this lab, you will:
* Create a custom Workbook
* Use the ledger and scenario as Workbook Filters
* Use the Time dimension as Dashboard Filters
* Create a Visual for Revenue by Product Segment, apply Top 5 filter on Revenue
* Create a Visual for Revenue by Balancing Segment, apply Top 5 filter on Revenue
* Create a Tabular Visual for detailed break-up of Revenue, and apply a conditional format on Revenue
* Be creative with your visuals and the steps. The steps shown below represent a sample process of recreating visuals from an existing workbook. The steps unable you to reuse a lot of existing components.


### Prerequisites

This lab assumes you have:
* Access to Fusion Data Intelligence Platform

## Task 1: Create Detailed Insights

1. To meet our business requirement, instead of creating a workbook from scratch, we have decided to create in from an existing workbook. These steps focus on how you could customize existing content. Let’s open the workbook we created in our earlier lab. From the **Catalog** page you could either double-click or use the menu to **Open** the workbook.

  ![Open Workbook](./images/open-workbook.png)

2. The workbook opens, let’s open it in the **Edit** mode.

  ![Edit mode](./images/edit.png)

3. Lets **Save As** a different workbook to leave the source workbook unchanged.

  ![Save as](./images/save-as.png)
 
4. Let’s navigate to the required folder. For the purpose of this lab, use the folder, **Shared Folder > Custom > Workshop Participants**. Save your workbook as **"XX Revenue Analysis"**.

  **Note**: Replace XX with your initials, this will help you to locate your Workbook. Do not overwrite on other participants workbook. Also do not delete any objects that you have not created.

  ![Save workbook](./images/save-workbook.png =500x*)

5. Click on the **Revenue** visual. From the **Grammar** panel, delete **Revenue** from the **tile** section.

  ![Delete Revenue](./images/delete-rev.png)

6. Now drag **Revenue** from the **Values** section to the **Filters** section of the **Grammar** panel.

  ![Drag Revenue to Filter](./images/rev-filter.png =400x*)

7. The filter window will open automatically. Select the **Top Bottom N** tab and make the required selection for **Top 5**.

  ![Top bottom n](./images/top-bottom-n.png)

8. In the Filters section, right-click on the **Revenue** and un-check **Show Filter**.

  ![Uncheck show filter](./images/show-filter.png)

9. Let’s give this visual a custom **Title**. Click on **Properties**. In the **General** tab, click on **Title** and select **Custom**.

  ![Custom title](./images/custom-title.png)

10. Give the visual a title **Top 5 Products by Revenue**.

  ![Top 5 products](./images/top-five.png)

11. Let’s make the title bold. Click on **Title Font** and select **Bold**.

  ![Bold title](./images/bold-title.png)
 
12. Your first visual for this workbook is done. Let’s leverage this visual to build a similar visual. Before that let’s delete an existing visual. Right-click on the **Sales & Marketing Expenses** visual and select **Delete Visualization**.

  ![Delete Visualizaton](./images/delete-viz.png)

13. Now let’s duplicate the existing visual. Right-click on the **Top 5 Products by Revenue** visual and select **Edit > Duplicate Visualization**.

  ![Duplicate visual](./images/duplicate.png)
 
14. In the data pane, select the column **GL Segments > Balancing Segment > Balancing Segment Description** and place it over the existing **Category** attribute.

  ![Category](./images/category.png)

15. That’s it your new visual is created, you just need to give it an appropriate **Title**. Let’s go to the **Properties** tab and in the **General** tab, type in the new **Title**, i.e., **“Top 5 Business Segments by Revenue”**.

  ![New title](./images/new-title.png)
 
16. Now click on the line chart. Select the **Grammar** panel icon.

  ![Grammar panel](./images/grammar.png)

17. You want a detailed tabular report instead of a line chart. Click the drop-down icon and select **Table**.

  ![Select table](./images/select-table.png =400x*)
 
18. Delete all the columns including filters from the grammar panel. Click on the **x** icon next to each column.

  ![Click x](./images/click-x.png)

19. This is how your **Grammar** panel and the table visual should look like after you have cleared all the columns.

  ![result](./images/result.png)
 
20. Let’s start population the **Rows** with the required columns. Drag the **Legal Entity** as the first column.

  ![Legal entity](./images/legal-entity.png)

21. Similarly drag other columns, in order as shown below.

    * Ledger > Ledger Name
    * GL Segments > Balancing Segment > Balancing Segment Description
    * GL Segments > Natural Account > Natural Account Description
    * Currency > Analytics Currency
    * Scenario > Scenario Description
    * Facts – Analytics Currency >Profit and Loss (AC) > Revenue

  ![Create new visual](./images/create-new-viz.png)
 
22. We needed to highlight detailed Revenue balances below 50 Million, for exception reporting. Let’s right-click on the **Revenue** column and from the **Menu** select **Conditional Formatting > Manage Rules**.

  ![Manage rules](./images/manage-rules.png)

23. Give the rule a **Name** & select the **Measure**, in this case **Revenue**.

  ![New revenue name](./images/rev-name.png)
 
24. Select the first **Preset** and define the condition as shown below. After setting up the condition, click **Save**.

  ![Save](./images/save.png)

25. We now see the entries highlighted in **Red** for **Revenue below 50 million**. They require additional analysis. Let’s see how this workbook would appear to the end user. Click the **Preview** icon.

  ![Preview](./images/preview.png)
 
26. You have met the business requirements with the workbook below. Let’s save all the changes. To do that, lets go back to the **Edit** mode.

  ![Edit mode](./images/edit-mode.png)

27. Click the **Save** icon to save all the changes.

  ![Save](./images/save-all.png)
 
28. You have successfully completed your lab exercise. Let’s go back to the **Catalog** page.

  ![Back](./images/back.png)


You have successfully created another analysis/dashboard. In Fusion Data Intelligence Platform, we call this object Workbook. In the next lab exercise we will learn to link the detailed Workbook you created in this exercise to the first Workbook you created in your earlier lab exercise.


## Learn More
* [Getting Started with Oracle Analytics Cloud](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acsgs/what-is-oracle-analytics-cloud.html#GUID-E68C8A55-1342-43BB-93BC-CA24E353D873)


## Acknowledgements
* **Author** - Subroto Dutta, Senior Principal Product Manager, Analytics Product Strategy
* **Contributors** - Nagwang Gyamtso, Product Manager, Analytics Product Strategy
* **Last Updated By/Date** - Nagwang Gyamtso, October 2023
