# Automating Data Processing with Oracle AI Data Platform Workflows

## Introduction

This lab guides you through the process of creating and managing workflows in Oracle AI Data Platform to automate data processing tasks.

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

## Task 1: Understanding Workflows in Oracle AI Data Platform

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
