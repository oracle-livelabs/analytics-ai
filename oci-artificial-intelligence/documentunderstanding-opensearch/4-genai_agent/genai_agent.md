
# Create a conversational user interface with Generative AI Agent

## Introduction
In this lab you will create a conversational user interface with Generative AI Agent that can be used to chat with the content that has been processed by the AI services and loaded into OpenSearch. 

Estimated time: 10 min

### Objectives

- Create a conversational user interface with Generatvie AI Service and use it to chat with the content that has been processed by the solution

### Prerequisites
- You've completed the previous labs 1 and 2

## Task 1: Create a OCI Cache with Redis Cluster
You will need the OCI Cache with Redis Cluster for the Generative AI Agent. The agent stores a chat context in Redis cache.

1. Go the Cloud console 3-bar/hamburger menu and select the following    
   1. Databases
   2. Clusters (under OCI Cache)
   
  ![GenAI Agent link](images/redis-clusters-menu.png)
  
2. Check that you are in the intended compartment. (*oci-starter* was the recommended compartment name.)

3. Click **Create cluster** button
   Name: *search-redis*
   Create in compartment: *oci-starter*

4. Click the **Next** button. It will open the Node configuration tab.
   You can leave everything as default

5. Click the **Next** button. It will open the VCN tab.
   Select existing virtual cloud network
      Virtual cloud network: *search-vcn*
      Subnet: *search-priv-subnet*
    
6. Click the **Next** button. It will open the Review tab.

![GenAI Agent link](images/redis-cluster-create.png)

8. Click the **Create cluster** button. It will open the VCN tab.




## Task 2: Create a Generative AI Agent

1. Go the Cloud console 3-bar/hamburger menu and select the following    
   1. Databases
   2. Clusters (under OCI Cache)

  ![GenAI Agent link](images/genai-agents-menu.png)
  


1. In the OIC service console menu, choose **Visual Builder**.
![Visual Builder link](images/opensearch-vb-link-oic.png)

1. Import the project file that you obtained in **Task 1**.
    1. Click *Import*
        ![Visual Builder Import](images/opensearch-vb.png)
        
    1. Click **Application from file**
        ![Visual Builder file](images/opensearch-vb-file.png)
    1. Choose the file *vb/opensearch-1..x.zip*
    1. Application Name: *opensearch*
    1. Application ID: *opensearch*
    1. Click **Import**

        ![Visual Builder Import](images/opensearch-vb-import.png)
    1. Wait for the import to be confirmed

## Task 2: Edit the connections

1. From the Visual Applications list, open the imported application by clicking on the application name, **opensearch**
![Visual Builder Import](images/opensearch-vb-applications.png)

1. To edit the connection to connect to the OpenSearch server, click on the **Service icon**

### 1. Opensearch connection
1. Click the **opensearch** connection 

1. Click on **Servers** tab

1. Click the **Edit icon** 
![Connection OpenSearch](images/opensearch-vb-connection-opensearch.png)

1. Use the ***APIGW_URL*** value you saved to your text file to fill in the Connection details:
    - (If you need to get the value, run this command in OCI Console Cloud Shell: oci-genai-searchlab/starter/src/search_env.sh)

1. Configure the server as follows:
    - Replace Instance URL: *APIGW_URL*
      - Ex: https://xxxxxxxx.apigateway.eu-frankfurt-1.oci.customer-oci.com
    - Authentication: None
![Edit Connection OpenSearch](images/opensearch-vb-connection-opensearch2.png)

1. Click *Save*

1. Test the connection:
    1. Select tab *Endpoints*
    1. Click **Get - Get Many**
    1. Select tab *Test*
    1. Click **Send Request**

    ![Test Connection OpenSearch](images/opensearch-vb-connection-opensearch3.png)
    1. The test succeeded if you see *"successful": 1,* in the response

### 2. Generative AI connection
1. Click on the again on *Service icon*
2. Click on the *Backend Tab* 
3. Choose the *GenerativeAI* backend
4. Click on *Servers* tab 
5. Then *Edit icon* 
6. First, we need to get the Generative rest API. *##AI\_GENAI\_URL##*. You got it in the previous lab too.
    You can find it here [https://docs.oracle.com/en-us/iaas/api/#/en/generative-ai/20231130/](https://docs.oracle.com/en-us/iaas/api/#/en/generative-ai/20231130/)
7. Fill the details:
    - Instance URL: ##AI\_GENAI\_URL##
    - Edit the authentication
        - KeyId format = ##TENANCY\_OCID##/##USER\_OCID##/##FINGERPRINT##
        - Ex: ocid1.tenancy.oc1..xxxxx/ocid1.user.oc1..xxxx/11:22:33:44:55:66:77
    - Private KEY =  *##PRIVATE\_KEY\_RSA\_FORMAT##*
8. *Save*
9. *Save*

### 3. Compartment OCID
1. Click on the *Web Application icon*
2. Click on the *opensearch* application 
3. Go to the *Variables* tab
4. Click on the constant *compartmentId*
5. Replace the value with your compartment Id: *##COMPARTMENT_OCID##*

![Compartment ID OpenSearch](images/opensearch-vb-compartmentid.png)

## Task 3: Test the application

1. Click the **run** button on the top right of the Visual Builder page. The Visual Builder application user interface will appear in a new browser tab.
![Run the application](images/opensearch-vb-test.png)

1. In the search user interface, enter *jazz* and click **Search**. This will return a record for the file that was processed by OCI Document Understanding AI service to extract text from the image file so that it could be made searchable.
![Test Result](images/opensearch-vb-test-result.png)

1. Try the same with the question "when was jazz created" with *Search*, *Semantic Search*, *RAG* and *Generate*. Compare the results.
   
1. If you performed the optional task at the end of the previous lab and processed the additional files, you can query for those now. Here's some hints on words you can search for each of the provided documents. You can also search on *"\*"* to see all indexed documents.

    | Search Terms |
    | ------------------------------------- | --------------------------------------- |
    | When was jazz created | Search |
    | When was jazz created | Semantic Search |
    | When was jazz created | RAG |
    | When was jazz created | Generate |
    | When was the moon created | Search |
    | When was the moon created | Semantic Search |
    | When was the moon created | Generate |
    | When was the moon created | RAG |
    | Penguin | Search |


**Congratulations! You have completed this workshop.**

Here's what you accomplished. You provisioned multiple services into a compartment in your OCI tenancy. These included Oracle Integration Cloud (OIC), several AI services (such as OCI Document Understanding and OCI Language), and Oracle Search with OpenSearch. You imported a project into OIC that ingests document files from Object Storage, sends them to AI services based on the file type, and then loads extracted data into an OpenSearch index. You configured all of the service connections used by that OIC project and then you ran the integration project. Finally, you imported an application project into Visual Builder, you configured the connection to OpenSearch, and then you ran the project to display a search user interface. You used that search tool to query the content added to the OpenSearch index. This workshop has illustrated how different OCI services can be integrated together to use AI to make many types of content more searchable.

## Acknowledgements
- **Author**
    - Marek Krátký, Principal Cloud Storage Specialist
    - Marc Gueury, Master Principal Account Cloud Engineer

