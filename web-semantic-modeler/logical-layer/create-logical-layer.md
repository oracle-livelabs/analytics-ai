# Create the Logical Layer

## Introduction

In this lab, you create your business model in the logical layer using the physical table aliases and the joins from the physical layer. You modify the tables by removing unnecessary columns and renaming columns.

Estimated Time: -- minutes

### Objectives

In this lab, you will:
* Create your business model in the logical layer
* Modify the tables by removing unnecessary columns and renaming columns

### Prerequisites

This lab assumes you have:
* Access to Oracle Analytics Cloud
* Access to DV Content Author, BI Data Model Author, or a BI Service Administrator role
* Access to the Sample Sales Semantic Model
* All previous labs successfully completed

## Task 1: Create the Business Model

Begin with step 3 if you're continuing this lab directly after completing the steps in Create the Physical Layer lab.

1. If you closed your semantic model, sign in to Oracle Analytics Cloud using one of DV Content Author, BI Data Model Author or service administrator credentials. On the Home page, click the Navigator Navigator icon, and then click Semantic Models.

	![Image](images/image.png)

2. In the Semantic Models page, select Sample Sales, click Actions menu Actions menu icon, and then select Open.

	![Image](images/image.png)

3. Click Logical Layer Logical Layer icon, click Create Create icon, and then select Create Business Model.

	![Image](images/image.png)

4. In Create Business Model, enter Sample Sales BM in Name, and then click OK. The Semantic Modeler opens an empty business model.

	![Image](images/image.png)


## Task 2: Set Logical Layer Naming Preferences

In this section, you set preferences for the names of tables and columns in the Logical Layer. You change the tables and column names to use initial capitalization and replace the underscores with spaces.

1. In the empty Sample Sales business model, click the Physical Layer Physical Layer icon.

	![Image](images/image.png)

2. In the Physical Layer, select D1 Time and drag it to Dimensions in the Logical Layer.

	![Image](images/image.png)

3. Double-click D1 Time to view the table's columns. The table and columns use upper case, and the column names include underscores.

	![Image](images/image.png)

4. Double-click CALENDAR_DATE, enter Calendar Date to rename the column. Manually renaming every column would take valuable time.

	![Image](images/image.png)

5. In the Sample Sales BM page, right-click D1 Time and select Delete.

	![Image](images/image.png)

6. Click Page Menu Page Menu icon and select Preferences.

	![Image](images/image.png)

7. In Preferences, click Logical Layer. Select Rename Actions Rename Actions icon. Select Change each underscore (_) to a space, All lowercase, and Initial Capitals. Click the toggle to enable the preferences Preferences enabled, and then click Apply.

	![Image](images/image.png)

8. From the Physical Layer, select D1 Time and drag it to Dimensions in the Sample Sales BM business model.

	![Image](images/image.png)

9. Double-click D1 Time to see the renamed columns

	![Image](images/image.png)

## Task 3: Add Tables to the Logical Layer

1. In the Samples Sales BM page, click the Logical Tables tab. Click the Physical Layer Physical Layer icon pane.

	![Image](images/image.png)

2. Expand MySampleSalesDatabase, expand the BISAMPLE schema, and then drag F1 Revenue to Facts. Select D2 Products and D3 Customers, and then drag them to Dimensions.

	![Image](images/image.png)

3. Click and open each logical dimension table, D1 Time, D2 Products, and D3 Customers.

	![Image](images/image.png)

4. In the D1 Time logical table's General tab, click in the Primary Key field and select CALENDAR DATE. Repeat the same step for D2 Products and add its Primary Key, PROD KEY. For D3 Customers add its Primary Key, CUST KEY.

	![Image](images/image.png)

5. In the Logical Layer Logical layer icon, expand Sample Sales BM, right-click F1 Revenue, select Show Logical Diagram, and then select Selected Tables and Direct Joins. The logical diagram shows the logical joins between the fact and dimension tables.

	![Image](images/image.png)

6. If you don't see the logical joins, close the Logical Diagram. In the Logical Layer, hold the Ctrl key, select D1 Time, D2 Products, D3 Customers, and F1 Revenue.

	![Image](images/image.png)

7. Right-click on any of the tables, select Show Logical Diagram, and then select Selected Tables Only.

	![Image](images/image.png)

8. Hover over to F1 Revenue, grab the connector Connector icon and drag to D1 Time, and then in the Add Join dialog, click Add. Repeat this step by grabbing the connector Connector icon from F1 Revenue and adding joins to D2 Products and D3 Customers.

	![Image](images/image.png)

9. Click Save Save icon.

	![Image](images/image.png)

10. In the Samples Sales BM page, click the Logical Tables tab. The logical joins between the fact and dimension tables are listed.

	![Image](images/image.png)

## Task 4: Modify the Logical tables

In this section, you rename columns, remove columns for tables, and set the aggregation rules to create measures.

1. In the Sample Sales BM page, double-click the F1 Revenue table. In the Columns tab, keep the UNITS and the REVENUE columns. Hold down the Shift key and use the Down Arrow Down arrow icon to select the remaining columns

	![Image](images/image.png)

2. Click Delete Delete icon. In Delete Logical Column, click Yes.

	![Image](images/image.png)

3. Select Revenue, click Detail View Detail View icon, under Aggregation Rule, select Sum to create a simple measure.

	![Image](images/image.png)

4. Select Units, click Detail View Detail View icon, under Aggregation, select Count to create a simple measure.

	![Image](images/image.png)

5. Click Save Save icon.

	![Image](images/image.png)

## Task 5: Add an Extension Physical Table for a Logical Table Source



## Task 6: Manage Logical Table Sources



## Learn More
* [What is the Logical Layer?](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acmdg/what-is-logical-layer.html)
* [Plan the Logical Layer](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acmdg/plan-logical-layer.html#GUID-AED3B120-70F8-4837-9F2A-D9236F7BCCF0)
* [About Logical Joins](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acmdg/work-logical-joins.html#GUID-3810662A-AFAE-4EF9-B7C9-0A70D81A5A9A)
* [Automatically Rename Logical Layer Objects](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acmdg/automatically-rename-logical-layer-objects.html)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
