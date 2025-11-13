# Setup OCI Agent SQL tool

## Introduction

This lab will take you through the steps needed to set up an OCI Generative AI Agents SQL tool via the console. Some of the key aspects we cover are as follows:


- SQL Tool – A SQL tool in Generative AI Agents converts natural language queries into Oracle SQL and SQLite statements and can run the SQL commands to generate responses against a connected database.
- Databases – The SQL tool in Generative AI Agents supports Oracle Database (Base Database and Autonomous Database).
- Database Schema – A valid database schema must be provided when you add a SQL tool to an agent in Generative AI Agents. SQL tool creation fails at the validation step if the schema is invalid.
- Model Customization – When creating a SQL tool, you can select between using a small or large model.
  - A small model provides faster response times. Use it for simple queries such as "Get total sales for January 2025."
  - A large model provides more accuracy but at the cost of higher latency. Use it for complex queries such as "Show the average sales of the top 5 performing products in Q1 2023 grouped by region."

Estimated Time: 30 minutes

## Task 1: Configure SQL tool.

We will be using the database connection created during earlier steps.

1. Using OCI Console > Analytics & AI > Generative AI Agents

    ![Agent View](images/agent_view.png)

2. Click on the name of the desired agent.

    ![Agent details](images/agent_details.png)

3. Click Tools > Create tool.

    ![Create tool](images/create_tool.png)

4. Select the SQL option.

    ![Sql choice](images/sql_choice.png)

5. Provide a name for the tool.

6. Provide the description: Tool for product-related queries.

    ![Sql routes](images/sqltool_routes.png)

7. Select Inline for the schema option and provide the information below. We will be using some of the default tables available with our database.

    ```
    <copy>
    create table "sh.products"(
    "PROD_ID" NUMBER(6),      
    "PROD_NAME" VARCHAR2(50),
    "PROD_DESC"  VARCHAR2(4000) , 
    "PROD_SUBCATEGORY" VARCHAR2(50) ,   
    "PROD_SUBCATEGORY_ID" NUMBER ,         
    "PROD_SUBCATEGORY_DESC" VARCHAR2(2000) , 
    "PROD_CATEGORY" VARCHAR2(50) ,   
    "PROD_CATEGORY_ID" NUMBER ,         
    "PROD_CATEGORY_DESC" VARCHAR2(2000), 
    "PROD_WEIGHT_CLASS" NUMBER(3),      
    "PROD_UNIT_OF_MEASURE" VARCHAR2(20),   
    "PROD_PACK_SIZE" VARCHAR2(30) ,   
    "SUPPLIER_ID" NUMBER(6) ,      
    "PROD_STATUS" VARCHAR2(20) ,   
    "PROD_LIST_PRICE" NUMBER(8,2) ,    
    "PROD_MIN_PRICE" NUMBER(8,2) ,    
    "PROD_TOTAL" VARCHAR2(13) ,   
    "PROD_TOTAL_ID" NUMBER,         
    "PROD_SRC_ID" NUMBER,         
    "PROD_EFF_FROM" DATE,           
    "PROD_EFF_TO" DATE,           
    "PROD_VALID" VARCHAR2(1)    
    );
    </copy>
    ```

    ![Schema](images/schema.png)

8. Select Inline for the In-context learning examples option.

9. Provide the following sample learning example:

    ```
    <copy>
    Question: What is the product category for product Y Box.
    Oracle SQL: SELECT PROD_CATEGORY FROM sh.products WHERE PROD_NAME = 'Y Box'     
    </copy>
    ```
    ![context learning](images/context_learning.png)

10. Select Inline for the option Description of tables and columns.

11. Copy and update the following:

    ```
    <copy>
    Description of the important tables in the schema:

    sh.products         All about products
    sh.sales       Details about sales

    Description of the important columns of the tables in the schema:

    sh.products table

    sh.products.PROD_ID A unique code assigned to each product
    sh.products.PROD_SUBCATEGORY Product's secondary categories
    ---------------------------------------------------------------------
    sh.sales table

    sh.sales.CUST_ID ID for customer associated to each sales record
    </copy>
    ```

    ![Table reference](images/table_description.png)

12. Select Small (faster response) for the Model customization option.

13. Select Oracle SQL for the Dialect option.

    ![Custom model](images/custom_model.png)

14. Select the database connection created earlier. If necessary, change the compartment name.

15. Click Test connection and validate the connection.

    ![Validate connection](images/validate_connection.png)

16. Enable the SQL execution option.

17. Enable the Self correction option.

    ![Sql options](images/options.png)

18. Provide the following custom instructions:

    ```
    <copy>
    Always try all the possible cases with in a query before returning the answer
    Always use aggregators such as COUNT, SUM, AVG, MIN, and MAX in Oracle SQL queries that contain GROUP BY.
    </copy>
    ```

    ![Instructions](images/instruction.png)

19. Click Create.

20. Wait for the tool to become Active. It may take a few minutes.

    ![Active tool](images/active_tool.png)


**Proceed to the next lab.**

## Acknowledgements

* **Author**
    * **Rahul MR**, Principal Solutions Architect - OCI 
* **Contributors**
    * **Sanjeeva Kalva**, Principal Data Scientist - OCI 