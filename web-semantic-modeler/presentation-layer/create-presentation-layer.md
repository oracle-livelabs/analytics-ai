# Create the Presentation Layer

## Introduction

In this lab, you will crate the presentation layer using the tables that you modified in the logical layer.

The presentation layer provides the tables, relationships, and hierarchies using terms understood by business users. The presentation layer's subject area contains the business data that closely aligns with user roles and goals. For customers in sales and sales support roles, you could create a subject area that has tables and columns related to product sales, revenue, and customer orders. For customers in human resources, the subject area tables and columns could include employee retention, promotion, and hire data.

Estimated Lab Time: 25 minutes

### Objectives

In this lab, you will:
* Create the presentation layer

### Prerequisites

This lab assumes you have:
* Access to Oracle Analytics Cloud
* Access to DV Content Author, BI Data Model Author, or a BI Service Administrator role
* Access to the Sample Sales Semantic Model
* All previous labs successfully completed


## Task 1: Create the Subject Area

In this section, you create the Sample Sales subject area that displays in Oracle Analytics when the semantic model is deployed.

Begin with step 3 if you're continuing this lab directly after completing the steps in Create the Logical Layer lab.

1. If you closed your semantic model, sign in to Oracle Analytics Cloud using one of DV Content Author, BI Data Model Author or Service Administrator credentials. On the **Home page**, click the **Navigator** icon, and then click **Semantic Models**.

	![Navigate to Semantic Modler](./images/nav-semantic-modeler.png)

2. In the **Semantic Models** page, select **Sample Sales**, click **Actions menu**, and then select **Open**.

	![Open Sample Sales](./images/open-sample-sales.png)

3. Click the **Presentation Layer** icon. Click the **Create** icon, and then select **Create Subject Area**.

	![Create subject area](./images/create-sa.png =500x*)

4. In **Create Subject Area**, enter <code>Sample Sales</code> in **Name**, and then click **OK**.

	![Subject area name](./images/sa-name.png =500x*)

5. In the **Sample Sales** subject area on the **Tables** tab, click **Add Tables**, and then select **Create Presentation Table**.

	![Create presentation table](./images/create-pres-table.png)

6. In **Create Presentation Table**, enter <code>Time</code> in **Name**, and then click **OK**. Close the Time tab.

	![Create Time presentation table](./images/create-time-table.png =500x*)

7. In the **Sample Sales** subject area, click the **Add Tables** icon and select **Add Tables**.

	![Image](./images/add-table.png)

8. In **Select Logical Table**, click **D2 Products**, and then click **Select**.

	![Select D2 Products](./images/select-d2.png =500x*)

9. Double-click **D2 Products**.

![Double click D2 Products](./images/dc-products.png)

10. Click the **General** tab. In **Name**, enter <code>Products</code>, and then click the **Save** icon.

	![Enter Products for name](./images/enter-products.png)

11. In the **Sample Sales** subject area, click **Add Tables**, and select **Create Presentation Table**.

	![Create presentation table](./images/create-presentation-table.png)

12. In **Create Presentation Table**, enter <code>Customers</code> in **Name**, and then click **OK**.

	![Presentation table name](./images/pres-table-name.png =500x*)

13. Add another **Presentation Table** and name this one <code>Base Facts</code>, and then click **OK**.

	![Base facts presentation table](./images/base-facts.png =500x*)

14. Click the Presentation Layer's **Table** tabs, and then click and open each table to review the table columns.

	![Tables tab](./images/open-each-table.png)

15. The **Products** table contains columns imported from the **D2 Products** table in the business model. The **Time**, **Customers**, and **Base Facts** tables don't yet have columns because they aren't connected to a source table.

	![Products table](./images/products-table.png)


## Task 2: Add Columns to the Presentation Tables

In this section, you select columns from the logical tables to use in the presentation tables.

1. In the **Logical Layer**, expand the **Sample Sales BM** and then expand **D1 Time**. Click the **Logical Layer** icon, expand **Sample Sales BM**, and then expand **D1 Time**.

	![Expand D1 Time](./images/expand-d1-time.png)

2. Hold down the **Ctrl** or **Command** key, and select and drag the following columns to the **Columns** tab in the **Time** presentation table:
	* Calendar date
	* Per name half
	* per name month
	* Per name qtr
	* Per name week
	* Per name year

	![Drag and drop columns](./images/drag-drop-cols.png)

3. Click **Save**.

	![Save](./images/save-time.png)

4. Double-click **Customers** in the **Sample Sales** subject area.

	![Customers in Sample Sales](./images/dc-customers.png)

5. In the **Logical Layer**, expand **D3 Customers**. Hold down the **Ctrl (Command for Mac)** key, select **Cust Key** and **Name**, and then drag them to the **Columns** tab in the **Customers** table.

	![Customers in Sample Sales](./images/dd-cust.png)

6. Click **Save**.

	![Save](./images/save-dd.png)

7. Double-click **Base Facts** in the **Sample Sales** subject area. In the **Logical Layer** icon, expand **F1 Revenue**. Hold down the **Ctrl (Command for Mac)** key, select **Revenue** and **Units**, and then drag them to the **Columns** tab.

	![Drag and drop Revenue and Units](./images/dd-rev-units.png)

8. Click **Save**.

	![Save](./images/save-rev-units.png)

## Task 3: Modify Columns to the Presentation Tables

In this section, you change the names of some columns, remove columns, and reorder columns in the semantic model's presentation tables.

1. Click the **Products** tab. Hold down the **Ctrl (Command for Mac)** key, select the **Prod key**, **Attribute 1**, **Attribute 2**, and **Total Value** columns, and then click the **Delete** icon. Click **Yes** when prompted to delete the presentation columns.

	![Delete](./images/delete-icon.png)

2. Double-click **Prod Dsc**. Enter **'Product'** in **Name**.

	![Product name](./images/product-name.png)

3. Double-click **Lob**. Enter **'Line of Business'** in **Name**.

	![Line of Business in name](./images/lob-name.png)

4. Click **Save**.

	![Save](./images/save-lob.png)

5. Select a column, and then click the **Move Up** arrow icon and **Move Down** arrow icon to arrange the Products columns in the following order:

	* Brand
	* Product
	* Type
	* Line of Business
	* Sequence
	* Brand key
	* Lob key
	* Type key

	![Move columns](./images/move-cols.png)

6. Click **Save** icon.

	![Save move](./images/save-move.png)

## Learn More
* [What is the Presentation Layer?](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acmdg/what-is-presentation-layer.html)
* [About Creating Subject Areas](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acmdg/work-subject-areas.html#GUID-BB34F6A4-6CC1-40B6-8EC1-E8B8E65D4F3C)
* [About Presentation Tables](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acmdg/work-presentation-tables-and-columns.html#GUID-B5109E7A-314C-4DF5-BCDD-CD2374084AE9)

## Acknowledgements
* **Author** - Nagwang Gyamtso, Product Manager, Analytics Product Strategy
* **Contributors** - Pravin Janardanam, Gabrielle Prichard
* **Last Updated By/Date** - Nagwang Gyamtso, February, 2024
