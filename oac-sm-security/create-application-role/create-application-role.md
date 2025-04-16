# Create a Custom Application Role in OAC

## Introduction

This lab walks you through the steps to create a custom application role that will use in the semantic modeler to assign permissions. An application role comprises a set of permissions that determine what users can see and do after signing in to Oracle Analytics Cloud.

Estimated Time: 10 minutes

### Objectives

In this lab, you will:
* Create a custom role in OAC
* Add DVAuthor role to the custom role
* Add users to or groups to the application role
* Validate User's application roles

### Prerequisites (Optional)

This lab assumes you have:
* Users and groups already created in the IDCS
* All previous labs successfully completed


## Task 1: Create a Custom Application Role


1. Navigate to the Console

	 ![Image alt text](images/sample2.png) click **Navigation**.

	> **Note:** Use this format for notes, hints, and tips. Only use one "Note" at a time in a step.

2. Click Roles and Permissions

  ![Image alt text](images/approle1.png)

3. Click Application Roles then Create Application Role

  ![Image alt text](images/approle3.png)


4. In the dialog box enter name and Display name for the Application Role, then Click **Create**

  ![Image alt text](images/approle2.png)


## Task 2: Add Application Role to the Custom Application Role

1. Click the CountryRole to edit

	![Image alt text](images/approle4.png)

	> **Note:** Use this format for notes, hints, and tips. Only use one "Note" at a time in a step.

2. Under Members Click Application Roles

  ![Image alt text](images/approle5.png)

3. Click Add Application Roles, then add **BI Content Author** and Click **Add Selected**

  ![Image alt text](images/approle6.png)  

## Task 3: Add users or group to the Custom Application Role

1. Under Members click **Users**

	![Image alt text](images/approle7.png)

	> **Note:** Use this format for notes, hints, and tips. Only use one "Note" at a time in a step.

2. Click **Add Users**, then add users you created or group and click **Add**

  ![Image alt text](images/approle8.png)


## Task 4: Validate User's Application Roles

1. Navigate to Users tab and pick the user

	![Image alt text](images/approle9.png)

	> **Note:** Use this format for notes, hints, and tips. Only use one "Note" at a time in a step.

2. Click **Application Roles**, then you should see all application roles including the CountryRole

  ![Image alt text](images/approle10.png)


## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [About Application Roles](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acabi/application-roles.html#GUID-3CEED4DB-F124-45AF-A115-75AF7392974C)

## Acknowledgements
* **Author** - <Chenai Jarimani, Cloud Architect, NACI>
* **Last Updated By/Date** - <Chenai Jarimani, April 2025>
