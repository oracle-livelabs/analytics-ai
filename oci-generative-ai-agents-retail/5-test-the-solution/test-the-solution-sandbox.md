# Lab 4: Test the Solution

## Introduction

Our provisioning work is now complete. It is now time to enjoy the fruits of our labor. In the previous labs we have:

- Created the proper permissions & basic setup.
- Uploaded the merchandising policy documents to a storage bucket.
- Created our Autonomous AI Database instance and filled it with data.
- Created an agent as well as the SQL and RAG tools alongside their knowledge bases.
- Configured the agent endpoint.

It is now time for us to test our solution.

**Estimated Time:** 15 minutes

### Objectives

In this lab, you will:

- Use the agent to answer questions about products, suppliers, returns, and merchandising policies.

### Prerequisites

This lab assumes you have:

- All previous labs successfully completed

> �� **Note:** Prior prompts and conversation history may influence responses and agent routing. If results are unexpected, rephrase your request or retry in a fresh session.

## Task 1: Overview of the chat page functionality

1. If the agent is still not showing as **Active**, give it a few more minutes to complete the provisioning process.

2. Once the agent is showing as **Active**, click the **merchandising insights agent** in the **Agents** list.

3. In the agent details page, click the **Launch chat** button.

4. In the chat page, on the left, make sure that both the **Agent compartment** and the **Agent endpoint compartment** are set to your compartment.

5. On the top of the page, the **Agent** drop down should show **merchandising insights agent** and the **Agent endpoint** drop down should show the newly created endpoint.

6. In the chat window, you'll be able to see the greeting message we have configured for the agent.

7. Other elements in the page include:

    - The message text box where you would write the messages for the agent.
    - The **Submit** and **Reset chat session** buttons, which you'll use to send the message you've typed in the message text box and reset all communications up until that point, respectively.
    - On the right, you'll see the **Traces** pane where the agent will communicate the various steps it took while reasoning over your requests.

## Task 2: Let's test our agent

1. To start, type the following question into the message box:

    ```text
    What are the top 5 products by number of returns?
    ```

2. Click the **Submit** button.

3. The agent generates a SQL query to count returns by product. You should see **Espresso Maker Model A** at the top with 8 returns, followed by other products. In addition, you can see that a trace was generated on the right.

4. Click the **View** button next to the first trace.

5. Expand the traces to see the full output (click the **Show more** link to see the rest of the output). The traces give you a glimpse of how the agent went about addressing your request. As you can see, the first trace shows how the agent is trying to figure out what the answer should be.

6. In the second trace, you'll be able to see that the agent invoked the SQL tool and generated a SQL request. This request will be executed and the response will be incorporated in the final response.

7. The third trace shows how the agent composed the final response using the output of the previous steps.

8. Click the **Close** button to close the traces pane.

9. Our next question would be:

    ```text
    Which suppliers have the most defect-related returns?
    ```

    Let's see if the agent will be able to figure that out...

10. Click the **Submit** button.

11. The agent shows that **ValueParts Manufacturing** has the most defect-related returns (7 returns), followed by **Budget Electronics Co** (5 returns). Using the magic of Large Language Models (LLMs) and the clues we've left in the configuration of the agent and tools, the agent was able to identify the problematic suppliers.

12. Feel free to take a look at the **Traces** generated for this response.

13. The agent remembers conversation context, so let's ask a follow-up question. Type:

    ```text
    What is their status?
    ```

14. Click the **Submit** button.

15. The agent understands "their" refers to the suppliers just mentioned and retrieves their quality status: **ValueParts Manufacturing** is on Probation, **Budget Electronics Co** is on Probation, and **QuickShip Distributors** is Active (Under Review).

16. Next, let's look at a specific product. Type:

    ```text
    Show me all returns for the Espresso Maker Model A and what the return reasons are.
    ```

17. Click the **Submit** button.

18. The agent returns the details associated with the Espresso Maker returns: 8 total returns, primarily due to DEF001 (defective) and DEF002 (missing parts). This product has a high defect rate that warrants attention.

19. Now let's see if we can pull up a policy document which can help us understand what to do about this. Type the following question:

    ```text
    What does our policy say about products that exceed the critical return rate threshold?
    ```

20. Click the **Submit** button.

21. As you can see, for this question, the agent figured out that the information required might be in the knowledge base documents. For this task it employed the RAG tool which searched for the relevant information in our merchandising policy docs stored in object storage. Feel free to look at the traces for this interaction which show the steps the agent took to give us the information we needed. In the response you can see that a summary of the document was provided, but, also, if you expand the **View citations** section, you'll be able to see a reference to the document(s) which were used to compose the reply with a direct link to the file(s), the page(s) from which content was extracted and more.

22. Let's ask about supplier quality. Type:

    ```text
    What are the criteria for putting a supplier on probation?
    ```

23. Click the **Submit** button.

24. The agent retrieves the probation criteria from the Supplier Probation Procedures document, including thresholds for quality rating (below 2.5), defect return counts (25+ in 90 days), and product return rates (above 25%).

25. Now let's test the agent's ability to combine database queries with policy lookups. Type:

    ```text
    ValueParts Manufacturing has 32 defect returns. What does our supplier quality policy say should happen to them?
    ```

26. Click the **Submit** button.

27. Watch the traces on the right — you'll see the agent queries the database to confirm ValueParts' defect count and status, searches the Supplier Quality Standards and Supplier Probation Procedures documents, and explains that with 32 defect returns (exceeding the 25 threshold) and a 2.3 quality rating (below 2.5), ValueParts correctly placed on Probation status per policy.

28. Let's explore regional patterns. Type:

    ```text
    Which region has the most shipping damage returns?
    ```

29. Click the **Submit** button.

30. The agent identifies the **Southwest** region as having the highest shipping damage (DMG001) returns.

31. Now combine this with policy. Type:

    ```text
    What does our regional distribution policy say about packaging requirements for the Southwest region?
    ```

32. Click the **Submit** button.

33. The agent retrieves the Regional Distribution Guidelines and explains that the Southwest region requires enhanced packaging due to higher damage rates: double-wall corrugated boxes, minimum 2 inches cushioning, and heat-resistant packaging for temperature-sensitive items.

34. We invite you to try some prompts of your own to experiment with the agent.

## Task 3: (Optional) More prompts to try

Here are a few more prompts to try with the agent:

- _What are the RTV claim eligibility criteria for defective merchandise?_
- _List all returns from the Northeast region._
- _Show me all products from suppliers on Probation status._
- _What are the defect-specific return thresholds that trigger a supplier notification?_
- _What's the disposition policy for items that are defective but repairable?_
- _How long do we have to file an RTV claim for a manufacturing defect?_
- _What customer remediation should we offer for critical defects?_

## Summary

As you've experienced, the OCI AI Agents service allows you to ask complex questions about data stored in multiple locations and get intelligent answers. By simply pointing the various tools towards your data sources and providing the right context, the agent was able to automatically determine which data source should be accessed, retrieve the data for you, compile a coherent and concise response and provide references to the original data when applicable.

Another interesting advantage of building solutions on top of the OCI AI Agents service is that the user is no longer restricted to tasks allowed by the application user interface. With a chat interface, the user can ask questions and get answers to any question which can be answered using the data in the system even if the system engineers did not plan for that specific scenario. For example, you can ask the agent to sort the results in any way that is supported by the data even if the application was not designed to give you that option.

Although our use-case was focused on retail merchandising and return analysis, the OCI AI Agents service can be used to fuel many different use-cases which require deep understanding and retrieval of information from internal data sources, reasoning over the data, summarizing it, providing insights and more.

## Learn More

- [Chatting with Agents in Generative AI Agents](https://docs.oracle.com/en-us/iaas/Content/generative-ai-agents/chatting.htm#chatting)

## Acknowledgements

- **Author** - Deion Locklear
- **Contributors** - Hanna Rakhsha, Daniel Hart, Uma Kumar, Anthony Marino
