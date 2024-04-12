# Install the Components

## Introduction
In this lab, you will install all the components needed for this workshop. Some of these will be provisioned manually and many will be provisioned automatically using a provided Terraform script.

Estimated time: 50 min

### Objectives

- Provision all the cloud components

### Prerequisites

- An OCI Account with sufficient credits where you will perform the lab. (Some of the services used in this lab are not part of the *Always Free* program.)
- Cookies must be enabled in your browser to use the OCI console code editor in this lab
- Choose which web browser to use before you start. There is an option in a later lab to download a github repo to your local computer using the OCI Console Cloud Shell. Some users have experienced a bug attempting to do this with the Firefox Browser Extended Support Release (ESR). The Chrome browser is an alternative in this case.
- Check that your tenancy has access to the Chicago Region
    - For Paid Tenancy
        - Click on region on top of the screen
        - Check that the Chicago Region is there (Green rectangle)
        - If not, Click on Manage Regions to add it to your regions list. You need Tenancy Admin right for this.
        - Click on the US MidWest (Chicago)
        - Click Subscribe

    ![Chicago Region](images/chicago-region.png)

    - For Free Trial, the home region should be Chicago

## Task 1: Prepare to save configuration settings

1. Open a text editor and copy & paste this text into a text file on your local computer. These will be the variables that will be used during the lab.

    ````
    <copy>
    List of ##VARIABLES##
    ---------------------
    COMPARTMENT_OCID=(SAMPLE) ocid1.compartment.oc1.amaaaaaaaa
    OIC_OCID=(SAMPLE) ocid1.integrationinstance.oc1.aaaaaaaaa
    OIC_APPID=(SAMPLE) ABC12345678_APPID
    
    TENANCY_OCID = (SAMPLE) ocid1.tenancy.oc1..amaaaaaaaa
    USERNAME= (sample) john.doe@example.com
    USER_OCID = (SAMPLE) ocid1.user.oc1..amaaaaaaaa
    PRIVATE_KEY = (SAMPLE) file private_key.pem

    -----BEGIN PRIVATE KEY-----
    AAAAB3NzaC1yc2EAAAABIwAAAQEAklOUpkDHrfHY17SbrmTIpNLTGK9sdfhkjdhf
    ...
    -----END PRIVATE KEY-----

    PRIVATE_KEY_RSA_FORMAT = (SAMPLE) file private_key_rsa_format.pem

    -----BEGIN RSA PRIVATE KEY-----
    ABCDEpAIBAAKCAQEAxHbqmTFASn48FY8mVtVZoUUE5iixGFpcN6JSdHHaxtkqTbx2
    ...
    -----END RSA PRIVATE KEY-----

    FINGERPRINT = (SAMPLE) aa:aa:aa:98:ac:84:96:f5:a8:aa:aa:aa:aa:aa:aa:a

    Terraform Output
    ----------------
    -- STREAMING CONNECTION --------------------------
    STREAM_BOOSTRAPSERVER=(SAMPLE)cell-1.streaming.us-phoenix-1.oci.oraclecloud.com:9092
    STREAM_USERNAME=(SAMPLE)tenantname/username/ocid1.streampool.oc1.phx.amaaaaaa3twn4mia5hvcf4m3npe2l76fxfhffbrabcdefgh
    AUTH_TOKEN=(SAMPLE)abcdefgh$$123

    -- FUNCTION CONNECTION ---------------------------
    FUNCTION_ENDPOINT=(SAMPLE)https://abcdefgh.us-phoenix-1.functions.oci.oraclecloud.com/20181201/functions/ocid1.fnfunc.oc1.phx.aaaaaaaacfum7wwrgt34y5pdnjum24kqxr6lkjdgabcdefgh

    -- OPENSEARCH CONNECTION --------------------------
    OPENSEARCH_API_ENDPOINT=(SAMPLE)https://amaaaaaaabcdefgh.opensearch.us-phoenix-1.oci.oraclecloud.com:9200

    -- API GATEWAY CONNECTION ------------------------
    APIGW_URL=(SAMPLE)https://abcdefgh.apigateway.us-phoenix-1.oci.customer-oci.com
    </copy>
    `````

## Task 2: Create a Compartment

The compartment will be used to contain all the components of the lab.

You can
- Use an existing compartment to run the lab 
- Or create a new one (recommended)

1. Login to your OCI account/tenancy
1. Go the 3-bar/hamburger menu of the console and select
    1. Identity & Security
    1. Compartments
    ![Menu Compartment](images/opensearch-compartment1.png =40%x*)
2. Click ***Create Compartment***
    - Give a name: ***oci-starter***
    - Then again: ***Create Compartment***
    ![Create Compartment](images/opensearch-compartment2.png)
2. When the compartment is created copy the compartment ocid ##COMPARTMENT_OCID## and put it in your notes
    - Give a name: ***oci-starter***
    - Then again: ***Create Compartment***
    ![Create Compartment](images/opensearch-compartment2.png)    

## Task 3: Create an Oracle Integration instance

Oracle Integration Cloud (OIC) will allow you to glue all of the components together.
Note: If you have just created your Cloud Account, it is possible that you need to wait few minutes before to complete this step.

1. Go the Cloud console 3-bar/hamburger menu and select the following
    1. Developer Services
    1. Integration (under Application Integration)
    ![Menu Integration](images/opensearch-oic1.png =50%x*)
2. Check that you are in the intended compartment (*oci-starter* in this case)
3. Click the *Create Instance* button and set the following options
    - Name: *oic*
    - Version: *OIC Integration 3*
    - Edition: *Standard*
    - Shape: *Development*
    - Choose the license type (Use *Subscribe to a new...* unless you already have a license that you can reuse.)
    - Click *Create*
        ![Create Integration](images/opensearch-oic2.png)
4. Wait about 3 mins until **oic** state is *Active*.
1. Click *oic* in the list of integration instances. 
5. In the *Integration instance details*, click **Service Console**. It will open a new tab that you will use in the next Task.
1. In the *Integration instance details*, copy the OCID of the OIC instance and paste it in your text file at ***OIC_OCID***. You will need it later.
1. Click **Enable** next to *Visual Builder* to enable it. The **oic** instance status will change to *updating*.
    ![Visual Builder Enable Integration](images/opensearch-oic3.png)

1. Continue to next task. You do not have to wait for Visual Builder to be installed before continuing.

## Task 4: Get the OIC AppID (ClientID)

To enable Resource Principal, you need the OIC APPID.

1. Go the console 3-bar/hamburger menu and select
    1. Identity & Security 
    1. Domains (under Identity)
    ![Menu Domain](images/opensearch-oic-domain.png)
2. Choose the *Default (Current domain)* domain
3. On the left, choose *Oracle Cloud Services*
    ![OIC Domain](images/opensearch-oic_service.png)
4. Scroll down until that you see a name like *oic-xxx-xxxx* and the *Description* is *Integration Cloud Service*, then **click on it**
5. In the Service details, look for *Client ID* under *General Information*
    - Copy the value to your text file at *##OIC\_APPID##*. It will be of the something like 668BEAAAA904B7EBBBBBBC5E33943B\_APPID
    ![OIC Domain](images/opensearch-oic_appid.png)

## Task 5: Run a Terraform script to create the other components.

1. Go to the OCI console homepage
2. Click the *Developer Tools* icon in the upper right of the page and select *Code Editor*. Wait for it to load.
3. Check that the Code Editor Architecture is well X86_64.
    - Go to Actions / Architecture
    - Check that the current Architecture is well X86_64.
    - If not change it to X86_64 and confirm. It will restart.

        ![OIC Domain](images/opensearch-shell-architecture.png)

4. In the code editor menu, click *Terminal* then *New Terminal*
5. Run the command below in the terminal
    ![Menu Compute](images/opensearch-terraform1.png =50%x*)
    ````
    <copy>
    git clone https://github.com/mgueury/oci-genai-searchlab.git
    </copy>
    ````
6. Edit the file *oci-genai-searchlab/starter/env.sh*
    1. Click the **Explorer** icon in the left bar of the code editor
    1. Use Explorer to locate env.sh
    1. Click env.sh to open it in the editor
7. In env.sh, replace the ## with the corresponding value from your text file.
    ````
    <copy>
    export TF_VAR_compartment_ocid="##COMPARTMENT_OCID##"
    export TF_VAR_oic_ocid="##OIC_OCID##"
    export TF_VAR_oic_appidd="##OIC_APPID##"
    </copy>
    ````
8. Save your edits using File > Save
9. Run each of the three commands below in the Terminal, one at a time. It will run Terraform to create the rest of the components.
    ```
    <copy>
    cd oci-genai-searchlab/starter/
    </copy>
    ```
    ```
    <copy>
    bin/gen_auth_token.sh
    </copy>
    ```
    You should see the following in the results of the *gen\_auth\_token.sh* script:
    - AUTH\_TOKEN stored in env.sh
    - TF\_VAR\_auth\_token='a generated token'

    
    ````
    <copy>
    ./build.sh
    </copy>
    ````
10. **Please proceed to the [next lab](#next) while Terraform is running.** 
    Do not wait for the Terraform script to finish because it takes about 34 minutes and you can complete some steps in the next lab while it's running. However, you will need to come back to this lab when it is done and complete the next step.
11. When Terraform will finished, you will see settings that you need in the next lab. Save these to your text file. It will look something like:

    ```
    --------------------------
    OCI SEARCH LAB Environment
    --------------------------

    -- STREAMING CONNECTION --------------------------
    STREAM_BOOSTRAPSERVER=cell-1.streaming.us-phoenix-1.oci.oraclecloud.com:9092
    STREAM_USERNAME=tenantname/username/ocid1.streampool.oc1.phx.amaaaaaa3twn4mia5hvcf4m3npe2l76fxfhffbrabcdefgh
    AUTH_TOKEN=abcdefgh$$123

    -- FUNCTION CONNECTION ---------------------------
    FUNCTION_ENDPOINT=https://abcdefgh.us-phoenix-1.functions.oci.oraclecloud.com/20181201/functions/ocid1.fnfunc.oc1.phx.aaaaaaaacfum7wwrgt34y5pdnjum24kqxr6lkjdgabcdefgh

    -- OPENSEARCH CONNECTION --------------------------
    OPENSEARCH_API_ENDPOINT=https://amaaaaaaabcdefgh.opensearch.us-phoenix-1.oci.oraclecloud.com:9200

    -- API GATEWAY CONNECTION ------------------------
    APIGW_URL=https://abcdefgh.apigateway.us-phoenix-1.oci.customer-oci.com

    Done.
    ```
**You may now proceed to the [next lab](#next)**

## Known issues

1. During the terraform run, there might be an error resulting from the compute shapes supported by your tenancy:

    ```
    oci_core_instance.starter_instance: Creating..
    - Error: 500-InternalError, Out of host capacity.
    Suggestion: The service for this resource encountered an error. Please contact support for help with service: Core Instance
    ```
    Solution:  edit the file *oci-genai-searchlab/starter/src/terraform/variable.tf* and replace the *availability domain* to one where there are still capacity
    ```
    OLD: variable availability_domain_number { default = 1 }
    NEW: variable availability_domain_number { default = 2 }
    ```

    Then rerun the following command in the code editor
    ```
    <copy>
    ./build.sh
    </copy>
    ```

    If it still does not work, to find an availability domain or shape where there are still capacity, try to create a compute manually with the OCI console.

2. It happened on new tenancy that the terraform script failed with this error:

    ```
    Error: 403-Forbidden, Permission denied: Cluster creation failed. Ensure required policies are created for your tenancy. If the error persists, contact support.
    Suggestion: Please retry or contact support for help with service: Opensearch Cluster
    Documentation: https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/opensearch_opensearch_cluster 
    API Reference: https://docs.oracle.com/iaas/api/#/en/opensearch/20180828/OpensearchCluster/CreateOpensearchCluster 
    Request Target: POST https://search-indexing.eu-frankfurt-1.oci.oraclecloud.com/20180828/opensearchClusters 
    Provider version: 5.14.0, released on 2023-09-27. This provider is 1 Update(s) behind to current. 
    Service: Opensearch Cluster 
    Operation Name: CreateOpensearchCluster 
    ```

    In such case, just rerunning ./build.sh fixed the issue.

3. During terraform:
    ```
    Error: 409-PolicyAlreadyExists, Policy 'search-fn-policy' already exists
    ```

    Several persons are probably trying to install this tutorial on the same tenancy.

    Solution:  edit the file *env.sh* and use a unique *TF\_VAR\_prefix*
    ```
    OLD: export TF_VAR_prefix="search"
    NEW: export TF_VAR_prefix="search2"
    ```

## Acknowledgements

- **Author**
    - Marc Gueury, Master Principal Account Cloud Engineer
    - Badr Aissaoui, Principal Account Cloud Engineer
    - Marek Krátký, Cloud Storage Specialist 

