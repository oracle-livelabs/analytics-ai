# Install the Components

## Introduction

Estimated time: 60 min

In this section, we will install all the components needed using the OCI Wizards.

### Objectives

- Create all the components.

### Prerequisites

- A OCI Account
- Open a text editor and copy this text. This will be the variables that we will use during the lab.

````
<copy>
List of ##VARIABLES##
---------------------

User
----
COMPARTMENT_OCID = (SAMPLE) ocid1.compartment.oc1.amaaaaaaaa
OIC_OCID = (SAMPLE) ocid1.integrationinstance.oc1.aaaaaaaaa
USER_OCID = (SAMPLE) ocid1.user.oc1..amaaaaaaaa
AUTH_TOKEN = (SAMPLE)  X1232324_TGH
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

Components
----------
STREAM_BOOSTRAPSERVER = (SAMPLE) cell-1.streaming.eu-frankfurt-1.oci.oraclecloud.com:9092
STREAM_USERNAME = (SAMPLE) tenancy/oracleidentitycloudservice/name@domain.com/ocid1.streampool.oc1.eu-frankfurt-1.amaaaaaaaa

OPENSEARCH_API_ENDPOINT = (SAMPLE) https://amaaaaaaaa.opensearch.eu-frankfurt-1.oci.oraclecloud.com:9200
OPENSEARCH_HOST = (SAMPLE) amaaaaaaaa.opensearch.eu-frankfurt-1.oci.oraclecloud.com
OPENSEARCH_USER = opensearch-user
OPENSEARCH_PWD = (SAMPLE) LiveLab--123

OIC_HOST = (SAMPLE) opensearch-oic-namespace-fr.integration.ocp.oraclecloud.com

COMPUTE_PRIVATE-KEY = This is a file that you need to keep
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

- Check that you are in the right compartment (oci-starter in this case)
- Click *Create*
- Name: *oic*
- Version: *OIC Integration *
- Edition: *Standard*
- Shape: *Development*
- Choose the licence type 
- Click *Create*

![Create Integration](images/opensearch-oic2.png)

Wait that OIC is created and Green. 
When it is created, 
- Copy the OCID of the OIC instance in your text editor. ***##OIC_OCID##***. We will need it later.
- Enable Visual Builder



## Task 2: Create an Agent Group

To communicate with OpenSearch in the private network, we have to install the OIC agent on the compute.

First, 
- Go to the OIC console that you opened just above
- Take note of the hostname of OIC in the browser URL,  *##OIC_HOST##*
    - Ex: opensearch-oic-xxxxxx-fr.integration.ocp.oraclecloud.com 

Create the Agent Group
- On the left menu, choose *Integration*
- Then *Agent* 
- Click *Create Agent Group*
- Name: *OPENSEARCH\_AGENT\_GROUP* 
- Identifier: *OPENSEARCH\_AGENT\_GROUP*
- Then *Create*

![Create Agent Group](images/opensearch-oic-agent-group.png)

![Create Integration](images/opensearch-oic3.png)
![Menu Integration](images/opensearch-oic1.png =50%x*)

You do not have to wait that it is done to go to the next step.

## Task 3: Run Terraform to create the other components.

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
- Replace the value with your OIC OCID

````
<copy>
export TF_VAR_oic_ocid=##OIC_OCID##
export TF_VAR_oci_password=##OCI_PASSWORD##
</copy>
````

- Run 2 commands below

````
cd oci-searchlab/starter/
bin/gen_auth_token.sh
./build.sh
````

## Known issue

During the terraform run, there is a error:

```
oci_core_instance.starter_instance: Creating..
- Error: 500-InternalError, Out of host capacity.
  Suggestion: The service for this resource encountered an error. Please contact support for help with service: Core Instance
```

Solution:  edit the file starter/terraform/variable.sh
Replace:
```
OLD: variable instance_shape { default = "VM.Standard.E4.Flex" }
NEW: variable instance_shape { default = "VM.Standard.E3.Flex" }
```

## Acknowledgements

- **Author**
    - Marc Gueury
    - Badr Aissaoui
    - Marek Krátký 
- **History** - Creation - 24 May 2023