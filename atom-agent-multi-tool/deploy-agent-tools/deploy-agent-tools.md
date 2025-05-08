# Lab 2: Deploy Agent Tools

## Introduction

This lab will go through the steps on configuring the GenAI Agent tools. First we'll go through the steps needed to provision Oracle Autonomous Database 23ai and Database Tools Connection, then define the tools through the console. After the tools are configured we will deploy a function that invokes the agent service. The function we deploy will be used in the next lab.

Estimated Time: 90 minutes

### Objectives

In this lab, you will:
* Define agent tools in the oci console
* Deploy agent function to function application
* Provision an Oracle ADB 23ai
* Create DB Tools Connection

### Prerequisites

This lab assumes you have:

* An Oracle account
* All previous labs successfully completed
* Must have an Administrator Account or Permissions to manage several OCI Services: Oracle Databases, Networking, Policies.

## Task 1: Dynamic Group and Policy Definition for ADB and DB Tools Connection

This task will help you ensure that the Dynamic Group and Policy are correctly defined.

1. Locate Domains under Identity & Security

    ![Domain Navigation](images/adb/locate_domain.png)

2. Click on your current domain name

    ![Click Domain](images/adb/click_domain.png)

3. Click on Dynamic Groups, and then your Dynamic Group name

    ![Click DG](images/adb/click_dg.png)

    **Note** The name of your dynamic group can be different.

4. Ensure that your Dynamic Group is properly defined - as follows. Then click on Identity

    ![DG Details](images/adb/dg_details.png)

    ```text
     <copy>
      ALL {resource.type='genaiagent'}
     </copy>
    ```

5. Click on Policies, ensure that you are in your "root" compartment, then click on your Policy name

    ![Click Policy](images/adb/click_policy.png)

    **Note** The name of your policy can be different.

6. Ensure that your Policy is properly defined - as follows. Make sure to change the compartment to your own compartment name where the respective services are hosted. 

    ![Policy Details](images/adb/policy-details.png)

    ```text
     <copy>
      Allow dynamic-group atom-dev-dg to read database-tools-family in compartment <comp-with-database-connection>
      Allow dynamic-group atom-dev-dg to read secret-bundle in compartment <comp-with-vault-secret>
      allow any-user to read database-tools-family in compartment <database-connection-comp> where any {request.principal.type='genaiagent'}
      allow any-user to read secret-bundle in compartment <vault-comp> where any {request.principal.type='genaiagent'}
      Allow any-user to use database-tools-connections in compartment <database-connection-comp> where any {request.principal.type='genaiagent'}
     </copy>
    ```

    **Note** If you are using a non-default identity domain - then instead of of just supplying the dynamic group name, you need to provide domain-name/group-name in the policy statements.

## Task X: Create RAG Tool 

1. Navigate to your GenAI Agent created in the previous lab 

![Screenshot showing how to navigate to the Agents service from the main menu](./images/console/agents-service-navigation.png)

2. Select your agent and create a new tool 

![Create RAG Tool](./images/rag/create-rag-tool.png)

3. Give a description of the tool and select the knowledge base you created in the previous lab 

![Configure RAG Tool](./images/rag/config-rag.png)

4. Navigate to the agent endpoint and launch the chat. You should now be able to ask questions about your dataset - 

![Test RAG Tool](./images/rag/test-rag.png)

## Task 2: Create VCN and Private Subnet

This task will help you to create a VCN and private subnet in your compartment. This will be used for the ADB for the SQL Tool.

1. Go to Networking -> Virtual cloud networks and Create VCN. Provide IPv4 CIDR Blocks as 10.0.0.0/16

2. Go to the newly created VCN and click on Create Subnet. Provide IPv4 CIDR Block as 10.0.1.0/24 and click on Private Subnet. You can leave rest as default. Click on Create Subnet.

3. Click on newly created subnet and go to the Security List. Add following ingress rules in the security list. Make sure to have the ingress rule to access database port 1521-1522

    ![Ingress Rules](images/adb/ingress_rules.png)

## Task 3: Create Vault to store database secrets

This task will help you to create vault which would be used to save secrets for the database. The secrets are used for the agent to connect to your database with the db tool connection.

1. Locate Vault under Key Management & Secret Management. Provide Name and click on Create Vault.

    ![Vault](images/adb/create_vault.png)

2. Go to the newly created Vault. Click on Create Key.

3. Provide Name and leave rest as default. Choose Protection Mode as HSM and click on Create Key.

    ![Create Key](images/adb/create_key.png)

## Task 4: Create Autonomous Database

This task involves creating Autonomous Database 23ai.

1. Locate Autonomous Databases under Oracle Databases. Click on Create Autonomous Database.

    ![Create ADB](images/adb/create_adb.png)

2. Provide information for Compartment, Display name, Database name. Choose workload type as Transaction Processing. Choose deployment type as Serverless. Choose database version as 23ai and give it a password of your preference. Check the Developer mode option.

    ![Create ATP](images/atp/create-atp-1.png)

3. Make sure to select the Network Access: Private Endpoint access only, and select the VCN and subnet mentioned in above section. Also, do not check Require mutual TLS (mTLS) authentication.

    ![ADB creation](images/adb/adb.png)

4. Finally provide a valid email ID and click on Create Autonomous Database.

## Task 5: Create Database Tools Connection

This task involves creating a Database Tools Connection which will be used to query the database using SQL Worksheet.

1. Locate Database Tools Connections under Developer Services. Click on Create connection.

    ![Create conn](images/adb/dbconn.png)

2. Provide Name and Compartment information. Choose Oracle Autonomous Database as Database cloud service. Provide Username as admin.

3. Click on Create password secret. Provide Name, Vault and Key created in Task 3. Provide same password used at the time of ADB creation in previous task.

    ![Create Password](images/adb/dbconn_pass.png)

4. Use the newly created password secret as User password secret.

5. Copy the connection string from your autonomous database. Go to ADB and click on database connection and copy any of the low, medium or high connection strings as shown below,

    ![Create Conn String](images/adb/conn_string.png)

6. Modify the connection string with the following: Reduce retry_count form 20 to 3; Replace host with private ip address. You can get Private IP address from the autonomous database as shown below.

    ![Private IP](images/adb/pvt_ip.png)

7. Click on Create private endpoint. Provide Name and private subnet created in Task 1.

    ![Private Endpoint](images/adb/dbconn_pvt_endp.png)

8. Choose newly created private endpoint as Private Endpoint.

9. Choose Wallet format as None in SSO details.

10. Click on Create to create a database tools connection.

    ![Create DBTools](images/adb/dbconn_create_conn.png)

11. Go to newly create Database Tools connection. Click on Validate.

    ![Validate DBTools](images/adb/dbconn_validate.png)


## Task X: Create and Populate Employee Table

1. Navigate to the SQL Worksheet of your newly created ADB and run the following statements: 

> *Note* You can create or use your own tables here; we provided the table below for illustration purposes. 

```text
<copy>
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    DepartmentID INT,
    HireDate DATE NOT NULL
);
</copy>
```

- Populate your table with the following data 

```text
<copy>
INSERT ALL
INTO Employees (EmployeeID, Name, DepartmentID, HireDate) VALUES (1, 'John Doe', 1, TO_DATE('2020-01-01', 'YYYY-MM-DD'))
INTO Employees (EmployeeID, Name, DepartmentID, HireDate) VALUES (2, 'Jane Smith', 2, TO_DATE('2020-02-01', 'YYYY-MM-DD'))
INTO Employees (EmployeeID, Name, DepartmentID, HireDate) VALUES (3, 'Bob Johnson', 1, TO_DATE('2020-03-01', 'YYYY-MM-DD'))
INTO Employees (EmployeeID, Name, DepartmentID, HireDate) VALUES (4, 'Alice Brown', 3, TO_DATE('2020-04-01', 'YYYY-MM-DD'))
INTO Employees (EmployeeID, Name, DepartmentID, HireDate) VALUES (5, 'Mike Davis', 2, TO_DATE('2020-05-01', 'YYYY-MM-DD'))
SELECT * FROM dual;
</copy>
```

## Task C: Create SQL Tool
1. In the console navigate to your agent and create a new SQL Tool

  ![Navigate to Agent](./images/console/agents-service-navigation.png)

2. Enter name e.g. atomlab-sql and description, along with the database schema 

> *Note* Make sure to use the same schema defined from the previous task.

```text
<copy>
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    DepartmentID INT,
    HireDate DATE NOT NULL
);
</copy>
```

![Create SQL Tool](images/sqltool/create-tool.png)

3. Select Oracle SQL as the dialect and select the database tool connection configured in the previous task. Enable SQL Execution and self correction. 
4. Test the connection 

![Test Connection](images/sqltool/tool-connection.png)

5. Create the tool 

6. Navigate to your endpoint and launch the chat. Ask a question such as "Give me list of employees". The agent should invoke the SQL Tool and convert the query to Oracle SQL, then return the result - 

  ![Test SQL Tool](./images/sql/test-sql-tool.png)

  ![Test SQL Tool](./images/sql/test-sql-tool-2.png)

## Task D: Create Analyze Document Tool from Console 

  1. Navigate back to the tools of your agent and create a new function tool - 

  ![Create Analyze Doc Tool](./images/analyze-doc/create-analyze-doc-tool.png)

  - Give the following description - 

    ```text
    <copy>   
      Analyzes document and returns text 
    </copy>
    ```

  - Paste the following function parameters - 

    ```text
    <copy>
      {"type":"object","properties":{"url":{"type":"string"}},"required":"['url']"}
    </copy>
    ```

  2. Create the tool 

  > *Note* You will not be able to test the analyze_doc function yet; this tool will depend on the function we will deploy later.

## Task E: Create a General Chat Tool

  1. Navigate to your agent tools and create a new tool - 

  ![Create General Chat Tool](./images/general-chat/create-general-chat-tool.png)

  - Give the following description - 

    ```text
    <copy>
      Takes a general user input and returns answer 
    </copy>
    ```

  - Paste the following function parameters - 

    ```text
    <copy>
      {"type":"object","properties":{"userInput":{"type":"string"}},"required":"['userInput']"}
    </copy>
    ```

  2. Create the tool 

## Task E: Create a Weather Tool

  1. Navigate to your agent tools and create a new tool called "get_weather" 

  - Give the following description - 

    ```text
    <copy>
      Get the weather for a given location
    </copy>
    ```

  - Paste the following function parameters - 
    ```text
    <copy>
    {"type":"object","properties":{"location":{"type":"string"}},"required":"['location']"}
    </copy>
    ```

  2. Create the tool 

## Task F: Create an API Endpoint Tool 

## Task Y: Deploy Function to Function Application

The function to be deployed will invoke the agent from the ODA application.

1. Files that you want the reader to download:

  When the file type is not recognized by the browser, you can use the following format.

  > **Note:** _The filename must be in lowercase letters and CANNOT include any spaces._

  Download the [starter SQL code](files/starter-file.sql).

  When the file type is recognized by the browser, it will attempt to render it. So you can use the following format to force the download dialog box.

  > **Note:** _The filename must be in lowercase letters and CANNOT include any spaces._

  Download the [sample JSON code](files/sample.json?download=1).

  *IMPORTANT: do not include zip files, CSV, PDF, PSD, JAR, WAR, EAR, bin or exe files - you must have those objects stored somewhere else. We highly recommend using Oracle Cloud Object Store and creating a PAR URL instead. See [Using Pre-Authenticated Requests](https://docs.cloud.oracle.com/en-us/iaas/Content/Object/Tasks/usingpreauthenticatedrequests.htm)*

3. Conditional content example (type="livelabs")

    Select your compartment. <if type="livelabs">If you are using a LiveLabs environment, be sure to select the compartment provided by the environment. Leave Always Free unchecked,</if><if type="alwaysfree">Choose any compartment, select "Always Free",</if> and enter `SecretPassw0rd` for the ADMIN password, then click **Create Autonomous Database**.

    ![](images/atp-settings-1.png)
    <if type="livelabs">![](images/atp-settings-2-notaf.png)</if>
    <if type="alwaysfree">![](images/atp-settings-2.png)</if>
    ![](images/atp-settings-3.png)

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*


* [SQL Tool Guidelines for Generative AI Agents](https://docs.oracle.com/en-us/iaas/Content/generative-ai-agents/sqltool-guidelines.htm)
* [Database Tools - ADB Shared with Public IP](https://docs.oracle.com/en-us/iaas/database-tools/doc/oracle-database-use-cases.html#OCDBT-GUID-87796740-BAE4-4805-BF6D-C75A02A3D1D4)
* [RAG Tool Oracle Database Guidelines for Generative AI Agents](https://docs.oracle.com/en-us/iaas/Content/generative-ai-agents/oracle-db-guidelines.htm)

## Acknowledgements

* **Author** - Luke Farley, Senior Cloud Engineer, NACIE
* **Contributors**
    * **Kaushik Kundu**, Master Principal Cloud Architect, NACIE
    * **Abhinav Jain**, Senior Cloud Engineer, NACIE
* **Last Updated By/Date**
    * **Luke Farley**, Senior Cloud Engineer, NACIE, May 2025