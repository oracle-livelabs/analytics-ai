# Examine Semantic Model Markup Language

## Introduction

This tutorial describes how to build governed semantic models using the Semantic Modeler.

Estimated Lab Time: 25 minutes

### About

In this tutorial, you continue building the Sample Sales semantic model by creating calculated, level-based, and share measures, and creating level-based and time hierarchies..

### Objectives

In this lab, you will:
* Create caluclated, level-based, and share measures.
* Create level-based and time hierarchies

### Prerequisites

This lab assumes you have:
* Access to Oracle Analytics Cloud
* Access to DV Content Author, BI Data Model Author, or a BI Service Administrator Problems
* Access to the Sample Sales Semantic Model



## Task 1: Create a Semantic Model

 In the logical layer, your tables are dimension objects. The dimension object's logical columns are its attributes. You organize the columns of a dimension object into levels of a hierarchical structure.

1. If you closed your semantic model, sign in to Oracle Analytics Cloud using one of DV Content Author, BI Data Model Author or service administrator credentials.

2. On the Home page, click the Navigator Navigator icon, and then click Semantic Models.
	![Open Semantic Models](./images/semantic-models.png)
	
3. In the Semantic Models page, select **Sample Sales**, click **Actions menu**, and then select **Open**.
	![Open Samples Sales](./images/open-sample-sales.png)

4. In the Logical layer, double-click **D2 Products**.

	![click d2 products](./images/select-d2-products.png)

5. In D2 Products, click the **Hierarchy** tab. In Hierarchy Type, select **Level-Based**.

	![open hierarchy tab and select level-based](./images/level-based-hierarchy.png)

## Task 2: Add Physical tables

In this section, you add physical tables from the data source to the empty semantic model.

1. In MySampleSalesDatabase, click the **Tables** tab.

	![Tables tab](./images/tables.png)

2. In the Connections Connections pane icon pane, expand the BISAMPLE connection, and then expand Schemas.

	![Schemas](./images/schemas.png =400x*)

3. Expand the BISAMPLE schema.

	![Expand BISAMPLE](images/expand-bisample.png =400x*)

4. Hold down the Ctrl (Command for Mac users) key and select these tables:
	* SAMP_ ADDRESSES_D
	* SAMP_ CUSTOMERS_D
	* SAMP_ PRODUCTS_D
	* SAMP_ REVENUE_F
	* SAMP_ TIME_ DAY_D

5. Drag the selected tables to Tables in the MySampleSalesDatabase tab

	![Drag tables](./images/drag-tables.png)

## Task 3: Create Physical Table Aliases

In this section, you create physical table aliases that enables reusing the physical source tables. You also prefix the physical alias table's name with the table type such as F for fact and D for dimension, and use a number along with the F or D to change the original physical table name. For example, D1 Time for the SAMP_ TIME_ DAY_ D table and D2 Products for the SAMP_ PRODUCTS_D table.

1. In Tables, right-click **SAMP_ TIME_ DAY_D** and select **Create Physical Table** Alias.

	![create physical table alias](./images/create-physical-table-alias.png)

2. In Create Physical Table Alias, enter <code>D1 Time</code> in **Name**, and then click **OK**. Close D1 Time.

	![D1 Time](./images/d1-time.png =500x*)

3. Right-click **SAMP_ PRODUCTS_D** and select **Create Physical Table Alias**.

	![SAMP_PRODUCTS_D alias](./images/product-alias.png)

4. In **Create Physical Table Alias**, enter <code>D2 Products</code> in **Name**, and then click **OK**. Close D2 Products.

	![D2 products](images/d2-products.png =500x*)

5. Create physical table aliases for **SAMP_ CUSTOMERS_ D, SAMP_ OKRESSES_ D, and SAMP_ REVENUE_F** with the following instructions:

	* Right-click **SAMP_ CUSTOMERS_D** and select **Create Physical Table Alias**.
		* In Create Physical Table Alias, enter <code>D3 Customers</code> in **Name**, and then click **OK**. Close D3 Customers.
	* Right-click **SAMP_ ADDRESSES_D** and select **Create Physical Table Alias**.
		* In Create Physical Table Alias, enter <code>D4 Addresses</code> in **Name**, and then click **OK**. Close D4 Addresses.
	* Right-click **SAMP_ REVENUE_F** and select **Create Physical Table Alias**.
		* In Create Physical Table Alias, enter <code>F1 Revenue</code> in **Name**, and then click **OK**. Close F1 Revenue

6. You should now have the D1 Time, D2 Products, D3 Customers, D4 Addresses, and F1 Revenue tables.

	![Table aliases](./images/table-aliases.png =400x*)

## Task 4: Create Physical Joins

In this section, you define joins between alias tables to express relationships between tables in the Physical layer.

1. In the **Joins** section, click the **Add Join** icon.

	![Add join](./images/add-join.png)

2. In **Add Physical Join**, click the dropdown in the Left Table. Expand the database, expand the schema, and then click **F1 Revenue**. Click the dropdown in the Right Table. Expand the database, expand the schema, and then click **D1 Time**.

	![Add physical table](./images/add-physical-table.png =500x*)

3. In **Join Conditions**, click the dropdown under Left Table (F1 Revenue), select the **BILL_ DAY_ DT** column. Under the Right Table (D1 Time), click the dropdown, and select the **CALENDAR_ DATE** column. Click **Add**.

	![Add join conditions](./images/join-conditions.png =500x*)

4. Click **Save** icon.

	![Save](./images/save.png)

5. Let's add another join. Click the **Add Join** icon. In **Add Physical Join**, click the dropdown in the Left Table. Expand the database, expand the schema, and then click **F1 Revenue**. Click the dropdown in the Right Table. Expand the database, expand the schema, and then click **D2 Products**.

	![Join](./images/join-f1-d2.png =500x*)

6. In **Join Conditions**, click the dropdown under Left Table (F1 Revenue), select the **PROD_ KEY** column. Under the Right Table (D2 Products), click the dropdown, and select the **PROD_ KEY** column. Then click **Add**.

	![Join conditions](./images/conditions-f1-d2.png =500x*)

7. Click the **Physical Layer** icon. Under the BISAMPLE schema, right-click **F1 Revenue**, select **Show Physical Diagram**, and then click **Selected Tables and Direct Joins**.

	![Selected tables and join conditions](./images/selected-tables-joins.png)

8. Drag **D3 Customers** to the **Physical Diagram**. Drag the **F1 Revenue** from the Physical Diagram away so that it's not blocking D1 Time. Re-arrange as you see fit.

	![Drag D3 Customers](./images/drag-d3.png)

9. From the **F1 Revenue connector**, draw a line to **D3 Customers**.

	![Connect F1 D3](./images/connect-f1-d3.png)

10. In **Add Physical Join** under **Join Conditions**, click the dropdown under Left Table (F1 Revenue), select the **CUST_ KEY** column. Under the Right Table (D3 Customers), click the dropdown, and select the **CUST_ KEY** column. Then click **Add**.

	![Join F1 D3](./images/cust-key-join.png =500x*)

11. Drag **D4 Addresses** to the Physical Diagram.

	![Drag D4](./images/drag-d4.png)

12. From the D3 Customers connector, draw a line to D4 Addresses.

	![Connect D3-D4](./images/connect-d3-d4.png)

13. In Add Physical Join under **Join Conditions**, click the list icon on the left, and select the **ADDRESS_ KEY** column. Click list icon on the right, and then select the **ADDRESS_ KEY column**. Click **Add**.

	![Join ADDRESS_KEY](./images/join-address-key.png =500x*)

14. Click the **Save** icon.

	![Save](./images/save-diagram.png)

## Task 5: Review Physical Layer tables

In this section, you can review columns, joins, and data in the Physical Layer tables.

1. In the Physical Layer, double-click the **D2 Products** table.

	![Double click D2](./images/dc-d2.png)

2. The Physical Layer table opens in the **Columns** tab.

	![D2 columns](./images/d2-columns.png)

3. Click **Joins** to view the joins to the F1 Revenue table.

	![View F1 joins](./images/view-f1-joins.png)

4. Click **Preview** to see a sample of the data in the columns.

	![Preview D2 table](./images/preview-d2.png)

## Learn More
* [What Is a Semantic Model?](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acmdg/what-is-semantic-model.html)
* [Understand a Semantic Model's Requirements](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acmdg/understand-semantic-models-requirements.html)
* [Plan the Physical Layer](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acmdg/plan-physical-layer.html#GUID-D7D6E064-F9C8-4B8B-A02F-B9E0358063F1)

## Acknowledgements
* **Author** - Nagwang Gyamtso, Product Manager, Analytics Product Strategy
* **Contributors** - Pravin Janardanam, Shounak Ganguly, Gabrielle Prichard
* **Last Updated By/Date** - Nagwang Gyamtso, February, 2023
