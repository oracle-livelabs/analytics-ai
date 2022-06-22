# Design and Run your ETL Pipeline

![DI Pipeline](images/pipeline-banner.jpeg)

## Introduction

A **data flow** is a visual program representing the flow of data from source data assets, such as a database or flat file, to target data assets, such as a data lake or data warehouse.

The flow of data from source to target can undergo a series of transforms to aggregate, cleanse, and shape the data.

Data engineers and ETL developers can then analyze or gather insights and use that data to make business decisions.


Estimated Time: 30 minutes.

### Objectives

In this section, you will:

- Create the Data Flow.
- Create the Integration Task.
- Publish the Integration Task.
- Run the Task.

### Prerequisites

- All previous sections have been successfully completed.

## Task 1: Create the Data Flow

1. Click **Create Data Flow**.

   ![Data Flow create button](images/dataflow-create-button.png)

2. Set the **Name**, **Project** and **Description** in the New Data Flow Panel:

      - Name: `CSV to MySQL` 
      ```
      <copy>CSV to MySQL</copy>
      ```
      - Project or Folder: click on the empty field and the projects that you have created will show up. Click on `My First Project` and **Select**.
      - Description: `Data Flow from CSV on Object Storage to MySQL Database`
      ```
      <copy>Data Flow from CSV on Object Storage to MySQL Database</copy>
      ```
      - Click **Create**

   ![Data Flow select project](images/dataflow-select-project-new.png)

   It should look like this:

   ![Data Flow properties](images/dataflow-properties.png)

3. From the **Operators** panel, drag and drop the **Source** icon into the canvas.

   ![Data Flow source](images/dataflow-source-dnd.png)

4. Click **right mouse bottom** on top of **Source_1** and select **Details**.

   ![Data Flow details](images/dataflow-details.png)

5. Set the **Identifier** as `FISH_SURVEY` in the **Details** tab from the Source **Properties** panel. Then go to **Data Asset** and click **Select**.

   - Identifier: `FISH_SURVEY`
      ```
      <copy>FISH_SURVEY</copy>
      ```

   ![Data Flow source ID](images/dataflow-source-id.png)

6. From the **dropdown**, select `bucket-study` and click **Select**.

   ![Data Flow source data asset bucket](images/dataflow-source-data-asset-bucket.png)

7. **Select** `Default Connection` in the Connection section. In the **Schema** section, select the **Compartment** that you have used to create for this workshop, `root`. Then click **Select** and pick the name of the bucket `bucket-study`. And finally, select the **Data Entity**.

   ![Data Flow source data entity](images/dataflow-source-data-entity.png)

8. Browse by **Name**:

   ![Data Flow source data entity browser](images/dataflow-source-data-entity-browse.png)

9. **Select** `mds-di-ds-reef_life_survey_fish.csv` file.

   ![Data Flow source data entity file](images/dataflow-source-data-entity-file.png)

10. And click **Select**.

   ![Data Flow source data entity file select](images/dataflow-source-data-entity-file-select.png)

11. On the dropdown for **File Type**, pick `CSV`.

   ![Data Flow source data entity file type](images/dataflow-source-data-entity-file-type.png)

12. Then click **Select**.

   ![Data Flow source data entity file type csv](images/dataflow-source-data-entity-file-type-csv.png)

13. At this point, your source has access to the **Attributes**, where you can see the different fields of your dataset.

   ![Data Flow source data entity attributes](images/dataflow-source-data-entity-attributes.png)

   **Confirm** you can see **Attributes** and **Data**.

   Let's move into the target for our **MySQL Database**.

14. Drag and Drop the **Target** icon into the canvas.

   ![Data Flow target](images/dataflow-target-dnd.png)

15. Set the **Identifier** as `MySQL_DB` in the **Target**, and leave **Integration Strategy** as `Insert`:

   - Identifier: `MySQL_DB`
      ```
      <copy>MySQL_DB</copy>
      ```

   ![Data Flow target ID](images/dataflow-target-id.png)

16. This time, pick the `mysql-database` **Data Asset**. Also select **Connection** as `Default Connection`.

   ![Data Flow target MySQL](images/dataflow-target-data-asset-mysql.png)

17. For the **Schema**, select `nature`.

   ![Data Flow target schema](images/dataflow-target-data-asset-schema-nature.png)

18. For **Data Entity**, we select the table `fish`.

   ![Data Flow target data entity](images/dataflow-target-data-asset-data-entity.png)

   ![Data Flow target data entity fish](images/dataflow-target-data-asset-data-entity-fish.png)

19. At this point, we can see the fields of the table under the **Attributes** tab.

   ![Data Flow target data attributes](images/dataflow-target-attributes.png)

20. Time to **wire Source and Target**. Draw the link between `FISH_SURVEY` and `MYSQL_DB`. Starting from the circle in `FISH_SURVEY` source box and finishing over `MYSQL_DB` target box.

   ![Data Flow source to target](images/dataflow-source-to-target.png)

21. The **final result** should look like the following.

   ![Data Flow source to target linked](images/dataflow-source-to-target-linked.png)

22. **Make sure** `MYSQL_DB` target is selected (green border) and click on the **Map** tab on the **Properties** panel. 
**Drag and drop** the fields with NO `Auto` in the mapping column (from left to right). **Do it until they are all mapped**. 
You can **expand / shrink** the Properties canvas.

   ![Data Flow source to target map](images/dataflow-source-to-target-map.png)

23. Make sure the yellow indicator of `Not Mapped` contains **0**, meaning there is no left fields unmapped.

   ![Data Flow source to target map completed](images/dataflow-source-to-target-map-completed.png)

24. The **final step** is to **validate** the Data flow. Click **Validate**, check there are `O Total Warnings or/and  O Total Errors` and click **Save and Close**.

   ![Data Flow source to target validate](images/dataflow-validate.png)

---

## Task 2: Create the Integration Task

1. Go back to **Home** and Click **Create Integration Task**.

   ![Integration task create](images/integrationtask-create-button.png)

2. Set the **Name** and the rest of the info as follows:

      - Name: `IntegrationTaskMySQL`
         ```
         <copy>IntegrationTaskMySQL</copy>
         ```
      - Description: `Integration Task MySQL`
         ```
         <copy>Integration Task MySQL</copy>
         ```
      - Project or Folder: `My First Project`. Be sure you have selected this Project or Folder, otherwise, you will have an error.
      - Data Flow: `CSV to MySQL`

   ![Integration task fields](images/integrationtask-fields.png)

3. Wait for the **Validation** to be **Successful** on the Data Flow and click **Create and Close**.

   ![Integration task save](images/integrationtask-save.png)

---

## Task 3: Publish the Integration Task

1. Go to **Projects** on the home screen.

   ![DI projects](images/di-select-projects.png)

2. Click on **My First Project**.

   ![DI projects My First Project](images/di-select-projects-my-first-project.png)

3. On the Details menu (left), click on **Tasks**.

   ![DI projects tasks menu](images/di-project-tasks-menu.png)

4. Select **IntegrationTaskMySQL**, and click **Publish to Application**.

   ![DI projects tasks publish integration](images/di-project-tasks-publish-integration.png)

5. **Select** (if not selected by default) your **Default Application**. Click **Publish**.

   ![DI projects tasks publish integration to app](images/di-project-tasks-publish-integration-to-default-app.png)

---

## Task 4: Run the Task

1. Go back to the **Home** screen and click **Applications**.

   ![DI application menu](images/di-application-menu.png)

2. Select **Default Application**, and you will see your task **IntegrationTaskMySQL**.

   ![DI application integration menu](images/di-application-integration-dots.png)

3. Click on the **Context Menu** (three dots) and click **Run**.

   ![DI application integration run](images/di-application-integration-run.png)

4. Wait few seconds and the **Status** will change from `Not Started` to `Queued`, and after to `Running`. 

   ![DI application integration not started](images/di-application-integration-not-started.png)

   ![DI application integration queued](images/di-application-integration-queued.png)

   ![DI application integration running](images/di-application-integration-running.png)

5. Feel free to click **Refresh** from time to time until you see `Success` on the Status.

   ![DI application integration success](images/di-application-integration-success.png)

---

## Task 5: It Works

1. On the bastion host in **Cloud Shell** (reconnect from Cloud Shell to the bastion host if timed out: `ssh -i .ssh/bastion opc@PUBLIC_IP`), run the **MySQL Shell** in the `bash` **Terminal** with:

      ```
      <copy>mysqlsh --sql root@PRIVATE_IP</copy>
      ```

2. If requested, write the MySQL **Password**.

3. Set `nature` as the **Schema** in use.

      ```
      <copy>use nature;</copy>
      ```

      The result message says:
      `Default schema set to nature.`
      `Fetching table and column names from nature for auto-completion... Press ^C to stop.` You can continue.

4. Count the **number** of rows in the table `fish` by running the following query.

      ```sql
      <copy>select count(1) from fish;</copy>
      ```

   You should see 3493 as result.

5. **Exit** with:

      ```
      <copy>\exit</copy>
      ```

Congratulations, you are ready for the next Lab!

---

## **Acknowledgements**

- **Author** - Victor Martin, Technology Product Strategy Director
- **Contributors** - Priscila Iruela
- **Last Updated By/Date** - Priscila Iruela, June 2022