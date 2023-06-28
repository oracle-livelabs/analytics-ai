# Install the Components

## Introduction

Estimated time: 60 min

In this section, we will install all the components needed using the OCI Wizards.

### Objectives

- Create all the components.

### Prerequisites

- An OCI Account
- Open a text editor and copy this text. This will be the variables that we will use during the lab.

````
<copy>
List of ##VARIABLES##
---------------------

User
----
COMPARTMENT_OCID = (SAMPLE) ocid1.compartment.oc1.amaaaaaaaa
OIC_OCID = (SAMPLE) ocid1.integrationinstance.oc1.aaaaaaaaa
OIC_CLIENT_ID = (SAMPLE) 668BEAAAA904B7EBBBBBBC5E33943B_APPID
OIC_CLIENT_SECRET = (SAMPLE) 12345678$#12234
OIC_SCOPE = (SAMPLE) https://1234567890.integration.us-phoenix-1.ocp.oraclecloud.com:443/ic/api/

## NOT USED
USER_OCID = (SAMPLE) ocid1.user.oc1..amaaaaaaaa
AUTH_TOKEN = (SAMPLE)  X1232324_TGH
OCI_PASSWORD = (SAMPLE) LiveLab--123

Components
----------
STREAM_BOOSTRAPSERVER = (SAMPLE) cell-1.streaming.eu-frankfurt-1.oci.oraclecloud.com:9092
STREAM_USERNAME = (SAMPLE) tenancy/oracleidentitycloudservice/name@domain.com/ocid1.streampool.oc1.eu-frankfurt-1.amaaaaaaaa

OPENSEARCH_API_ENDPOINT = (SAMPLE) https://amaaaaaaaa.opensearch.eu-frankfurt-1.oci.oraclecloud.com:9200
OPENSEARCH_HOST = (SAMPLE) amaaaaaaaa.opensearch.eu-frankfurt-1.oci.oraclecloud.com
OPENSEARCH_USER = opensearch-user
OPENSEARCH_PWD = (SAMPLE) LiveLab--123

OIC_HOST = (SAMPLE) opensearch-oic-namespace-fr.integration.ocp.oraclecloud.com

COMPUTE_PUBLIC-IP = (SAMPLE) 123.123.123.123
AI_VISION_URL = (SAMPLE) https://vision.aiservice.eu-frankfurt-1.oci.oraclecloud.com
FUNCTION_ENDPOINT = (SAMPLE) https://amaaaaaaaa.eu-frankfurt-1.functions.oci.oraclecloud.com/20181201/functions/ocid1.fnfunc.oc1.eu-frankfurt-1.amaaaaaaaa
APIGW_HOSTNAME = (SAMPLE) amaaaaaaaa.apigateway.eu-frankfurt-1.oci.customer-oci.com
</copy>
`````

## Task 1: Create a Compartment

The compartment will be used to contains all the components of the lab.

You can
- Use an existing compartment to run the lab. 
- Or create a new one.

Go the menu
- Identity & Security
- Choose Compartment

![Menu Compartment](images/opensearch-compartment1.png =40%x*)

Go to the right place in the hierarchy
- Click ***Create Compartment***
- Give a name: ***oci-starter***
- Then again: ***Create Compartment***

![Create Compartment](images/opensearch-compartment2.png)

After creating the compartment, copy the OCID in your text editor. ***##COMPARTMENT_OCID##***. We will need it later.

![Details Compartment](images/opensearch-compartment3.png)

## Task 2: Create an Oracle Integration instance

Oracle Integration will allow to glue all of this together.

Go the menu
- Developer Services
- Application Integration

![Menu Integration](images/opensearch-oic1.png =50%x*)

- Check that you are in the right compartment (*oci-starter* in this case)
- Click *Create*
- Name: *oic*
- Version: *OIC Integration 3*
- Edition: *Standard*
- Shape: *Development*
- Choose the licence type 
- Click *Create*

![Create Integration](images/opensearch-oic2.png)

Wait 3 mins that OIC is created and Green. 
When it is created, 
- Click **Service Console**. It will open a new tab that you will use in Task 3.
- Copy the OCID of the OIC instance in your text editor. ***##OIC_OCID##***. We will need it later.
- Enable Visual Builder

You do not have to wait that it is done before to go to the next step.

![Visual Builder Enable Integration](images/opensearch-oic3.png)

## Task 3: Create an Agent Group

To communicate with OpenSearch in the private network, we have to install the OIC agent on the compute.

First, 
- Go to the OIC console that you opened just above

Create the Agent Group
- On the left menu, choose *Design*
- Then *Agent* 
- Click *Create*
- Name: *OPENSEARCH\_AGENT\_GROUP* 
- Identifier: *OPENSEARCH\_AGENT\_GROUP*
- Then *Create*

![Create Agent Group](images/opensearch-oic3-agent-group.png)

## Task 4: Get the OIC AppID (ClientID)

Go the menu
- Identity & Security
- Domains

![Menu Domain](images/opensearch-oic-domain.png)

- Choose *Default (current domain)*
- On the left, choose *Oracle Cloud Services*

![OIC Domain](images/opensearch-oic_service.png)

- Scroll down until that you see a name like  
    oic-xxx-xxxx  - Integration Service
- Click on it
- In the Service details look for *Client ID*
- Copy the value in your notes *##OIC\_CLIENT\_ID##*. It will be of the something like 668BEAAAA904B7EBBBBBBC5E33943B\_APPID
- Click *Show Secret* Copy the value in your notes *##OIC\_APPID##*.

![OIC Domain](images/opensearch-oic_appid.png)

## Task 5: Get the OIC Client ID/Secret

Again, go the menu
- Identity & Security
- Domains

![Menu Domain](images/opensearch-oic-domain.png)

- Choose *Default (current domain)*
- On the left, choose *Oracle Cloud Services*

![OIC Domain](images/opensearch-oic_service.png)

- Scroll down until that you see a name like (this time)
    opensearch_agent_group-oic-xxx-xxxx  - Connectivity Agent OAuth Client
- Click on it
- In the Service details look for *Client ID*
- Copy the value in your notes *##OIC\_CLIENT\_ID##*. It will be of the something like 668BEAAAA904B7EBBBBBBC5E33943B\_APPID
- Click *Show Secret* Copy the value in your notes *##OIC\_CLIENT\_SECRET##*.

![OIC Domain](images/opensearch-confapp1.png)

- Scroll further in the page.
- Copy the scope finishing with /ic/api in your notes *##OIC\_SCOPE##*. It will be of the something like https://12345678.integration.us-phoenix-1.ocp.oraclecloud.com:443/ic/api/

![OIC Domain](images/opensearch-confapp2.png)

## Task 6: Run Terraform to create the other components.

In OCI,

- Login to your OCI account
- Click Code Editor
- Click New Terminal
- Copy paste the command below. 

![Menu Compute](images/opensearch-terraform1.png =50%x*)

````
<copy>
git clone https://github.com/mgueury/oci-searchlab.git
</copy>
````
- Edit the file oci-searchlab/starter/env.sh
- Replace the value with your ##OIC\_OCID##, ##OIC\_CLIENT\_ID##, ##OIC\_CLIENT\_SECRET##, ##OIC\_SCOPE##
- Replace the value with the password of the OCI account. It will be used to download 

````
<copy>
export TF_VAR_oic_ocid="##OIC_OCID##"
export TF_VAR_oic_client_id="##OIC_CLIENT_ID##"
export TF_VAR_oic_client_secret="##OIC_CLIENT_SECRET##"
export TF_VAR_oic_scope="##OIC_SCOPE##"
</copy>
````

- Run 2 commands below. It will run Terraform to create the rest of the components.

````
<copy>
cd oci-searchlab/starter/
bin/gen_auth_token.sh
./build.sh
</copy>
````

- You can already run the Lab 3, Task 1 and 2. When it is finished. 
  You will see:

```



```


## Known issue

During the terraform run, there is a error:

```
oci_core_instance.starter_instance: Creating..
- Error: 500-InternalError, Out of host capacity.
  Suggestion: The service for this resource encountered an error. Please contact support for help with service: Core Instance
```

Solution:  edit the file oci-searchlab/starter/src/terraform/variable.tf
Replace:
```
OLD: variable instance_shape { default = "VM.Standard.E4.Flex" }
NEW: variable instance_shape { default = "VM.Standard.E3.Flex" }
```

Then rerun

```
./build.sh
```


## Acknowledgements

- **Author**
    - Marc Gueury
    - Badr Aissaoui
    - Marek Krátký 
- **History** - Creation - 24 May 2023