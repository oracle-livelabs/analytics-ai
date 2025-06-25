# Install the Components

## Introduction
In this lab, you will install all the components needed for this workshop. It will be provisioned automatically using a provided Terraform script.

Estimated time: 45 min

### Objectives

- Provision all the cloud components

### Prerequisites

- An OCI Account with sufficient credits where you will perform the lab. (Some of the services used in this lab are not part of the *Always Free* program.)
- Check that your tenancy has access to the **Frankfurt, London or Chicago Region**
    - For Paid Tenancy
        - Click on region on top of the screen
        - Check that the Frankfurt, London or Chicago Region is there
        - If not, Click on Manage Regions to add it to your regions list. You need Tenancy Admin right for this.
        - For ex, click on the US MidWest (Chicago)
        - Click Subscribe

    ![Chicago Region](images/chicago-region.png)

    - For Free Trial, the HOME region should be Frankfurt, London or Chicago.
- The lab is using Cloud Shell with Public Network.

    The lab assume that you have access to **OCI Cloud Shell with Public Network access**.
    To check if you have it, start Cloud Shell and you should see **Network: Public** on the top. If not, try to change to **Public Network**. If it works, there is nothing to do.
    ![Cloud Shell Public Network](images/cloud-shell-public-network.png)

    OCI Administrator have that right automatically. Or your administrator has maybe already added the required policy.
    - **Solution:**

        If not, please ask your Administrator to follow this document:
        
        https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellintro_topic-Cloud_Shell_Networking.htm#cloudshellintro_topic-Cloud_Shell_Public_Network

        He/She just need to add a Policy to your tenancy :

        ```
        <copy>
        allow group <GROUP-NAME> to use cloud-shell-public-network in tenancy
        </copy>        
        ```

## Task 1: Prepare to save configuration settings

1. Open a text editor and copy & paste this text into a text file on your local computer. These will be the variables that will be used during the lab.

    ```
    <copy>
    List of ##VARIABLES##
    =====================
    COMPARTMENT_OCID=(SAMPLE) ocid1.compartment.oc1.amaaaaaaaa
    TF_VAR_db_password=(SAMPLE) YOUR_PASSWORD

    Terraform Output
    ================

    -----------------------------------------------------------------------
    Evaluation (API)
    http://xxxxxxxxxxx.apigateway.eu-frankfurt-1.oci.customer-oci.com/app/evaluate?question=What%20is%20the%20importance%20of%20Virus%20and%20Intrusion%20Detection

    -----------------------------------------------------------------------
    APEX Builder
    https://xxxxxxxxxxx.apigateway.eu-frankfurt-1.oci.customer-oci.com/ords/_/landing
    Workspace: APEX_APP
    User: APEX_APP
    Password: Password__1234

    -----------------------------------------------------------------------
    AI Eval (APEX)
    https://xxxxxxxxxxx.apigateway.eu-frankfurt-1.oci.customer-oci.com/ords/r/apex_app/apex_app/
    User: APEX_APP / Password__1234

    -----------------------------------------------------------------------
    Chat (Streamlit)
    http://123.45.67.89:8080/

    -----------------------------------------------------------------------
    Chat (React)
    http://123.45.67.89/    
    </copy>
    ```

## Task 2: Create a Compartment

The compartment will be used to contain all the components of the lab.

You can
- Use an existing compartment to run the lab 
- Or create a new one (recommended)

1. Login to your OCI account/tenancy
2. Go the 3-bar/hamburger menu of the console and select
    1. Identity & Security
    1. Compartments
    ![Menu Compartment](images/compartment1.png =40%x*)
2. Click ***Create Compartment***
    - Give a name: ex: ***genai-agent***
    - Then again: ***Create Compartment***
    ![Create Compartment](images/compartment2.png)
4. When the compartment is created copy the compartment ocid ##COMPARTMENT_OCID## and put it in your notes


## Task 3: Run a Terraform script to create the other components.

1. Go to the OCI console homepage
2. Click the *Developer Tools* icon in the upper right of the page and select *Code Editor*. Wait for it to load.
3. Check that the Network used is Public. (see requirements)
4. Check that the Code Editor Architecture is well X86_64.
    - Go to Actions / Architecture
    - Check that the current Architecture is well X86_64.
    - If not change it to X86_64 and confirm. It will restart.

        ![OIC Domain](images/cloud-shell-architecture.png)

5. In the code editor menu, click *Terminal* then *New Terminal*
6. Run the command below in the terminal
    ![Menu Compute](images/terraform1.png =50%x*)
    ````
    <copy>
    git clone https://github.com/mgueury/oci-genai-agent-llama.git
    </copy>
    ````
7. Run each of the three commands below in the Terminal, one at a time. It will run Terraform to create the rest of the components.
    ```
    <copy>
    cd oci-genai-agent-llama
    </copy>
    ```
   
    ````
    <copy>
    ./starter.sh build
    </copy>
    ````

    Answer the question about Compartment OCID and Vault OCID.

    The script will ask to create or reuse:
    - a Vault (to store encryption keys) 
    - and a Compartment is asked for. 
    For both, it is a better idea to create one or reuse an existing one. But if you have none, the script will just create them.  

    In case of errors, check **Known Issues** below

8. **Please proceed to the [next lab](#next) while Terraform is running.** 
    Do not wait for the Terraform script to finish because it takes about 45 minutes and you can check the steps in the next labs while it's running. However, you will need to come back to this lab when it is done and complete the next step.
9. When Terraform will finished, you will see settings that you need in the next lab. Save these to your text file. It will look something like:

    ```
    <copy>    
    -----------------------------------------------------------------------
    Evaluation (API)
    http://xxxxxxxxxxx.apigateway.eu-frankfurt-1.oci.customer-oci.com/app/evaluate?question=What%20is%20the%20importance%20of%20Virus%20and%20Intrusion%20Detection

    -----------------------------------------------------------------------
    APEX Builder
    https://xxxxxxxxxxx.apigateway.eu-frankfurt-1.oci.customer-oci.com/ords/_/landing
    Workspace: APEX_APP
    User: APEX_APP
    Password: Password__1234

    -----------------------------------------------------------------------
    AI Eval (APEX)
    https://xxxxxxxxxxx.apigateway.eu-frankfurt-1.oci.customer-oci.com/ords/r/apex_app/apex_app/
    User: APEX_APP / Password__1234

    -----------------------------------------------------------------------
    Chat (Streamlit)
    http://123.45.67.89:8080/

    -----------------------------------------------------------------------
    Chat (React)
    http://123.45.67.89/    
    </copy>    
    ```
**You may now proceed to the [next lab](#next)**

## Known issues

1. During the terraform run, there might be an error resulting from the compute shapes supported by your tenancy:

    ```
    <copy>    
    oci_core_instance.starter_instance: Creating..
    - Error: 500-InternalError, Out of host capacity.
    Suggestion: The service for this resource encountered an error. Please contact support for help with service: Core Instance
    </copy>
    ```

    Solution:  edit the file *starter/src/terraform/variable.tf* and replace the *availability domain* to one where there are still capacity
    ```
    <copy>    
    OLD: variable availability_domain_number { default = 1 }
    NEW: variable availability_domain_number { default = 2 }
    </copy>    
    ```

    Then rerun the following command in the code editor

    ```
    <copy>
    ./starter.sh build
    </copy>
    ```

    If it still does not work, to find an availability domain or shape where there are still capacity, try to create a compute manually with the OCI console.

2. During the terraform run, there might be an error resulting from the compute shapes supported by your tenancy:

    ```
    <copy>    
    - Error: 404-NotAuthorizedOrNotFound, shape VM.Standard.x86.Generic not found
    </copy>    
    ```

    Solution:  edit the file *starter/src/terraform/variable.tf* and replace the *instance_shape* to one where there are still capacity in your tenancy/region
    ```
    <copy>    
    OLD: variable instance_shape { default = "VM.Standard.x86.Generic" }
    NEW: variable instance_shape { default = "VM.Standard.E4.Flex" }
    </copy>    
    ```

    Then rerun the following command in the code editor

    ```
    <copy>
    ./starter.sh build
    </copy>
    ```

    If it still does not work, to find an availability domain or shape where there are still capacity, try to create a compute manually with the OCI console.    

3. It happened on new tenancy that the terraform script failed with this error:

    ```
    <copy>    
    Error: 403-Forbidden, Permission denied: ...
    </copy>    
    ```

    In such case, just rerunning ./starter.sh build fixed the issue. It is also probable that your user is not admin and is missing right to create some type of OCI resources.

4. 409 - XXXXXAlreadyExists
    ```
    <copy>    
    Error: 409-PolicyAlreadyExists, Policy 'agent-fn-policy' already exists
    or
    Error: 409-BucketAlreadyExists, Either the bucket "agext-public-bucket' in namespace "xxxxxx" already exists or you are not authorized to create it
    </copy>    
    ```

    Several persons are probably trying to install this tutorial on the same tenancy.
    Solution:  edit the file *env.sh* and use a unique *TF\_VAR\_prefix*
    ```
    <copy>    
    OLD: export TF_VAR_prefix="llama"
    NEW: export TF_VAR_prefix="llama2"
    </copy>    
    ```

5. Error: 400-LimitExceeded, The following service limits were exceeded: xxxxxxx
   
    Solution:
    - Ask your administrator to increase your quota or the limits of the tenancy.

6. 404-NotAuthorizedOrNotFound in Createsecret.

    ```
    Error: 404-NotAuthorizedOrNotFound, Authorization failed or requested resource not found.
    Suggestion: Either the resource has been deleted or service Vault secret need policy to access this resource. Policy reference: https://docs.oracle.com/en-us/iaas/Content/Identity/Reference/po
    Documentation: https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/vault_secret
    API
    Reference: https://docs.oracle.com/iaas/api/=/en/secretmgmt/20180608/Secret/CreateSecret
    Request Target: POST https://vaults.us-chicago-1.oci.oraclecloud.com/20180608/secrets
    Provider version: 7.4.0, released on 2025-06-08. This provider is 1 Update(s) behind to current.
    Service: Vault Secret
    Operation Name: Createsecret
    with oci_vault_secret.starter_secret_atp,
    on db_connection.tf line 45, in resource "oci_vault_secret" "starter_secret_atp":
    45: resource "oci_vault_secret" "starter_secret_atp"
    ```

    You have no access to the vault.

    Solution: 
    - Ask your administrator to give you access to your vault. Ex: add this policy
        ```
        allow group OracleIdentityCloudService/specialists to use secret-family in compartment xxxxx-shared
        ```
    - Check that the installation is done in the same region than the Vault.

## Acknowledgements

- **Author**
    - Marc Gueury, Oracle Generative AI Platform
    - Omar Salem, Oracle Generative AI Platform
    - Ras Alungei, Oracle Generative AI Platform
    - Anshuman Panda, Oracle Generative AI Platform
