# Connect OAC to Essbase cube

<!--![Banner](images/banner.png)-->

## Introduction

This lab shows how we can create a connection between OAC and Essbase

*Estimated Lab Time:* 10 minutes

### Objectives
In this lab, you will:
- Launch OAC Console
- Connect to Essbase.

### Prerequisites
- Oracle Free Trial Account.


## Task 1 : Launch Cloud URL

### Login to OCI Console

Click on the hamburger icon, select Analytics & AI and click on Analytics Cloud

![Click on the hamburger icon, select Analytics & AI and click on Analytics Cloud.](images/analytics-cloud-launch.png)

Launch OAC Console:

Click on the https URL under Access Information

![ Launch OAC Console.](images/launch-oac.png)

## Task 2: Create Essbase Connection

Click on create and select connections:

![ Click on create and select connections](images/create-connection.png)

Click on Oracle Essbase:

![ Click on create and select connections](images/select-essbase.png)

Enter the relevant details:
- a.	Provide a connection name.
- b.	Appropriate description
- c.	Enter the DSN as per the screenshot. (Make sure It is either Non-SSL URL or a CA certified Certificate which you are using)
- d.	Provide username and password, please make sure the user you are providing here has admin access to Essbase instance.
- e.	Click on Save

![ Click on create and select connections](images/click-create.png)

## Task 3: Create Dataset

Click on Create and select Dataset:

![ Click on create and select connections](images/create-dataset.png)

A pop up will appear with the list of connections, select the connection we created above for Essbase:

![ Click on create and select connections](images/select-connection.png)

Select the application for which you want to perform reporting and click on Add:

Note: You can create multiple datasets for the same application by giving different names to the Dataset

![ Click on create and select connections](images/add_dataset.png)

![ Click on create and select connections](images/dataset-created.png)

## Acknowledgements

 - **Authors** – Srinivas SR NACI
 - **Contributors** - Srinivas SR/ Sudip Bandyopadhyay, NACI
 - **Last Updated By/Date** – 22/02/2024







