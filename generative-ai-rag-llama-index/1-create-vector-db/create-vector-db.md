### Lab *: Create and configure Autonomous Database
<details>
<summary>Step 1: Create the Autonomous Database</summary>	
1. Log in to your OCI console.    
2. Open the main "hamburger" menu in the top left corner of the Console. Select "Oracle Database" and then click "Autonomous Database."    
&nbsp;&nbsp;&nbsp;&nbsp; \<image:adb1.png>    
3. Select the correct compartment from the "List Scope"→"Compartment" on the left side of the page, and then click the "Create Autonomous Database" button.    
&nbsp;&nbsp;&nbsp;&nbsp; \<image:adb2.png>    
4. Change the "Display name" and "Database name" to "LiveLabVS" and choose the "Transaction Processing" workload. Everything else can remain as the default.    
&nbsp;&nbsp;&nbsp;&nbsp; \<image:adb3.png>    
5. Make sure the database version is "23ai". Everything else can remain as the default.    
&nbsp;&nbsp;&nbsp;&nbsp; \<image:adb4.png>    
6. Enter an administrator password. For this lab, we will use "<b>Livelabpassword1!</b>".    
&nbsp;&nbsp;&nbsp;&nbsp; \<image:adb5.png>    
7. Leave everything else as the default, and click the "Create Autonomous Database" button.    
8. Wait while the database is fully provisioned. Once the "ADW" icon turns from orange to green, and the word "AVAILABLE" appears under it, the database is ready.    
&nbsp;&nbsp;&nbsp;&nbsp; \<image:adb6.png>    
</details>

<details>
<summary>Step 2: Download the Autonomous Database Wallet File</summary>    
1. Once the database is ready, click the "Database connection" button on the database details page.    
&nbsp;&nbsp;&nbsp;&nbsp; \<image:adb7.png>    
2. Leave "Wallet Type" as "Instance wallet" and click the "Download wallet" button. Enter a password for the wallet. For this lab, we will be using "<b>Livelabpassword1!</b>". Click the "Download" button.    
&nbsp;&nbsp;&nbsp;&nbsp; \<image:adb8.png> <image:adb9.png>    
3. Close the database connection page
</details>

<details>
<summary>Step 3(Optional): Create an AIUSER Database Account</summary>    
1. From the database details page, click the "Database actions" dropdown button and select "Database Users".    
&nbsp;&nbsp;&nbsp;&nbsp; \<image:adb10.png>    
2. Click the "Create User" button on the right side of the page.    
&nbsp;&nbsp;&nbsp;&nbsp; \<image:adb11.png>    
3. Enter the following details for the user:    
&nbsp;&nbsp;&nbsp;&nbsp;a. Username: <b>AIUSER</b>    
&nbsp;&nbsp;&nbsp;&nbsp;b. Quota on tablespace DATA: <b>UNLIMITED</b>    
&nbsp;&nbsp;&nbsp;&nbsp;c. Password: <b>Livelabpassword1!</b>    
&nbsp;&nbsp;&nbsp;&nbsp;Enable the slider for "Web Access"    
&nbsp;&nbsp;&nbsp;&nbsp; \<image:adb12.png>    
4. Click the "ADMIN" profile button in the top right of the page, and select "Sign Out".    
&nbsp;&nbsp;&nbsp;&nbsp; \<image:adb13.png>    
5. Enter the credentials for the user account you just created. In this lab we use the following:    
&nbsp;&nbsp;&nbsp;&nbsp;a. Username: <b>AIUSER</b>    
&nbsp;&nbsp;&nbsp;&nbsp;b. Password: <b>Livelabpassword1!</b>    
6. Select the "Development" tab and select "SQL" from the list. Click the "Open" button.    
&nbsp;&nbsp;&nbsp;&nbsp; \<image:adb14.png>    
</details>

<details>
<summary>Create Database Tables For Vector Store</summary>    
<b>If you did Step 3, skip to number 3 below:</b>    
1. From the database details page, click the "Database actions" dropdown button and select "SQL".    
&nbsp;&nbsp;&nbsp;&nbsp; \<image:adb15.png>    
2. Select the "Development" tab and select "SQL" from the list. Click the "Open" button.    
&nbsp;&nbsp;&nbsp;&nbsp; \<image:adb16.png>    
3. Copy and paste the SQL code from the create_tables.sql file into the SQL worksheet and click the "Run Script" button (or press F5).    
&nbsp;&nbsp;&nbsp;&nbsp; \<image:adb17.png>    
```sql
create table BOOKS
("ID" NUMBER NOT NULL,
"NAME" VARCHAR2(100) NOT NULL,
PRIMARY KEY ("ID") 
);
 
create table CHUNKS
("ID" VARCHAR2(64) NOT NULL,
"CHUNK" CLOB,
"VEC" VECTOR(1024, FLOAT64),
"PAGE_NUM" VARCHAR2(10),
"BOOK_ID" NUMBER,
PRIMARY KEY ("ID"),
CONSTRAINT fk_book
        FOREIGN KEY (BOOK_ID)
        REFERENCES BOOKS (ID)
);
```
</details>
