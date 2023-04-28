
# Create a Google like user interface

## Introduction

Estimated time: 20 min

### Objectives

- Create a user interface with Visual Buidler

### Prerequisites

## Task 1: Import the project

First, lets go in Visual Builder. Go back to the homepage of Oracle Integration Cloud and choose Visual Builder.

![Visual Builder link](images/opensearch-vb-link-oic.png)

Then let's import the project from the file that you downloaded before in the "Function" lab.
- Click *Import*
- Choose the file *opensearch-1.0*
- Name: *opensearch*
- Description: *opensearch*
- Click *Import*

![Visual Builder Import](images/opensearch-vb-import.png)

##Task 2: Edit the connections

Let's edit the connection to connect to our server.

### A. Connection *objectStoragePreAuthRequest*

Go to the imported application.
- Click on the *Service icon*
- Choose the *objectStoragePreAuthRequest* connection 
- Click on *Servers* tab 
- Then *Edit icon*

![Connection PreAuth](images/opensearch-vb-connection-preauth.png)

-  Search your Object Storage URL based on your region: [https://docs.oracle.com/en-us/iaas/api/#/en/objectstorage/20160918/](https://docs.oracle.com/en-us/iaas/api/#/en/objectstorage/20160918/)

You have the other values from the previous labs.

- In the instance URL, type
   *https://objectstorage.(YOUR REGION PREFIX).oraclecloud.com*
- Edit the *Key ID*
  - In the *Key ID*, type
    *##TENANCY\_OCID##/##USER\_OCID/##FINGERPRINT##*
  - In the Private Key, paste your OCI Private Key *##PRIVATE\_KEY\_RSA\_FORMAT##*
  - Click *Save*
- Click *Save* again

![Create KEY ID](images/opensearch-vb-connection-preauth2.png)

You can also test the connection:
- Tab *Endpoints*
- Then *Post - Get one*
- Tab *Test*
- Click *Send Request*

![Test Connection Preauth](images/opensearch-vb-connection-preauth3.png)

### B. Connection opensearch

Redo this for the second connection:
- Click on the *Service icon*
- Choose the *opensearch* connection 
- Click on *Servers* tab 
- Then *Edit icon* 

![Connection OpenSearch](images/opensearch-vb-connection-opensearch.png)

- Instance URL: *https://##APIGW_HOSTNAME##*
  Ex: https://xxxxxxxx.apigateway.eu-frankfurt-1.oci.customer-oci.com
- In Authentication for Logged-in-users 
    - Type: *Basic*
    - Edit Username. Username = *##OPENSEARCH\_USER##* / Password = *##OPENSEARCH\_PWD##*
- In Authentication for Anonymous users, the same: 
    - Type: *Basic*
    - Edit Username. Username = *##OPENSEARCH\_USER##* / Password = *##OPENSEARCH\_PWD##*
- Click *Save*

![Edit Connection OpenSearch](images/opensearch-vb-connection-opensearch2.png)

You can also test the connection:
- Tab *Endpoints*
- Then *Get - Get Many*
- Tab *Test*
- Click *Send Request*

![Test Connection OpenSearch](images/opensearch-vb-connection-opensearch3.png)

### C. Variable region

We need also to give the region to Visual Builder that will use it to call the preAuthRequest.
- Click on the Application name: *opensearch*
- Go to the *Variables* tab
- Click on the variable *region*
- Edit it and replace with your region name. Ex: eu-frankfurt1

![Edit variable region](images/opensearch-vb-variable-region.png)

## Test the application

Click on the run button on the top

![Run the application](images/opensearch-vb-test.png)

- Type *test* : This will return the PDF, word, excel uploaded 
- Type *penguin* : This will return the image of a penguin recognized by Artificial Intelligence
- Type *shakespeare* : This will return the image of a text scanned by Text Recognition
- Type *specimen* : This will return the Belgian ID card with the name "Specimen"
 
![Test Result](images/opensearch-intro.png)

## Acknowledgements

- **Author**
  - Marc Gueury
  - Badr Aissaoui
  - Marek Krátký 
- **History** - Creation - 27 Sep 2022

