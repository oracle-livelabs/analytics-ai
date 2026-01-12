# Introduction 

OCI Generative AI Agents is a fully managed service that combines the power of large language models (LLMs) with AI technologies to create intelligent virtual agents that can provide personalized, context-aware, and highly engaging customer experiences.

## Key Features

- **Simple agent setup**: A fully managed, few-step setup process to create and deploy the agents.
- **Tools orchestration**: Orchestrate several tools and services to address complex workflows and automate conversations.
- **Multi-turn chat experience**: Engage in dynamic, multi-turn dialogues with more human-like interactions.
- **Context retention**: Ask follow-up questions because agents remember conversation context across turns for personalized and consistent interactions.
- **Custom instructions**: Guide the agent's behavior with added instructions.
- **Guardrails**: Have the agent help identify and apply content moderation, and help identify and protect against prompt injection (PI) and personally identifiable information (PII) at its endpoints.
- **Human-in-the-loop**: Optional feature for real-time monitoring and human intervention.
- **Scalability and security**: Get OCI's inherent secure and scalable infrastructure.

In OCI Generative AI Agents, depending on the use case, you can empower each agent with one or more of the following tools:

- **SQL Tool**: Converts natural language queries into SQL statements, which can automatically execute to generate responses against a connected database.
- **RAG Tool**: Retrieves information from one or more knowledge bases and aims to respond with relevant and context-aware information in natural language.
- **Custom Function Calling Tool**: Calls functions that you define to expand the features that the agent covers. The agent can execute the configured function and respond depending on the returned values.

## About this Workshop

In this workshop you will learn how to harness the power of conversational generative AI to unlock the information hidden in your documents and databases to automate business processes and increase productivity.

As a use case for this workshop, we are going to create a merchandising insights agent. This assistant, powered by an intelligent agent, will simplify the work of the Chief Merchandising Officer by searching and analyzing information from multiple data sources seamlessly and returning relevant information in human-readable form.

The agent enables executives to analyze return trends, identify product defects, evaluate supplier performance, and uncover regional patterns — all through natural language conversation.

**Estimated Workshop Time:** 1 hour 20 minutes

## Solution Architecture

The following is a simplified solution architecture diagram for our merchandising insights agent:

![Screenshot showing solution architecture](./images/solution-architecture.png)

As described in the diagram, our solution makes use of the following resources:

- **Autonomous AI Database** - In this database, we are going to save information about the following entities relevant to our retail merchandising system:
    - Products (SKU catalog with supplier linkage)
    - Suppliers (vendor directory with quality ratings)
    - Stores (locations for regional analysis)
    - Return Transactions (individual return records)
    - Return Reasons (standardized reason codes)

Here is the database schema:

![Screenshot showing database schema](./images/database-schema.png)

- **Storage Bucket** - The storage bucket will store merchandising policy documents (provided for you as part of this workshop). The agent will retrieve the relevant policy documents whenever a Chief Merchandising Officer requires this information.

The policy documents include:

- Supplier Quality Standards
- RTV (Return-to-Vendor) Claim Policy
- Product Return Thresholds
- Defective Merchandise Handling
- Regional Distribution Guidelines
- Supplier Probation Procedures
- Inventory Disposition Policy
- Customer Return Policy

- **Vault** - In this vault, we are going to securely store the credentials required to access the Autonomous AI Database instance.

- **Database Connection** - This resource will contain all of the information required to retrieve data from our Autonomous AI Database instance. The connection will securely retrieve the required credentials from the vault.

- **Knowledge bases** - The two knowledge bases reference our two data sources, the Storage Bucket and the Autonomous AI Database instance, and are used by the relevant agent tools.

- **RAG tool** - This tool is used by the agent to retrieve, reason over and analyze information from unstructured data such as the merchandising policies stored in the storage bucket. The agent will use this tool whenever specific policy knowledge is required to complete a task.

- **SQL tool** - This tool is used by the agent to retrieve, reason over and respond using information found in our Autonomous AI Database instance. This tool knows how to convert natural language requests or questions into SQL and can retrieve the information for the agent to use in its replies.

- **Agent** - The agent will receive all requests from the user, come up with an execution plan, will ask clarifying questions if required and route requests to the tools if needed. The agent will collect all of the pieces of information collected during the execution of the plan and compile a coherent response for the user.

In order to accelerate the development process, in this workshop we are going to use the chat feature built into the OCI console to communicate with the agent without writing or deploying a single line of code.

## Objectives

In this workshop, you will learn how to:

- Validate your tenancy for compatibility with the service and set up access policies.
- Set up our knowledge base data source.
- Create our Autonomous AI Database instance with all of the required data and configuration.
- Create the agent and supporting resources to make our solution come alive.
- As a Chief Merchandising Officer, have a conversation with our agent and see how it can supercharge your productivity.

## Learn More

- [OCI Generative AI Agents service information](https://www.oracle.com/artificial-intelligence/generative-ai/agents/)
- [OCI Generative AI Agents service documentation](https://docs.oracle.com/en-us/iaas/Content/generative-ai-agents/home.htm)
- [Managing SQL Tools in Generative AI Agents](https://docs.oracle.com/en-us/iaas/Content/generative-ai-agents/sql-tool.htm)
- [Managing RAG Tools in Generative AI Agents](https://docs.oracle.com/en-us/iaas/Content/generative-ai-agents/rag-tool.htm)
- [Managing Function Calling Tools in Generative AI Agents](https://docs.oracle.com/en-us/iaas/Content/generative-ai-agents/function-calling-tool.htm)

## Acknowledgements

- **Author** - Anthony Marino, Deion Locklear
- **Contributors** - Hanna Rakhsha, Daniel Hart, Uma Kumar, Taylor Zheng