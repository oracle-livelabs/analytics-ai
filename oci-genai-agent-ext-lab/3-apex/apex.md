# Test with APEX

## Introduction
In this lab, you will test the installation using APEX.

Estimated time: 10 min

### Objectives

- Test the program

### Prerequisites
- The lab 1 must have been completed.

## Task 1: Test

2. Check the APEX URL and the user/password at the end of the build log.

3. Go to the URL of the application (e.g., https://abcdefghijklmnop.apigateway.eu-frankfurt-1.oci.customer-oci.com/ords/r/apex_app/apex_app/).

    Log in as APEX\_APP / YOUR\_PASSWORD.

4. Type "when was jazz created" and press Enter.

    Hover on the citation. Note that you can see the page number. Click on the link.
    ![Test Jazz](../0-intro/images/when-was-jazz-created.png)

5. Type "what is Oracle Analytics" and press Enter.

    ![Test Video](images/test-video.png)

1. Try more questions:

    | File type | Extension | Question                                          |
    | ----------| --------- | ------------------------------------------------- |
    | PDF       | .pdf      | When was jazz created ?                           |
    |           |           | What is Document Understanding                    |
    | Word      | .docx     | What is OCI ?                                     |
    | Image     | .png      | List the countries in the map of Brazil.          |
    | Website   | .selenium | What is Digital Assistant ?                       |
    | FAX       | .tif      | Is there an invoice for Optika ?                  | 
    |           |           | What does the file invoice.tif contain?           |
    | Video     | .mp4      | What is Oracle Analytics                          | 
    | Audio     | .mp3      | What is the issue with my headphones ?            |


**You may now proceed to the [next lab.](#next)**

## Task 2. Filter

One additional step is needed to use the RAG filter. We need to add a RAG tool.

### 1. Rag Tool ###

- In the hamburger menu, go to **Analytics and AI / Generative AI Agents**
- Click on **Agents**
- Choose your compartment
- Open the agent created in Lab 1
- Choose Tools / Create Tool
- Choose **RAG** 
   ![Custom tool](../6-tools/images/rag-tool.png)
- Enter:
    - **Name** = rag-tool
    - **Description** = Use this tool for any questions that are not covered by the other tools. It contains generic documentation.
- Select the knowledge base - agext-agent-kb
- Click **Create Tool**

### 2. Test again ###
- Go back to the APEX app. 
- Refresh the browser to start a new session. 
- Set the filter to */oracle*.
- Ask again the same questions. You will see that based on the metadata, you can filter files. 

## Known issues

1. Conversation history 
    Notice, do not change the filter in the middle of the conversation, or you can have funny effect. Ex:
    - Ask "what is jazz ?" without filter -> you get the answer from the RAG (with a citation)
    - Stay in the same conversation: 
    - Ask "what is jazz ?" with filter "/music" -> you get the answer from the RAG (with a citation) 
    - Ask "what is jazz ?" with filter "/oracle" -> you get an answer... from the conversation history... 
    - The correct way is to reset the conversation to get another chat session.

## Acknowledgements

- **Author**
    - Marc Gueury, Generative AI Specialist
    - Anshuman Panda, Generative AI Specialist
    - Maurits Dijkens, Generative AI Specialist

