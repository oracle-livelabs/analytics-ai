# Provision AI Agent Stack using Resource Manager

## About this Workshop

Oracle Cloud Infrastructure Generative AI Agents (Beta) is a fully managed service that combines the power of large language models with an intelligent retrieval system to create contextually relevant answers by searching your knowledge base, making your AI applications smart and efficient.

This livelabs will cover all the steps to create and configure this service.  

Estimated Workshop Time: 2 hours 30 minutes 

### Objectives

In this workshop, you will learn how to:
* Provision new AI Agent.
* Setup & configure the Agent.
* Load indexes in oracle search.
* Interact with Chat Agent. 

### Prerequisites (Optional)

This lab assumes you have:
* An Oracle account
* Admin access to create required policies.


## Provision new AI Agent

1. Download the Terraform script from here:

2. This Terraform code creates:
- 1 VCN with 1 public subnet and 1 private subnet
- 1 OCI Compute instance on the public subnet
- 1 OCI Search Service with OpenSearch cluster on the private subnet
- Security rules to allow connectivity between the instance and the cluster
- Configure OpenId based security for OpenSearch. Also, configure roles to work with OpenID token having scope "genaiagent"

  
## Setup & configure the Agent

### Prerequisites
- Terraform version should be 1.2 or higher
- Make sure that public IP is available in the IP pool for the tenancy. 
- Open ID URL. It may be the IDCS URL, if OCI IAM Domains are used. eg: https://idcs-xxxxxxx.identity.oraclecloud.com
- Generate Open Search password hash, 
  - Download the jar oci-crypto-common-1.0.0-SNAPSHOT.jar from https://objectstorage.uk-london-1.oraclecloud.com/p/ZcVUX2JmCqwxgS9szgYfk1wyf7UwzxAHyXb2xwDFX5boKrd-JrvOnC7vzRttQxio/n/idee4xpu3dvm/b/os-ops-tools/o/oci-crypto-common-1.0.0-SNAPSHOT.jar. 
  - Execute the command 
  ```
     java -jar oci-crypto-common-1.0.0-SNAPSHOT.jar pbkdf2_stretch_1000 <password-in-plain-text>
  ```

### Steps

1. Create a Stack in Resource manager through OCI console. Use the terraform folder in this repo.
2. Configure the variables in the create stack screen
   1. Region
   2. Tenancy OCID
   3. Compartment OCID
   4. Open ID URL
   5. Opensearch master User
   6. Opensearch master password
   7. Opensearch master password hash
3. Create Jobs to plan and apply releases
4. Once the setup is completed, connection can be made to the Opensearch by sshing to the public management instance. IP Address and API Key will be available in the Job page.

## Deploy Using the Terraform CLI through Local Setup

### Clone the Module
Clone with the commands:

```
    git clone ssh://git@bitbucket.oci.oraclecorp.com:7999/ocasrgs/genairag-service-accelerator.git
    
    cd genairag-service-accelerator/genairag-solution-acc-quickstart

```

### Prerequisites

#### This is required if deployment will be through Local Setup

Create/Modify the `terraform.tfvars` file, and specify the following variables:

```
# Authentication
tenancy_ocid        = "<tenancy_ocid>"
user_ocid           = "<user_ocid>"
fingerprint         = "<finger_print>"
private_key_path    = "<pem_private_key_path>"

region              = "<oci_region>"
compartment_ocid    = "<compartment_ocid>"
```

### Create the Resources
Run the following commands:

    1. terraform init
    2. terraform plan
    3. terraform apply

 ##### If there is an error while executing terraform init the command regarding hashicorp/Template v2.2.0 installation in macOS M1 chip, refer to this (https://discuss.hashicorp.com/t/template-v2-2-0-does-not-have-a-package-available-mac-m1/35099/4) .


### Connect to the compute instance

```ssh -i <path_of_private_key> opc@<public_ip>```

```<path_of_private_key>``` Create this file with the output of the command ```terraform output -raw generated_ssh_private_key```  <br>
```<public_ip>``` of instance can be obtained from ```terraform.tfstate``` or from the OCI console

### Destroy the Deployment
When you no longer need the deployment, you can run this command to destroy the resources:

    terraform destroy

###

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1]([http://docs.oracle.com](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Tasks/managingstacksandjobs.htm))

## Acknowledgements
* **Author** - Pavan Kumar Manuguri
* **Contributors** -  Jiayuan Yang
* **Last Updated By/Date** - Pavan Kumar Manuguri, May 23 2024
