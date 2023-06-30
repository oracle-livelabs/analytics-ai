# Create a Data Flow and Integration task

## Introduction

Learn how to create **Data Flows** along with an **Integration task** in OCI Data Integration. The use-case for each of these data integration tasks is detailed in the associated workshop task.

**Estimated Time**: 20 minutes

### Objectives
* Create a Data Flow.
* Create Integration task.

## Task 1: Create a Data Flow

To further explore the capabilities of Data Flows in OCI Data Integration, you will now create **a new Data Flow** with different transformation rules.

This Data Flow will load data from **multiple source files** containing Employees data using File Patterns functionality in OCI Data Integration. After, you will do transformations on the Employees data and later load the data in **multiple target tables**, based on the region of the employees. Two target tables will be loaded: one for employees from **West and Midwest region** and one for employees from **Northeast and South region**. We will take advantage of the **Split operator** in OCI Data Integration Data Flows.

1. From the Project Details page for `DI_WorkshopNN` project, click on **Data Flows** from the submenu.

  ![](images/ocw23_lab2_1.png " ")

2. Click **Create Data Flow**.

  ![](images/ocw23_lab2_2.png " ")

3. The data flow designer opens in a new tab. In the **Properties panel**, for **Name**, enter `Load Employees by Region`, and click **Create**.

  ![](images/ocw23_lab2_3.png " ")
  ![](images/ocw23_lab2_4.png " ")

4. You will add your **Source operator**. You add source operators to identify the data entities to use for the data flow. From the Operators panel on the left, drag and drop a Source operator onto the canvas.

  ![](images/ocw23_lab2_5a.png " ")

5.  On the canvas, select **SOURCE\_1** operator. The Properties panel now displays the details for this operator.

  ![](images/ocw23_lab2_5.png " ")


6. In the **Details** tab, click Select next to each of the following options to make your selections:

    - For **Identifier**, rename to `EMPLOYEES_SOURCE_FILES`.
    - For **Data Asset**, select `Object_Storage`.
    - For **Connection**, select `Default Connection`.
    - For **Schema**, select your **compartment** and then your **bucket**. For the purposes of this tutorial, **Object Storage** serves as the source data asset, this is why you select your bucket here.
  ![](images/ocw23_lab2_5b.png " ")
    - For **Data Entity**, click on **Select** and then on **Browse by Pattern**.
  ![](images/ocw23_lab2_6.png " ")

   Write the file pattern `EMPLOYEES_*` and click **Search**. All files from your Object Storage bucket that are found which match this pattern are now displayed: there are three files for employees. Click on **Select Pattern**.
  ![](images/ocw23_lab2_7.png " ")

   For **File Type**, choose **CSV** and leave the defaults for the other fields that appear. Click **Select**.
  ![](images/ocw23_lab2_8.png " ")

   In the end, your details for the source operator should look like this.
  ![](images/ocw23_lab2_9.png " ")

7. Drag and drop a **Distinct operator** on the data flow canvas. We use the distinct operator to return distinct rows with unique values. Connect **EMPLOYEES\_SOURCE\_FILES** source to the **DISTINCT\_1** operator.  *Note*: Be sure to save often during design time!

  ![](images/ocw23_lab2_10.png " ")

8. Drag and drop an **Expression operator** on the data flow canvas. Connect the **DISTINCT\_1** operator to the new **Expression** operator.

  ![](images/ocw23_lab2_11.png " ")

9. In the Properties panel for **EXPRESSION\_1** operator, rename the Identifier to **TRANSFORM\_DATATYPES**.

  ![](images/ocw23_lab2_11.png " ")

10. You will now add a **new expression**. Still in the Properties panel, click on **Add Expression**.

  ![](images/ocw23_lab2_12.png " ")

11. In the **Add Expression** panel:

    - **Rename** the expression to `BIRTH_DATE` in the Identifier field.
    - Change **Data Type** to `DATE`.
    - Enter
    ```
    TO_DATE(EXPRESSION_1.EMPLOYEES_SOURCE_FILES.Date_of_Birth, 'MM/dd/yyyy')
    ```
   in the **expression** box.

   This function will convert the **STRING** value of birth date from the source files to a **DATE** data type value, in the specified format. You can also find this function in **Functions** tab, under **Date/Time** section and select it from there. Attributes can be added from **Incoming** tab, by highlighting a function's placeholders and then double-click or drag and drop attributes from the Incoming list to create an expression.
    - Click **Add**.

  ![](images/ocw23_lab2_13.png " ")

12. Your expression for **BIRTH\_DATE** is now displayed. Click again on **Add Expression** to add a new one.

  ![](images/ocw23_lab2_14.png " ")

13. In the **Add Expression** panel:

    - **Rename** the expression to `YEAR_OF_JOINING` in the Identifier field.
    - Change **Data Type** to `NUMERIC`.
    - Enter   
    ```
    TO_NUMBER(EXPRESSION_1.EMPLOYEES_SOURCE_FILES.Year_of_Joining)
    ```
   in the **expression** box. This function will transform your string value of year of joining from the files to a number value.
    - Click **Add**.

  ![](images/ocw23_lab2_15.png " ")

14. The expressions for the **TRANSFORM\_DATATYPES** operator should now look like this:

  ![](images/ocw23_lab2_16.png " ")

15. Drag and drop an **Expression operator** on the data flow canvas. Connect the **TRANSFORM\_DATATYPES** operator to the new **Expression** operator.  *Note*: Be sure to save often during design time!

  ![](images/ocw23_lab2_17.png " ")

16. In the Properties panel for the new **EXPRESSION\_1 operator**, change the Identifier to **EMPLOYEE\_AGE\_AND\_PHONE**.

  ![](images/ocw23_lab2_18.png " ")

17. You will now add a new expression. Still in the Properties panel, click on **Add Expression**.

  ![](images/ocw23_lab2_19.png " ")

18. In the **Add Expression** panel:

    - **Rename** the expression to `EMPLOYEE_AGE` in the Identifier field.
    - Change **Data Type** to `NUMERIC`.
    - Enter

    ```
    CASE WHEN DAYOFYEAR(CURRENT_DATE)>=DAYOFYEAR(EXPRESSION_1.TRANSFORM_DATATYPES.BIRTH_DATE) THEN TRUNC(YEAR(CURRENT_DATE)-YEAR(EXPRESSION_1.TRANSFORM_DATATYPES.BIRTH_DATE)) ELSE TRUNC(YEAR(CURRENT_DATE)-YEAR(EXPRESSION_1.TRANSFORM_DATATYPES.BIRTH_DATE)-1) END
    ```
   in the **expression** box.
   This function will calculate the age of the employee, by doing a minus between the current date and his birth date. CASE WHEN function returns the value for which a condition is met.

   *Note*: In case the attributes in the expression don't get automatically highlighted, please replace them, by highlighting in the expression's placeholders and then double-click or drag and drop attributes from the Incoming list.
    - Click **Add**.

  ![](images/ocw23_lab2_20.png " ")

19. You will now add a new expression in the same operator. Still in the Properties panel, click on **Add Expression**.

  ![](images/ocw23_lab2_21.png " ")

20. In the **Add Expression** panel:

    - **Rename** the expression to `PHONE_NO` in the Identifier field.
    - Leave **Data Type** as `VARCHAR`.
    - Enter   
    ```
    COALESCE(EXPRESSION_1.EMPLOYEES_SOURCE_FILES.Phone_No,'Phone Number Not Available')
    ```
   in the **expression** box
   This function will fill in the null values for phone number with string `Phone Number Not Available`.
    - Click **Add**.

  ![](images/ocw23_lab2_22.png " ")

21. The two expressions you defined for this operator are now displayed. Click on **Attributes** tab.  *Note*: Be sure to save often during design time!

  ![](images/ocw23_lab2_23.png " ")

22. Check the following two fields: **EMPLOYEES\_SOURCE\_FILES.Age\_in\_Yrs**, **EMPLOYEES\_SOURCE\_FILES.Year\_of\_Joining**. We will exclude these fields from this operator.

  ![](images/ocw23_lab2_24.png " ")

23. Click on **Actions** and then on **Exclude by selection**.

  ![](images/ocw23_lab2_25.png " ")

24. The fields are now excluded. Click on **View Rules** to see the rules you defined.

  ![](images/ocw23_lab2_26.png " ")

25. Click on **Data** tab of the **EMPLOYEE\_AGE\_AND\_PHONE** operator.

  ![](images/ocw23_lab2_27.png " ")

26. Scroll to the right until you get to the attribute **EMPLOYEE\_AGE\_AND\_PHONE.EMPLOYEES\_SOURCE\_FILES.Region**. Click on it and a **Data Profile** window will appear. You can observe that there is employee data from four regions: Northeast, West, South, Midwest. In this data flow you will split the employee data into two target tables based on the **region**: one target table for employees from **Northeast and South** region (table named `EMPLOYEES_NORTHEAST_SOUTH`) and one target table for employees from **West and Midwest** region (table named `EMPLOYEES_WEST_MIDWEST`).

  ![](images/ocw23_lab2_28.png " ")

27. Drag and drop a **Split operator** on the data flow canvas. Connect the **EMPLOYEE\_AGE\_AND\_PHONE operator** to the new **Split operator**. Use the split operator to divide one source of input data into two or more output ports based on split conditions that are evaluated in a sequence. Each split condition has an output port. Data that satisfies a condition is directed to the corresponding output port.  *Note*: Be sure to save often during design time!

  ![](images/ocw23_lab2_29.png " ")

28. In the **Properties** bar of the Split Operator, we will leave the default **Identifier** (**SPLIT\_1**) and **Match** option (**First matching condition** means that data that matches the first condition should be removed from further processing by other conditions).

  ![](images/ocw23_lab2_29.png " ")

29. Still in Properties bar of the Split Operator, click on **Add Condition** in **Split Conditions section**.

  ![](images/ocw23_lab2_29.png " ")

30. In **Add Split Condition** page:

    - Enter **Identifier** `WEST_MIDWEST_REGION`.
    - For **Condition** enter
    ```
    SPLIT_1.EMPLOYEES_SOURCE_FILES.Region IN ('Midwest','West')
    ```
    - Click **Add**.

  ![](images/ocw23_lab2_30.png " ")

31. The first split condition you defined is now displayed. The Split operator properties should look like this:

  ![](../../integration-tasks/images/split-operator-properties.png " ")
  ![](images/ocw23_lab2_31.png " ")

32. Still in Properties bar of the Split Operator, click on **Add Condition** in **Split Conditions section** to add a new split condition.

  ![](images/ocw23_lab2_31.png " ")


33. In **Add Split Condition** page:

    - Enter **Identifier** `NORTHEAST_SOUTH_REGION`.
    - For **Condition** enter
    ```
    SPLIT_1.EMPLOYEES_SOURCE_FILES.Region IN ('Northeast','South')
    ```
    - Click **Add**.

  ![](images/ocw23_lab2_32.png " ")

34. The split conditions that you defined are now displayed. After the conditions in the split operator are evaluated during run-time, data that does not meet the condition is directed to the **Unmatched** output port.

  ![](images/ocw23_lab2_33.png " ")

35. Drag and drop a **target operator**. Connect the **WEST\_MIDWEST\_REGION** output of the Split operator to the **TARGET\_1** operator.  *Note*: Be sure to save often during design time!

  ![](images/ocw23_lab2_34.png " ")

36. In the properties for **TARGET\_1** operator:

    - Change to **Merge Integration Strategy**.
    - For **Data Asset**, select `Data_Warehouse`.
    - For **Connection**, select `Beta connection`.
    - For **Schema**, select `Beta`.
    - For **Data Entity**, select `EMPLOYEES_WEST_MIDWEST` (this target table was created with the SQL script from _Setting up the Data Integration prerequisites in OCI that you ran on the Autonomous Data Warehouse).
    - For **Staging Location**, select your **Object Storage bucket** (`DI-bucket`).
    - **Merge Key** will automatically get populated with the primary key name of the table, from the database.

  ![](images/ocw23_lab2_35.png " ")

37. Go to **Map** tab of the **EMPLOYEES\_WEST\_MIDWEST** target operator. There are 3 attributes that were not mapped automatically in the target.

  ![](images/ocw23_lab2_36.png " ")

38. **Manually map** the **E\_Mail** attribute from source  to **EMAIL** attribute from target, with drag and drop.

  ![](images/ocw23_lab2_37.png " ")

39. You will use **mapping by pattern** to map the two remaining unmapped attributes. This maps inbound attributes to target attributes based on simple, user-defined regex rules. Click on **Actions** button and then on **Map by pattern**.

  ![](images/ocw23_lab2_38.png " ")

40. In the **Map by pattern** page that pops up:

    - For **Source Pattern**, use `*_S_NAME`.
    - For **Target Pattern**, use `$1S_NAME`.
    - Click on **Preview Mapping**. In the table, the mapping for FATHERS\_NAME and MOTHERS\_NAME attributes is now displayed.
    - Click on **Map**.

   *Note:* For more information on how to use **Mapping by pattern**, please see the following [link](https://docs.oracle.com/en-us/iaas/data-integration/using/using-operators.htm#operator-target), section Target Operator, **Mapping attributes**.

  ![](images/ocw23_lab2_39.png " ")

41. The attribute mapping for the **EMPLOYEES\_WEST\_MIDWEST target table** is now complete.  *Note*: Be sure to save often during design time!

  ![](images/ocw23_lab2_40.png " ")

42. Drag and drop **another target operator**. Connect the **NORTHEAST\_SOUTH\_REGION output port** of the Split operator to the **TARGET\_2 operator**. In Properties tab of the new target operator:

    - Change to **Merge Integration Strategy**.
    - For **Data Asset**, select `Data_Warehouse`.
    - For **Connection**, select `Beta connection`.
    - For **Schema**, select `Beta`.
    - For **Data Entity**, select `EMPLOYEES_NORTHEAST_SOUTH` (this target table was created with the SQL script from _Setting up the Data Integration prerequisites in OCI_ that you ran on the Autonomous Data Warehouse).
    - For **Staging Location**, select your **Object Storage bucket** (`DI-bucket`)
    - **Merge Key** will automatically get populated with the primary key name of the table, from the database.

   **Make sure you also map all of the columns, same as in steps 38, 39 and 40.**

  ![](images/ocw23_lab2_41.png " ")

43. The design of the Data Flow is now ready. Click on **Validate**. The Validation panel lets you know if any warnings or errors were detected.  *Note*: If any warnings or errors are found, select an issue and it'll take you to the operator that caused it, to investigate further. Warnings that might be displayed should not cause the task to fail.

  ![](images/ocw23_lab2_42.png " ")

44. Click on **Save and Close**.

  ![](images/ocw23_lab2_43.png " ")

## Task 2: Create Integration Task

**Integration tasks** in OCI Data Integration let you take your data flow design and choose the parameter values you want to use at runtime. With the help of Integration Tasks, you can create multiple Tasks with distinct configurations for the same Data Flow. You will create an Integration task for the Data Flow you created in the previous steps.

1. From your Workspace home page of OCI Data Integration, click **Open tab** (plus icon), and then select **Projects**.

  ![](../../integration-tasks/images/home-projects.png " ")

2. On the **Projects** page, select the project you have been working on for this workshop, `DI_WorkshopNN`.

  ![](../../integration-tasks/images/select-project.png " ")

3. On the `DI_WorkshopNN` **Project Details** page, from the submenu, click **Tasks**.

  ![](images/ocw23_lab2_43.png " ")

4. Click **Create Task**, and then select **Integration**.

  ![](images/ocw23_lab2_44.png " ")

5. The **Create Integration Task** page opens in a new tab. On this page:

    - Change the **Name** to `Load Employees by Regions` and enter the optional **Description**. The value in the **Identifier** field is auto-generated based on the value you enter for Name.
    - In the Data Flow section, click Select. In the **Select a Data Flow** panel, select `Load Employees by Region`, and then click Select.
    - The Data Flow will be **validated**.
    - Click **Create and Close**.

  ![](images/ocw23_lab2_45.png " ")

   **Congratulations!**  You created the Data Flow and Integration task in OCI Data Integration.

## Learn More

* [Data Flow in OCI Data Integration](https://docs.oracle.com/en-us/iaas/data-integration/using/data-flows.htm)
* [Integration Task in OCI Data Integration](https://docs.oracle.com/en-us/iaas/data-integration/using/integration-tasks.htm)
* [Data Loader Task in OCI Data Integration](https://docs.oracle.com/en-us/iaas/data-integration/using/data-loader-tasks.htm)
* [SQL Task in OCI Data Integration](https://docs.oracle.com/en-us/iaas/data-integration/using/sql-tasks.htm)

## Acknowledgements

* **Contributors** -  David Allan, Theodora Cristea
* **Last Updated By/Date** - David Allan, June 2023
