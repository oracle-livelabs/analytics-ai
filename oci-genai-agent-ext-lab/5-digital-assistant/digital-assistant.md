# Test with Oracle Digital Assistant (ODA)

## Introduction
In this lab, we will install Digital Assistant and configure it to work with the previous installation
Estimated time: 30 min

### Objectives

- Test the program

### Prerequisites
- The lab 1 must have been completed.
- Download the [zip file](https://github.com/mgueury/oci-vector-store-ext/archive/refs/heads/main.zip).
    In the subdirectory "oda", you will find the files needed below.

You reuse the Bucket and Vector Store created in Lab 1

## Task 1: Install Oracle Digital Assistant

1. Login to your OCI account/tenancy
2. Follow the steps in 'Recipe for Quick Setup and Provisioning'
    - https://docs.oracle.com/en-us/iaas/digital-assistant/doc/order-service-and-provision-instance.html
    - You can use the same compartment used for your AI Agent
    - In the end,
        - Bookmark the Base web url to go quickly to the ODA console in the future
        - Copy the OCID of the ODA instance and save it for use in the next step (##ODA_OCID##)
        ![Instance](images/oda-instance.png)
3. Create policy for ODA to access AI Agent
    - Go the 3-bar/hamburger menu of the console and select 'Identity & Security' > 'Compartments'
    - Select the compartment AI Agent is installed in
	- Create new policy agext_oda:

        ```
        <copy>
		allow any-user to manage genai-agent-family in compartment id ##COMPARTMENT_OCID## where request.principal.id='##ODA_OCID##'
        allow any-user to manage generative-ai-family in compartment id ##COMPARTMENT_OCID## where request.principal.id='##ODA_OCID##'
        </copy>
        ```
        - Replace ##COMPARTMENT\_OCID## with the OCID you saved in Lab 1 (in Task 2.5)
        - Replace ##ODA\_OCID## with the OCID you saved when installing ODA (in Task 1.2)
		- It will now look like:
		```
        <copy>
        allow any-user to manage genai-agent-family in compartment id ocid1.compartment.oc1..aaaaaaaafgdfsg8976sdfg79sdfggsdfg987sdfsdfgsdf9g87sdfgs98zzz where request.principal.id='ocid1.odainstance.oc1.eu-frankfurt-1.amaaaaaa8sdfjkhsdfjfg8fdg8df8gdf8g8dfg8d8fg8d8fgdf8gfxxxxxxx'
        allow any-user to manage generative-ai-family in compartment id ocid1.compartment.oc1..aaaaaaaafgdfsg8976sdfg79sdfggsdfg987sdfsdfgsdf9g87sdfgs98zzz where request.principal.id='ocid1.odainstance.oc1.eu-frankfurt-1.amaaaaaa8sdfjkhsdfjfg8fdg8df8gdf8g8dfg8d8fg8d8fgdf8gfxxxxxxx'
        </copy>
        ```

## Task 4: Import & Test the API Services in ODA

1. Login to the ODA console with the Base web url you bookmarked during ODA install
2. Go the 3-bar/hamburger menu of the console and select 'Settings' > 'API Services'
    ![RestImport](images/oda-rest-import.png)
3. Import the 'RESTService-mdLabAgentRest1.0.yaml' provided in the zip-file
    - Set Endpoint correct region
    - In POST test-body Replace ##VECTORSTORE_OCID## with your saved id.
    - In Headers change OpenAI-Project to your saved ##COMPARTMENT_OCID##
    ![RestImport](images/oda-rest-edit.png)
    - Click Test Request button and wait for 200 Success status
    ![RestImport](images/oda-rest-test.png)
    - Press 'Save as Static Response'
4. Go to LLM Services tab and click Import LLM Services button
    ![RestImport](images/oda-llm-import.png)
5. Import the 'LLMService-mdGptOss1.0.yaml' provided in the zip-file
    - Set Endpoint correct region
    - In POST test-body Replace ##COMPARTMENT_OCID## with your saved id.
    - Click Test Request button and wait for 200 Success status
    ![RestImport](images/oda-llm-test.png)
    - Press 'Save as Static Response'

## Task 5: Import & Train the skill in ODA

1. Go the 3-bar/hamburger menu of the console and select 'Development' > 'Skills'

   ![Skills](images/oda-skills.png)
2. Click 'Import skill' in the top-right and import 'import mdLabAgent(1.0).zip'
   ![Import](images/oda-import.png)
3. Open the imported skill by clicking its tile
4. Go to Settings (cogwheel icon on left side)
    - Select Configuration tab and scroll down to 'Custom Parameters'
    - Now edit the 3 parameters with your values:
      - ##OBJECTSTORE_LINK## (Lab 1, Task 4.8)
      - ##PROJECT_OCID## (Lab 1 Task 3.5)
      - ##VECTORSTORE_OCID## (Lab 1 Task 6.5)
   ![Settings](images/oda-settings.png)
5. Click 'Train' in the top-right

   ![Train](images/oda-flow-preview.png)

    - Select 'Trainer Tm' and press 'Submit'
    - When training is finished we can click 'Preview' in the top-right
6. In the tester we can ask a question about the content in our AI Agent
   ![odaTester](images/oda-flow-tester.png)

## Task 6: Creating the web channel

1. Go the 3-bar/hamburger menu of the console and select 'Development' > 'Channels'
    ![Channels](images/oda-channels.png)
2. Press 'Add Channel' to add a new channel with the following settings:
    - Channel Type: 'Oracle Web'
    - Allowed Domains: '*'
    - Client Authentication: Disabled  
    - And press 'Create'

      ![Channel1](images/oda-channel1.png)
3. Complete your channel definition with:
    - Route To: your skill
    - Channel Enabled: ON
    - Copy the Channel Id and save for later  (##ODA_CHANNEL_ID##)

      ![Channel3](images/oda-channel3.png)
4. Go back to the OCI cloud shell where you installed the previous lab and edit the settings.js as follows:

    ```
    <copy>
    ./starter.sh ssh compute
    sudo su -
    cd /usr/share/nginx/html/scripts
    nano settings.js
    or
    vi settings.js
    </copy>
    ```

    - The hostname part of your ODA console (without https://)
    - The Channel ID copied in the previous step
    ![WebSettings](images/oda-web-settings.png)
5. In your browser, open the web-widget with http://##BASTION\_IP## (You got that URL at the end of Lab 1)
    ![Webchat](images/oda-webchat.png)


## Known issues

None

## Acknowledgements

- **Author**
    - Marc Gueury, Generative AI Specialist
    - Maurits Dijkens, Generative AI Specialist


