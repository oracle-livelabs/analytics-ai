# Provisioning the AI Data Platform Workbench

## Introduction

This step is to provision the AI Data Platform Workbench.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:
Learn how to provision an AI Data Platform.

### Prerequisites

The prerequisites as listed in previous lab need to be met before this can be executed.

## Task 1: Locate in OCI console where AI Data Platform is located and select the compartment as defined in the prerequisites

1. Step 1: Find AI Data platform in OCI console

    ![oci console](./images/provisionlocateservice.png)

2. Step 2: Provision AI Data Platform

    ![ai data platform page](./images/provisiondeploystart.png)

## Task 2: Start provisioning

1. Step 1 - Enter all required fields in the entry form

    ![ai data platform provisioning form](./images/provisionentryscreen.png)

    1. Choose a name for the AI Data Platform
    2. Enter a description
    3. In the next section provide the name of your default workspace. In this work also automatically the default management compute cluster will be provisioned
    4. Optionally give it a description
    5. Again the Policies check is taking place and here you have the option to add policies when you have the right permissions.
    6. Click the "Create" button.
    7. Once the status of the provisioning becomes "Active" you can open AI Data Platform

    ![ai data platform open screen](./images/openaidp.png)

    The provisioning itself takes some time.

## Learn More

* [AI Data Platform documentation](https://docs.oracle.com/en/cloud/paas/ai-data-platform/index.html)

**proceed to the next lab**

## Acknowledgements

* **Author** - Wilbert Poeliejoe, AI Data Platform Black Belt
* **Contributors** -  Massimo Dalla Rovere, AI Data Platform Black Belt
