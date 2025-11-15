# Provision Resources

## Introduction

This lab will walk you thru provisioning an Autonomous Database, adding API keys in the Oracle Cloud Console and adding a database user for Graph studio. 

Estimated Time: 30 minutes

### Objectives


In this lab, you will:
* Provision an Autonomous Database
* Create API Key in OCI
* Create Autonomous Database user with access to Graph Studio
 

### Prerequisites

 
This lab assumes you have:
* An Oracle Cloud account with privileges to access Generative AI services, provision Autonomous Database and add API keys
 

## Task 1: Create Autonomous Database

This task involves creating Autonomous Database 23ai.

1. Locate Autonomous Databases under Oracle Databases. Click on Create Autonomous Database.

    ![Create ADB Navigate To](images/create_adb_navigate_to_adb.png)
    ![Create ADB](images/create_adb.png)

2. Provide information for Compartment, Display name, Database name. Also, choose workload type as Data Warehouse or Transaction Processing one of these workload types are needed for Graph Studio.
    
    ![Create ADB Name](images/create_adb_name_workload.png)
    
3. Choose database version as 23ai and disable Compute auto scaling.

    ![Create ADB Deployment](images/create_adb_deployment_type.png)

4. Make sure Network Access is Secure access from everywhere, provide password, valid email ID and click the Create button.

    ![Create ADB Password](images/create_adb_password_network.png)
    ![Create ADB Email](images/create_adb_contact_email.png)

5. After deployment is complete, check to make sure your autonomous database is available on the autonomous databases page with the specified compartment selected.

    ![Create ADB Done](images/create_adb_complete.png)

## Task 2: Create API Key in OCI

This task involves creating and API Key in OCI, the key will be needed in creating an AI profile for the data generation.

1. Login the OCI Console, click the person icon on the top right and then click your username.

    ![Open OCI Profile](images/oci_profile.png)

2. Select the Tokens and API keys tab, then click the add API Key button.

    ![Add API Key](images/oci_add_api_key.png)

3. Select the generate API Key Pair and click the add button. Make sure to download the private key.

    ![Generate API Key](images/oci_add_api_key_generate.png)

4. Make note of the API configurations, it will be needed later.

    ![View API Key](images/add_api_key_config_view.png)


## Task 3: Create the Graph User


1. Open the service detail page for your Autonomous Database instance in the OCI console.  

   Then click on **Database Actions** and select **View all database actions**. 

   ![Autonomous Database home page pointing to the Database Actions button](images/click-database-actions-updated.png "Autonomous Database home page pointing to the Database Actions button")


2. Login as the ADMIN user for your Autonomous Database instance.

    ![Log in to your Autonomous Database instance](./images/sign-in-admin.png "Log in to your Autonomous Database instance")

3. Click the **DATABASE USERS** tile under **Administration**.

   ![Click the Database Actions tile](./images/db-actions-users.png "Click the Database Actions tile")

4. Click the **+ Create User** icon.

    ![Click Create User](./images/db-actions-create-user.png "Click Create User ")

5. Enter the required details, i.e. user name and password. Turn on the **Graph Enable** and **Web Access** radio buttons. And select a quota, e.g. **UNLIMITED**,  to allocate on the `DATA` tablespace.   

    >**Note:** The password should meet the following requirements:

    - The password must be between 12 and 30 characters long and must include at least one uppercase letter, one lowercase letter, and one numeric character.
    - The password cannot contain the username.
    - The password cannot contain the double quote (“) character.
    - The password must be different from the last 4 passwords used for this user.
    - The password must not be the same password that is set less than 24 hours ago.

    ![Set Graph username and password, and select Create User](images/db-actions-create-graph-user.png "Set Graph username and password, and select Create User ")

    >**Note:** Please do not Graph Enable the ADMIN user and do not login to Graph Studio as the ADMIN user. The ADMIN user has additional privileges by default. 

    Click the **Create User** button at the bottom of the panel to create the user with the specified credentials.

    The newly created user will now be listed.

    ![The newly created user will be listed](./images/db-actions-user-created.png "The newly created user will be listed ")   



## Acknowledgements

* **Author**
    * **Jadd Jennings**, Principal Cloud Architect, NACIE

* **Contributors**
    * **Kaushik Kundu**, Master Principal Cloud Architect, NACIE

* **Last Updated By/Date**
    * **Jadd Jennings**, Principal Cloud Architect, NACIE, May 2025