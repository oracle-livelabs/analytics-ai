# Orchestrate data processing using workflows

## Introduction

In this lab we define the data processing orchestration using workflows. In workflows you can automate and schedule to execution of tasks. In this Lab w will use it to orchestrate the runs of Notebooks in subsequent phases (Bronze- Silver-Gold)

Estimated Lab Time: 30 minutes

### Objectives

In this lab, you will:

* Define workflows
* Run workflows
* Schedule Workflows

### Prerequisites (Optional)

This lab assumes you have:

* An Oracle Cloud account
* All previous labs successfully completed

## Task 1: Creation of Workflows

1. Step 1: Start workflow creation

    Select the Workspace. In the main pane start the creation of a job.
    Enter the form with Name, Description and Max concurrent runs.
    For concurrent runs select '5'. Create.

    In the Job definition screen the first task is automatically created. The goal is to put all notebooks per phase in a workflow. All Bronze in one, All silver in one, and similar for Gold

    On the right side:

    | description | to enter |
    | --- | --- |
    | Name | Meaningful name |
    |Task Type | Notebook Task |
    | File location | Select the location of the notebook and notebook that you want to run |
    | Cluster | Select the compute cluster |
    | Execution timeout | 10 |
    | retries | number of retries |
    |retry on timeout | Enable |

    We will create a workflow for each layer so that per layer (Bronze, silver, gold) a workflow can be run.
    We start with bronze layer. There we add the notebooks that we have stored in the workspace folder for bronze. Those files start with 01\_git\_.... to 07\_git\_.... Each task has one notebook. It requires to have 1 tasks in the workflow.
    For the Bronze\_to\_Silver Workflow the files starting with 08\_bronze\_... to 14\_bronze\_... need to be part of the workflow.
    For Silver to gold workflow a specific order has to be taken in account. This is controlled by the **dependencies** field

    ![creation of workflow](./images/createworkflow.png)

    When filled the form for the first task in the middle click 'Add Task' to add next tasks.

    In the workflow pane the runs can be monitored

    ![workflow overview](./images/workflowoverview.png)

    Repeat same for all notebooks in this phase.
    For 'File to Bronze' and 'Bronze to Silver', all tasks can run in parallel.
    At 'Depends on' no dependency to be entered.

    For the Silver to Gold it is important to run the tasks sequentially in following order.

    * 17\_silver\_drivers.ipynb
    * 18\_silver\_constructors.ipynb
    * 15\_silver\_team\_ranking.ipynb
    * 16\_silver\_driver\_ranking.ipynb

    Dependencies need to be set at the task which is dependent on previous taks.
    A list of possible values is shown when adding a dependency.
    It is also possible to change the behavior of the dependencies.
    You can check the **run if** field for possible options. We will use the "all dependencies have executed and succeeded"
    
    ![setting dependencies](./images/dependencies.png)

    In the workflow details you find the possibility to schedule the workflow

    ![workflow schedule details](./images/workflowdetailsschedule.png)

**proceed to the next lab**

## Acknowledgements

* **Author** - Wilbert Poeliejoe, AI Data Platform Black Belt
* **Contributors** -  Massimo Dalla Rovere, AI Data Platform Black Belt
