# Create Workflows to Operationalize a Medallion Architecture with AIDP Workbench

## Introduction

This lab guides you through the process of creating and managing jobs from the Workflows tab in Oracle AI Data Platform Workbench to automate data processing tasks. You will configure jobs to process your medallion architecture data on a regular basis.

Estimated Time: 45 minutes

### Objectives

In this lab, you will:
* Learn the core concepts of workflow creation in Oracle AI Data Platform.
* Create and configure jobs and tasks within a workflow.
* Implement conditional logic to customize job execution.
* Monitor and manage job runs.

### Prerequisites

This lab assumes you have:

* A basic understanding of data pipelines concepts.

## Task 1: Create Workflows for each Tier of the Medallion Architecture

You would like your medallion notebooks to run on a schedule so that new data added to your data sources is processed regularly. 

1. Begin by selecting **Workflow** and then **Create job**

    ![access workflows](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/create-job.png)

2. Enter the Job Name **Bronze\_Workflow** and leave all other fields as they are. Select **Create**

    ![name workflow](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/create-workflow.png)

3. You are brought to the job editor where you can define the tasks that make up your job. The first task is already open. Enter the task name **Bronze\_1**. For **Task type** select **Notebook task**. Select **Browse** and navigate to the **Bronze** folder to select the `1_Create_Bronze_Tier.ipynb` file. For **Cluster** select **Medallion\_Compute**.

    ![create first task](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/bronze-task-details.png)

4. This is the only bronze notebook, so this is the only task you will create. Select **Run now** and navigate to the **Runs** tab to test if the job runs successfully. A green check will appear when it does.

    ![run job](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/run-bronze.png)

5. Return to the workflows page using the breadcrumb menu. Create a second workflow called **Silver\_Workflow**.

    ![create silver workflow](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/create-silver-workflow.png)

6. Create a first task called **Silver\_1** in the same way you did for the bronze job, this time using the `2_silver_transformation.ipynb` notebook.

    ![create silver task 1](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/silver-task-1.png)

7. Create a second task by selecting **Add task**. Name this one **Silver\_2** and make it in the same way using the `3_silver_transformation_continent.ipynb` notebook.

    ![create second silver task](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/silver-add-task.png)

8. Notice that the section **Depends on** has **Silver\_1** selected. This means that currently this task depends on the first task. The **Run if** selection tells us that this second task will only run if the first task executes and succeeds. Leave these selections as is, but note that different **Run if** conditions can allow you to create branching tasks depending on the results of previous ones.

    ![depends on](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/silver-depends.png)

9. Create a third and final task for this workflow. Make it a notebook task to run the `4_silver_transformation_summary.ipynb` notebook. Make sure that it is dependent on the second task.

    ![create third task](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/silver-3-details.png)

10. Test this workflow by choosing **Run now** and navigating to the **Runs** tab.

    ![run job](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/run-bronze.png)

11. Create a third workflow called **Gold\_Workflow**. Add tasks to run `5_Gold_join.ipynb` and `6_gold_job_into_DB.ipynb` from the **Gold** folder in numerical order. Before running the workflow, open `5_Gold_join.ipynb` and confirm that it does not contain empty code cells at the end of the notebook. If blank trailing code cells are present, delete them and save the notebook. Workflow runs can remain in a running state if the notebook contains empty trailing code cells. Run the job to test it as you did the previous ones.

    ![create gold workflow](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/gold-workflow.png)

## Task 2: Create Unified Job to Run Medallion Architecture

Now you will make a final workflow that ties together the 3 you just created.

1. Create a workflow and call it **Medallion\_Workflow**.

    ![create medallion workflow](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/create-medallion-workflow.png)

2. Name the first task **Bronze_Tier** and select **Nested job task** for the **Task type**. Browse the available jobs and select the **Bronze\_Workflow** job. This means that the entire workflow will run as a single task within the **Medallion\_Workflow**.

    ![create bronze task](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/bronze-tier-details.png)

3. We would like to configure this workflow so that the bronze tier tasks run every day, but the silver and gold ones only run on weekdays. To achieve this, create a second task called **Weekday\_Condition** and for **Task type** choose **If/else condition**.

    ![create weekday condition](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/ifelse-name.png)

4. Under **Condition** next to **A**, paste in the below text. This text references a parameter that returns true on weekdays and false on the weekend. Select **==** as the operator and type **true** into the other side of the condition expression. Leave all other options set to the defaults. Optionally you could add additional conditions to the if/else logic, but you only need the one.

    ```
      <copy>
      {{job.start_time.is_weekday}}
      </copy>
      ```

    ![define condition](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/ifelse-task.png)

5. Create a third task and name it **Silver\_Tier**. Make it a **Nested job task** and choose the **Silver\_Workflow** job. Under the **Depends on** section make sure that **Weekday\_Condition (true)** is selected. This means that this task will only run when the condition in the if/else condition evaluates to true. Here you could create an alternate branching task to run if the condition returned false instead.

    ![create silver task](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/silver-tier.png)

6. Create a fourth task and name it **Gold\_Tier**. Make it a **Nested job task** and choose the **Gold\_Workflow** job. Make sure that it is dependent on the **Silver\_Tier** task.

    ![Create gold task](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/gold-tier.png)

7. Now your workflow is complete. It combines all of the data processing for the bronze, silver, and gold tiers. Select **Run now** to test the workflow. If a run does not appear on the **Runs** tab after a few seconds, select **Run now** again. Navigate to the **Runs** tab and select **View** to see its details.

    ![run workflow](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/run-medallion.png)

8. The **Graph** section displays the tasks that make up the job run. Select a task to view details for that task.

    ![view graph](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/run-graph.png)

9. Select the **Timeline** tab. This tab displays tasks executed. If you are running this workflow on the weekend, the silver and gold tasks will not have run because of the if/else task you added.

    ![view timeline](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/timeline-tab.png)

10. Select **Medallion\_Workflow** in the breadcrumb menu and then select **Details** to view job details.

    ![navigate to details](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/navigate-to-details.png)

11. On this page you can view and modify settings for the job, but we are interested in the **Schedule** section. Select **Add** to create a new schedule.

    ![add schedule](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/add-schedule.png)

12. Set the **Frequency** to **Daily**. The schedule form may default to **Weekly**, so confirm the value before selecting **Create**. Leave all other options as is.

    ![define schedule](https://oracle-livelabs.github.io/analytics-ai/aidp-essentials/3-create-workflows/images/set-schedule.png)

You have now created and scheduled a job to process your data into the 3 tiers of the medallion architecture, ensuring that high quality data is created and regularly updated for regular use.

## Learn More

- [Oracle AI Data Platform Community Site](https://community.oracle.com/products/oracleaidp/)
- [Oracle AI Data Platform Documentation](https://docs.oracle.com/en/cloud/paas/ai-data-platform/)
- [Oracle Analytics Training Form](https://community.oracle.com/products/oracleanalytics/discussion/27343/oracle-ai-data-platform-webinar-series)
- [AIDP Workflows Documentation](https://docs.oracle.com/en/cloud/paas/ai-data-platform/aidug/workflows.html)

## Acknowledgements
* **Author** - Miles Novotny, Senior Product Manager, Oracle Analytics Service Excellence
* **Contributors** -  Farzin Barazandeh, Senior Principal Product Manager, Oracle Analytics Service Excellence
* **Last Updated By/Date** - Miles Novotny, March 2026

