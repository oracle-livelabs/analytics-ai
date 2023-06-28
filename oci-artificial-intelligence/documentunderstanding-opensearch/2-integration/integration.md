
# Integrate to the Components together

## Introduction

Estimated time: 20 min

### Objectives

- Integrate all the components together

### Prerequisites

- You will need the Oracle integration Cloud (OIC) package, the Visual Builder (VB) application and samples files on your laptop/desktop. The easiest option is to download a zip file from Github. 

- To download the files to your laptop from Github, please follow these steps:

- In your Intenet browser go to https://github.com/mgueury/oci-searchlab/tree/main and click Code and then Download ZIP.
![GitHub_Download](images/opensearch-github-download-zip.png)

Extract the oci-searchlab-main.zip file on your laptop/desktop. 
![GitHub_Download](images/opensearch-github-extract-zip.png) 

The directory contains the Oracle integration Cloud (OIC) package in the oic folder, the Visual Builder (VB) application in the vb folder and samples files in the sample_files folder.

Alternatively, since we have downloaded the Github repository in the previous lab (Install the Components) in the Cloud Shell using the _git clone_ command, there is an option Download in the Cloud Shell.
![CloudShell_Download](images/opensearch-cloudshell-download.png)

Download the files from the Cloud Shell as follows:
![CloudShell_Download2](images/opensearch-cloudshell-download2.png)

Enter the file name: oci-searchlab/oic/OPENSEARCH_OIC.par and click Download button.



## Task 1: Import the integration

We will upload the integration.
Go to the tab with Integration open
Go to the Oracle Integration home page:
Go the menu
- Developer Services
- Application Integration
- Choose *oic*
- Click *Service Console* to open a new browser tab with OIC 
- On the left menu, choose *Design*
- Then *Package*
- Click *Import*
- Browse: choose *OPENSEARCH_OIC.par*
    - Go to the directory that you downloaded from GITHUB
    - In the directory "oic", you will find *OPENSEARCH_OIC.par*
- Click: *Import and Configure*


![Import Package](images/opensearch-oic-package-import.png)

## Task 2: Configure the connections

Lets configure the connections. 
We can start with the public connections first because these don't depend on components provisioning being completed in the previous lab (Terraform script).

Click to edit the connection *RestObjectStorage*

![Package details](images/opensearch-oic-package-import1.png)

### A. RestObjectStorage

First, we need to get the Object Storage rest API. *##OS\_URL##*

You can find it here [https://docs.oracle.com/en-us/iaas/api/#/en/objectstorage/20160918/](https://docs.oracle.com/en-us/iaas/api/#/en/objectstorage/20160918/)

Fill the Connection details:
Then fill the Connection details:
- Connection Type = *REST API Base URL*
- Connection URL = *##OS\_URL##*
    - ex: https://objectstorage.eu-frankfurt-1.oraclecloud.com
- Security policy = *OCI Service Invocation*
- Access Type = *Public gateway*
- *Test / Save / Save* until 100%
- Go back to the list of connections

### B. RestLanguageAI

First, we need to get the AI Language rest API. *##AI\_LANG\_URL##*

You can find it here [https://docs.oracle.com/en-us/iaas/api/#/en/language/20221001/](https://docs.oracle.com/en-us/iaas/api/#/en/language/20221001/)

Fill the Connection details:
Then fill the Connection details:
- Connection Type = *REST API Base URL*
- Connection URL = *##AI\_LANG\_URL##*
    - ex: https://language.aiservice.eu-frankfurt-1.oci.oraclecloud.com
- Security policy = *OCI Service Invocation*
- Access Type = *Public gateway*
- *Test / Save / Save* until 100%
- Go back to the list of connections
  
### C. Resttrigger

There is no change needed here. The connection is already configured. 

### D. RestDocumentUnderstandingAI

First, we need to get the AI Document Understanding rest API. *##AI\_DOC\_URL##*

You can find it here [https://docs.oracle.com/en-us/iaas/api/#/en/document-understanding/20221109/](https://docs.oracle.com/en-us/iaas/api/#/en/document-understanding/20221109/)

Fill the Connection details:
Then fill the Connection details:
- Connection Type = *REST API Base URL*
- Connection URL = *##AI\_LANG\_URL##*
    - ex: https://document.aiservice.eu-frankfurt-1.oci.oraclecloud.com
- Security policy = *OCI Service Invocation*
- Access Type = *Public gateway*
- *Test / Save / Save* until 100%
- Go back to the list of connections

### E. RestSpeechAI

First, we need to get the AI Speech rest API. *##AI\_SPEECH\_URL##*

You can find it here [https://docs.oracle.com/en-us/iaas/api/#/en/speech/20220101/](https://docs.oracle.com/en-us/iaas/api/#/en/speech/20220101/)

Fill the Connection details:
Then fill the Connection details:
- Connection Type = *REST API Base URL*
- Connection URL = *##AI\_LANG\_URL##*
    - ex: https://speech.aiservice.eu-frankfurt-1.oci.oraclecloud.com
- Security policy = *OCI Service Invocation*
- Access Type = *Public gateway*
- *Test / Save / Save* until 100%
- Go back to the list of connections

### F. RestVisionAI

First, we need to get the AI Vision rest API. *##AI\_VISION\_URL##*

You can find it here [https://docs.oracle.com/en-us/iaas/api/#/en/vision/20220125/](https://docs.oracle.com/en-us/iaas/api/#/en/vision/20220125/)

Fill the Connection details:
Then fill the Connection details:
- Connection Type = *REST API Base URL*
- Connection URL = *##AI\_VISION\_URL##*
    - ex: https://vision.aiservice.eu-frankfurt-1.oci.oraclecloud.com
- Security policy = *OCI Service Invocation*
- Access Type = *Public gateway*
- *Test / Save / Save* until 100%
- Go back to the list of connections

**NOTE: Before we can proceed with configuring the remaining three connections we need to wait for the script build.sh (Terraform) from the previous lab (provisioning the components) to finish (approx 30 minutes).**

### G. StreamInputBucket
You will need to get values from your environment:
In OCI terminal run: oci-searchlab/starter/src/search_env.sh
In the output of this script look for the following values:
- ##STREAM_BOOSTRAPSERVER##, 
- ##STREAM_USERNAME##, 
- ##AUTH_TOKEN## and 

Download the file *oss_store.jks* from OCI Cloud Shell. 
![CloudShell_Download2](images/opensearch-cloudshell-download3.png)

Enter the file name: oci-searchlab/starter/oss_store.jks and click Download button. 

Click to edit the connection *StreamInputBucket*

![Package details](images/opensearch-oic-package-import2.png)

Use this info:
  - Bootstrap servers = *##STREAM_BOOSTRAPSERVER##*
  - SASL Username = *##STREAM_USERNAME##*
  - SASL Password = *##AUTH_TOKEN##*
  Expand Optional security
  - Truststore = *oss_store.jks*
  - TrustStore password = *changeit* 
  
  - Access Type = *Connectivity agent*
  - Selected agent group: *OPENSEARCH\_AGENT\_GROUP*
  - *Test / Save / Save* until 100%
  - Go back to the list of connections

![Connection StreamInputBucket](images/opensearch-connection-streaminputbucket.png)

### H. RestFunction
You will need to get values from your environment:
In OCI terminal run: oci-searchlab/starter/src/search_env.sh
In the output of this script look for the following values:
*##FUNCTION_ENDPOINT##*

Fill the Connection details:
- Connection Type = *REST API Base URL*
- Connection url = *##FUNCTION_ENDPOINT##* without /action/invoke at the end.
    - ex: https://xxxx.eu-frankfurt-1.functions.oci.oraclecloud.com/20181201/functions/ocid1.fnfunc.oc1.eu-frankfurt-1.aaaaaaabbbbb
- Security policy = *OCI Service Invocation*
- Access Type = *Public gateway*
- *Test / Save / Save* until 100%
- Go back to the list of connections

![Connection RestFunction](images/opensearch-connection-restfunction.png)

### I. RestOpenSearch
You will need to get values from your environment:
In OCI terminal run: oci-searchlab/starter/src/search_env.sh
In the output of this script look for the following values:
*##OPENSEARCH\_API\_ENDPOINT##*
    
Fill the Connection details:
- Connection Type = *REST API Base URL*
- Connection url = *##OPENSEARCH\_API\_ENDPOINT##*
    - ex: https://amamamamalllllaaac5vkwantypqqcs4bqrgqjrkvuxxghsmg7zzzzzxxxxx.opensearch.eu-frankfurt-1.oci.oraclecloud.com:9200
- Security policy: *No Security Policy*
- Access Type = *Connectivity agent*
- Selected agent group: *OPENSEARCH\_AGENT\_GROUP*
- *Test / Save / Save* until 100%
- Go back to the list of connections

![Connect RestOpenSearch](images/opensearch-connection-restopensearch.png)

### J. Activate the integration

All connections should be valid. Let's activate the integrations:
Click on Activation 
![Checkup](images/opensearch-oic-checkup1.png)

Click on the Activate buttons for each integration and active them. 
![Activate](images/opensearch-oic-activation.png)
Note: it is recommended to enable Debug level loging for this lab so that we can check the integration payloads. 
![Activate2](images/opensearch-oic-activation2.png)

All integrations should be up and running.
![Activate3](images/opensearch-oic-activation3.png)

## Task 3: Test OIC

- In OCI console go the Object Storage bucket *opensearch-bucket*.

![Test OIC](images/opensearch-oic-test-os-buckets.png)

![Test OIC](images/opensearch-oic-test-opensearch-bucket.png)

- On your desktop go to the directory that you downloaded from GITHUB
- Alternatively you can download the files form the Cloud Shell:
![CloudShell_Download2](images/opensearch-cloudshell-download4.png)

Enter the file name: oci-searchlab/sample\_files/shakespeare\_macbeth.tif and click Download button.

Upload the sample files to OCI Object Storage bucket: 

![Test OIC](images/opensearch-oic-test.png)

Check the result in OIC. 
- Go to OIC Home page
- Menu *Observability* 
- Menu *Integrations*

![Monitor OIC](images/opensearch-oic-test2.png)

Optional: Upload the rest of the sample files to the Object Storage bucket *opensearch-bucket*.

Check the instances in OIC. 
- Go to OIC Home page
- Menu *Observability* 
- Menu *Integrations*

Click on the "eye" icon to open the instance Activity Stream 

![Monitor OIC](images/opensearch-oic-test-instances.png)

and view the message payloads.

![Monitor OIC](images/opensearch-oic-test-instances-activity-stream.png)


## Acknowledgements

- **Author**
    - Marc Gueury
    - Badr Aissaoui
    - Marek Krátký 
- **History** - Creation - 19 May 2023
