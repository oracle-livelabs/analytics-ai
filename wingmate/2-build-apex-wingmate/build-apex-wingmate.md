# Lab 1: Build a Wingmate on AI Database 26ai

## Introduction

This lab walks users through how to provision an Autonomous AI Database, generate API keys, and use those keys to connect Oracle GenAI services to the APEX application.

> **Note:** If you prefer to build on top of the **Resource Analytics** database, skip ahead to **Lab 2: Build a Data Model for Wingmate**.

Estimated time - 30 minutes

### Objectives

* Provision an Oracle AI Database 26ai ADB and APEX app
* Generate API keys
* Update the credentials to connect to OCI resources
* Create GenAI Service
* Create the Application

### Prerequisites

* An OCI cloud account
* Subscription to the US Midwest (Chicago), US-Ashburn-1, or US-Phoenix-1 region

## Task 1: Provision an Oracle AI Database 26ai (ADB) and APEX app

1. Navigate to the OCI home console and expand the side-menu bar.

	![home menu bar](./images/home-menu.png "")

2. Select **Oracle Database** and click the **Autonomous Database** option.

	![Navigate to Autonomous Database](./images/nav-adb.png "")

3. Ensure you are in the correct compartment and select **Create Autonomous AI Database**.

	> **Note:** The region in which you provision the ADB does not matter as much as in the previous GenAI Services lab, because the ADB will use the service route to access the model.

	![Console create ADB button](./images/create-adb-button.png "")

4. Give the ADB a unique name, such as **WINGMATE**, select database version **26ai**, and provide a password. Leave everything else as default and click **Create**.

	![Name the ADB](./images/name-adb.png "")

	![Choose database version dropdown](./images/choose-26ai.png "")

5. Navigate to the newly created ADB by selecting the name you provided, then click the **Tool Configuration** tab and select the Public Access URL **Copy** button for Oracle APEX. Paste it into a new tab.

	![Copy URL for APEX app](./images/open-apex.png "")

6. Enter your password used during the creation of the ADB and click **Sign in to Administration**.

	![Sign in to Admin Portal](./images/access-admin.png "")

7. Create a new workspace by clicking **Create Workspace**.

	![Create workspace button](./images/create-workspace.png "")

8. Create a new schema by clicking the **New Schema** button.

	![New Schema button](./images/new-schema.png "")

9. Enter the following credentials and click **Create Workspace**:
	* **Workspace Name:** *WINGMATE*
	* **Workspace Username:** *WINGMATE*
	* **Workspace Password:** *Welcome2Oracle* (or choose a secure password that you will remember)

	![Create Credentials for Workspace](./images/workspace-creds.png "")

10. Sign out of the admin console by selecting the profile button in the top-right corner and clicking **Sign out**.

	![Sign out of admin console](./images/sign-out-admin.png "")

11. Click **Return to Sign in Page**.

	![Return to sign in page button](./images/return-sign-in.png "")

12. Sign in using the new credentials:
	* **Workspace Name:** *WINGMATE*
	* **Workspace Username:** *WINGMATE*
	* **Workspace Password:** *Welcome2Oracle* (or whichever password you chose to remember)

	![Sign in workspace credentials](./images/sign-in-workspace.png "")

## Task 2: Generate API Keys

1. Navigate back to the OCI console and click your profile icon on the upper-right-hand side of the screen. Select **User Settings**. 

	![Profile menu button](./images/profile.png "")

2. On the menu in the center, select **tokens and keys**.

	![Menu button on profile](./images/tokens-and-keys.png "")

3. Make sure **Generate API Key Pair** is selected. Download your private and public keys because you will need them later. After downloading, select **Add**. You will see a configuration file preview; save it in a notepad file, as it will be helpful in the next task.

	  ![Create Bucket button](./images/save-key.png "")

## Task 3: Update the Credentials to Connect to OCI Resources

1. Click **App Builder** to access the Web Credentials.

	![App Builder Button](./images/app-builder.png "")

2. Click the **Workspace Utilities** button.

	![Workspace Utilities button](./images/workspace-utilities.png "")

3. Click the **Web Credentials** button.

	![Web Credentials Button](./images/web-credentials.png)

4. Click **Create** to update your web credentials.

	![Web Credentials Create button](./images/create-web-credentials.png "")

5. Change the Authentication Type to **OCI Native Authentication**. Paste the information collected in your notepad from the previous task into the corresponding fields (be sure to name the credentials and static ID: **api_key**).
Additionally, under **Valid for URLs**, include the following endpoint for the GenAI Service and select **Create**:
	```
	<copy>https://inference.generativeai.us-chicago-1.oci.oraclecloud.com</copy>
	```
* **Note:** Be sure this matches the subscribed region that hosts GenAI Services.

	![api_key credentials for oci access](./images/save-api-key-creds.png "")

## Task 4: Create GenAI Service

1. Navigate back to **Workspace Utilities** by selecting the first menu option on the breadcrumb bar.
	
	![breadcrumb bar for workspace utilities](./images/nav-utilities.png "")

2. Select the **Generative AI** button to navigate to service configuration.
	
	![genai services button on workspace utilities](./images/genai-services-button.png "")

3. Create a GenAI service by selecting the **Create** button.

	![create button on genai service console](./images/create-genai-service.png "")

4. Name the service **OCI_GENAI** and click **Create**.

## Task 5: Create the Application

1. Navigate back to the App Builder by selecting the menu button **App Builder**.

	![App Builder Button](./images/nav-app-builder.png "")

2. Create an application by selecting the **Create** button.

	![create button on console](./images/create-app.png "")

3. Name the App **WINGMATE** and click **Create Application**.

	![Naming of the App](./images/name-app.png "")


You may now **proceed to the next lab**.

## Acknowledgements

* **Authors:**
	* Nicholas Cusato - Cloud Architect
	* Royce Fu - Master Principal Cloud Architect
* **Last Updated by/Date** - Nicholas Cusato, February 2026