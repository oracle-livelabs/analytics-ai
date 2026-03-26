# Install the Components

## Introduction
In this lab, you will install all the components needed for this workshop. They will be provisioned automatically using a provided Terraform script.

Estimated time: 45 minutes

### Objectives

- Provision all cloud components

### Prerequisites

- An OCI Account with sufficient credits where you will perform the lab. (Some of the services used in this lab are not part of the *Always Free* program.)
- Check that your tenancy has access to the **Frankfurt or London or Chicago region**.
    - For paid tenancy:
        - Click on the region at the top of the screen.
        - Check that the Frankfurt, London, or Chicago region is listed.
        - If not, click on *Manage Regions* to add it to your region list. You need Tenancy Administrator rights for this.
        - For example, click on the US Midwest (Chicago).
        - Click Subscribe.

    ![Chicago Region](images/chicago-region.png)

    - For free trial accounts, the HOME region should be Frankfurt or London or Chicago.
- The lab uses Cloud Shell with Public Network.

    The lab assumes you have access to **OCI Cloud Shell with Public Network access**.
    To check if you have it, start Cloud Shell and you should see **Network: Public** at the top. If not, try to change to **Public Network**. If it works, you don't need to do anything further.
    ![Cloud Shell Public Network](images/cloud-shell-public-network.png)

    OCI Administrators have this right automatically, or your administrator may have already added the required policy.
    - **Solution:**

        If not, please ask your Administrators to follow this document:
        
        https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellintro_topic-Cloud_Shell_Networking.htm#cloudshellintro_topic-Cloud_Shell_Public_Network

        They just need to add a policy to your tenancy:

        ```
        <copy>
        allow group <GROUP-NAME> to use cloud-shell-public-network in tenancy
        </copy>        
        ```

## Task 1: Prepare to save configuration settings

1. Open a text editor and copy and paste this text into a text file on your local computer. These are the variables used during the lab.

    ```
    <copy>
    List of ##VARIABLES##
    =====================
    COMPARTMENT_OCID=(SAMPLE) ocid1.compartment.oc1.amaaaaaaaa
    TF_VAR_db_password=(SAMPLE) YOUR_PASSWORD

    Terraform Output
    ================

    -----------------------------------------------------------------------
    APEX login:

    APEX Workspace
    https://abcdefghijklmnop.apigateway.eu-frankfurt-1.oci.customer-oci.com/ords/_/landing
    Workspace: APEX_APP
    User: APEX_APP
    Password: YOUR_PASSWORD

    APEX APP
    https://abcdefghijklmnop.apigateway.eu-frankfurt-1.oci.customer-oci.com/ords/r/apex_app/apex_app/
    User: APEX_APP / YOUR_PASSWORD
    -----------------------------------------------------------------------
    Streamlit:
    http://12.45.67.89:8080/

    -----------------------------------------------------------------------
    LangGraph Agent Chat:
    https://abcdefghijklmnop.apigateway.eu-frankfurt-1.oci.customer-oci.com/agext8/chat.html

    -----------------------------------------------------------------------
    LangGraph OpenID Chat:
    https://abcdefghijklmnop.apigateway.eu-frankfurt-1.oci.customer-oci.com/openid/chat.html
    </copy>
    ```

## Task 2: Create a Compartment

The compartment will be used to contain all the components of the lab.

You can
- Use an existing compartment to run the lab 
- Or create a new one (recommended)

1. Log in to your OCI account/tenancy.
2. Go the 3-bar/hamburger menu of the console, navigate to Identity & Security / Compartments.
    ![Menu Compartment](images/compartment1.png)
2. Click ***Create Compartment***.
    - Give a name. For example, ***genai-agent***
    - Then again: ***Create Compartment***
    ![Create Compartment](images/compartment2.png)
4. When the compartment is created, copy the compartment OCID ##COMPARTMENT_OCID## and add it in your notes.


## Task 3: Run a Terraform script to create the other components.

1. Go to the OCI console homepage
2. Click the *Developer Tools* icon in the upper right of the page and select *Code Editor*. Wait for it to load.
3. Check that the network used is public. (see requirements)
4. Check that the Code Editor architecture is X86_64.
    - Go to Actions / Architecture
    - Check that the current architecture is X86_64.
    - If not, change it to X86_64 and confirm. It will restart.

        ![OIC Domain](images/cloud-shell-architecture.png)

5. In the code editor menu, click *Terminal* then *New Terminal*
6. Run the command below in the terminal
    ![Menu Compute](images/terraform1.png =50%x*)
    ````
    <copy>
    git clone https://github.com/marcgueury/oci-genai-db26ai-langgraph.git
    </copy>
    ````
7. (Optional). Enable OpenID login to the application.

    *!!! Note: This typically can only be done by an OCI Administrator or a user who has privilege to create OCI Confidential Application in your OCI Identity Domain !!!*

    Edit the file **starter/terraform.tfvars**. Uncomment the openid line:
    ```
    <copy>
    openid="true" 
    </copy>
    ```

8. Run each of the commands below in the Terminal, one at a time. It will run Terraform to create the rest of the components.
    ```
    <copy>
    cd oci-genai-db26ai-langgraph/starter/
    </copy>
    ```
   
    ````
    <copy>
    ./starter.sh build
    </copy>
    ````

    Answer the questions about Compartment OCID and Database Password.

    In case of errors, check **Known Issues** below

9. **Please proceed to the [next lab](#next) while Terraform is running.** 
    Do not wait for the Terraform script to finish, because it takes about 45 minutes. You can check the steps in the next labs while it's running. However, you will need to come back to this lab when it is done and complete the next step.
10. When Terraform has finished, you will see settings that you need for the next lab. Save these to your text file. It will look something like:

    ```
    <copy>    
    -----------------------------------------------------------------------
    APEX login:

    APEX Workspace
    https://abcdefghijklmnop.apigateway.eu-frankfurt-1.oci.customer-oci.com/ords/_/landing
    Workspace: APEX_APP
    User: APEX_APP
    Password: YOUR_PASSWORD

    APEX APP
    https://abcdefghijklmnop.apigateway.eu-frankfurt-1.oci.customer-oci.com/ords/r/apex_app/apex_app/
    User: APEX_APP / YOUR_PASSWORD
    -----------------------------------------------------------------------
    Streamlit:
    http://12.45.67.89:8080/

    -----------------------------------------------------------------------
    LangGraph Agent Chat:
    https://abcdefghijklmnop.apigateway.eu-frankfurt-1.oci.customer-oci.com/agext8/chat.html

    -----------------------------------------------------------------------
    LangGraph OpenID Chat:
    https://abcdefghijklmnop.apigateway.eu-frankfurt-1.oci.customer-oci.com/openid/chat.html
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

    Solution: Edit the file *starter/src/terraform/variable.tf* and change the *availability domain* to one where there is still capacity
    ```
    <copy>    
    OLD: variable availability_domain_number { default = 1 }
    NEW: variable availability_domain_number { default = 2 }
    </copy>    
    ```

    Then re-run the following command in the code editor

    ```
    <copy>
    ./starter.sh build
    </copy>
    ```

    If it still does not work, try to create a compute instance manually in the OCI console to find an availability domain or shape with enough capacity.

2. During the terraform run, there might be an error resulting from the compute shapes supported by your tenancy:

    ```
    <copy>    
    - Error: 404-NotAuthorizedOrNotFound, shape VM.Standard.x86.Generic not found
    </copy>    
    ```

    Solution:  edit the file *starter/src/terraform/variable.tf* and replace the *instance_shape* to one where there is still capacity in your tenancy/region
    ```
    <copy>    
    OLD: variable instance_shape { default = "VM.Standard.x86.Generic" }
    NEW: variable instance_shape { default = "VM.Standard.E4.Flex" }
    </copy>    
    ```

    Then re-run the following command in the code editor

    ```
    <copy>
    ./starter.sh build
    </copy>
    ```

    If it still does not work, to find an availability domain or shape where there is still capacity, try creating a compute manually with the OCI console.    

3. It has happened on new tenancies that the Terraform script fails with the following error:

    ```
    <copy>    
    Error: 403-Forbidden, Permission denied: Cluster creation failed. Ensure required policies are created for your tenancy. If the error persists, contact support.
    Suggestion: Please retry or contact support for help with service: xxxx
    </copy>    
    ```

    In such a case, simply re-running *./starter.sh build* may fix the issue.

4. 409 - XXXXXAlreadyExists
    ```
    <copy>    
    Error: 409-PolicyAlreadyExists, Policy 'agent-fn-policy' already exists
    or
    Error: 409-BucketAlreadyExists, Either the bucket "agext-public-bucket' in namespace "xxxxxx" already exists or you are not authorized to create it
    </copy>    
    ```

    This may occur if several people are trying to install this tutorial in the same tenancy.
    Solution: Edit the file *terraform.tfvars* and use a unique *prefix*.
    ```
    <copy>    
    OLD: prefix="agent"
    NEW: prefix="agent2"
    </copy>    
    ```

 5. BadErrorResponse - CreateDynamicResourceGroup 
 
    If your user does not have the right to create a Dynamic Group in the Default Identity Domain, you will get this error:
     
    ```
    <copy>
    Error: 400-BadErrorResponse,
    Suggestion: Please retry or contact support for help with service: Identity Domains Dynamic Resource Group
    Documentation: https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_domains_dynamic_resource_group
    API Reference:
    Request Target: POST https://idcs-xxxxxx.identity.oraclecloud.com:443/admin/v1/DynamicResourceGroups
    Provider version: 6.21.0, released on 2024-12-22. This provider is 8 Update(s) behind to current.
    Service: Identity Domains Dynamic Resource Group
    Operation Name: CreateDynamicResourceGroup
    OPC request ID: xxxxxx
    with oci_identity_domains_dynamic_resource_group.search-fn-dyngroup,
    on search_dyngroup_identity_domain.tf line 1, in resource “oci_identity_domains_dynamic_resource_group” “search-fn-dyngroup”:
    1: resource “oci_identity_domains_dynamic_resource_group” “search-fn-dyngroup” {
    </copy>    
    ```
    Solution:
    1. If the Default Domain exists, it is probably a privilege issue. Ask your tenancy administrator.
    2. If your Identity Domain is “OracleIdentityCloudService” (for tenancies upgraded from IDCS)
        - edit the file starter/terraform.tfvars 
        - add the line
        ```
        <copy>
        idcs_domain_name="OracleIdentityCloudService"
        </copy>
        ```

6. Error: 400-LimitExceeded, The following service limits were exceeded: xxxxxxx
   
    Solution:
    - Ask your administrator to increase your quota or the limits of the tenancy.
   
7. Error: Attempt to index null value

  ```
  <copy>
  on datasource.tf line 64, in locals:
  64:   idcs_url = (var.idcs_url!="")?var.idcs_url:data.oci_identity_domains.starter_domains.domains[0].url
    ├────────────────
    │ data.oci_identity_domains.starter_domains.domains is null
  </copy>
  ```

  Workaround:
  - This is due to lacking privileges to access the list of domains in your tenancy.
  - Edit file terraform.tfvars and add this line:
    ```
    <copy>
    idcs_url=https://idcs-xxxxxx.identity.oraclecloud.com:443
    </copy>
    ````
    You can find this URL by:
    - going to OCI Console / Hamburger menu / Identity and Security / Domains 
    - go to the root compartment
    - choose the *default* domain
    - look for the domain URL. It will look like: https://idcs-xxxxxx.identity.oraclecloud.com:443
  - Re-run *./starter.sh build*


## Acknowledgements

- **Author**
    - Marc Gueury, Generative AI Specialist
