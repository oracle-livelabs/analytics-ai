# (optional) Explore Functions in Depth

## Introduction

This lab will walk you through how to deploy a test and dev environment for your functions as well as promoting a version to production.

Estimated Time: 1 hour

### Objectives

In this lab, you will:

* Create a Dev Cloud environment via Terraform
* Install and Configure the FN CLI
* Test a function locally
* Deploy the Function to Dev
* Deploy the Function to Prod

### Prerequisites

This lab assumes you have:

* All previous labs successfully completed
* Must have an Administrator Account or Permissions to manage several OCI Services: Functions, OCIR, Logging, APM, Network, Dynamic Groups, Policies, Resource Manager

## Task 1: Create Resource Manager Stack

This task is mostly the same as when we deployed the Stack in lab 2. The only required variable change is to change the **Function Deployment Method**. Using a different **prefix** is recommended. You can reuse IAM and Networking resources if you deploy these stacks in the same compartment.

1. Start Create Stack Workflow via the button below

    <!-- https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Tasks/deploybutton.htm
    TODO: update package url when available
    -->
    [![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://objectstorage.us-ashburn-1.oraclecloud.com/p/OOL_2RmaYtzKH1cwpwYzo0eLGE1kIKSTywmoJdYa5YN6zVEnBAw7th9E2pa-LxSU/n/c4u02/b/hosted_workshops/o/generative_ai_agent_oda/agent-terraform-livelabs-1.1.zip)

    Clicking this button will direct you to log in to your tenancy and then to Resource Manager's **Create Stack** page

2. Fill out **Stack Information**

    ![Stack Accept Package](../terraform/images/stack_accept_package.png)
    * Ensure you are creating your stack in the correct region.
    * Accept the Terms of Use.

    ![Stack Information](../terraform/images/stack_information.png)
    * Ensure you have selected the compartment you want the stack to live in.
    * Optionally, update the name and description of the stack.
    * Click Next


3. Functions Configuration

    Setup the variables in the stack like you did before except for two

    * It is recommended to use a different **prefix** in the General configuration at the top

    ![variables functions configuration](images/variables_functions.png)

    * In the functions section at the bottom, click the box to **Manually Deploy Functions**

    Click Next

4. Review and Create

    ![stack review](../terraform/images/stack_review.png)

    On this page, you can review your stack information and variable configuration.

    When you are done, click **Create** or **Save Changes** to finish the stack creation wizard.

    You can select **Run Apply** and skip Tasks 2, but it is recommended you perform these tasks separately so you can review the Terraform plan before applying.

## Task 2: Run Terraform Stack

1. Click on the **Plan** button

    ![stack plan](../terraform/images/stack_plan.png)

    This will bring up a window on the right side. Click **Plan** again to initiate the job.

2. Review completed plan

    ![stack plan success](../terraform/images/stack_plan_success.png)

    The plan job may take a couple minutes to complete. After it is completed, you can search through the logs to see the resources that will be created/updated/deleted as well as their configuration parameters.

3. Click on the **Apply** button

    ![stack apply](../terraform/images/stack_apply.png)
    * This will bring up a window on the right side.
    * In the **Apply job plan resolution** dropdown menu, select the Plan job you just reviewed
    * Click **Apply** again to initiate the job

4. Wait for the job to be completed

    ![stack apply in progress](../terraform/images/stack_apply_in_progress.png)

    The deployment of the infrastructure may take 10-20 minutes.

    ![stack apply success](../terraform/images/stack_apply_success.png)

## Task 3: Set up your Local Host Dev Environment

Complete section C of the [localhost functions quickstart guide](https://docs.oracle.com/en-us/iaas/Content/Functions/Tasks/functionsquickstartlocalhost.htm#functionsquickstartlocalhost_topic_start_setting_up_local_dev_environment)

The rest of the the instructions in this task expand upon the directions provided in the quickstart guide.

1. Install and Start Docker

    Alternatively you can install Rancher Desktop or any other docker client and server software compatible with the docker cli.

2. Use the OCI CLI to create an auth profile instead of using an API key

    * If necessary, install the [OCI CLI](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/cliinstall.htm)
    * run this command to create an OCI session
    ```
    <copy>oci session authenticate</copy>
    ```

    * select the region to deploy the functions into.
    * Log into your tenancy in the browser popup window
    * Create a unique name for your profile

3. Install Fn Project CLI and configure context

    continue following the quickstart guide for steps 3, 4, and 5
    <!-- TODO what to do with registry creation. Could be in TF. Can also use create repo on push global setting. Is this on in tenancies by default?-->

4. Check Fn context setup

    ![fn inspect context](images/fn_inspect_context.png)

    ```
    <copy>fn inspect context</copy>
    ```

    use this command to display the current context details

    ![fn list context](images/fn_list_context.png)

    ```
    <copy>fn list context</copy>
    ```

    use this command to list all contexts on your machine

    ```
    <copy>fn use context <context name></copy>
    ```

    use this command to switch contexts


5. Generate an Auth Token and Log into the Registry

    If your account is in a non-default domain, you will have to use the domain name in the login username

    ```
    <copy>docker login -u '<tenancy-namespace>/<domain-name>/<user-name>' <region-key>.ocir.io</copy>
    ```

    <!-- TODO Sometimes the auth token doesn't copy/paste correctly for me. I have to copy to an intermediate text file, then copy/paste again-->

## task 4: Setup Codebase

1. Download and unzip Function code

    [genai-agent-function](https://objectstorage.us-ashburn-1.oraclecloud.com/p/OOL_2RmaYtzKH1cwpwYzo0eLGE1kIKSTywmoJdYa5YN6zVEnBAw7th9E2pa-LxSU/n/c4u02/b/hosted_workshops/o/generative_ai_agent_oda/agent-function-livelabs-1.1.zip)

2. In a terminal, navigate to the recently unzipped folder

3. (optional) Create a Python Virtual Environment
    It is recommended that you create virtual environments for different python projects. There are multiple tools to manage these environments including venv, conda, pyenv, and virtualenv.

4. Install requirements
    Navigate to the function code folder, activate your virtual environment, and run `pip install -r requirements.txt`

The Following Tasks showcase how to set up the Agent-ODA Chat integration function used in an earlier version of this lab. There are additional functions available in the source code including:

- Chat (default/root folder)
- create_agent (Terraform stand-in)
- auto_ingest (Coming Soon)


## task 5: Test Function Locally

1. Setup local environment variables

    ```
    <copy>export PROFILE_NAME=<profile name> #name of the profile created in task 3, step 2
    export ENDPOINT_URL=https://agent-runtime.generativeai.us-chicago-1.oci.oraclecloud.com #update for your region
    export ENDPOINT_ID=ocid1.genaiagentendpoint.oc1.us-chicago-1.**** #update for your endpoint
    export KEEP_ALIVE_SESSION=False</copy>
    ```

    **NOTE** most of these values are also set in the function application configuration. These are the default values used if the parameters are not passed in the request body


2. create a local listener for your function
    run this command in one terminal in the function's folder
    ```
    <copy>env FDK_DEBUG=1 FN_FORMAT=http-stream FN_LISTENER=unix://tmp/func.sock fdk func.py  handler</copy>
    ```

    keep this terminal open. When requests come in, the logs will be displayed in this window

    ![local listener](images/local_listener.png)

3. Send a local http request
    Run this command in another terminal
    ```
    <copy>curl -v --unix-socket /tmp/func.sock -H "Fn-Call-Id: 0000000000000000" -H "Fn-Deadline: 2030-01-01T00:00:00.000Z" -XPOST http://function/call -d '{"user_message":"Which account is associated with bill number 28676209?"}'</copy>
    ```

    * you can update the user message to fit your knowledge base and agent
    * Any of these parameters can be used in the request body: endpoint_url, endpoint_id, delete_session, user_message, session_id, and keep_alive_session

    ![local request](images/local_request.png) <!-- TODO update image with better response-->

<!-- TODO: add task for running pytest testbench-->

## task 6: Deploy the Function to Dev

1. update app.yaml file
    ```
    <copy>fn list apps</copy>
    ```

    run this command to see a list of your apps available in the current context

    update the name to match the name of the funtion application deployed by the terraform

2. Deploy function using fn cli

    ```
    <copy>fn deploy --app <app name> --verbose</copy>
    ```

3. Invoke function in Cloud Dev environment

    ```
    <copy>echo -n '{"user_message":"Which account is associated with bill number 28676209?"}' | fn invoke <app name> genai-agent --content-type application/json</copy>
    ```

    * You can customize this request body just like in the local test

    **Note** Requests may take significantly longer than your production environment as provisioned concurrency is not on

## task 7: Deploy the Function to Prod

1. Update Prod Resource Manager Stack variables

    From stack details page, edit -> edit stack -> next:

    For the functions variables, copy the full image url from the function details page
    <!-- * or provide the local image details

    <!-- TODO: reenable local image instructions once code is fixed
    ![variables function local image](images/variables_functions_local_image.png)
    <!--TODO: Can we let user provide an easier value than OCIR OCID? -->

    click next -> save changes

2. Run a new Plan and Apply Job

    The Function should be the only resource requiring changes. It should update it's image and digest.

3. Invoke function in Cloud Prod environment

    Use a similar command as in the dev environment, but update the app and function name to the prod function application
    ```
    <copy>echo -n '{"user_message":"Which account is associated with bill number 28676209?"}' | fn invoke <app name> genai-agent-func --content-type application/json</copy>
    ```

    <!-- TODO should we update the dev and prod function names to match currently dev is 'genai-agent' and prod is 'genai-agent-func'-->

<!-- X. Explore Logs and Traces (optional) TODO: create-->

## task 8: (optional) Get the details of an API call including the opc-request-id

![Look up API call through Console Browser including OPC request ID](images/console_opc_request_id.png)
The screenshot above shows how to find the opc request id for a chat message

- When you execute operations on the console, they are transformed into api calls.
- You can view these calls by using the dev tools built into your browser.
- For Firefox,
    - right click -> inspect will bring up dev tools
    - if you go to the network tab, you can see any api requests
    - After the network tab is open, perform the action you want more info on in the console window.
    - It is helpful to filter to just the service you are interested in
        - agent cp: agent.generativeai
        - agent dp: agent-runtime.generativeai
    - you should see a stream of api requests. You need to identify what api request you care about based on the status, method, and file columns
    - After you click on an individual request, you can see details on the right hand side including the Request and Response Payloads
    - The opc-request-id is located in the headers section. You can filter for it


## Acknowledgements

* **Author**
    * **Kaushik Kundu**, Master Principal Cloud Architect, NACIE
    * **JB Anderson**, Senior Cloud Engineer, NACIE
* **Contributors**
    * **Abhinav Jain**, Senior Cloud Engineer, NACIE
* **Last Updated By/Date**
    * **JB Anderson**, Senior Cloud Engineer, NACIE, October 2024
