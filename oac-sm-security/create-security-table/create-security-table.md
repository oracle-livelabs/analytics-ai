# Create Security Table

## Introduction

This lab walks you through the steps to create a database table USER_RESPONSIBILITIES which contains country assignments for analytics users.

Estimated Time: 20 minutes

### About <Product/Technology> (Optional)
Enter background information here about the technology/feature or product used in this lab - no need to repeat what you covered in the introduction. Keep this section fairly concise. If you find yourself needing more than two sections/paragraphs, please utilize the "Learn More" section.

### Objectives

In this lab, you will:
* Set up a security table in ADB
* Objective 2
* Objective 3

### Prerequisites (Optional)

*List the prerequisites for this lab using the format below. Fill in whatever knowledge, accounts, etc. is needed to complete the lab. Do NOT list each previous lab as a prerequisite.*

This lab assumes you have:
* An Oracle Cloud account
* All previous labs successfully completed
* You have a running ADB instance


## Task 1: Configure the security table

1. Navigate to the Database Schema

	![Image alt text](images/sample1.png)

	> **Note:** You can use any sql interface of your choice (SQL Developer, Toad, Database Actions and etc

2. Copy and paste the SQL Code in the worksheet

  ![Image alt text](images/sample1.png)

  ```
   </copy> CREATE TABLE ADMIN.USER_RESPONSIBILITIES 
(
  USER_NAME VARCHAR2(80) 
, COUNTRY_ISO_CODE VARCHAR2(20) 
);

INSERT INTO "ADMIN"."USER_RESPONSIBILITIES" (USER_NAME, COUNTRY_ISO_CODE) VALUES ('CHENAI.JARIMANI', 'GB');
INSERT INTO "ADMIN"."USER_RESPONSIBILITIES" (USER_NAME, COUNTRY_ISO_CODE) VALUES ('CHENAI.JARIMANI', 'US');
INSERT INTO "ADMIN"."USER_RESPONSIBILITIES" (USER_NAME, COUNTRY_ISO_CODE) VALUES ('JUDE.WILSON', 'NZ');
INSERT INTO "ADMIN"."USER_RESPONSIBILITIES" (USER_NAME, COUNTRY_ISO_CODE) VALUES ('JUDE.WILSON', 'AU');
INSERT INTO "ADMIN"."USER_RESPONSIBILITIES" (USER_NAME, COUNTRY_ISO_CODE) VALUES ('ADRIENNE.HOWARD', 'US');

COMMIT; </copy>
    ```

4. Test your table is configured by writing a select * statement

 ![Image alt text](images/sample2.png) click **Navigation**.

5. Example with bold **text**.

   If you add another paragraph, add 3 spaces before the line.

## Task 2: Test the security table

1. Test your table is configured by writing a select * statement

 ![Image alt text](images/sample2.png) click **Navigation**.

2. You can also include bulleted lists - make sure to indent 4 spaces:

    - List item 1
    - List item 2


## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>
