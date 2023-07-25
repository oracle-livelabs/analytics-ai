# Provision Analytics Cloud

## Introduction

During this lab you will deploy an Oracle Analytics Cloud instance on Oracle Cloud Infrastructure.

Estimated Time: 15 minutes (provisioning time may vary)

### Objectives
In this lab, you will:
- Login as a federated user.
- Create an Oracle Analytics Cloud Instance.

## Task 1: Federated User Login

1. Oracle Cloud has two types of users:

   - **OCI Native users**: represent users like you, or applications that can perform operations on OCI native services.
   - **OCI Federated Users** with Identity Cloud Service (IDCS). IDCS is an Identity Provider included with Oracle Cloud to manage Identity services beyond basic users, groups and roles capabilities. For example, OAuth2.0, Multi Factor Authentication, etc.

   > NOTE: Oracle Analytics Cloud (OAC) requires a Federated user.

2. Go to **Profile** on the top-right corner and make sure your user has the name **oracleidentitycloudservice/** appended before your email, like in the picture:

   ![Federated user](images/oac-profile-federated.png)

3. If you don't you see **oracleidentitycloudservice/** before your email, then you need to Sign out and log in as a federated user, following these steps.

4. Go to [cloud.oracle.com](https://cloud.oracle.com), type your **Cloud Account Name** and click **Next**.

   ![Cloud Account Name](images/oac-login-cloud-account-name.png)

5. Login with user and password.

   ![User and Password](images/oac-login-user-password.png)

6. At this point, you should have **oracleidentitycloudservice/** before your email on the Profile popup, on the top-right corner.

   For more information about federated users, see [User Provisioning for Federated Users](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Tasks/usingscim.htm).

## Task 2: Create an Oracle Analytics Cloud (OAC) Instance

1. Return to the Home Page and go to the **Menu** > **Analytics & AI** > **Analytics Cloud**.

   ![OAC Menu](images/oac-menu.png)

2. Make sure you select the `root` compartment (unless you have permissions and experience selecting a different one) and click **Create Instance**.

   ![OAC Create Button](images/oac-create-button.png)

3. Fill the web form with the following information and click **Create**:

   - **Name**: `DiversityAndInclusion`
   - **Description**: `Analytics Instance for D&I Workshop`
   - **Compartment**: `root` compartment, unless you have permissions and experience selecting a different one.
   - **Capacity**: `OCPU`
   - **OCPU Count**: `1 (Non-Production)`
   - **License**: `License Included`
   - **Edition**: `Enterprise Edition`

   ![OAC Form](images/oac-form.png)

   Your Analytics Instance will start provisioning.

   ![pic3](images/oac-creating.png)

   > **Note:** Provisioning an Oracle Analytics Cloud instance can take from 10 (most likely) to 40 minutes.

   We will get back to your Oracle Analytics Cloud instance later in the workshop.

**Proceed to the next lab.**

## **Acknowledgements**

- **Author** - Alexandra Sims - Engagement Strategy Manager, Jeroen Kloosterman - Technology Product Strategy Director.
