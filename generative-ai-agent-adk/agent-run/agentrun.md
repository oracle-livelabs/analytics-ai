# Run OCI Agent 

## Introduction

This lab will take provide various run modes with the *Agent* we have configured.

## Task 1: Run a query using RAG tool.

1. Run below query to fetch answers from OCI Agent RAG tool based on the knowledgebase attached.

    ```
    <copy>
    question="explain Kea DHCP Server"
    response = asyncio.run(agent_handler(prompt=question)) 
    response.pretty_print()
    </copy>
    ```
* The agent will run and share the information based on the RAG too.


    ![Rag run](images/rag-run.png)

## Task 2: Validate SQL tool execution.

1. Run below query to fetch information via agent ,which will fetch and report the information from OCI Autonomous Data Base.

    ```
    <copy>
    question="list all the product second category for product category Photo"
    response = asyncio.run(agent_handler(prompt=question))
    response.pretty_print()
    </copy>
    ```
* Here the query about secondary category will translate to product subcategory based on the colum description that we defined during SQL Tool setup.


 



**Proceed to the next lab.**

## Acknowledgements

* **Author**
    * **Rahul MR**, Prinicipal Solutions Architect - OCI 
* **Contributors**
    * **Sanjeeva Kalva**, Principal Data Scientist - OCI 