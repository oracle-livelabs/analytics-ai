# Create the Agent

## Introduction

In this lab we are going to create the intelligent agent which will drive our entire solution. We will provide the agent with the required tools and knowledge bases to perform it's work effectively. Tools are resources the agent can use to perform it's tasks. In our use-case, we are going to use two tools:

- **RAG Tool** - Which will scan the knowledge articles uploaded to object storage whenever the user requires such information.
- **SQL Tool** - Which will be able to retrieve information stored in our ADB instance relating to the ticketing system.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:

- Create our agent including the RAG & SQL Tools and assign the relevant knowledge base to each.

### Prerequisites

This lab assumes you have:

- All previous labs successfully completed.

## Task 1: Create the agent

1. Click the navigation menu on the top left.
1. Click **Analytics & AI**.
1. Click **Generative AI Agents**.

   ![Screenshot showing how to navigate to the agents service](./images/navigate-to-agents.jpg)

1. In the overview page, click the **Agents** link
1. Under the **List scope** section, make sure that your compartment is selected.
1. Click the **Create Agent** button at the top of the **Agents** table.

   ![Screenshot showing how to create a new agent](./images/create-new-agent-tenancy.png)

1. For the **Name** field use: _loan compliance agent_
1. For the **Compartment** field, make sure that your compartment is selected.
1. For the **Description** field, use: _This agent assists compliance officers in reviewing applications, workloads, and policy compliance_.
1. For the **Welcome message** field, use: _Hello! I’m your compliance assistant. How can I help?_
1. Click the **Next** button.

   ![Screenshot showing the basic information for the agent](./images/basic-agent-info-sandbox.png =50%x*)

## Task 2: Add the RAG Tool

1. Under the **Tools** section, click the **Add tool** button to create our first tool.

   ![Screenshot showing how to create a new tool](./images/create-new-tool.png)

1. Select the **RAG** tool option.
1. Under the **RAG Configuration** section, use _Knowledge base loan policy articles_ in the **Name** field.
1. For the **Description** field, use: _Retrieves lending policy manuals and underwriting rules (DTI, credit score thresholds, FHA/VA limits, manual underwriting guidance)_.

   It is very important to provide a high-level description of the knowledge that this tool can retrieve. This allows the agent to make accurate decisions when choosing to invoke this tool.

   ![Screenshot showing the initial configuration for the RAG tool](./images/rag-tool-info-1.png)

1. Under the **Add knowledge bases** section, make sure that your compartment is selected in the **Compartment** field.
1. Click the **Create knowledge base** button. In this step we are going to create a knowledge base which references the storage bucket into which we've uploaded the knowledge articles.

   ![Screenshot showing more configuration for the RAG tool](./images/rag-tool-info-2-sandbox.jpg)

1. In the **New knowledge base** form, use: _Compliance officer knowledge base loan policy articles_ for the **Name** field.
1. Make sure that your compartment is selected in the **Compartment** field.
1. In the **Data store type** field, we will select **Object storage** to be able to retrieve information from our storage bucket.
1. Make sure that **Enable hybrid search** is checked. Enabling this option instructs the system to combine lexical and semantic search when scanning our documents.
1. Click the **Specify data source** button.

   ![Screenshot showing the knowledge base configuration](./images/knowledge-base-info-1-sandbox.png)

1. In the **Specify data source** form, use: _loan policy docs_ for the **Name** field.
1. Make sure that the **Enable multi-modal parsing** option is **not** checked. This option enable parsing of rich content, such as charts and graphics, to allow responses based on visual elements. However, we do not have any images in our knowledge articles so right now this option is not required.
1. Under the **Data bucket** option, select the _loan-policy-manuals_ bucket into which we've previously uploaded the knowledge articles PDF files.
1. Check the **Select all in bucket option**. This option will automatically flag all of the file in the bucket for ingestion instead of us having to select each file individually.
1. Click the **Create** button.

   ![Screenshot showing the data source configuration](./images/data-source-info-sandbox.png)

1. Back in the **New knowledge base** panel, the **Loan policy manuals** data source was added to the **Data source** table.
1. Make sure that the **Automatically start ingestion job for above data sources** option is checked. This will create an ingestion job which will scan all of our files automatically when the knowledge base is initially created. Please note that this will only run the ingestion job once. In order to re-ingest information from the bucket in the future, you will need to trigger a job manually.
1. Click the **Create** button.

   ![Screenshot showing the knowledge base configuration](./images/knowledge-base-info-2.png)

1. The knowledge base will take a few minutes to create and ingest the data.
1. Back at the **Add knowledge bases** panel, make sure that the checkbox next to the knowledge base name is checked.
1. Click the **Add tool** button.

   ![Screenshot showing the end of the RAG tool configuration](./images/rag-tool-info-3.png)

## Task 3: Add the SQL Tool

1. Now that we have our RAG tool configured, let's configure our SQL tool. In the **Tools** section Click the **Add tool** button.

   ![Screenshot showing the create tool button for creating the SQL tool](./images/create-new-tool.png)

1. Click the **SQL** option.
1. For the **Name** field, use: _Loan Applications database_.
1. For the **Description** field, use: _Tables contain applicants, loan applications, statuses, and officers for compliance review._.

   ![Screenshot showing the initial set of the SQL tool configuration](./images/sql-tool-info-1.png)

1. Under **Import database schema configuration for this tool**, selec the **Inline** option which will allow us to use the same schema text we've used when we created the database.
1. Copy the following text and paste it into the **Database schema** field:

      ```sql
      <copy>
      CREATE TABLE Applicants (
      ApplicantID NUMBER PRIMARY KEY,
      ExternalCustomerID VARCHAR2(20) UNIQUE,
      FirstName VARCHAR2(50) NOT NULL,
      LastName  VARCHAR2(50) NOT NULL,
      Address   VARCHAR2(200),
      City      VARCHAR2(50),
      State     VARCHAR2(2),
      ZipCode   VARCHAR2(10),
      Age NUMBER,
      AnnualIncome NUMBER,
      CreditScore NUMBER
      );
      CREATE TABLE LoanOfficers (
      OfficerID NUMBER PRIMARY KEY,
      FirstName VARCHAR2(50) NOT NULL,
      LastName  VARCHAR2(50) NOT NULL,
      Email VARCHAR2(100) UNIQUE NOT NULL,
      Phone VARCHAR2(20)
      );
      CREATE TABLE LoanStatus (
      StatusID NUMBER PRIMARY KEY,
      StatusName VARCHAR2(50) NOT NULL
      );
      CREATE TABLE LoanApplications (
      LoanApplicationID NUMBER PRIMARY KEY,
      ApplicationID NUMBER UNIQUE NOT NULL,
      ApplicantID NUMBER NOT NULL,
      LoanType VARCHAR2(50) NOT NULL,
      RequestedAmount NUMBER NOT NULL,
      DebtToIncomeRatio NUMBER NOT NULL,
      CreatedDate DATE NOT NULL,
      LastUpdatedDate DATE NOT NULL,
      StatusID NUMBER NOT NULL,
      AssignedToOfficerID NUMBER,
      EducationLevel VARCHAR2(50),
      TotalDebt NUMBER,
      Veteran VARCHAR2(3)
      );
      </copy>
      ```

1. Under the **Description of tables and columns**, select the **Inline** option.
1. Copy and paste the following text into the **Description of tables and columns**. This verbal description contains details about each table and column. This will allow the tool to better understand the data stored in our database:

      ```text
      <copy>
      Applicants — customer demographic and financial details.
         ApplicantID (number): PK
      ExternalCustomerID (string): business ID (e.g., CUST_22000)
         FirstName, LastName, Address, City, State, ZipCode
      Age (number)
         AnnualIncome (number)
         CreditScore (number)
      LoanOfficers — officer directory.
         OfficerID (number): PK
      FirstName, LastName, Email, Phone
      LoanStatus — application lifecycle statuses.
         StatusID (number): PK
      StatusName (string): one of Pending Review, In Progress, Approved, Denied
      LoanApplications — each loan application and its state.
         LoanApplicationID (number): PK
      ApplicationID (number): external app ID (unique)
         ApplicantID (number): FK → Applicants.ApplicantID
      LoanType (string): Conventional, FHA, VA, Jumbo
      RequestedAmount (number)
         DebtToIncomeRatio (number)
         CreatedDate (date)
         LastUpdatedDate (date)
         StatusID (number): FK → LoanStatus.StatusID
      AssignedToOfficerID (number): FK → LoanOfficers.OfficerID
      EducationLevel (string)
         TotalDebt (number)
         Veteran (string): 'Yes'/'No'


      </copy>
      ```

   ![Screenshot showing the second set of the SQL tool configuration](./images/sql-tool-info-2-sandbox.png)

1. For **Model customization**, select the **Small** option.
1. For **Dialect**, select **Oracle SQL**.
1. In the **Database tool connection in...** select the **connection-loancomplianceXXXX** connection we've previously created.
1. Click the **Test connection** button. You should see a successful connection connection attempt.
1. Enable the **SQL execution** option. This option will instruct the tool to execute the SQL queries generated by the tool as a result of the user's requests. This will allow the agent to craft intelligent responses based on the data returned from the queries.
1. Enable the **Self correction** option. Enabling this option will allow the tool to automatically detect and correct syntax errors in generated SQL queries.

1. Click the **Add tool** button.

   ![Screenshot showing the last set of the SQL tool configuration](./images/sql-tool-info-3-sandbox.png)

1. Back in the **Tools** section, Click **Next**

   ![Screenshot showing how to move to the next agent creation section after tools were created](./images/complete-tools.png)

## Task 4: Setup the Agent Endpoint

1. In the **Setup agent endpoint** section, check the **Automatically create an endpoint for this agent**.
1. Enable the **Enable human in the loop** option. This will enable the agent to ask for additional human input or information if needed.

   ![Screenshot showing the first set of the agent's endpoint configuration](./images/agent-endpoint-info-1.jpg)

1. We are going to leave all of the options under **Guardrails** for **Content moderation**, **Prompt injection (PI) protection** & **Personally identifiable information (PII) protection** sections as **Disabled**. Those options are important but not required for our demonstration. Please refer to the **Learn More** section below for additional information about those options.
1. Click the **Next** button.

   ![Screenshot showing how to move to the next section in the agent's creation after the endpoint configuration](./images/agent-endpoint-info-2.jpg)

## Task 5: Review and Create

1. In the **Review and create** page, review the agent information and click the **Create agent** button.

   ![Screenshot of the agent creation review page](./images/agent-info-last.png)

1. In the license agreement dialog, review the agreement, check the concent checkbox and click the **Submit** button.

   ![Screenshot showing how to accept the license agreement](./images/accept-license.jpg)

1. The agent will take a few minutes to create. When complete, the agent's **Lifecycle state** will show **Active**.

You may now **proceed to the next lab**

## Learn More

- [Creating an Agent in Generative AI Agents](https://docs.oracle.com/en-us/iaas/Content/generative-ai-agents/create-agent.htm#create-agent)
- [Add AI Guardrails to OCI Generative AI Model Endpoints](https://docs.oracle.com/en-us/iaas/releasenotes/generative-ai/ai-guardrails.htm)

## Acknowledgements

- **Author** - Deion Locklear 
- **Contributors** - Hanna Rakhsha, Daniel Hart, Uma Kumar, Anthony Marino
