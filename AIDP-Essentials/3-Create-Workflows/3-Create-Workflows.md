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

## Task 1: Create a Workflows for each Tier of the Medallion Architecture

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

## Task 1: Create and Schedule a Workflow to Run the Medallion Architecture

1. Now you will make a final workflow that ties together the 3 you just created. Again create a workflow and call it **Medallion_Workflow**.

2. Name the first task **Bronze_Tier** and select **Nested task** for the **Task type**. Browse the available jobs and select the **Bronze_Workflow** job. This means that the entire workflow will run as a single task within the **Medallion_Workflow**.

3. We would like to configure this workflow so that the bronze their tasks run every day, but the silver and gold ones only run on weekdays. To achieve this, create a second task called **Weekday_Condition** and for **Task type** choose **If/else condition**.

4. Under **Condition** next to **A**, paste in the below text. This references a parameter that returns true on weekdays and false on the weekend. Select **==** as the operator and type **true** into the other side of the condition expression. Leave all other options as is.

'''{{job.start_time.is_weekday}}'''

5. Create a third task and name it **Silver_Tier**. Also make it a **Nested task** and choose the **Silver_Workflow** job. Under the **Depends on** section make sure that **Weekday_Condition (true)** is selected. This means that this task will only run when the condition in the if/else condition evaluates to true. Here you could create an alternate branching task to run if the condition returned false instead.

6. Create a fourth task and name it **Gold_Tier**. Make sure that it is dependent on the **Silver_Tier** task.

7. Now your workflow is complete combining all of the data processing for the bronze, silver, and gold tier. Select **Run now** to give it a test run. Navigate to the **Runs** tab and **View** next to the run to see its details

8. The **Graph** section displays the tasks you created, which you can select to view their output.

9. Select the **Timeline** tab. This shows a timeline of when the different tasks executed. Notice that if you are running this on the weekend the silver and gold tasks will not have run because of the condition we set.

10. Select **Medallion_Job** in the breadcrumb menu then select **Details** to see the details for the job itself.

11. On this page you can view and set a number of settings for the job, but we are interested in the **Schedule** section. Select **Add** to create a new schedule.

12. Set the **Frequency** to daily and leave all other options as is. Select **Create**. 

## Learn More

* [Oracle AI Data Platform Documentation](https://docs.oracle.com/en/cloud/paas/ai-data-platform/)

## Acknowledgements
* **Author** - Miles Novotny, Senior Product Manager, Oracle Analytics Service Excellence
* **Contributors** -  Farzin Barazandeh, Senior Principal Product Manager, Oracle Analytics Service Excellence
* **Last Updated By/Date** - Miles Novotny, December 2025
