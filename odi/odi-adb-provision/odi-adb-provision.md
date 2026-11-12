# Provision ADB and Link to ODI

## Introduction

This lab walks you through the steps to get started using the Oracle Autonomous Database (Autonomous Data Warehouse [ADW] and Autonomous Transaction Processing [ATP]) on Oracle Cloud. You will provision a new ADW instance and connect to the database using Oracle SQL Developer Web.

*Note: While this lab uses ADW, the steps are identical for creating and connecting to an ATP database.*

Estimated Lab Time:  10 minutes

### Objectives

* Learn how to provision a new Autonomous Data Warehouse
* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account


### Prerequisites

This lab assumes you have already completed the [Log in to Oracle Cloud] (?lab=lab-1-login-oracle-cloud) lab seen in the menu on the right.  In this lab you will be provisioning an ADW database instance using the cloud console.

### Video Preview

Watch a video demonstration of provisioning a new autonomous data warehouse:

[](youtube:Q6hxMaAPghI)

## Task 1: Choosing ADW from the Services Menu

1. Login to the Oracle Cloud, as shown in the previous lab.
2. Once you are logged in, you are taken to the cloud services dashboard where you can see all the services available to you. Click the navigation menu in the upper left to show top level navigation choices.

    **Note:** You can also directly access your Autonomous Data Warehouse service in the **Quick Actions** section of the dashboard.

    ![Autonomous Data Warehouse in the OCI navigation menu](./images/Picture100-36.png " ")

3. The following steps apply similarly to either Autonomous Data Warehouse or Autonomous Transaction Processing. This lab shows provisioning of an Autonomous Data Warehouse database, so click **Autonomous Data Warehouse**.

    ![Select Autonomous Data Warehouse in the console](https://oracle-livelabs.github.io/common/images/console/database-adw.png " ")

4. Make sure your workload type is **Data Warehouse** or **All** to see your Autonomous Data Warehouse instances. You can use the **List Scope** drop-down menu to select a compartment. Select the compartment provided in the email instructions where you will create your new ADW instance.

    **Note** - Avoid the use of the ManagedCompartmentforPaaS compartment as this is an Oracle default used for Oracle Platform Services.

5. This console shows that no databases yet exist. If there were a long list of databases, you could filter the list by the state of the databases (available, stopped, terminated, and so on). You can also sort by **Workload Type**. Here, the **Data Warehouse** workload type is selected.

    ![Autonomous Database list and compartment selector](./images/Compartment.png " ")

6. You can see your current default **region** in the top, right hand corner of the page. Go ahead and select the region indicated in the email you received.

    ![Select the region for the workshop](./images/Region.png " ")

## Task 2: Creating the ADB instance

1. Click **Create Autonomous Database** to start the instance creation process.

    ![Create Autonomous Database button](./images/Picture100-23.png " ")

2. This brings up the **Create Autonomous Database** screen where you will specify the configuration of the instance.
3. Provide basic information for the autonomous database:

    * **Choose a compartment** - Select the compartment provided in the email you received.
    * **Display Name** - Enter a memorable name for the database for display purposes. For this lab, prefix the name with the first letter of your *first* and *last* name.
    * **Database Name** - Use letters and numbers only, starting with a letter. Maximum length is 14 characters. (Underscores not initially supported.) For this lab, prefix the name with the first letter of your *first* and *last* name.

    ![Database display name and database name fields](./images/Picture100-26.png " ")

4. Choose a workload type. Select the workload type for your database from the choices:

    * **Data Warehouse** - For this lab, choose **Data Warehouse** as the workload type.
    * **Transaction Processing** - Alternately, you could have chosen Transaction Processing as the workload type.

    ![Select the Data Warehouse workload](./images/Picture100-26b.png " ")

5. Choose a deployment type. Select the deployment type for your database from the choices:

    * **Shared Infrastructure** - For this lab, choose **Shared Infrastructure** as the deployment type.
    * **Dedicated Infrastructure** - Alternately, you could have chosen Dedicated Infrastructure as the workload type.

    ![Select the database deployment type](./images/Picture100-26_deployment_type.png " ")

6. Configure the database:

    * **Always Free** - For this lab, you can select this option to create an always free autonomous database, or not select this option and create a database using your paid subscription. An always free database comes with 1 CPU and 20 GB of storage. Selecting Always Free will suffice for this lab.
    * **Choose database version** - Select a database version from the available versions.
    * **OCPU count** - Number of CPUs for your service. For this lab, specify **2 CPUs**. Or, if you choose an always free database, it comes with 1 CPU.
    * **Storage (TB)** - Select your storage capacity in terabytes. For this lab, specify **1 TB** of storage. Or, if you choose an always free database, it comes with 20 GB of storage.
    * **Auto Scaling** - For this lab, keep auto scaling enabled, to allow the system to automatically use up to three times more CPU and IO resources to meet workload demand.
    * **New Database Preview** - If a checkbox is available to preview a new database version, do **not** select it.

    ![Choose database version and compute settings](./images/Picture100-26c.png " ")

7. Create administrator credentials:

    * **Password and Confirm Password** - Specify the password for ADMIN user of the service instance. The password must meet the following requirements:
    * The password must be between 12 and 30 characters long and must include at least one uppercase letter, one lowercase letter, and one numeric character.
    * The password cannot contain the username.
    * The password cannot contain the double quote (") character.
    * The password must be different from the last 4 passwords used.
    * The password must not be the same password that is set less than 24 hours ago.
    * Re-enter the password to confirm it. Make a note of this password.

    ![Set and confirm the ADMIN password](./images/Picture100-26d.png " ")
8. Choose network access:
    * For this lab, accept the default, "Allow secure access from everywhere".
    * If you want a private endpoint, to allow traffic only from the VCN you specify - where access to the database from all public IPs or VCNs is blocked, then select "Virtual cloud network" in the Choose network access area.
    * You can control and restrict access to your Autonomous Database by setting network access control lists (ACLs). You can select from 4 IP notation types: IP Address, CIDR Block, Virtual Cloud Network, Virtual Cloud Network OCID).

    ![Configure database network access](./images/Picture100-26e.png " ")

9. Choose a license type. For this lab, choose **Bring Your Own License (BYOL)**. The two license types are:

    * **Bring Your Own License (BYOL)** - Select this type when your organization has existing database licenses.
    * **License Included** - Select this type when you want to subscribe to new database software licenses and the database cloud service.

10. Click **Create Autonomous Database**.

    ![Create the Autonomous Database instance](./images/Picture100-27.png " ")

11. Your instance will begin provisioning. In a few minutes the state will turn from Provisioning to Available. At this point, your Autonomous Data Warehouse database is ready to use! Have a look at your instance's details here including its name, database version, CPU count and storage size.

    ![Autonomous Data Warehouse in the Available state](./images/Picture100-32.png " ")


## Task 3: Populating ADW Database with Seed Data

1. Ensure your ADW instance is available:
    ![Verify that the Autonomous Data Warehouse is available](./images/adw-available.png " ")

2. In your ADW database's details page, click the **Tools** tab.

    ![Open the database Tools tab](./images/Picture100-34.png " ")

3. The Tools page provides you access to SQL Developer Web, Oracle Application Express, and Oracle ML User Administration. In the SQL Developer Web box, click **Open SQL Developer Web**.

    ![Open SQL Developer Web from the Tools page](./images/Picture100-15.png " ")
4. A sign-in page opens for the SQL Developer Web. For this lab, simply use your database instance's default administrator account, **Username - admin**, and with the admin **Password** you specified when creating the database. Click **Sign in**.

    ![Sign in to SQL Developer Web as ADMIN](./images/Picture100-16.png " ")

5. SQL Developer Web opens on a worksheet tab. The first time you open the SQL Developer Web, a series of pop-up informational boxes introduce you to the main features.

    ![SQL Developer Web worksheet](./images/Picture100-16b.png " ")

6. Click on the link [User-Seed-SQL.ZIP](https://objectstorage.us-ashburn-1.oraclecloud.com/p/4Au3jJ-t8Wtw3LWyYsDMqQk2FdlXDvXCb1MYRS0J6P4QS-GCrv2YNOolWdtFMLZq/n/c4u04/b/livelabsfiles/o/labfiles/ODI_User-Seed-SQL.zip) to download a ZIP file containing:
    * User_setup.sql
    * Seed_data.sql

7. Copy the contents of *User_setup.sql* in to the worksheet:
    ![Run the User_setup.sql script in the worksheet](./images/user-setup.png " ")

8. Select all of the text and run it to create the users *ODI\_DEMO* and *ODI\_STAGING*

9. Copy the contents of *Seed_data.sql* in to the worksheet, select the text and run to create tables and populate with seed data. The execution may take few minutes to complete (UI doesn't show any activity in the meantime). Check for messages in "Script Output" tab to make sure commit completed after the execution.
    ![Run the seed data script and inspect Script Output](./images/seed-data.png " ")

## Want to Learn More?

Click [Autonomous Data Warehouse workflow documentation](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/autonomous-workflow.html#GUID-5780368D-6D40-475C-8DEB-DBA14BA675C3) for documentation on the typical workflow for using Autonomous Data Warehouse.

## Acknowledgements

* **Author** - Nilay Panchal, ADB Product Management
* **Adapted for Cloud by** - Richard Green, Principal Developer, Database User Assistance
* **Contributors** - Jeffrey Malcolm Jr, Arabella Yao, June 2020
* **Last Updated By/Date** - Kamryn Vinson, September 2020

