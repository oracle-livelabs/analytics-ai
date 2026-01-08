# Lab 4: Test the Solution

## Introduction

Our provisioning work is now complete. It is now time to enjoy the fruits of our labor. In the previous labs we have:

- Created the proper permissions & basic setup.
- Uploaded the grid policy documents to a storage bucket.
- Created our Autonomous AI Database instance and filled it with data.
- Created an agent as well as the SQL and RAG tools alongside their knowledge bases.
- Configured the agent endpoint.

It is now time for us to test our solution.

**Estimated Time:** 15 minutes

## Objectives

In this lab, you will:

- Use the agent to answer questions about interconnection requests and grid policies.

## Prerequisites

This lab assumes you have:

- All previous labs successfully completed

> 💡 **Note:** Prior prompts and conversation history may influence responses and agent routing. If results are unexpected, rephrase your request or retry in a fresh session.

## Task 1: Overview of the chat page functionality

1. If the agent is still not showing as **Active**, give it a few more minutes to complete the provisioning process.

2. Once the agent is showing as **Active**, click the **grid operations agent** in the Agents list.

   ![Screenshot showing the active agent in the agents list](./images/click-agent-from-table.png)

3. In the agent details page, click the **Launch chat** button.

   ![Screenshot showing the agent details page with the launch chat button highlighted](./images/launch-chat-button.png)

4. In the chat page, on the left, make sure that both the **Agent compartment** and the **Agent endpoint compartment** are set to your compartment.

5. On the top of the page, the **Agent** drop down should show **grid operations agent** and the **Agent endpoint** drop down should show the newly created endpoint.

6. In the chat window, you'll be able to see the greeting message we have configured for the agent.

7. Other elements in the page include:

   - The message text box where you would write the messages for the agent.
   - The **Submit** and **Reset chat session** buttons, which you'll use to send the message you've typed in the message text box and reset all communications up until that point, respectively.
   - On the right, you'll see the **Traces** pane where the agent will communicate the various steps it took while reasoning over your requests.

   ![Screenshot showing the initial chat page](./images/initial-chat-page-sandbox.png)

## Task 2: Let's test our agent

1. To start, type the following question into the message box:

    ```text
    <copy>
    What's the current status breakdown of all interconnection requests?
    </copy>
    ```

2. Click the **Submit** button.

   ![Screenshot showing the first question for the agent](./images/send-first-question.png)

3. The agent generates a SQL query to count requests by status. You should see a breakdown showing: 2 Denied, 2 Approved, 2 Pending Review, and 1 Technical Review. In addition, you can see that a trace was generated on the right.

4. Click the **View** button next to the first trace.

   ![Screenshot showing the response for the first question](./images/first-question-response.png)

5. Expand the traces to see the full output (click the **Show more** link to see the rest of the output). The traces give you a glimpse of how the agent went about addressing your request. As you can see, the first trace shows how the agent is trying to figure out what the answer should be.

   ![Screenshot showing the first trace of the first question's response](./images/first-question-traces-1.png)

6. In the second trace, you'll be able to see that the agent invoked the SQL tool and generated a SQL request. This request will be executed and the response will be incorporated in the final response.

   ![Screenshot showing the SQL tool trace](./images/first-question-traces-2.png)

7. The third trace shows how the agent composed the final response using the output of the previous steps.

   ![Screenshot showing the trace for the final response](./images/first-question-traces-3.png)

8. Click the **Close** button to close the traces pane.

9. Our next question would be:

    ```text
    <copy>
    Which grid operator has the most interconnection requests assigned?
    </copy>
    ```

   Let's see if the agent will be able to figure that out...

10. Click the **Submit** button.

    ![Screenshot showing the second question for the agent](./images/send-second-question.png)

11. The agent shows the correct answer: **Emma Johnson**. Using the magic of Large Language Models (LLMs) and the clues we've left in the configuration of the agent and tools, the agent was able to identify the grid operator with the most requests assigned to them.

    ![Screenshot showing the response for the second question](./images/second-question-response.png)

12. Feel free to take a look at the Traces generated for this response.

13. Next, let's look up a specific application. Type:

    ```text
    <copy>
    Show me the company and details for application 1005.
    </copy>
    ```

14. Click the **Submit** button.

    ![Screenshow showing the third question for the agent](./images/send-third-question.png)

15. The agent returns the details associated with the SunPower Solutions application: 150kW requested, InverterCompliant shows 'No'.

    ![Screenshot showing application details](./images/third-question-response.png)

16. Now let's see if we can pull up a policy document which can help us understand inverter certification requirements. Type the following question:

    ```text
    <copy>
    What are the anti-islanding detection requirements? How quickly must a system disconnect?
    </copy>
    ```

17. Click the **Submit** button.

    ![Screenshot showing the fourth question for the agent](./images/send-fourth-question.png)

18. As you can see, for this question, the agent figured out that the information required might be in the knowledge base documents. For this task it employed the RAG tool which searched for the relevant information in our grid policy docs stored in object storage. Feel free to look at the traces for this interaction which show the steps the agent took to give us the information we needed. In the response you can see that a summary of the document was provided, but, also, if you expand the **View citations** section, you'll be able to see a reference to the document(s) which were used to compose the reply with a direct link to the file(s), the page(s) from which content was extracted and more.

    ![Screenshot showing the RAG tool response](./images/rag-response-1.png)

19. Let's ask about inverter certification. Type:

    ```text
    <copy>
    What are the UL 1741 inverter certification requirements for interconnection approval?
    </copy>
    ```

20. Click the **Submit** button.

    ![Screenshow showing RAG question number 2](./images/send-rag-question-2.png)


21. The agent retrieves the certification requirements from the UL 1741 document, including the mandatory certification requirement and denial criteria for non-certified inverters.

    ![Screenshot showing repsonse to second RAG question](./images/rag-response-2.png)

22. Now let's test the agent's ability to combine database queries with policy lookups. Type:

    ```text
    <copy>
    Application 1005 was denied and shows InverterCompliant as 'No'. What does our UL 1741 policy say about inverter certification requirements for approval?
    </copy>
    ```

23. Click the **Submit** button.

    ![Screenshot showing multi-tool question](./images/multi-tool-question-1.png)

24. Watch the traces on the right — you'll see the agent queries the database to confirm application 1005 details, searches the UL 1741 policy document for certification requirements, and explains that inverters must be UL 1741 certified for interconnection approval, and non-compliant inverters result in denial.

    ![Screenshot showing multi-tool response](./images/multi-tool-response-1.png)

25. The agent also remembers conversation context, allowing for natural follow-up questions. Type:

    ```text
    <copy>
    What about application 1007? Was that one approved?
    </copy>
    ```

26. Click the **Submit** button.

27. The agent understands you're asking about another application in the same context. It retrieves application 1007 and confirms it was approved — 350kW requested with sufficient local capacity (8.5 MW) and a compliant inverter.

    ![Screenshot showing context retention](./images/context-retention.png)

28. We invite you to try some prompts of your own to experiment with the agent.

## Task 3: (Optional) More prompts to try

Here are a few more prompts to try with the agent:

```text
<copy>
What are the normal voltage operating ranges required by IEEE 1547?
</copy>
```

```text
<copy>
List all interconnection requests in California.
</copy>
```

```text
<copy>
What is the average requested capacity across all applications?
</copy>
```

```text
<copy>
Show me all requests assigned to Olivia Brown.
</copy>
```

```text
<copy>
What are the voltage ride-through requirements for Category II systems?
</copy>
```

```text
<copy>
What does Rule 21 require for smart inverter compliance in California?
</copy>
```

```text
<copy>
What are the net metering eligibility requirements?
</copy>
```

```text
<copy>
Are there any pending requests with a grid impact score above 70?
</copy>
```

## Summary

As you've experienced, the OCI AI Agents service allows you to ask complex questions about data stored in multiple locations and get intelligent answers. By simply pointing the various tools towards your data sources and providing the right context, the agent was able to automatically determine which data source should be accessed, retrieve the data for you, compile a coherent and concise response and provide references to the original data when applicable.

Another interesting advantage of building solutions on top of the OCI AI Agents service is that the user is no longer restricted to tasks allowed by the application user interface. With a chat interface, the user can ask questions and get answers to any question which can be answered using the data in the system even if the system engineers did not plan for that specific scenario. For example, you can ask the agent to sort the results in any way that is supported by the data even if the application was not designed to give you that option.

Although our use-case was focused on grid operations and solar PV interconnection requests, the OCI AI Agents service can be used to fuel many different use-cases which require deep understanding and retrieval of information from internal data sources, reasoning over the data, summarizing it, providing insights and more.

## Learn More

- [Chatting with Agents in Generative AI Agents](https://docs.oracle.com/en-us/iaas/Content/generative-ai-agents/chat-agent.htm)

## Acknowledgements

- **Author** - Anthony Marino
- **Contributors** - Eli Schilling, Uma Kumar

