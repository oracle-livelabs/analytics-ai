# Automating Data Processing with Oracle AI Data Platform Workflows

## Introduction

This lab guides you through the process of creating and managing jobs from the Workflows tab in Oracle AI Data Platform to automate data processing tasks. You will configure the jobs to process your medallion architecture data on a regular basis.

Estimated Time: 45 minutes

### Objectives

In this lab, you will:
* Understand the core concepts of workflows in Oracle AI Data Platform.
* Create and configure jobs and tasks within a workflow.
* Implement parameterization to customize job executions.
* Monitor and manage job runs.

## Prerequisites

This lab assumes you have:
* An Oracle Cloud account with access to Oracle AI Data Platform.
* Basic knowledge of data processing concepts.

## Task 1: Create a workflow to run your medallion Notebooks

1. You would like your medallion notebooks to run on a schedule so that new data added to your data sources is regularly processed. Begin by selecting **Workflow** then **Create job**

2. Name it **Bronze_Workflow** and leave all other fields as they are. Select **Create**

3. You are brought to the job editor where you can define the jobs that make up your task. The first task is already open, name it **Bronze_1**. For **Task type** select **Notebook task**. Select **Browse** and navigate to the **Bronze** folder to select the **create_bronze_tier** file. For **Cluster** select **Medallion_Compute**.

4. Leave all other options as is and select **Add task** to create a second task. Name this **Bronze_2**. Navigate to the **Bronze** folder to select the **2_upload_suppliar_emotions** file. Use **Medallion_Compute** again.

5. Notice the section **Depends on** has **Bronze_1** selected. This means that currently this task depends on the first task. The **Run if** selection tells us that this second task will only run if the first task executes and succeeds. Leave these selections as is, but note that different **Run if** conditions can allow you to create branching tasks depending on the results of previous ones.

6. This workflow is now complete, test that it runs correctly by selecting **Run now**. Select the **Runs** tab to monitor the progress of the run. A green check will appear when it finishes running successfully.

7. return to the workflows page using the breadcrumb menu. Create a second workflow called **Silver_Workflow**.

8. Populate this workflow with all of the notebooks in the **Silver** folder. Add them in numerical order so that they each depend on the previous on running successfully.

9. Test this workflow as well by choosing **Run now** and navigating to the **Runs** tab.

10. Create a third workflow called **Gold_Workflow**. Add the notebooks from the **Gold** folder to it and run the job to test it as you did the previous ones.

11. Now you will make a final workflow that ties together the 3 you just created. Again create a workflow and call it **Medallion_Workflow**.

12. Name the first task **Bronze_Tier** and select **Nested task** for the **Task type**. Browse the available jobs and select the **Bronze_Workflow** job. This means that the entire workflow will run as a single task within the **Medallion_Workflow**.

13. We would like to configure this workflow so that the bronze their tasks run every day, but the silver and gold ones only run on weekdays. To achieve this, create a second task called **Weekday_Condition** and for **Task type** choose **If/else condition**.

14.

14. Under **Condition** next to **A**, paste in the below text. This references a parameter that returns true on weekdays and false on the weekend. Select **==** as the operator and type **true** into the other side of the condition expression. Leave all other options as is.

'''{{job.start_time.is_weekday}}'''

14. Create a third task and name it **Silver_Tier**. Also make it a **Nested task** and choose the **Silver_Workflow** job. Under the **Depends on** section make sure that **Weekday_Condition (true)** is selected. This means that this task will only run when the condition in the if/else condition evaluates to true.

15. Create a fourth task and name it **Gold_Tier**.

1. **Navigate to the Workflows Section:**
   - Log in to your Oracle AI Data Platform instance.
   - Access your workspace and click on the **Workflows** tab.

   ![Workflows Tab](images/workflows_tab.png)

   > **Note:** Workflows are tied to workspaces, allowing for organized management of data processing tasks.

2. **Explore Existing Jobs:**
   - Within the Workflows section, review any pre-existing jobs to understand their structure and components.

## Task 2: Creating and Configuring a Job

1. **Create a New Job:**
   - Click on **Create Job**.
   - Provide a meaningful name and select the appropriate folder for the job assets.
   - Click **Create**.

   ![Create Job](images/create_job.png)

2. **Add a Task to the Job:**
   - Within the newly created job, click on **Add Task**.
   - Name the task and select the task type (e.g., Notebook Task).
   - Choose the relevant notebook (e.g., `Exit_now.ipynb`).
   - Select the appropriate compute cluster and configure other options as needed.
   - Click **Create**.

   ![Add Task](images/add_task.png)

## Task 3: Implementing Parameterization

1. **Set Parameters for the Task:**
   - Within the task configuration, navigate to the **Parameters** section.
   - Add a new parameter with the key `TARGET_FORMAT` and value `csv1`.
   - Save the configuration.

   ![Set Parameter](images/set_parameter.png)

2. **Run the Job and Observe Behavior:**
   - Click **Run Now** to execute the job.
   - Monitor the job run and note any failures due to incompatible parameter values.

   ![Job Run](images/job_run.png)

3. **Modify Parameter Value:**
   - Change the `TARGET_FORMAT` parameter value to `csv`.
   - Rerun the job and observe successful execution.

   ![Modify Parameter](images/modify_parameter.png)

   > **Note:** Parameter values directly impact job runs; ensure compatibility with the code logic.

## Task 4: Scheduling and Monitoring Jobs

1. **Schedule the Job:**
   - Within the job details, navigate to the **Scheduling** tab.
   - Set up a schedule for the job to run at specified intervals.
   - Save the schedule.

   ![Schedule Job](images/schedule_job.png)

2. **Monitor Job Runs:**
   - Access the **Runs** tab to view job execution history.
   - Review details such as status, logs, and execution time.

   ![Monitor Job Runs](images/monitor_job_runs.png)

   > **Note:** Regular monitoring ensures timely identification and resolution of issues.

## Learn More

* [Oracle AI Data Platform Documentation](https://docs.oracle.com/en/cloud/paas/ai-data-platform/)

## Acknowledgements
* **Author** - Miles Novotny, Senior Product Manager, Oracle Analytics Service Excellence
* **Contributors** -  Farzin Barazandeh, Senior Principal Product Manager, Oracle Analytics Service Excellence
* **Last Updated By/Date** - Miles Novotny, December 2025
