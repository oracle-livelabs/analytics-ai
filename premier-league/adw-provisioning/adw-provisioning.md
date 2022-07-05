# Provision  Autonomous Data Warehouse

<!--![Banner](images/banner.png)-->

## Introduction

In this lab, you will provision a new Autonomous Data Warehouse (ADW) instance. This database will hold the data that you will analyze.

Estimated Time: 5 minutes

### Objectives

In this lab, you will:

-   Learn how to provision a new Autonomous Database

### Prerequisites

To complete this lab, you need to have the following:

- Logged into your Oracle Cloud Account

## Task 1: Provision ADW

1. Go to **Menu** > **Oracle Database** > **Autonomous Data Warehouse**.

   ![ADW Menu](images/adw-menu.png)

2. Click **Create Autonomous Database**.

   ![ADW Create Button](images/adw-create-button.png)

3. Fill the first part of the provisioning form with the following values.

   ![ADW Form 1](images/adw-form-1.png)

      - Compartment: `root` (You can select the root compartment, if not already selected)
      - Display name: `PL`
      - Database name: `PL`
      - Choose a workload type: `Data Warehouse`
      - Choose a deployment type: `Shared Infrastructure`

4. Fill the next part of the provisioning form with the following values.

   ![ADW Form 2](images/adw-form-2.png)

      - Always Free: Turn it `on`, but it will work if you leave it `off` like in the screenshot.
      - Choose database version: `19c`, if your region has 21c it will equally work.
      - OCPU count: `1` or default value.
      - Storage (TB): `1` or default value.
      - Auto Scaling: `on` or default value.

5. Fill the last part of the provisioning form with the following values.

   ![ADW Form 3](images/adw-form-3.png)

      - Password: Create a secure password
      - Confirm password: Confirm the secure password
      - Access Type: `Secure access from everywhere`
      - Choose a license type: `License Included`

6. Click **Create Autonomous Database**.

   We will see the new ADW Database provisioning.

   Wait for the icon to change from:

   ![AWD Provisioning](images/adw-provisioning-state.png)

   To `ACTIVE` state:

   ![AWD Active](images/adw-active-state.png)

7. Your Autonomous Data Warehouse is ready to use.

You may now proceed to the next lab.

## **Acknowledgements**

- **Author** - Jeroen Kloosterman - Technology Product Strategy Director, Sudeshni Fisher - Technology Product Strategy Manager.
