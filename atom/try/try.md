# Try out the ATOM and learn about it's features

## Introduction

This lab will walk you through how an end user can interact with ATOM.

Estimated time: 1 hour <!-- TODO update estimate -->

### Objectives

In this lab, you will:

* Access the application
* Chat with LLM with base knowledge
* Chat with LLM with augmented knowledge
  * Give a file to LLM
  * Ask questions about contents in the file
<!-- TODO add more use cases. In future, showcase Luke's connector to other OCI AI services to process more file types-->

### Prerequisites

This lab assumes you have provisioned ATOM as described in the previous lab or been given access to an ATOM instance.

## Task 1: Access the Application



1. Get application URL

    * End User
        * The administrator who provisioned your account should also give you a link
    * Application Administrator
        * Navigate to your Visual Builder instance homepage
        * find the application you created in the previous lab.
            * If you don't see any apps listed, click on "Show apps I have access to"
        * Click on the drop down arrow by the name
        * Find the entry with "Live" status
        * Click on "Live"
        * Click on the entry in the drop down menu
        * Copy the url above for your records and to distribute to any end users.

    The url should look like this:
    https://<vb_instance_name>-vb-<tenancy_namespace>.builder.us-chicago-1.ocp.oraclecloud.com/ic/builder/rt/<application_id>/live/webApps/<application_name>/

2. Login

    * End User
        * You should login with the credentials to access the OCI tenancy the app is hosted on. This may be your corporate SSO credentials.
    * Application Administrator



## Task 2: Chat with LLM with base knowledge
    After logging in, you should be presented with a chat screen. To start a conversation, click "Chat with ATOM" and then start typing out messages.
<!-- TODO: dictation worked poorly for me. Seems like an ODA issue where it wouldn't detect the beginning of my speech, missed whole words, and misheard several words
You also have the option to use your voice to speak to the chatbot by clicking on the microphone button in the lower right corner-->

<!-- TODO: 
Examples:
- fact ATOM knows
- fact ATOM doesn't know, but can be given file in next task to learn about it
- Email/marketing draft use case
- semantic analysis use case
- 
-->


## Task 3: Chat with LLM with augmented knowledge

<!-- TODO: 
How to upload files
- give example files to use
Examples:
- go back to use case from task 2 about fact ATOM doesn't know, and show how it learned from the file
- Email/marketing draft with additional knowledge about customer/recipient in file
- semantic analysis use case with few shot examples in file
- 
>


## Acknowledgements
**Authors** 
* **Nitin Jain**, Master Principal Cloud Architect, NACIE
* **Abhinav Jain**, Senior Cloud Engineer, NACIE
* **JB Anderson**,  Senior Cloud Engineer, NACIE
