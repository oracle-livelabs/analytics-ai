# Run Data Loader task, schedule and run Pipeline task

## Introduction

Learn how to **run a Data Loader task**, create a **task schedule** in your OCI Data Integration application, to **schedule the Pipeline task** and to **run it**.
After publishing tasks to an Application, you can run a task **manually on-demand**, or you can use schedules and task schedules to **automate the execution** of your tasks.
To run a task automatically on a specific schedule, you must:
* **Create a schedule**: A schedule defines when and how frequently tasks should be run. A schedule can be used across tasks of any type.
* **Create a task schedule for the task**: A task schedule is an automated run configuration for a specific task. You schedule a task to run automatically by creating a task schedule, and associating the task schedule with an existing schedule.

You will schedule your Pipeline Task to run daily at 2PM.

**Estimated Time**: 15 minutes

### Objectives
* Run the Data Loader task
* Create a Schedule
* Schedule the Pipeline Task
* Run the Pipeline Task

1. From your `DI_Workspace` homepage, click on **Applications**.

  ![](images/home3.png " ")

2. From the **list of Applications**, select the `Workshop ApplicationNN` you created, which contains all the tasks that you created previously in this workshop.

  ![](images/home4.png " ")

3. You now have the list of published task in `Workshop ApplicationNN` displayed. From the list of tasks, select **Run** from the **Actions menu** (three dots) for the `Load Revenue Data into Data Warehouse` Data Loader task that you will run.

  ![](../schedule-run/images/run-data-loader-task.png " ")

4. The **Run task** dialog will be displayed, you could change the parameter values here, simply press **Run**.

  ![](images/rundataloader.png " ")

5. A **run entry** is created in the Runs section of the Application details page. You can monitor here the **status** and **duration** of your task run. Click on **Refresh** if you want to update the status.

  ![](../schedule-run/images/data-loader-task-running.png " ")

6. After a short time, The **Data Loader task run ends successfully**.

  ![](../schedule-run/images/data-loader-task-successful.png " ")

## Task 2: Create a Schedule

You will first create a **Schedule** in the Application that contains the tasks that can be scheduled for automated runs. Set up a schedule by selecting a time zone and configuring a frequency at which associated task schedules should run. You can automate task runs on an hourly schedule, or a daily or monthly schedule.

1. In the OCI Console navigation menu, navigate to **Analytics & AI**. Under Data Lake, click **Data Integration**.

  ![](images/home_menu.png " ")

2. From the Workspaces page, make sure that you are in the compartment you created for data integration (`DI-compartment`). Click on your **Workspace** (`DI-workspace`).

  ![](images/workspaces.png " ")

3. From your `DI_Workspace` homepage, click on **Applications**.

  ![](images/workspace_home.png " ")

4. From the **list of Applications**, select the `Workshop ApplicationNN`, which contains all the tasks that you created previously in this workshop.

  ![](images/applications.png " ")

5. On the Application details page, click **Schedules tab** under Details.

  ![](images/menu.png " ")

6. Click **Create Schedule**.

  ![](images/schedules.png " ")

7. On the **Create Schedule** page:

    - Enter a **Name**: `Daily Schedule 2PM`
    - Enter a **Description** (optional)
    - Select a **Time Zone** for this schedule: `For example, (UTC+01:00) Central European Time (CET)`
    - From the **Frequency** drop-down, select `Daily`
    - **Repeat Every**: Enter the number of days between scheduled runs. We want the schedule to repeat every single day, so leave the default option of `1`
  For example, enter 2 if you want the schedule to run every two days
    - **Time**: Enter the time in the 24-hour format. For example, enter `14:00` for 2PM
    - **Review** the Summary of your schedule
    - Click **Create**.

    ![](../schedule-run/images/create-schedule-options.png " ")

8. You can now see the **new schedule** in the Schedules list from your application.

  ![](../schedule-run/images/schedules-list.png " ")

## Task 3: Schedule the Pipeline task

You can create **task schedules** to schedule tasks to run on **specific days and times**, and at a **specific frequency**. You create a task schedule for each task that you want to run on an **automated schedule**. A task schedule must be associated with an existing schedule. You can enable or disable a task schedule at any time. In this step, you will schedule the Pipeline Task. However, scheduling process is the same for all tasks in OCI Data Integration.

1. From the `Workshop ApplicationNN` you are currently in, click on **Tasks** under Details section.

  ![](../schedule-run/images/tasks-section.png " ")

2. In the Tasks section, click on the **Actions menu** (three dots) from the `Load DWH Pipeline Task` and select **Schedule**.

  ![](../schedule-run/images/action-menu-pipeline-task.png " ")

4. On the **Create Task Schedule** page, enter a **Name** (`Load DWH Pipeline Task - Daily`) and **Description** (optional).

  ![](../schedule-run/images/task-schedule-name.png " ")

5. Ensure the **Enable Task Schedule check box** is selected to allow this task schedule to trigger automated runs when schedule conditions are met.

  ![](../schedule-run/images/enable-task-schedule.png " ")

6. In the **Schedule** section:

    - Click **Select** to associate this task schedule with a schedule
    ![](../schedule-run/images/select-button-schedule.png " ")
    - On the **Select Schedule** page, check the existing schedule (`Daily Schedule 2PM`) that you created in _Create a Schedule_, then click **Select**.
    ![](../schedule-run/images/select-schedule.png " ")

7. In the Configure Task Schedule section, click **Configure** to specify run options for this task schedule.

  ![](../schedule-run/images/configure-task-schedule-button.png " ")

8. In the **Configure Task Schedule** page:

    - **Start Time** and **End Time** are optional. If you don't specify a Start Time, this task schedule takes effect immediately, and runs are triggered when conditions specified in the associated schedule are met. We will not define Start Time and End Time.
    - Leave blank also the optional **Expected Time to Complete** field.
    - For **Retry Count**, enter the number of times to retry executing the task when a run fails. For example, you can define a value of **1**.
    - Enter a value in **Retry Delay Duration**, and then select a unit from the menu to specify the time interval between retries. You can specify a value in seconds, minutes, or hours. The value must be greater than 5 seconds. Leave the default of **30 seconds**.
    - Click **Configure**.

    ![](../schedule-run/images/configure-task-schedule.png " ")

9. **Review** the options you defined and click **Create**.

  ![](../schedule-run/images/task-schedule-save-close.png " ")

10. From the `Workshop ApplicationNN` you are currently in, click on **Task Schedules** under Details section.

  ![](../schedule-run/images/task-schedules-section.png " ")

11. In the list of Task Schedules, you can find the one you have just defined. **Your pipeline task is now scheduled to run every day at 2PM**.

  ![](../schedule-run/images/task-schedule.png " ")

## Task 4: Run the Pipeline task

In this step, you will now do a **manual on-demand run** of your pipeline task. However, you can run all the published tasks in your Application (Integration task, Data Loader task, SQL task, Pipeline task).

1. From the `Workshop ApplicationNN` you are currently in, click on **Tasks** under Details section.

  ![](../schedule-run/images/tasks-section.png " ")

2. From the list of tasks, select **Run** from the **Actions menu** (three dots) for the `Load DWH Pipeline Task` that you will run.

  ![](../schedule-run/images/run-pipeline-task.png " ")

3. A **run entry** is created in the Runs section of the Application details page. You can monitor here the **status** and **duration** of your task run. Click on **Refresh** if you want to update the status.

  ![](../schedule-run/images/pipeline-running.png " ")

4. The Pipeline task run has ended successfully.

  ![](../schedule-run/images/pipeline-success.png " ")

   **Congratulations!**

## Learn More

* [Scheduling tasks in OCI Data Integration](https://docs.oracle.com/en-us/iaas/data-integration/using/schedules.htm)
* [Executing Published Tasks](https://docs.oracle.com/en-us/iaas/data-integration/using/published-tasks.htm)
* [Viewing Executed Task Runs](https://docs.oracle.com/en-us/iaas/data-integration/using/task-runs.htm)

## Acknowledgements

* **Contributors** -  Theodora Cristea, David Allan
* **Last Updated By/Date** - David Allan, June 2023
