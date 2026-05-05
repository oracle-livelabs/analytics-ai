# Lab 4: Deploy the Agent Flow

## Introduction

You've built and validated the Entertainment Release & Performance Analyst agent. The final step is to deploy it to a production endpoint so it can be accessed by applications, integrations, and users beyond the Playground. In this lab, you'll deploy the agent flow to an AI Compute, retrieve the production endpoint URL, and understand how the deployed agent can be consumed via REST API.

Deployment transforms the agent from a development artifact into a live service that your marketing, finance, and content strategy teams can access through internal tools, dashboards, or custom applications.

**Estimated Time:** 5 Minutes

### Objectives

In this lab you will:

1. Deploy the agent flow to an AI Compute
2. Retrieve the production endpoint URL
3. Understand how the deployed agent can be consumed via REST API

### Prerequisites

This lab assumes you have:

* Completed Lab 3 (Validate the Agent Flow)
* An active AI Compute
* A fully configured and tested agent flow

## Task 1: Deploy the Agent Flow

1. From the agent flow canvas, click the **Deploy** button in the upper right corner.

2. In the deployment dialog, select the **AI Compute** that will host the deployed agent flow. You can use the same AI Compute you created in Lab 2, or provision another one (reminder 3-5 minutes provisioning time) to use specifically for this exercise.

3. Click **Deploy** and wait for the deployment to complete. The status will update to indicate a successful deployment.

    ![Screenshot of agent deployment](images/04-agent-deployment.png " ")

## Task 2: Retrieve the Endpoint URL

Once the deployment is successful, you need to retrieve the production URL that applications will use to communicate with the agent.

1. Navigate to the **Details** tab of your agent flow.

2. Locate the **Endpoint URL**. This is the production URL of your deployed agent flow. Copy this URL — it is the address that external applications, scripts, or integration tools will use to send messages to the agent.

    ![Screenshot of details tab](images/04-agent-details-endpoint.png " ")

3. Note that the deployed agent is now a live REST endpoint. It accepts messages and returns responses using the same reasoning, tools, and knowledge that you validated in the Playground.

## Task 3: Understand REST API Consumption

Once deployed, the agent flow endpoint can be called programmatically via `curl`, Python, or any HTTP client. While executing REST API calls is beyond the scope of this workshop, here's how the integration model works:

1. **Authentication**: Callers authenticate via OCI request signing or session cookies. The endpoint uses OCI IAM policies to determine who can access the agent.

2. **Sending messages**: Callers send a POST request to the endpoint URL with a JSON body containing the user's message. For example:

    ```json
    {
      "message": "How did Neon Knights perform in the US last weekend?"
    }
    ```

3. **Conversational context**: After the first message, the API returns a `roomID`. Subsequent requests can include this `roomID` to maintain conversational context across turns — just like the multi-turn session you tested in the Playground.

4. **Integration options**: The endpoint can be integrated with internal dashboards, Slack bots, custom web apps, Oracle Digital Assistant, or any tool that can make HTTP requests. This means marketing, finance, and content strategy teams can access the agent from the tools they already use.

    > **Key takeaway**: Deployment turns your agent from a prototype into a production service. The REST endpoint makes it accessible to any application or integration, while OCI IAM ensures only authorized users and systems can access it. The same governance, RBAC, and lineage controls that protect the data in the Workbench carry through to the deployed agent.

## Lab 4 Recap

In this lab, you completed the final step of the end-to-end agent development lifecycle:

- You **deployed** the agent flow to an AI Compute, creating a live production endpoint.
- You **retrieved the endpoint URL** that applications and integrations use to communicate with the agent.
- You **understand the REST API model** for consuming the agent — including authentication, message format, conversational context, and integration options.

The Entertainment Release & Performance Analyst agent is now a production-ready service that can serve marketing, finance, and content strategy teams across your organization.

## Learn More

* [Oracle AI Data Platform — Documentation](https://docs.oracle.com/en/cloud/paas/ai-data-platform/)
* [Oracle AI Data Platform — Sample Agent Flows on GitHub](https://github.com/oracle-samples/oracle-aidp-samples/tree/main/ai/agent-flows)
* [From Vision to Velocity: How Oracle AI Database Private Agent Factory Rewires Enterprise Innovation — Oracle Blog](https://blogs.oracle.com/database/our-experience-with-oracle-ai-database-private-agent-factory)

## Acknowledgements

* **Author(s)** - Jean-Rene Gauthier [AIDP]
* **Contributors** - Eli Schilling - Cloud Architect, Gareth Nathan - SDE, GenAI
* **Last Updated By/Date** - Published March 2026