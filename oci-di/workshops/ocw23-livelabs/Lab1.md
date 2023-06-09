# Create a Data Loader task, two Data Flows, Integration tasks and a SQL task

## Introduction

Learn how to create a **Data Loader task**, **two Data Flows** along with **Integration tasks** and a **SQL task** in OCI Data Integration. The use-case for each of these data integration tasks is detailed in the associated workshop task.

**Estimated Time**: 30 minutes

### Objectives
* Create an OCI Data Integration project
* Create a Data Loader task

## Task 1: Create an OCI Data Integration project

In Oracle Cloud Infrastructure Data Integration, a **project** is the container for design-time resources, such as tasks or data flows and pipelines.

1. In the Oracle Cloud Infrastructure Console navigation menu, navigate to **Analytics & AI**. Under Data Lake, click **Data Integration**.

  ![](../../integration-tasks/images/menu-di.png " ")

2. From the Workspaces page, make sure that you are in the compartment for data integration (`DI-compartment`). Click on your **Workspace** (`DI-workspace`).

   ![](../../integration-tasks/images/workspaces-click.png " ")

3. On your workspace home page, click **Open tab** (plus icon) in the tab bar and then select **Projects**.

   ![](../../integration-tasks/images/click-projects.png " ")

4. On the Projects page, click **Create Project**.

   ![](../../integration-tasks/images/create-project.png " ")

5. On the Create Project page, enter `DI_WorkshopNN` (replace NN with your user number ie. DI_Workshop01) for **Name** and an optional **Description**, and then click **Create**.

   ![](../../integration-tasks/images/create-project-page.png " ")

6. You are now in the **Project Details** page for `DI_WorkshopNN` project.

   ![](../../integration-tasks/images/di-workshop-project.png " ")


## Task 2: Create a Data Loader task

A **Data Loader task** helps you load diverse data set into data lakes, data marts, and data warehouses. A data loader task takes a source data entity, applies transformations (optional), and then loads the transformed data into a new target data entity, or updates an existing data entity. A data loader task supports transformations at the metadata and data levels.

In this step of the Workshop, you will create a Data Loader task that will load Orders data from **REVENUE.csv** source file. You will then fill up the null values for the Source Order Number and rename the Order Time zone field, and finally load data to **REVENUE_TARGET** table in Autonomous Data Warehouse. The Data Loader task will also create the target table on the Autonomous Data Warehouse.

1. From your Workspace home page of OCI Data Integration, click **Open tab** (plus icon), and then select **Projects**.

  ![](../../integration-tasks/images/home-projects.png " ")

2. On the **Projects** page, select the project you have been working on for this workshop, `DI_WorkshopNN`.

  ![](../../integration-tasks/images/select-project.png " ")

3. On the `DI_WorkshopNN` **Project Details** page, from the submenu, click **Tasks**.

  ![](../../integration-tasks/images/click-tasks.png " ")

4. Click **Create Task**, and then select **Data Loader**.

  ![](../../integration-tasks/images/data-loader.png " ")

5. On the **Create Data Loader Task** page that pops up, for **Name**, enter `Load Revenue Data into Data Warehouse`.

  ![](../../integration-tasks/images/loader-name.png " ")

6. In the **Source** section, click **Select**.

  ![](../../integration-tasks/images/select-source.png " ")

7. In the **Select Source** page that pops up, select the following values:

    - **Data Asset**: `Object_Storage`.
    - **Connection**: `Default Connection`.
    - **Compartment**: `DI-compartment` (the Compartment in which you have the bucket where you uploaded your REVENUE.CSV file in _Setting up the Data Integration prerequisites in OCI_).
    - **Schema**: `DI-bucket` (the Object Storage bucket where you uploaded your REVENUE.CSV file in _Setting up the Data Integration prerequisites in OCI_).
    - **Data Entity**: Click `Browse by Name` and then select **REVENUE.csv**.
    - **File Type**: Set to **CSV**. Then leave the default settings as-is in all the remaining fields.
    - Click **Select**.

    ![](../../integration-tasks/images/loader-file.png " ")

8. In the **Configure Transformations** section, click **Configure**.

  ![](../../integration-tasks/images/configure-transformation.png " ")

9. The Configure Transformations panel opens, showing the metadata information of the data entity and its attributes. You can also view sample data in the **Data** tab.

  ![](../../integration-tasks/images/loader-attributes.png " ")

10. Click **Data** to navigate to the Data tab, then locate and select **SRC\_ORDER\_NUMBER**.
A panel displays, showing the **Data Profile** and the **Attribute Profile** for SRC\_ORDER\_NUMBER. Null Data Percent for SRC\_ORDER\_NUMBER is at 100%.

  ![](../../integration-tasks/images/src-order-number-attribute.png " ")

11. From the **transformations icon** (three dots) for SRC\_ORDER\_NUMBER, select **Null Fill Up**.

  ![](../../integration-tasks/images/null-fill-up.png " ")

12. In the **Null Fill Up dialog**, do the following:

    - Enter `Not Available` in the **Replace by String** field.
    - Do **not** select Keep Source Attributes.
    - Leave the **Name** and **Data Type** as-is.
    - Click **Apply**.

    ![](../../integration-tasks/images/null-fill-up-selections.png " ")

13. After the **Data** tab refreshes, use the horizontal scrollbar to scroll to the end of the dataset where the updated **SRC\_ORDER\_NUMBER** column is. Notice the values for SRC\_ORDER\_NUMBER have been replaced by the `Not Available` string.

  ![](../../integration-tasks/images/data-loader-new-field.png " ")

14. In the Data tab, look for attribute **ORDER\_DTIME2\_TIMEZONE** by scrolling to the right. Click on the **transformation icon** (three dots) for ORDER\_DTIME2\_TIMEZONE, and then select **Rename**.

  ![](../../integration-tasks/images/rename-attribute.png " ")

15. In the **Rename** dialog box, enter a new name for the attribute ORDER\_DTIME2\_TIMEZONE. For this workshop, enter **ORDER\_TIMEZONE** then click **Apply**.

  ![](../../integration-tasks/images/rename-attribute-loader.png " ")

16. Click the **Transformations** icon next to the data entity name.

  ![](../../integration-tasks/images/transformations.png " ")

17. You can **review the list of transformations** that are applied to the source dataset. If you would want to remove a transformation, you could click the X icon next to a transformed attribute name. For now close the Configure Transformations panel, click **OK**.

  ![](../../integration-tasks/images/final-transformations.png " ")

18. The number of transformation rules applied is shown in the **Configure Transformations** section.

  ![](../../integration-tasks/images/transformations-number.png " ")

19. In the **Target section**, select the **Create New Entity** check box, and then click Select.

  ![](../../integration-tasks/images/data-loader-target.png " ")

20. In the **Select Target** page, select the following values:

    - **Data Asset**: `Data_Warehouse`
    - **Connection**: `Beta Connection`
    - **Schema**: `BETA`
    - **Data Entity**: Enter `REVENUE_TARGET` for the new entity you're going to create
    - Under **Staging Location**, select the `Object_Storage` data asset
    - Select the `Default connection` for Object Storage
    - Select the `DI-compartment` name
    - Select the `DI-bucket`
    - Click **Select** to complete selecting the target.

    ![](../../integration-tasks/images/data-loader-target-selections.png " ")

21. The Target section in the Data Loader Task now displays your selections for the target. Click **Save and Close**.

  ![](../../integration-tasks/images/loader-save.png " ")

   **Congratulations!**  You created the Data Loader task.

## Learn More

* [Data Flow in OCI Data Integration](https://docs.oracle.com/en-us/iaas/data-integration/using/data-flows.htm)
* [Integration Task in OCI Data Integration](https://docs.oracle.com/en-us/iaas/data-integration/using/integration-tasks.htm)
* [Data Loader Task in OCI Data Integration](https://docs.oracle.com/en-us/iaas/data-integration/using/data-loader-tasks.htm)
* [SQL Task in OCI Data Integration](https://docs.oracle.com/en-us/iaas/data-integration/using/sql-tasks.htm)

## Acknowledgements

* **Author** - Theodora Cristea
* **Contributors** -  Aditya Duvuri, Rohit Saha
* **Last Updated By/Date** - Theodora Cristea, August 2021
