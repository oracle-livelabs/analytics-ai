# Introduction

## About This Workshop
In this workshop, we will see how to build AI Agents using Oracle Digital Assistant.

The lab does not use any code, all is done using Oracle Digital Assistant (ODA) low code and intuitive web user interface.

Prerequisite: 
- Ideally, you should be familiar with the base concept of ODA before to start the lab. If not, please read this page to learn the base terminology: [Digital Assistant Overview](https://docs.oracle.com/en/cloud/paas/digital-assistant/use-chatbot/overview-digital-assistants-skills.html).
- We will use the Large Language Model (LLM) Blocks to recognize the user intents and entities. Also to identify the next best action for the AI Agent. So, we will not use the standard intent/entity recognition of ODA. 

![Screenshot](images/app-screenshot.png =50%x*)

Here is a **definition of an AI Agent**: 
- An AI agent interacts autonomously with its environment. It uses tools and data to perform self-determined tasks to meet predetermined goals. 

![Definition](images/oda-agent-definition.png =50%x*)

Unlike normal programming language, an AI Agent decides itself what steps and what actions to use to reach the goal.

Practically that means that an AI Agent has:
- **Tools**
- **Data**

that he may use. He will **decide himself which tool or data** to use to answer the the reach the **goal** and produce the desired **result**. In the root of an Agent we have a Large Language Model. During the lab, we will use Oracle Digital LLM blocks, who allows to use a Large Language Model of our choice 

![LLM](images/oda-agent-llm.png =50%x*)

### Logical Architecture

There will be a several architectures of AI Agents in this LiveLab. 
- First, **a single agent** with tools and data. 
- **A router** with a single agent that will route the request to a tool or get data. 

![Router](images/oda-agent-router.png =50%x*)

Then more complex architectures, where we will see how to use memory, how to build multi-agents and we will finish with several examples of multi-agent systems.
- **Reflection**
- **Human in the loop**
- **Supervisor**, ....

![MultiAgent](images/agent-architecture.png =50%x*)

### Physical Architecture

The physical architecture is mostly Oracle Digital Assistant that calls REST APIs for the tools. 
In the lab, we will make as simple as possible and build the REST APIs using static JSON files accessed via an Object storage URLs.

![Physical Architecture](images/physical-architecture.png =50%x*)

### Objectives

- Provision Oracle Digital Assistant
- Import all the samples and test them

**Please proceed to the [next lab.](#next)**

## Acknowledgements 

- **Author**
    - Marc Gueury, Oracle Generative AI Platform
