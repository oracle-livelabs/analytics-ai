# Provision OCI OpenSearch Cluster

## About this Workshop


OCI Generative AI Agents is a fully managed service that combines the power of large language models (LLMs) with an intelligent retrieval system to create contextually relevant answers by searching your knowledge base,
making your AI applications smart and efficient.

OCI Generative AI Agents supports several ways to onboard your data, one of the option is to bring your own (BYO) ingested and indexed OCI Search with OpenSearch data for the agents to use.
In this workshop, we'll create an OCI OpenSearch Cluster to be used as knowledge base to store business dashboards' metadata.

In this lab, you'll use following services:

- **OCI Search with OpenSearch** is a managed service that you can use to build in-application search solutions based on OpenSearch to enable you to search large datasets and return results in milliseconds, without having to focus on managing your infrastructure.
- **OCI Object Storage** is an internet-scale, high-performance storage platform that offers reliable and cost-efficient data durability. You can create a bucket and store an object in the bucket, safely and securely retrieve data, and easily manage storage at scale. 
- **OCI Vault** is an encryption management service that stores and manages encryption keys and secrets to securely access resources.
- **Resource Manager** automates deployment and operations for Oracle Cloud Infrastructure resources.

Estimated Workshop Time: 50 minutes


### Objectives

In this workshop, you will learn how to:
* Create OCI Object Storage Bucket, upload data to bucket and create Pre-Authenticated Request
* Create OCI OpenSearch Cluster using Resource Manager Terraform stack
* Create OCI Vault Secret

### Prerequisites

* Oracle cloud tenancy that is subscribed to Chicago region, and configured to work with OCI Object Storage service
* Familiar with Oracle Cloud Infrastructure is advantage, but not required
* Your cloud tenancy should have below Identity and Access Management (IAM) resources set up in the root compartment:
    - Dynamic Group with below matching rule:
    ```
      ALL {resource.type='genaiagent'}
    ``` 
    - Policies:
    ```
      allow group <your-group-name> to manage genai-agent-family in tenancy
      allow group <your-group-name> to manage object-family in tenancy
      allow dynamic-group <dynamic-group-name> to read secret-bundle in tenancy
    ```

### About the data
* Before you start, download the data [dashboard_metadata.json](https://objectstorage.us-chicago-1.oraclecloud.com/p/zaJxpillGZNeRFdZjaZoCn_TPlkjIypkQw6LEFspMa2ItWxD_mZ9HpQVBgBcUQRZ/n/orasenatdpltintegration03/b/AI_Agent_workshop/o/dashboard_metadata.json)
* *explain json data here*


## Task 1: Upload Data to Object Storage and Create Pre-Authenticated Request URL
1. Log into the OCI Cloud Console, switch to Chicago region. Click Menu bar ![menu_bar](./images/menu_bar.png ) -> Storage -> Buckets
![oci_console](./images/oci-console.png )
2. Select the compartment you have created. 
![create_bucket](./images/object-storage-console.png )
3. Click Create Bucket, enter Bucket Name, then click Create
![create_bucket](./images/create-bucket.png )
4. Open the Bucket just created, click Upload. Drag and drop the dashboard_metadata.json you just downloaded, upload
![upload_file](./images/upload1.png )
![upload_file](./images/upload2.png )
5. Now you have uploaded the json file, click the 3 dots on the right of console, click Create Pre-Authenticated Request
![create_par](./images/create-par1.png )
6. Select Object, Permit object reads. Choose an expiration date, then click Create Pre-Authenticated Request
![create_par](./images/create-par2.png )
7. In the pop-up window, copy the PAR-URL and paste into your notepad. Make sure to copy of url before close the window, it will show up only once.
![create_par](./images/get-par-url.png )


## Task 2: Provision OpenSearch Cluster

1. Go to OCI Cloud Console Menu -> Developer Services -> Resource Manager -> Stack

<img width="908" alt="image" src="https://github.com/user-attachments/assets/69c36069-fcac-4893-bd2d-69c9a3e3fc5f">

2. Create a Stack
<img width="953" alt="image" src="https://github.com/user-attachments/assets/d4b305d4-102c-4692-8962-e2e69eb1ee27">

3. Please use this link to download instructions on OCI Resource Manager Terraform stack that creates an OCI Search with OpenSearch cluster with a public management instance.
   
4. In Stack Configuration, Select zip file, Browse and upload the file downloaded from above link.

<img width="953" alt="image" src="https://github.com/user-attachments/assets/88380940-7435-4559-a938-2e2e05df9a36">

5. Select Terraform version 1.2.x.
   
6. If you're using OCI Identity Domain for authentication, in the Consele, navigate to the domain section and copy the domain URL.
   For example, https://idcs-xxx.identity.oraclecloud.com:443

   <img width="492" alt="image" src="https://github.com/user-attachments/assets/9e404811-8d94-4206-ad77-0eb7707c0988">

7. If you're using a federation-based tenancy, in the Console, navigate to Federation and under Identity, select your identity provider.
   Get the OpenID URL by copying the IDCS URL. For example, https://idcs-xxxx.identity.oraclecloud.com
   
<img width="954" alt="image" src="https://github.com/user-attachments/assets/0c944851-8da1-408f-ba41-4f175b44279b">

8. Review the Configure variables. 

<img width="955" alt="image" src="https://github.com/user-attachments/assets/0e28eee1-f8c2-4097-b726-e6f03e7d8478">

9. Save the Open Search paramters, both master username and password.
    
<img width="956" alt="image" src="https://github.com/user-attachments/assets/21c7f846-6b45-495d-8a76-52e2f55fbeed">

10. Review the Redis parameters (optional). No changes.
    
<img width="960" alt="image" src="https://github.com/user-attachments/assets/0b0cb806-1139-4aea-87e1-5935143189b7">

11. Review the Compute Instance variables. 
<img width="960" alt="image" src="https://github.com/user-attachments/assets/97a98644-7211-4e11-b644-983db1cd4bc4">

12. Click Next to Review all variable again and Submit. The above steps will provision all the resources required for Open Search Clusters, Redis Cluster and a Compute Instance for Management.

## Task 3: Create Vault Secret
1. Navigate to OCI Vault by clicking Menu bar -> Identity & Security -> Vault.
![oci_vault](./images/oci-vault.png )
2. Click Create Vault, provide name to create.
![create_vault1](./images/create-vault1.png )
![create_vault2](./images/create-vault2.png )
3. In the Vault, click Create Key. Pick software protection mode, AES Algorithm, 256 bits. Click Create Key.
![create_master_key](./images/create-master-key.png )
4. In the Vault, click Secrets, then create Secret. Provide name, select the encryption key created from last step. Choose Plain-Text type, then provide following text as secret contents:
```
   osmaster:Osmaster@123
```
![create_secret1](./images/create-secret1.png)
![create_secret2](./images/create-secret2.png)  


## Learn More
* [OpenSearch Guidelines for Generative AI Agents](https://docs.public.oneportal.content.oci.oraclecloud.com/en-us/iaas/Content/generative-ai-agents/opensearch-guidelines.htm)
* [Getting Started with OCI Object Storage](https://apexapps.oracle.com/pls/apex/r/dbpm/livelabs/view-workshop?wid=655&clear=RR,180&session=35038433542341)
* [Creating Dynamic Group](https://docs.public.oneportal.content.oci.oraclecloud.com/en-us/iaas/Content/Identity/dynamicgroups/To_create_a_dynamic_group.htm)

## Acknowledgements
* **Author** 
  - Jiayuan Yang, Principal Cloud Engineer 
  - Pavan Kumar Manuguri, Principal Cloud Engineer
* **Last Updated By/Date** - Pavan Kumar Manuguri, August 2024
