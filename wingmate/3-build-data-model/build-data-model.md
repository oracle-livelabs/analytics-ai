# Lab 4: Leverage Resource Analytics for a Data Pipeline

## Introduction

This lab walks the user through 3 methods of Data Model building:
* **Flat files** for convience.
* **REST API** to connect to sources not covered with flat files (or Resource Analytics!).
* **Resource Analytics** for creating a data pipeline with pre-built Data Models we can leverage in our app.

The first lab showed how to create an database and APEX application. Additionally, Resource Analytics will be provisioned as a separate database you can build on top of with the flat files (or APIs). If you skipped lab 1, please use it as a reference for setting up APEX app and web credentials for building on top of Resource Analytics. In this lab, the user will create a data model from synthetic data. As an optionality, setting up an API connection to live tenancy data is modeled but not required for the App Development labs 3 & 4.

>**Note:** The visuals that will be created in labs 3 & 4 (Security and Multi-cloud Wingmates) will require** the flat files that can be downloaded here: [Wingmate Data Zip](https://oraclejamescalise.objectstorage.us-phoenix-1.oci.customer-oci.com/p/72-f7TSP1o3DgeVKmh42oBuft-Q5vvRlyyGq4QPqYl2SI-p5ULJnbKDynL9v1qUO/n/oraclejamescalise/b/Wingmate-LL/o/wingmate_data.zip)

> **Note:** For reference, the list of available APIs that can be utilized for Task #4: [OCI API Reference and Endpoints](https://docs.oracle.com/en-us/iaas/api/)

Estimated time - 20 minutes

### Objectives

* Configure Resource Analytics Prerequisites
* Provision Resource Anlaytics Instance
* Connect pipeline to Wingmate
* Load Synthetic Data
* (Optional) Connect RESTful data from Tenancy

### Prerequisites

* An OCI cloud account
* Subscription to US-Central Chicago, US-Ashburn-1, or US-Phoenix-1 Region
* Basic database and SQL knowledge.
* Familiarity with Oracle Cloud Infrastructure (OCI) is helpful.
* Familiarity with the role of REST services.

## Task 1: Configure Resource Analytics Prerequisits

1. Select the **hamburger menu** at the top left. Click the **Observability & Management** menu and scroll to **Resource Analytics**. Click **Instances**.

	![Resource Analytic Menu](./images/nav-ra.png "")

2. Notice the warning at the top, which requires the tenancy admin to perform the prerequisits listed in the documentation. Click **View Details** to perform those actions. 

	![Prerequisits for Resource Analytics](./images/prerequisits.png "")

3. Read through the details of step 1. The next 9 steps will cover VCN creation using the VCN Wizard.

	![Prerquisits step 1 details](./images/prerequisits-step1.png "")

4. Click on the **Hamburger Menu** in the top left of the OCI Console, under **Networking** select **Virtual Cloud Networks**. 

	![Navigate to VCN](./images/nav-vcn.png "")

5. Click **Actions** and click the **VCN Wizard** button to create a VCN quickly with internet Connectivity.

	![VCN wizard button](./images/nav-vcn-wizard.png "")

6. Select **Create VCN with Internet Connectivity** and click **Next**.

	![VCN Wizard](./images/vcn-wizard.png "")

7. Name the VCN and leave everything else as default (confirm the correct compartment). Select **Next**.

	![VCN name](./images/name-vcn.png "")

8. Confirm the information is correct and select **Create**.

	![Confirm VCN detail](./images/confirm-vcn.png "")

9. After provisioned, select **Subnets** from the menu and click **private subnet**.

	![Private Subnet](./images/private-subnet.png "")

10. Select **Security** and click **Default Security List**.

	![Private subnet security list](./images/private-subnet-security.png "")

11. Select **Security Rules** tab and click **Add Ingress Rules**. 

	![Ingress Rules for Private subnet](./images/private-subnet-security-ingress.png "")

12. Add a **Source CIDR** of 0.0.0.0/0 and **Destination Port Range** of 1522,443. Click **Add Ingress Rule**.

	![Ingress Rule](./images/private-subnet-security-ingress-rules.png "")

13. For reference, navigate back to the **Resource Analytics Prerequisits setup** page and read Step 2. Click **Domains** to create the dynamic group.

	![Step 2](./images/prerequisits-step2.png "")

14. Click the domain this resides in. If the domain is at the root level, change the compartment to match the location. 

	![Domains](./images/domains.png "")

15. Click on **User Management** tab and scroll down to select the **Create Group** button.

	![User Management button](./images/user-management.png "")

	![Create Group button](./images/create-group.png "")

16. Name and describe the group and click **Create**.

	![Name and create group](./images/name-group.png "")

17. Click on the group, select **Users**, and click **Assign user to group**. Add desired users on the popup.

	![Assign user to group](./images/assign-users.png "")

18. Click on the **hamburger menu**, select **Identity & Security** and under Identity, click **Compartments**.

	![Compartment menu button](./images/compartment.png "")

19. Click on the compartment in which the Resource Analytics will reside and copy the **OCID**. 

	![Compartment ocid](./images/compartment-ocid.png "")

20. Navigate back to the domain and select **Dynamic Groups**. Click **Create dynamic group**.

	![Dynamic Group](./images/dynamic-groups.png "")

21. Name the group, add a description, and copy/paste the following in the **Rule Builder** - modifying to include the OCID from last step.

	```
	<copy>
	ALL {resource.type = 'resanalyticsinstance', resource.compartment.id ='<resource-analytics-compartment-ocid>'}
	</copy>
	```

	![Dynamic group rule builder](./images/dynamic-groups-rule.png "")

22. Returning to the **Prerequisites** page and read step 3. Click **Policy Builder**.

	![Step 3](./images/prerequisits-step3.png "")

23.  

Once completed, select **Create Instance**.

	![Create instance button](./images/create-instance.png)

## Task 2: Provision Resource Anlaytics Instance

1. Provide a **Name**, **Description**, and select the correct **Compartment**. 

	>* **Note:** Click **View List** to see the services that you can connect to.

	![Name the Resource Analytics Instance](./images/name-ra.png "")

2. Select the **Regions** you want to collect data from. Additionally, select **Input Password** for the Autonomous Data Warehouse Admin Credentials and provide a **Password**.

	![Region and Password for Instance](./images/name-ra.png "")


3. 	Select a **VCN** and **Subnet**. Select **Create** at the bottom - leaving everything as default.

	![VCN display](./images/create-complete.png "")

4. Wait for the Provisioning to be complete.

	![Instance Provisioning](./images/provisioning-instance.png "")

## Task 3: Connect pipeline to Wingmate

The Resource Analytics provisions an Autonomous AI Database in a private subnet. In order to view the data and import our Wingmate App, access can be granted for your personal IP address. 

1. 

## Task 3: Load Synthetic Data 

1. Download the Lab files and unzip:

	[Wingmate Data Zip](https://oraclejamescalise.objectstorage.us-phoenix-1.oci.customer-oci.com/p/72-f7TSP1o3DgeVKmh42oBuft-Q5vvRlyyGq4QPqYl2SI-p5ULJnbKDynL9v1qUO/n/oraclejamescalise/b/Wingmate-LL/o/wingmate_data.zip)

2. Navigate to the SQL Workshop by pressing the **SQL Worshop button** at the top, and then **SQL Scripts**.

	![SQL Workshop button](./images/sql-workshop.png "")


3. Select **Upload** and upload **wingmate-ddl.sql** in the popup.

	![Upload DDL script and run button](./images/execute-ddl-script.png "")

	![load DDL script and upload button](./images/upload-script.png "")


4. Click the **Run button** to execute the script.

	![Run button](./images/run-sql.png "")

5. Confirm the run script by clicking **Run Now** on the popup at the bottom. 

	![Confirm button](./images/confirm-run.png "")

6. Verify the script ran to completion.

	![Sucessful DDL](./images/ddl-complete.png "")

	>**Note:** If you see any errors, validate the error and identify if any conflicts exists with any tables/views.

7. Navigate to Object Browser by clicking **SQL Workshop** and select **Object Browser**. 

	![load csv navigation](./images/data-workshop.png "")

8. Observe the new tables created and select the first one **CIS\_IAM\_POLICIES**, and select **Data** and **Load Data** in the center module.

	![load data in tables](./images/data-loading.png "")

9. Verify that the columns are automatically mapped and hit the green **Load Data** button at the bottom. 

	![confirm data load](./images/load-data.png "")

10. Repeat for each table with each dataset located in the unzipped directory.

## Task 4: (Optional) Connect RESTful data from Tenancy

1. Navigate back to the application by selecting **App Builder** and then the **OCI Wingmate** app name.

	![Navigate to the Application](./images/nav-back-app.png "")

2. Select **Shared components** to navigate to the RESTful operations.

	![Navigate to the shared components](./images/shared-components.png "")

3. Select **REST Data Sources** under Data Sources.

	![Navigate to the REST Data Sources](./images/rest-data-services.png "")

4. Select **Create** to create your first RESTful data source.

	![Create RESTfull Data source Button](./images/create-rest-button.png "")
	
5. Select **Next** to create RESTful Data source from scratch.

	![Create RESTfull Data source from scratch button](./images/create-from-scratch.png "")

6. Name the service, such as the following **HostInsightsSummary** and paste an endpoint URL and select **Next**. For example endpoint: 
	* **https://operationsinsights.us-ashburn-1.oci.oraclecloud.com/20200630/hostInsights/resourceStatistics**

	> **Note:** For full list of endpoints, please check [Oracle Docs](https://docs.oracle.com/en-us/iaas/api/).

	![Create RESTfull Data source from scratch button](./images/endpoint-name.png "")

7. Validate the endpoint and select **Next**.

	![Next button for remote server](./images/remote-server.png "")

8. Select **Next** if no pagination is likely true.

	![Next button with no pagination](./images/no-pagination.png "")

9. Select the qualified credentails that allow for API queries of the tenancy. Select **Next**.

	![Set credentials for Rest](./images/credentials-rest.png "")

10. Navigate back if the endpoint requires parameters by selecting **back arrow**.

	![Discovery Error](./images/discovery-error.png "")

11. Select **Advanced** to define the parameters.

	![Advanced Data Discovery](./images/advanced-data-source.png "")

12. Insert the required parameters and select **Discover**.

	![Header Compartment Example](./images/header-compartment.png "")

	>**Note:** If the response says not authorized, navigate back to the credentials and select the correct credentials. This might require going back to Task 3 and creating a separate Web Credential for API, distinct from the GenAI service. Additionally, manage resource permissions are necessary for utilizing the API.

	![Example Not Authorized Error](./images/not-authorized.png "")

13. Validate a successfull data source discovery matches the expected profile. Select **Create REST Data Source** to finish the creation process for the REST endpoint. 

	![Host details of successful discovery](./images/host-details.png "")

	>**Note:** If not all columns are mapped, select **Configure button** to make sure it maps correctly.

	![Configure map button](./images/configure-columns.png "")

	![unmapped column](./images/unmapped-column.png "")

Thank you for completing this lab.

## Acknowledgements

* **Authors:**
	* Nicholas Cusato - Cloud Architect
	* Royce Fu - Master Principle Cloud Architect
* **Last Updated by/Date** - Nicholas Cusato, Febuary 2026