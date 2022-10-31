# Lab: Provision OCI Data Science

## Introduction

This lab will show you how to provision the OCI Data Science service.

Estimated lab time: 20 minutes

### Objectives

In this lab you will:
* Become familiar with the process of provisioning OCI Data Science

### Prerequisites

* An Oracle Free Tier or Paid Cloud Account (see prerequisites in workshop menu)
* You need a user with an **Administrator** privileges to execute the ORM stack or Terraform scripts. If you have just created an OCI Trial for this workshop, your main user has Administrator privileges.
* If you have just started with a new Oracle cloud account, make sure that it has completed provisioning. In particular, it's important that you **don't** see the message "Your account is currently being set up, and some features will be unavailable. You will receive an email after setup completes."

## Task 1: Configure prerequisites for the service

This guide shows how to use the Resource Manager to provision the prerequisites for the OCI Data Science service. This includes the configuration network (VCN) and security configuration (groups, dynamic groups and policies).

This process is automated.  However, **if you prefer a manual** approach, to control all the aspects of the provisioning, you can find those instructions here OCI Data Science: [manual provisioning steps](https://docs.cloud.oracle.com/en-us/iaas/data-science/data-science-tutorial/tutorial/get-started.htm#concept_tpd_33q_zkb). In all other cases, please continue with the steps below for automated provisioning.

1. Press this button below to open the Resource Manager.

    [![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/oracle-quickstart/oci-ods-orm/releases/download/v2.0.0.1/oci-ods-orm-v2.0.1.zip)

    You may have to log in first in case you were not logged into to Oracle Cloud Infrastructure already.

2. Configure the Stack.
    * Check "I have reviewed and accepted the Oracle Terms of Use".
    * Select the right compartment. If you have just created your Oracle cloud account you may choose the root compartment.
    * Click Next.

    ![](./images/autostack.png)

3. On the "Configure variables" screen, press Next.

    ![](./images/provision-ocids-step2.png)

4. On the "Review" screen, press Create.

    ![](./images/provision-ocids-step3.png)

5. After about a minute, the state of the Job should change to "Succeeded" 

    ![](./images/provision-ocidsprereq-success.png)


## Task 2: Create a Project and Notebook

1. Click on the top left "hamburger" menu, go to "Analytics and AI", then choose "Data Science".

    ![](./images/open-ods.png)

2. Click "Create Project"

    ![](./images/create-project-1.png)

    - Select the right compartment. If you have just created your Oracle cloud account you may choose the root compartment.
    - Choose a name, e.g. "Data Science Project" and press "Create".

    ![](./images/create-project-2.png)

2. The newly created project will now be opened. Within this project, provision an Oracle Data Science notebook by clicking "Create notebook session".

    ![](./images/create-notebook-1.png)

    - Select the right compartment. If you have just created your Oracle cloud account you may choose the root compartment.
    - Select a name, e.g. "Data Science Notebook"
    - We recommend you choose **VM.Standard2.2** as the shape. In practice this makes the processing of the video of this workshop fast enough.
    - Set block storage to 50 GByte.
    - Keep the defaults for the Networking Resources.

    ![](./images/create-notebook-4.png)

    Finally click "Create". The process should finish after 5-10 minutes and the status of the notebook will change to "Active".

3. Open the notebook that was provisioned

    ![](./images/open-notebook.png)

    You may be asked to log in again. After this you will see the Data Science Jupyter environment

    ![](./images/environment.png)

[Proceed to the next section](#next).

## Acknowledgements
* **Authors** - Olivier Perard - Iberia Technology Software Engineers Director, Jeroen Kloosterman - Product Strategy Director
