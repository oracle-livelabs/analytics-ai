# Setup OCI Digital Assistant (ODA)

## Introduction

This lab will take you through the steps needed to provision Oracle Digital Assistant Cloud Service

Estimated Time: 60 minutes

### About OCI Digital Assistant

Oracle Digital Assistant (ODA) is a platform that allows you to create and deploy digital assistants for your users. Digital assistants are virtual devices that help users accomplish tasks through natural language conversations, without having to seek out and wade through various apps and web sites. Each digital assistant contains a collection of specialized skills. When a user engages with the digital assistant, the digital assistant evaluates the user input and routes the conversation to and from the appropriate skills.

### Objectives

In this lab, you will:

* Create Dynamic Group and Policy to enable ODA connectivity to other OCI Services.
* Provision an ODA instance.
* Import and configure ODA Rest API Services to connect to different solution components.
* Import and configure ODA Digital Assistant and ODA Skills to use different solution components.
* Create a Channel to connect the ODA Digital Assistant to a frontend.

### Prerequisites

This lab assumes you have:

* All previous labs successfully completed
* Must have an Administrator Account or Permissions to manage several OCI Services: Digital Assistant

## Task 1: Dynamic Group and Policy Definition

This task will help you configure the Dynamic Group and Policy.

These Dynamic Group and Policy Definition are for single-tenancy deployment - where ODA and Generative AI Agent are in the same tenancy.

For Policy Definitions required for multi-tenancy deployment (where ODA and Generative AI Agent are in different tenancies), please refer to Task 7.

1. Locate Domains under Identity & Security

    ![Domain Navigation](images/locate_domain.png)

2. Click on your current domain name

    ![Click Domain](images/click_domain.png)

3. Click on Dynamic Groups, and then your Dynamic Group name

    ![Click DG](images/click_dg.png)

    **Note** The name of your dynamic group can be different.

4. Ensure that your Dynamic Group is properly defined - as follows. Then click on Identity

    ![DG Details](images/dg_details.png)

    **Note** The resource.compartment.id should be set to the OCID of your Compartment - that is having your ODA Instance.

5. Click on Policies, ensure that you are in your "root" compartment, then click on your Policy name

    ![Click Policy](images/click_policy.png)

    **Note** The name of your policy can be different.

6. Ensure that your Policy is properly defined - as follows.

    ![Policy Details](images/policy_details.png)

    ```
    allow dynamic-group <dynamic-group-name> to manage agent-family in tenancy
    allow dynamic-group <dynamic-group-name> to manage genai-agent-family in tenancy
    allow dynamic-group <dynamic-group-name> to manage object-family in tenancy
    ```

    **Note** If you are using a non-default identity domain - then instead of of just indicating the dynamic group name, you need to indicate domain-name/group-name in the policy statements.

## Task 2: Provision Oracle Digital Assistant

This task will help you to create Oracle Digital Assistant under your chosen compartment.

1. Locate Digital Assistant under AI Services

    ![ODA Navigation](images/oda_nav.png)

    **Note** You can find Digital Assistant under the AI Services.

2. Provide the information for Compartment, Name , Description (optional) & Shape. Click Create

    ![ODA creation wizard](images/oda_create_wizard.png)


3. In few minutes the status of recently created Digital Assistant will change from Provisioning to Active

    ![ODA Active](images/oda_active.png)

## Task 3: Create REST Services for the OCI Generative AI Agent

This task involves creating REST service which will be used by ODA to connect to OCI Generative AI Agent service.

1. Download the four REST Service Configurations

    a. [RESTService-DBSelectAIService.yaml](https://objectstorage.us-chicago-1.oraclecloud.com/n/idb6enfdcxbl/b/Excel-Chicago/o/Livelabs%2Fgenai-multi-agent%2FRESTService-DBSelectAIService.yaml)

    b.  [RESTService-DBAddRegionDataService.yaml](https://objectstorage.us-chicago-1.oraclecloud.com/n/idb6enfdcxbl/b/Excel-Chicago/o/Livelabs%2Fgenai-multi-agent%2FRESTService-DBAddRegionDataService.yaml)

    c. [RESTService-CohereToolChatServiceV2.yaml](https://objectstorage.us-chicago-1.oraclecloud.com/n/idb6enfdcxbl/b/Excel-Chicago/o/Livelabs%2Fgenai-multi-agent%2FRESTService-CohereToolChatServiceV2.yaml)

    d. [RESTService-OIC\_Weather\_Service.yaml](https://objectstorage.us-chicago-1.oraclecloud.com/p/HIomV4YoAvkW7IqNJA_T7KqSFb6ZxX21ObHS9jBchxkCa8_J0tcEJ-UErkj_Ij9I/n/idb6enfdcxbl/b/Excel-Chicago/o/Livelabs/genai-multi-agent/RESTService-OIC_Weather_Service.yaml)

2. Locate the ODA instance (created in Task 2)

    ![ODA locate](images/oda_locate.png)

3. Select the ODA Instance and click on Service Console

    ![ODA service console](images/oda_service_console.png)

4. In the ODA Console, click on hamburger menu. Under Settings, click API Services

    ![ODA API Services](images/oda_api_services.png)

5. Click on More -> Import REST Services

    ![ODA import rest services](images/oda_import_rest_services2b.png)

    **Note** Import all Rest Services:
    - The DBSelectAIService Rest API service (using "RESTService-DBSelectAIService.yaml")
    - DBAddRegionDataService Rest API service (using "RESTService-DBAddRegionDataService.yaml")
    - CohereToolChatService Rest API service (using "RESTService-CohereToolChatServiceV2.yaml")
    - OIC\_Weather\_Service (using "RESTService-OIC\_Weather\_Service.yaml")

7. In the DBSelectAIService Rest API service, update the Endpoint field by replacing "<REST ENDPOINT HERE>" with the ORDS endpoint (Lab 3 Task 4) url up to the "/:prompt". Do not include the "/:prompt".
    ![ODA DBSelectAIService api](images/oda_rest_db_select_ai.png)

8. Test the DBSelectAIService Rest API service, by clicking on the Test Request button. You should see Response Status 200, with a proper Response Body. 

   ![ODA DBSelectAIService api test](images/oda_rest_db_select_ai_test.png)

9. In the DBAddRegionDataService Rest API service, update the Endpoint field by replacing "<APEX REST ENDPOINT HERE>" with the APEX endpoint (Lab 3 Task 1) url.

    ![ODA DBAddRegionDataService api](images/oda_db_add_region_api.png)

10. Test the DBAddRegionDataService Rest API service, by clicking on the Test Request button. You should see Response Status 200, with a proper Response Body. 

    ![ODA DBAddRegionDataService api test](images/oda_db_add_region_test.png)

11. For the OIC\_Weather\_Service, update the Endpoint (from Lab 3 Task 4 Step 28), UserName/Password (from Lab 4 Task 3 Step 6), click on the pencil icon to change the value of the city parameter to London, and then test the service using the Test Request button. You should see Response Status 200.

    Endpoint URL should have the format "https://****/getTemperature1?city"

    ![ODA OIC Service API](images/oic_service_api.png)

12. Test the CohereToolChatService. Make sure in the request payload (in Edit Request Body) you reference your tenancy id from the API Key configuration (Lab 3, Task 2) or your own compartment id.

    ![ODA Cohere Service API](images/llm_tools_service.png)

## Task 4: Import Digital Assistant (Provided)

1. Click on the link to download the required Digital Assistant

    [DBMultiStepAgentAPIOrchestrationDA(2.0).zip](https://objectstorage.us-chicago-1.oraclecloud.com/n/idb6enfdcxbl/b/Excel-Chicago/o/Livelabs%2Fgenai-multi-agent%2FDBMultiStepAgentAPIOrchestrationDA(2.0).zip)

2. Import the downloaded Digital Assistant.

   Click on the Menu -> Development -> Assistants.

   Click on Import Digital Assistant & select the zip file to import

    ![import digital assistant](images/import_da.png)

3. Click on the Menu -> Development -> Skills.

    You'll see 4 new ODA Skills -
    - DBMultiStepAgentAPIOrchestrationTool,
    - MultiStepAgentAPIOrchestrationDBSelectAIAPI
    - MultiStepAgentAPIOrchestrationDBAddRegionAPI
    - MultiStepAgentAPIOrchestrationOICWeatherAPI

    ![skills](images/skills.png)

4.  To start the conversation loop in ODA preview, send this initial message: "MultiAgentAPIChat"

    You can use the following sample prompts to test this Digital Assistant:

     ```text
       <copy>

       1. Where is the store Oracle Eats located?

       2. When did the store All U Can Eat open?

       3. What is address of the store Moscone Store?

       4. Where is the store Big Grab located, and how is the weather there?

       5. What are the available regions?

       6. Add Denver region?

       7. What are the available regions?

       </copy>
    ```

    ![ODA Preview](images/preview.png)

## Task 5: Create Channel to Embed ODA in Visual Builder Application or in any custom Web App

1. Click on hamburger menu and select Development > Channels, and click on Add Channel

    ![channel navigation](images/channel_nav2.png)

2. Enter the Channel Name and Description. Select the following option on the form:
    * Channel Type = Oracle Web
    * Allowed Domain = *
    * Client Authentication Enabled = Toggle off

    ![channel configuration](images/channel_config.png)

3. After channel creation, route it to Digital Assistant imported in Task 4, and enable the Channel by using the toggle button.

    ![enable channel](images/channel_enable3.png)

4. Ensure that the Client Authentication Enabled is disabled. **Take note of Channel Id**.

    ![channel id](images/channel_id3.png)

## Task 6: (optional) View Conversation Analytics

From ODA service console homepage -> skill **Display name** -> **Insights** on side nav bar

* On this overview page, you can see stats such as **Total number of Conversations** and **Number of Unique users
* The View dropdown on the top right allows you to set a time window
* The Channels filter allows you to filter data from a specific frontend channel
* The Conversations tab allows you to see user messages and the agent's responses

## Task 7: (optional) Policy Definitions for multi-tenancy deployment

This task will help you ensure that the required Policy Definitions are correctly defined for multi-tenancy deployment (where ODA and Generative AI Agent are in different tenancies).

If the Policy Definitions are not correctly defined, please define them as follows.

**Required Information:**

* _ODATenancyOCID_ - The OCID of the Tenancy, where the ODA Instance is created.

    In the OCI Console, you can click on your profile icon in the top right corner, click on your Tenancy name, and then copy the OCID of the tenancy.

    ![Tenancy OCID](images/tenancy_ocid.png)

* _ODAInstanceOCID_ - The OCID of the ODA Instance.

    In the OCI Console, you can go to your Digital Assistance instance (Menu -> Analytics & AI -> Digital Assistant), and then copy the OCID of the       ODA instance

    ![ODA Instance OCID](images/oda_instance_ocid.png)

1. In the tenancy where the ODA instance is hosted - Locate Policies under Identity & Security, ensure that you are in your "root" compartment, and      then define the following policies.

   ```
   <copy>
    endorse any-user to manage agent-family in any-tenancy where request.principal.type='odainstance'
    endorse any-user to manage genai-agent-family in any-tenancy where request.principal.type='odainstance'
    endorse any-user to manage object-family in any-tenancy where request.principal.type='odainstance'
    </copy>
   ```

   ![ODA Instance Policy](images/create_policy.png)

2. In the tenancy where the Generative AI instance is hosted - Locate Policies under Identity & Security, ensure that you are in your "root"
   compartment, and then define the following policies.

   _Please ensure to replace the ODATenancyOCID and ODAInstanceOCID with the proper OCID values._

   ```
   <copy>
    define tenancy oda-instance-tenancy as ODATenancyOCID
    admit any-user of tenancy oda-instance-tenancy to manage agent-family in tenancy where request.principal.id in ('ODAInstanceOCID')
    admit any-user of tenancy oda-instance-tenancy to manage genai-agent-family in tenancy where request.principal.id in ('ODAInstanceOCID')
    admit any-user of tenancy oda-instance-tenancy to manage object-family in tenancy where request.principal.id in ('ODAInstanceOCID')
    </copy>
   ```

   ![ODA Instance Policy](images/create_policy.png)

You may now proceed to the next lab.

## Acknowledgements

* **Author**
    * **Jadd Jennings**, Principal Cloud Architect, NACIE

* **Contributors**
    * **Kaushik Kundu**, Master Principal Cloud Architect, NACIE
    * **Abhinav Jain**, Senior Cloud Engineer, NACIE
    * **Luke Farley**, Senior Cloud Engineer, NACIE

* **Last Updated By/Date**
    * **Jadd Jennings**, Principal Cloud Architect, NACIE, March 2025
