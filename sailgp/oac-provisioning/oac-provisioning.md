# Provision Analytics Cloud

## Introduction

In this lab, you will deploy an Oracle Analytics Cloud instance on Oracle Cloud Infrastructure.

> Provisioning Oracle Analytics Cloud can take up to 40 minutes.

<!--
[](youtube:Sf5MkI9pTn0)
-->

_Estimated Time:_ 5 minutes

![Banner](images/banner.jpg)

### Objectives

In this lab, you will:

- Create an Oracle Analytics Cloud Instance

### Prerequisites
This lab assumes you have:

- An Oracle Free Trial Account


## Task 1: Create an Oracle Analytics Cloud (OAC) Instance

1. Return to the Home Page and go to the **Menu** > **Analytics & AI** > **Analytics Cloud**.

   ![OAC Menu](images/oac-menu.png)

2. Make sure you select the `root` compartment (unless you have permissions and experience selecting a different one) and click **Create Instance**.

   ![OAC Create Button](images/oac-create-button.png)

3. Fill the web form with the following information and click **Create**:

   - **Name**: `SailGPAnalytics`
   - **Description**: `Analytics Instance for SailGP Workshop`
   - **Create in Compartment**: `root` compartment, unless you have permissions and experience selecting a different one
   - **Capacity**: `OCPU` and `1 - Non Production`
   - **License Type**: `License Included`
   - **Edition**: `Enterprise Edition`

   ![OAC Form](images/oac-form.png)

   Your Analytics Instance will start provisioning.

   ![pic3](images/oac-creating.png)

   > **Note:** Provisioning an Oracle Analytics Cloud instance can take from 10 (most likely) to 40 minutes.

   We will get back to your Oracle Analytics Cloud instance later in the workshop.

You may now *proceed to the next lab*.

## **Acknowledgements**
- **Author** - Jeroen Kloosterman (Technology Product Strategy Director), Victor Martin (Technology Product Strategy Manager)
- **Contributors** - Priscila Iruela, Arabella Yao
- **Last Updated By** - Arabella Yao, August 2021
