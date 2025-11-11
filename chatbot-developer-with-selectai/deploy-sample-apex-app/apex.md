# Create ADB and Deploy APEX Sample Application 

## Introduction

This lab will take you through the steps needed to provision an Oracle Autonomous Database for APEX workload types. It also covers how to access APEX Administrative services, create an APEX workspace and deploy a sample APEX app.

Estimated Time: 60 minutes

### About Oracle ADB for APEX workloads

Oracle Autonomous Database is an autonomous database that can drive, secure and repair itself. It offers elastic scalability, rapid query performance and eliminates the need for manual database administration. It can also be provisioned in manner where performance and features are positioned for APEX workloads.

### About Oracle APEX 

Oracle APEX is a powerful low-code platform that empowers developers to create scalable and secure web and mobile applications with ease. Its robust features allow for deployment in various environments, whether in the cloud or on-premises.

With APEX, the development process is streamlined, enabling developers to rapidly build and launch innovative apps that address real-world challenges and deliver tangible results. The platform simplifies the development process, eliminating the need for expertise in numerous technologies. Developers can concentrate on problem-solving, while APEX handles the technical intricacies behind the scenes. 


### Objectives

In this lab, you will:

* Provision an Oracle Autonomous Database for APEX workloads
* Learn how to access APEX Administrative Services
* Learn how to create an APEX Workspace 
* Deploy an APEX sample app that is accessible from the public internet 

### Prerequisites

This lab assumes you have:

* Must have an Administrator Account or Permissions to manage several OCI Services: Oracle Databases, Networking, Policies.


## Task 1: Create Autonomous Database

This task involves creating Autonomous Database 23ai.

1. Locate Autonomous Databases under Oracle Databases. Click on Create Autonomous Database.

    ![Create ADB](images/create_adb.png)

2. Provide information for Compartment, Display name, Database name. Also, choose workload type as APEX.
    
    ![Create ADB Name](images/create_adb_name_workload.png)
    
3. Choose database version as 23ai and disable Compute auto scaling.

    ![Create ADB Deployment](images/create_adb_deployment_type.png)

4. Make sure Network Access is Secure access from everywhere, provide password, valid email ID and click on Create Autonomous Database.

    ![Create ADB Password](images/create_adb_password_network.png)

5. After deployment is complete, check to make sure your autonomous database is available on the autonomous databases page with the specified compartment selected.

    ![Create ADB Done](images/create_adb_complete.png)

 
## Task 2: Access APEX Administration Services

This task involves logging into APEX Administration Services

1. Locate the Autonomous Database created in task 1, scroll down and find the APEX instance name. Click thru the instance name to view APEX Instance details.
    
    ![Goto APEX Instance](images/apex_instance_name.png)
    
2. From the APEX Instance Details click the Launch APEX button.

    ![Launch APEX](images/launch_apex.png)

3. Open APEX Administration Services, use the autonomous database admin password created in task 1.

    ![Create ADB Password](images/apex_admin_services.png)


## Task 3: Create APEX workspace 


This task involves Creating an APEX workspace from APEX Administration Services

1. After logging into APEX Administration services, click the create workspace button.

    ![Create APEX Workspace](images/apex_create_workspace.png)

2. In the next screen, click the New Schema button.

    ![Create APEX Workspace New Schema](images/apex_create_workspace_schema.png)

3. You should now be at the screen where you can name the workspace and add an admin user. Type in a name for your workspace, also type in a user name and password for the admin. Note, you can use the same name for workspace and user.

    ![Create APEX Workspace Name and User](images/apex_create_workspace_name_user.png)

4. Finish creating new workspace, use the link to log into your new workspace or logout and use the Launch APEX button from task 2, step 3.

    ![Finish Creating APEX Workspace](images/apex_create_workspace_done.png)

## Task 4: Deploy Sample App

In this task we deploy a sample Apex app into the workspace

1. Login into the workspace using the name and credentials you created in task 3.

    ![Login APEX Workspace](images/apex_login_workspace.png)

2. From the workspace home screen click the App Builder button.

    ![APEX Workspace App Builder Button](images/apex_workspace_home.png)

3. Click the Install a Starter or Sample App button.

    ![Install Sample App](images/apex_workspace_install_sample.png)

4.  Type in Brookstrut in the search bar and click the install button in the Bookstrut Sample App card.

    ![Select Sample App](images/apex_workspace_select_sample_brookstrut.png)

5.  After installation completes, you should see the install button replaced with a run button. Click the button to login the app and save the url for later.

    ![Run Sample App](images/apex_workspace_run_sample_brookstrut.png)

6. Login to the sample app using the workspace credentials. 

    ![Login Sample App](images/apex_workspace_sample_login.png)

You may now proceed to the next lab.

## Acknowledgements

* **Author**
    * **Jadd Jennings**, Principal Cloud Architect, NACIE
* **Contributors**
    * **Kaushik Kundu**, Master Principal Cloud Architect, NACIE
* **Last Updated By/Date**
    * **Jadd Jennings**, Principal Cloud Architect, NACIE, Aug 2025
