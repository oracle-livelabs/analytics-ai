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
TENANCY_OCID = (SAMPLE) ocid1.tenancy.oc1..amaaaaaaaa
COMPARTMENT_OCID = (SAMPLE) ocid1.compartment.oc1..amaaaaaaaa
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
- Give a name: ex: ***livelab***
- Then again: ***Create Compartment***

![Create Compartment](images/opensearch-compartment2.png)

After creating the compartment, copy the OCID in your text editor. ***##COMPARTMENT_OCID##***. We will need it later.

![Details Compartment](images/opensearch-compartment3.png)

## Task 2: Create an Object Storage Bucket

Object storage will be used to contain the documents to index.

Go the menu
- Storage
- Object Storage / Bucket

![Menu Object Storage](images/opensearch-objectstorage1.png)

- Choose the right compartment (livelab in this case)
- Click *Create Bucket*
- Bucket name: *opensearch-bucket*
- Check: *Emit Object Events*
- Click *Create*

![Create Object Storage](images/opensearch-objectstorage2.png)

## Task 3: Create a Stream

The stream will queue the list of files uploaded to Object Storage before processing.

Go the menu
- Analytics / AI
- Messaging / Streaming

![Menu Streaming](images/opensearch-streaming1.png =50%x*)

- Check that you are in the right compartment (livelab in this case)
- Click ***Create Stream***
- Stream Name: *opensearch-stream*
- Choose: *Create a new stream pool*
- Stream Pool Name: *opensearch-streampool*
- Then, *Create Stream*

![Create Streaming](images/opensearch-streaming2.png)

Collect some infos about the stream:
- Go to the *Stream Pool* that you have created
- Go the *Kafka Connection Settings*
- Note *##STREAM_BOOSTRAPSERVER##*: the Bootstrap Servers: ex: "cell-1.streaming.eu-frankfurt-1.oci.oraclecloud.com:9092" 
- Note *##STREAM_USERNAME##*: user name in the SASL Connection Strings ex: "tenancyname/oracleidentitycloudservice/name@domain.com/ocid1.streampool.oc1.eu-frankfurt-1.amaccccccccfsdfsdxfa"

![Details Streaming](images/opensearch-streaming3.png)

## Task 4: Create an Event Rule

The "Event rule" will send Object Storage events (file upload, ...) to the Stream created above.

Go the menu
- Observability & Management
- Event Rules

![Menu Rule](images/opensearch-rule1.png =40%x*)

- Check that you are in the right compartment (livelab in this case)
- Click *Create Rule*
- Display Name: *opensearch-input-rule*
- Add the Rules Condition:
    - Condition: *Event Type*
    - Service: *Object Storage*
    - Event Type: *Object - Create, Object - Delete, Object - Update*
- Add Another Condition
    - Condition: *Attribute*
    - Attribute Name: *bucketName*
    - Attribute value: *opensearch-bucket* (Then press enter)
- In the actions:
    - Action Type: *Streaming*
    - Stream Compartment: *livelab*
    - Stream: *opensearch-stream*
- Click *Create Rule*

![Create Rule](images/opensearch-rule2.png)

## Task 5: Create a Virtual Cloud Network

The Virtual Cloud Network will allow you to manage the network of the components.

Go the menu
- Networking
- Virtual Cloud Network

![Menu VNC](images/opensearch-vcn1.png =50%x*)

- Check that you are in the right compartment (livelab in this case)
- Click *Start VCN Wizard*
- Choose the default: *Create VCN with Internet Connectivity*
- Click *Start VCN Wizard* again

![Create VCN](images/opensearch-vcn2.png)
- VCN Name: *opensearch-vcn*
- Keep the rest default
- Click *Next*
- Click *Create*

![Create VNC Tab 2](images/opensearch-vcn3.png)

- Click *View Virtual Cloud Network*
- Choose *Security List*
- Then click on *Default Security List for opensearch-vcn*

![Create VNC Tab 3](images/opensearch-vcn4.png)

- Click *Add Ingress Rules*
- Source CIDR: *0.0.0.0/0*
- Destination Port: *443*
- Click *Add Ingress Rule*

![Ingress Rule 1](images/opensearch-vcn5.png)

- Choose *Security List* again
- Go to the other entry *Security List for Private Subnet-opensearch-vcn*
- Click *Add Ingress Rules*
- Source CIDR: *0.0.0.0/0*
- Destination Port: *5601,9200*
- Click *Add Ingress Rule*

![Ingress Rule 2](images/opensearch-vcn6.png)

## Task 6: Create a Dynamic group

The "Dynamic Group" will allow to give rights to the function (created later) to read the Object Storage.

Go the menu
- Identity & Security 
- Policies

![Menu Dynamic Group](images/opensearch-dyngroup.png =50%x*)

- Click *Create Dynamic Group*
- Name: *opensearch-fn-dyngroup*
- Description: *opensearch-fn-dyngroup*
- Rule (Replace the value ##COMPARTMENT_OCID## with your note above) 

```
<copy>
ALL {resource.type = 'fnfunc', resource.compartment.id = '##COMPARTMENT_OCID##'}
</copy>
Ex: ALL {resource.type = 'fnfunc', resource.compartment.id = 'ocid1.compartment.oc1..aaaaaaaanmnkccccc'}
```
![Create Dynamic Group](images/opensearch-dyngroup2.png)

## Task 7: Create Policies

The policies will give the rights to the components to access other components.

Go the menu
- Identity & Security 
- Policies

![Menu Policy](images/opensearch-policy1.png)

- Check that you are in the right compartment (livelab in this case)
- Click *Create Policy*
- Name: *opensearch-policy*
- Description: *opensearch-policy*
- Choose: *Show manual editor*
- Copy paste the below policies

```
<copy>
Allow service opensearch to manage vnics in compartment livelab
Allow service opensearch to use subnets in compartment livelab
Allow service opensearch to use network-security-groups in compartment livelab
Allow service opensearch to manage vcns in compartment livelab
Allow dynamic-group opensearch-fn-dyngroup to manage objects in compartment livelab
</copy>
```

- Click *Create*

![Create Policy](images/opensearch-policy2.png)

## Task 8: Create an OpenSearch Cluster

The OpenSearch cluster will allow to search in the text format representation of the documents.

Go the menu
- Database
- OpenSearch - Clusters

![Menu Cluster](images/opensearch-cluster1.png)

- Check that you are in the right compartment (livelab in this case)
- Click *Create Cluster*
- Name: *opensearch-cluster*
- Click *Next*

![Menu Cluster](images/opensearch-cluster-security.png)

On the second screen (Configure security), 
- Username: *opensearch-user*
- Password (for ex): *LiveLab--123*
- Confirm Password: *LiveLab--123*

After creating the compartment, copy the user/password in your text editor. *##OPENSEARCH\_USER##* and *##OPENSEARCH\_PWD##*. We will need them later.

![Create Cluster](images/opensearch-cluster2.png)

On the third screen (configure nodes), 
- Keep the default: *Development*
- Click *Next*

On the Configure Networking screen, 
- Choose the VCN created above: *opensearch-vcn*
- Choose the private network: *Private Subnet-opensearch-vcn*
- Click *Next*
- Then *Create*

![Create Cluster Tab Networking](images/opensearch-cluster3.png)

While OCI creates the instance, you can run the next step. 

When it is finished. You will need to get the name of OpenSearch hostname. *##OPENSEARCH_HOST##*. It looks like this: amaaaaxxx.opensearch.eu-frankfurt-1.oci.oraclecloud.com 

It is here:

![Cluster Details](images/opensearch-cluster4.png)

## Task 9: Create an Oracle Integration instance

Oracle Integration will allow to glue all of this together.

Go the menu
- Developer Services
- Application Integration

![Menu Integration](images/opensearch-oic1.png =50%x*)

- Check that you are in the right compartment (livelab in this case)
- Click *Create*
- Name: *opensearch-oic*
- Edition: *Standard*
- Choose the licence type 
- Click *Create*

![Create Integration](images/opensearch-oic2.png)

While OCI creates the instance, go to the next step.

## Task 10: Create a Compute

The compute will be used by Oracle Integration Agent to contact the OpenSearch Cluster in the private network. 

Go the menu
- Compute
- OpenSearch - Clusters

![Menu Compute](images/opensearch-compute1.png =50%x*)

- Check that you are in the right compartment (livelab in this case)
- Click *Create instance*
- Name: *opensearch-instance*
- I chose the image *Oracle Linux 7.9* but other images will work too.
- Networking
    - Select Existing VCN: *opensearch-vnc*
    - Select Existing Subnet: *Public Subnet-opensearch-vnc*
- SSH KEY: Choose the best method for you.
    - If you have no SSH key, choose *Generate a key pair* and download the Public and Private KEY.
    - Keep the private key file for later *##COMPUTE_PRIVATE-KEY##*
- Click *Create*

![Create Compute](images/opensearch-compute2.png)

When the machine is created, 
- Take note of *##COMPUTE_PUBLIC-IP##*, the public IP address. 

## Task 11: Create an API Gateway

The API Gateway will be used API to access the OpenSearch private URL from the website.

Go the menu
- Developer & Services
- API Management / Gateway

![Menu API Gateway](images/opensearch-apigw.png =50%x*)

- Check that you are in the right compartment (livelab in this case)
- Click *Create Gateway*
- Name: *opensearch-apigw*
- Network
    - Virtual Cloud Network: *opensearch-vcn*
    - Subnet: *Public Subnet-opensearch-vcn*
- Click *Create Gateway*

![Create APU Gateway](images/opensearch-apigw2.png)

When the Gateway is created, 
- Copy the Gateway hostname *##APIGW_HOSTNAME##*. Ex: xxxxxx.apigateway.eu-frankfurt-1.oci.customer-oci.com

Then, 
- Click on *Deployments*
- Click *Create Deployment*
- Basic Information
    - Name: *opensearch-deployment*
    - Path-Prefix: */oic*
    - Click *Next*

![Create Deployment](images/opensearch-apigw3.png)

- Authentication
    - To make the lab easier. Choose *No Authentication*. Ideally, we would need to setup OAUTH.
    - Click *Next*
- Routes
    - Path: */search*
    - Method: *ANY*
    - Backend-Type: *HTTP*
    - URL: *https://##OPENSEARCH_HOST##:9200/oic/\_search*
        - ex: https://amaaaaaabbbbbbb.opensearch.eu-frankfurt-1.oci.oraclecloud.com:9200/oic/_search
    - Click *Next*
- Then *Create*

![Create Route](images/opensearch-apigw3.png)

## Acknowledgements

- **Author**
    - Marc Gueury
    - Badr Aissaoui
    - Marek Krátký 
- **History** - Creation - 27 Sep 2022