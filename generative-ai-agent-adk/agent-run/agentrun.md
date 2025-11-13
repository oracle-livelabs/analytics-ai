# Run OCI Agent 

## Introduction

This lab demonstrates various run modes available with the configured *Agent*.

## Task 1: Run a query using RAG tool.

1. Run the query below to fetch answers from the OCI Agent RAG tool, using the attached knowledge base.

    ```
    <copy>
    question="explain Kea DHCP Server"
    response = asyncio.run(agent_handler(prompt=question)) 
    response.pretty_print()
    </copy>
    ```
* The agent will run and share the information based on the RAG tool.

    The agent will run and share the information based on the RAG tool.

    ![Rag run](images/rag-run.png)

## Task 2: Validate SQL tool execution.

1. Run the query below to fetch information through the agent, which will retrieve and report data from the Autonomous AI Database.

    ```
    <copy>
    question="list all the product second category for product category Photo"
    response = asyncio.run(agent_handler(prompt=question))
    response.pretty_print()
    </copy>
    ```
* Here, the query about secondary category will be mapped to the product subcategory, based on the column description defined during SQL Tool setup.

    ![SQL Run](images/sql-run.png)

## Task 3: Validate function execution.

1. Run the code below to see how the agent responds using the defined function tool.

    ```
    <copy>
    question="What is the weather condition in India"
    response = asyncio.run(agent_handler(prompt=question))
    </copy>
    ```

    ![Custom tool run](images/custom_tool_run.png)

## Task 4 : Sample agent run using OCI SDK.
Here, we use the OCI Python SDK to run the agent endpoint and fetch results.

1. Use the snippet below to retrieve results with the OCI SDK. Comment or uncomment the authentication section, region, and endpoint details as needed.

    ```
    <copy>
    import oci
    ### Section for OCI Data science notebook.
    signer = oci.auth.signers.get_resource_principals_signer()

    ### Section for Local API Key execution.
    OCI_CONFIG = {}
    # OCI_CONFIG_FILE = "~/.oci/config"
    # OCI_CONFIG_FILE_KEY = "DEFAULT"

    # OCI_CONFIG = oci.config.from_file(OCI_CONFIG_FILE, OCI_CONFIG_FILE_KEY)
    # signer = oci.signer.Signer(
    #         tenancy=OCI_CONFIG['tenancy'],
    #         user=OCI_CONFIG['user'],
    #         fingerprint=OCI_CONFIG['fingerprint'],
    #         private_key_file_location=OCI_CONFIG['key_file'],
    #         pass_phrase=OCI_CONFIG['pass_phrase']
    #     )

    region = "eu-frankfurt-1" #Update the region if needed.
    service_endpoint = "https://agent-runtime.generativeai.eu-frankfurt-1.oci.oraclecloud.com" #Update the endpoint 
    agent_endpoint_ocid = agent_endpoint #Update the endpoint OCID
    CLIENT_KWARGS = {
                "retry_strategy": oci.retry.DEFAULT_RETRY_STRATEGY,
                "timeout": (10, 240),  # default timeout config for OCI Gen AI service
                }
    CLIENT_KWARGS.update({'config': OCI_CONFIG})
    CLIENT_KWARGS.update({'signer': signer})
    CLIENT_KWARGS.update({'region':region})
    CLIENT_KWARGS.update({'service_endpoint':service_endpoint})
    agent_oci_client = oci.generative_ai_agent_runtime.GenerativeAiAgentRuntimeClient(**CLIENT_KWARGS)
    create_session_response = agent_oci_client.create_session(
                        create_session_details=oci.generative_ai_agent_runtime.models.CreateSessionDetails(
                        display_name="testSession",
                        description="testSession"),
                        agent_endpoint_id=agent_endpoint_ocid)
    print("🦞 -----Session Information------ ")
    print(create_session_response.__dict__)
    question="Explain vector search in simple words and max of 10 lines"
    chat_response = agent_oci_client.chat(
                        agent_endpoint_id=agent_endpoint_ocid, 
                        chat_details=oci.generative_ai_agent_runtime.models.ChatDetails(
                            user_message=f"{str(question)}.Always share all possible hyper links if found any in the output",
                            should_stream=False,
                            session_id=create_session_response.data.id),
                    )
    if chat_response.status == 200:
                    print("🔒 ---- Response ----- ")
                    print(chat_response.data.__dict__)
    else:
            print(chat_response.__dict__)

    ##Delete Sessions
    agent_oci_client.delete_session(
                        agent_endpoint_id = agent_endpoint_ocid,
                        session_id = create_session_response.data.id )

    </copy>
    ```
    ![SDK Run](images/sdk-run.png)

1. A sample execution result is shown below for demonstration purposes. The same outcome can be achieved using ADK. The SDK operates at a lower API level, while ADK functions at a higher abstraction layer.

    ![SDK run output](images/sdk-output.png)


## Task 5 : Additional samples

* You may refer [here](https://docs.oracle.com/en-us/iaas/Content/generative-ai-agents/adk/api-reference/examples.htm) for additional samples and run them against your setup.


**Proceed to the next lab.**

## Acknowledgements

* **Author**
    * **Rahul MR**, Prinicipal Solutions Architect - OCI 
* **Contributors**
    * **Sanjeeva Kalva**, Principal Data Scientist - OCI 
