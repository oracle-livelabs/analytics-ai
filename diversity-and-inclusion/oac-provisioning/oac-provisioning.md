# Provision Analytics Cloud

## Introduction

During this lab you will deploy an Oracle Analytics Cloud instance on Oracle Cloud Infrastructure.

Estimated Time: 15 minutes (provisioning time may vary)

### Objectives
In this lab, you will:
- Create an Oracle Analytics Cloud Instance.


## Task 1: Create an Oracle Analytics Cloud (OAC) Instance

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
