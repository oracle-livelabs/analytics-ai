# Setup OCI Infrastructures

## Introduction

This lab will take you through the steps needed to provision Oracle Infrastructure resources such as 

* OCI IAM resources.
* OCI Virtual Cloud Network resources.
* OCI Object Storage bucket. 
* OCI Autonomous Database.

Estimated Time: 30 minutes



## Task 1: Dynamic Group and Policy Definition

This task will help you ensure that the Dynamic Group and Policy are correctly defined.

1. Locate Domains under Identity & Security

    ![Domain Navigation](images/locate_domain.png)

1. Click on your desired  domain name
1. Click on Dynamic Groups, and then your Dynamic Group name

    ![Dynamic group](images/domain_dg.png)
1. Click create dynamic group.Provide a name and a description.Select option Match any rules defined below.

    ![Create Dynamic group](images/create_dg.png)
1. Add below rules to the dynamic group.

   ```
   <copy>
    all {resource.type='datasciencenotebooksession', resource.compartment.id='OCID of the Compartment'}
    ALL {resource.type='genaiagent',resource.compartment.id='OCID of the Compartment'}
    </copy>
   ```
1. Create the dynamic group.

    ![Created group](images/created_dg.png)


1. Make a note of *dynamic group's OCID* for further usage.

    ![DG OCID](images/dg_ocid.png)

## Task 2: Create policies.

The tasks will help you to associate necessary policies with the dynamic group

1. Select policies from section Identity & Security.

    ![Select policy](images/create_policies.png)

1. Ensure the compartment selected as the desired one.
1. Click *Create policy*.
1. Provide a name and description.

    ![create policy](images/create_policy.png)

1. Click *Show manual editor* option.
1. Add below policy statements,ensure to update OCI accordingly.

   ```
   <copy>
    allow dynamic-group <OCID of the Dynamic group> to manage genai-agent-family in compartment id <OCID of the compartment>
    allow any-user to manage genai-agent-family in compartment id <OCID of the compartment>  where ALL {request.principal.type = 'datasciencenotebooksession'}
    allow dynamic-group <OCID of the Dynamic group> to read database-tools-family compartment id <OCID of the compartment>
    allow dynamic-group <OCID of the Dynamic group> to read secret-bundle in compartment id <OCID of the compartment>
    allow dynamic-group <OCID of the Dynamic group> to use database-tools-connections in compartment id <OCID of the compartment>
    allow dynamic-group <OCID of the Dynamic group> to use database-family in compartment id <OCID of the compartment>
    allow dynamic-group <OCID of the Dynamic group> to use object-family in compartment id <OCID of the compartment>
    allow dynamic-group <OCID of the Dynamic group> to manage  all-resources  in compartment id <OCID of the compartment> 
   </copy>
   ```
1. Click create and validate.

    ![Validate policy](images/validate_policies.png)

## Task 3: Create virtual cloud network and subnet.

The tasks allows your to create our VCN that we will use for various transactions.

1. From OCI console ,select Network > *Virtual Cloud Networks*

    ![VCN View] (images/vcn_view.png)

1. Click *Actions* > *Start VCN Wizard*.

    ![Create VCN](images/create_vcn.png)

1. Select option *Create VCN with Internet Connectivity*.

    ![VCN options](images/vcn_options.png)

1. Provide name ,description and use default information and create the VCN.
1. Wait for the vcn state to be *Active*.

    ![VCN State](images/vcn_active.png)

## Task 4: Create Autonomous Database(ADB).

The task help to create ADB that we will use for Nl2SQL tool usage.

1. From *OCI Console* > *Oracle Database* > *Autonomous Databases*.

    ![ADB View](images/create_adb.png)

1. Click create autonomous database.
1. Provide a friendly name for display and table name.

    ![Create DB](images/create_db_basic.png)

1. Select version as *23ai*.Select other default configuration values.

    ![ADB config](images/adb_base_config.png)

1. Provide a complex password for the database.

    ![Admin credentials](images/db_admin_password.png)

1. As this for lab purpose select the option *Secure access from everywhere*.
1. Provide a contact mail id and click *Create*.
1. It will take several minutes to have the resource in Available status.

    ![ADB finale view](images/adb_final_view.png)
1. Make a note of Admin password for further usage.

## Task 5: Create a vault.

The task helps to setup the OCI Vault.

1. From OCI console > *Identity & Security* > *Key Management & Secret Management* > *Vault*

    ![Create vault](images/create_vault.png)

1. Click *Create vault*.Provide a name and click *Create Vault*.

    ![Create vault](images/vault_master.png)

1. Click *Create Master Key*.Provide a name and use default options.Click *Create Key*.

    ![Create master key](images/create_vault_key.png)

1. Wait till the resources are in active state before moving to next section.

## Task 6: Create database connection.

The task allow to create a DB connection for agent usage.

1. From OCI console > *Developer Services* > *Connections*.

    ![DB connections](images/db_connection.png)

1. Click *Create connection*.Provide name for the connection.Always ensure you are selected  the desired compartment. 

    ![DB connection create](images/connection_basics.png)

1. Use *Select Database* option.
1. Select option as *Oracle Autonomous Database*.
1. Select the compartment and the database created earlier.

    ![Select db](images/select_db.png)
1. Click *Create password secret*.
1. Provide name and description.
1. Select the vault and master key created.
1. Use the same password that used during ADB creation.
1. Click *Create*.

    ![Admin password creation](images/connection_admin_password.png)

1. Click *Create wallet content secret*.

    ![Wallet secrets](images/create_wallet_password.png)

1. Provide *Name*, *Description*,Select *Vault* and *Key*.
1. Use option *Retrieve regional wallet from Autonomous Database*.

    ![Wallet secret creation](images/create_secrets_wallet.png)

1. Click create.Wait for the resource to become active.

    ![Validate connection](images/validate_connection.png)

1. Provide confirmation. Wait for the validation.If there is an error fix accordingly.

    ![Connection validation](images/connect_validation.png)

1. Click *Close*.


## Task 7: Create OCI Object storage.

The task help to create a object storage bucket to store artifacts for RAG usages.

1. From OCI Console > *Object Storage & Archive Storage* > *Buckets*.

    ![buckets](images/bucket_view.png)

1. Click *Create bucket*.
1. Provide name and use with default options.

    ![Bucket created](images/bucket_created.png)
1. Make a note of *Name space name* and *Bucket name*.


## Task 8: Create OCI Generative AI agents.

The task help to create a basic agent to which we will add further tools later.

1. From OCI console > *Analytics&AI* > *Generative AI Agents*.

    ![Create agent](images/create_agent.png)

1. Click *Agents* > *Create Agent*.Provide basic information and click *Next*.

    ![Agent basic](images/agent_basic_input.png)

1. Skip the tools page and click *Next*.
1. With in page *Setup agent endpoint* , check option *Automatically create an endpoint for this agent
*.

1. Enable option *Enable human in the loop*.

    ![Enable HIL](images/enable_hil.png)

1. Select option *Inform* for all the option of Guardrails.

    ![Guardrails](images/guardrails.png)

1. Click *Next* and click *Create agent*

    ![Create agent](images/create_agent_final.png)

1. Wait for the agent and endpoint to become active,once completed make a note of the *OCID of the Agent endpoint*.

    ![Agent endpoint ocid](images/agent_endpoint.png)


**Proceed to the next lab.**

## Acknowledgements

* **Author**
    * **Rahul MR**, Principal Solutions Architect - OCI 
* **Contributors**
    * **Sanjeeva Kalva**, Principal Data Scientist - OCI 
