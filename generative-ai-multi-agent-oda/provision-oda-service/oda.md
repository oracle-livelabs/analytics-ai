# Setup OCI Digital Assistant (ODA)

## Introduction

This lab will take you through the steps needed to provision Oracle Digital Assistant Cloud Service

Estimated Time: 30 minutes

### About OCI Digital Assistant

Oracle Digital Assistant (ODA) is a platform that allows you to create and deploy digital assistants for your users. Digital assistants are virtual devices that help users accomplish tasks through natural language conversations, without having to seek out and wade through various apps and web sites. Each digital assistant contains a collection of specialized skills. When a user engages with the digital assistant, the digital assistant evaluates the user input and routes the conversation to and from the appropriate skills.

### Objectives

In this lab, you will:

* Create Dynamic Group and Policy to enable ODA connectivity to other OIC Services.
* Provision an ODA instance.
* Import and configure ODA Rest API Services to connect to different solution components.
* Import and configure ODA Digital Assistant and ODA Skills to use different solution components.
* Create a Channel to connect the ODA Digital Assistant to a frontend.

### Prerequisites

This lab assumes you have:

* All previous labs successfully completed
* Must have an Administrator Account or Permissions to manage several OCI Services: Digital Assistant

## Task 1: Dynamic Group and Policy Definition

This task will help you ensure that the Dynamic Group and Policy are correctly defined.

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

    a. [agent-RESTService-GenAIAgentCreateSession.yaml](https://idb6enfdcxbl.objectstorage.us-chicago-1.oci.customer-oci.com/n/idb6enfdcxbl/b/Excel-Chicago/o/Livelabs%2Fgenai-multi-agent%2FRESTService-GenAIAgentCreateSession.yaml)

    b. [agent-RESTService-GenAIAgentChat.yaml](https://objectstorage.us-chicago-1.oraclecloud.com/n/idb6enfdcxbl/b/Excel-Chicago/o/Livelabs%2Fgenai-multi-agent%2FRESTService-GenAIAgentChat.yaml)

    c. [RESTService-CohereToolChatService.yaml](https://objectstorage.us-chicago-1.oraclecloud.com/n/idb6enfdcxbl/b/Excel-Chicago/o/Livelabs%2Fgenai-multi-agent%2FRESTService-CohereToolChatService.yaml)

    d. [RESTService-OIC_Weather_Service.yaml](https://objectstorage.us-chicago-1.oraclecloud.com/p/HIomV4YoAvkW7IqNJA_T7KqSFb6ZxX21ObHS9jBchxkCa8_J0tcEJ-UErkj_Ij9I/n/idb6enfdcxbl/b/Excel-Chicago/o/Livelabs/genai-multi-agent/RESTService-OIC_Weather_Service.yaml)

2. Locate the ODA instance (created in Task 2)

    ![ODA locate](images/oda_locate.png)

3. Select the ODA Instance and click on Service Console

    ![ODA service console](images/oda_service_console.png)

4. In the ODA Console, click on hamburger menu. Under Settings, click API Services

    ![ODA API Services](images/oda_api_services.png)

5. Click on More -> Import REST Services

    ![ODA import rest services](images/oda_import_rest_services2.png)

     **Note** Import all Rest Services - The GenAIAgentCreateSession Rest API service (using "agent-RESTService-GenAIAgentCreateSession.yaml"), the GenAIAgentChat Rest API service (using "agent-RESTService-GenAIAgentChat.yaml"), the CohereToolChatService Rest API service (using "RESTService-CohereToolChatService.yaml") and the OIC_Weather_Service (using "RESTService-OIC_Weather_Service.yaml").

6. In the GenAIAgentCreateSession Rest API service, under Parameters, click on the pencil icon to change the value of the GenAIAgentEndpointId

    ![ODA create session api](images/oda_create_session_api1.png)

7. In the Value field, remove the existing value 1, and put the value of the GenAI Agent Endpoint Id (from Lab 2 Task 8 Step 4), and then click the Tick icon

    ![ODA create session api](images/oda_create_session_api2.png)

8. Test the GenAIAgentCreateSession Rest API service, by clicking on the Test Request button. You should see Response Status 200, with a proper Resoponse Body. Ensure that the "id" field is not blank / null. If the "welcomeMessage" field is blank in this Rest API response, a generic message would be shown in the ODA chatbot.

    ![ODA create session api](images/oda_create_session_api3.png)

9. Test the CohereToolChatService. Make sure in the request payload you reference your own compartment id.

## Task 5: Import Digital Assistant (Provided)

1. Click on the link to download the required Digital Assistant

    [MultiStepAgentAPIOrchestrationDA.zip](https://objectstorage.us-chicago-1.oraclecloud.com/p/ip1PWHwmF8nznyjlX8zmO2TsdoajMPW2TEMdd4gp7XR5-sCJ1gUw8i-bFdgqi2XN/n/idb6enfdcxbl/b/Excel-Chicago/o/Livelabs/genai-multi-agent/MultiStepAgentAPIOrchestrationDA.zip)

2. Import the Digital Assistant (downloaded). Click on Import Digital Assistant & select the zip file to import

    ![import digital assistant](images/import_da.png)

3. Open the GenAI23aiRAGAgentChatbot, go to “Flows” and click on “user.StartFlow”

    ![user start flow](images/user_start.png)

4. Open the second step “SetGenAIAgentEndpointIdVariable”, remove the old value and set the correct OCID value of the GenAI Agent Endpoint (the endpoint OCID that you copied in Lab 3 Task 2 Step 4).

    ![flow update endpoint](images/user_flow1.png)

5. Import the following skills

    a. [MultiStepAgentAPIOrchestrationEPM23aiGenAIAgent(2.0).zip](https://objectstorage.us-chicago-1.oraclecloud.com/p/G8xg4x5OdkLCzWwTeEMVwGxZbMjE2prl3p3Bpz9X-M2-U-FXFgQ-U2R2t3GaK77N/n/idb6enfdcxbl/b/Excel-Chicago/o/Livelabs/genai-multi-aget/MultiStepAgentAPIOrchestrationEPM23aiGenAIAgent(2.0).zip)

    b. [MultiStepAgentAPIOrchestrationOICWeatherAPI(2.0).zip](https://objectstorage.us-chicago-1.oraclecloud.com/p/xuz7BFhuDc-2rGAawurUKYyFnSn2AinsFu6dzYcaBQnnGb6USjMDZt8sj42zlMkt/n/idb6enfdcxbl/b/Excel-Chicago/o/Livelabs/genai-multi-agent/MultiStepAgentAPIOrchestrationOICWeatherAPI(2.0).zip)

    c. [MultiStepAgentAPIOrchestrationTool(2.0).zip](https://objectstorage.us-chicago-1.oraclecloud.com/p/Is9WnAVu3RYFuRNA9IATs4iTHGFQaDVW5EACENOJ_Z7AefHTuQ6H2WEwTbqmRyo7/n/idb6enfdcxbl/b/Excel-Chicago/o/Livelabs/genai-multi-agent/MultiStepAgentAPIOrchestrationTool(2.0).zip)

    d. [MultiStepAgentAPIOrchestrationWineCheeseOSGenAIAgent(2.0).zip](https://objectstorage.us-chicago-1.oraclecloud.com/p/wDJXTpTLid-uKz8Cb6HehRpx1NlcZ1sda7OIzX8fT35oaC7OJiWwHQplxHBs2MtP/n/idb6enfdcxbl/b/Excel-Chicago/o/Livelabs/genai-multi-agent/MultiStepAgentAPIOrchestrationWineCheeseOSGenAIAgent(2.0).zip)

6. Once MultiStepAgentAPIOrchestrationTool is imported. Go to Skills -> Settings -> Configuration -> Custom Parameters. Please provide your own values for Compartment ID and agent Endpoint IDs for both the agents. Please refer below screenshot for the changes

    ![ODA Skill change](images/oda_skillchange.png)

7. Ensure the Chatbot Training is completed

   Then click on the “Preview” button at top-right corner.

    ![ODA Train](images/user_flow2.png)

8. To start the conversation loop in ODA preview, send this initial message: "Hi"

    ![flow preview](images/oda_starter.png)

## Task 6: Create Channel to Embed ODA in Visual Builder Application or in any custom Web App

1. Click on hamburger menu and select Development > Channels, and click on Add Channel

    ![channel navigation](images/channel_nav2.png)

2. Enter the Channel Name and Description. Select the following option on the form:
    * Channel Type = Oracle Web
    * Allowed Domain = *
    * Client Authentication Enabled = Toggle off

    ![channel configuration](images/channel_config.png)

3. After channel creation, route it to skill imported in Task 3, and enable the Channel by using the toggle button.

    ![enable channel](images/channel_enable2.png)

4. Ensure that the Client Authentication Enabled is disabled. Take note of Channel Id.

    ![channel id](images/channel_id2.png)

## Task 7: (optional) View Conversation Analytics

From ODA service console homepage -> skill **Display name** -> **Insights** on side nav bar

* On this overview page, you can see stats such as **Total number of Conversations** and **Number of Unique users
* The View dropdown on the top right allows you to set a time window
* The Channels filter allows you to filter data from a specific frontend channel
* The Conversations tab allows you to see user messages and the agent's responses

## Task 8: (optional) Policy Definitions for multi-tenancy deployment

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

## Acknowledgements

* **Author**
    * **Abhinav Jain**, Senior Cloud Engineer, NACIE
    * **Kaushik Kundu**, Master Principal Cloud Architect, NACIE
    * **JB Anderson**, Senior Cloud Engineer, NACIE
    * **Luke Farley**, Staff Cloud Engineer, NACIE

* **Last Updated By/Date**
    * **Abhinav Jain**, Senior Cloud Engineer, NACIE, January 2025
