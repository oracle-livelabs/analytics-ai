# Lab 2: Deploy Agent Tools



## Introduction

This lab will go through the steps on configuring the GenAI Agent tools. First we will define the tools through the console, then deploy a function that invokes the agent service. The function we deploy will be used in the next lab.

Estimated Time: 60 minutes

### Objectives

In this lab, you will:
* Define agent tools in the oci console
* Deploy agent function to function application

### Prerequisites

This lab assumes you have:

* An Oracle account
* All previous labs successfully completed

## Task 1: Define Tools for Agent Service


## Task A: Create Policies 

1. Create dynamic group
```text
     <copy>
      ALL {resource.type='genaiagent'}
     </copy>
```

2. Add policy 
```text
     <copy>
      Allow dynamic-group atom-dev-dg to read database-tools-family in compartment <comp-with-database-connection>
      Allow dynamic-group atom-dev-dg to read secret-bundle in compartment <comp-with-vault-secret>
      allow any-user to read database-tools-family in compartment <database-connection-comp> where any {request.principal.type='genaiagent'}
      allow any-user to read secret-bundle in compartment <vault-comp> where any {request.principal.type='genaiagent'}
      Allow any-user to use database-tools-connections in compartment <database-connection-comp> where any {request.principal.type='genaiagent'}
     </copy>
```

## Task B: Create Autonomous Database

## Task C: Create Vault & Secrets

  1. Create secret for private key
  2. Create secret for wallet

## Task D: Create Database Tool Connection

## Task X: Create and Populate Employee Table

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
2. Enter name e.g. atomlab-sql and description, along with the database schema 

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

## Task Y: Deploy Function to Function Application

<!-- files -->

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
* **Last Updated By/Date** - Luke Farley, May 2025
