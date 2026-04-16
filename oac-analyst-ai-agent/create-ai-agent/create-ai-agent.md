# Create AI Agent

## Introduction

In this lab, you will create an AI agent in Oracle Analytics Cloud that acts as a domain-specific business analyst. By defining its purpose, attaching the dataset, and providing clear instructions, you shape how the agent interprets data and responds to questions. This transforms your data into an interactive, intelligent experience where users can ask questions and receive meaningful insights instantly.

Estimated Time: 10 minutes

### Objectives

In this lab, you will:
* Create the AI Agent with a dataset
* Create the AI Agent with a Semantic Modeler(subject area)
* 

### Prerequisites

This lab assumes you have:
* Optionally a working semantic model/rpd
* All previous labs successfully completed.


## Task 1: Create the AI Agent with a dataset
In this task we will create the Sales AI Agent using the dataset build in Lab 1. We will add Supplemental Instructions to guide the agent's default behavior, First Message to introduce the agent, set context or clarify capabilities and lastly upload a corporate document to guid the agent responses.

1. Navigate to the **Homepage**, **Click** AI Agent

	 ![Home Page Navigation](images/createaiagent1.png) 

2. Select the **Sales Data for AI**, then  **Add to Agent**.

  ![Add Dataset](images/createaiagent2.png)

3. Under **Supplemental Instructions** Add below

   ```
    <copy>
    You are a senior sales strategy analyst advising executive leadership.
	
	  Focus on Orders, Sales, Discounts, Region, and Profit, and synthesize insights into clear business narratives. 
	  Explain not just what is happening, but why it is happening, highlighting key drivers, trends, and deviations.
	
	  Identify risks and opportunities by calling out underperformance, margin erosion due to discounting, and high-performing regions or segments. 
	  Always provide comparative context across time periods, regions, and product segments to frame performance.
	
    Deliver concise, insight-driven responses with a strong emphasis on implications and recommended actions to improve revenue growth and profitability.

    </copy> 
   ```

4. Under **First Message** add below

   ```
    <copy>  
   Hello, I’m your Sales Performance Analyst. You can ask me about sales trends, regional performance, discount impact, or profitability and I’ll provide insights along with recommended actions.

    </copy>
   ``` 

4. In the dialog box enter **Name** and **Display name** for the Application Role, then click **Create**.

  ![Create Application Role](images/approle2.png)

4. In the dialog box enter **Name** and **Display name** for the Application Role, then click **Create**.

  ![Create Application Role](images/approle2.png)

4. In the dialog box enter **Name** and **Display name** for the Application Role, then click **Create**.

  ![Create Application Role](images/approle2.png)


## Task 2: Add Application Role to the Custom Application Role

1. Click the **CountryRole** to edit.

  ![Assign Role](images/approle4.png)
	
2. Under **Members** click **Application Roles**.

  ![Open Role](images/approle5.png)

3. Click **Add Application Roles**, then add **BI Content Author** and click **Add Selected**.

  ![Assign DV Author](images/approle6.png)  

## Task 3: Add Users or Groups to the Custom Application Role

1. Under **Members** click **Users**.

  ![Search Users](images/approle7.png)
	
2. Click **Add Users**, then add users you created or group and click **Add**.

  ![Add Users to Role](images/approle8.png)


## Task 4: Validate User's Application Roles

1. Navigate to Users tab and pick the user.

	![Open Users Menu](images/approle9.png)

2. Click **Application Roles**, then you should see all application roles including the CountryRole.

  ![Verify Available Roles](images/approle10.png)

You may now **proceed to the next lab.**

## Learn More

* [About Application Roles](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acabi/application-roles.html#GUID-3CEED4DB-F124-45AF-A115-75AF7392974C)

## Acknowledgements
* **Author** - Chenai Jarimani, Cloud Architect, ONA
* **Last Updated By/Date** - Chenai Jarimani, May 2026
