# Provision Infrastructure via Terraform

## Introduction

This lab helps you deploy the required OCI Infrastructure and Services via a Resource Manager stack for Terraform

Estimated Time: -- minutes


### Objectives


In this lab, you will:

* Create OCI Functions on an existing or new network
* Create ODA and Visual Builder instances if necessary
* Create Dynamic Groups and Policies for these services

### Prerequisites (Optional)

*List the prerequisites for this lab using the format below. Fill in whatever knowledge, accounts, etc. is needed to complete the lab. Do NOT list each previous lab as a prerequisite.*

This lab assumes you have:
* All previous labs successfully completed


*This is the "fold" - below items are collapsed by default*

## Task 1: Create Resource Manager Stack

1. Start Create Stack Workflow

<!-- https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Tasks/deploybutton.htm
TODO: update package url when available
-->
[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=<package-url>)

Clicking this button will direct you to log in to your tenancy and then to Resource Manager's **Create Stack** page

2. Fill out **Stack Information**

<!-- TODO screenshot-->

Ensure you are creating your stack in the correct region.

Accept the Terms of Use.

Optionally, update the name and description of the stack.

Ensure you have selected the compartment you want to deploy the resource in.

Click Next

3. Configure Variables

<!-- TODO screenshot-->

<!-- TODO go through variable options-->

4. Review and Create

On this page, you can review your stack information and variable configuration.

When you are done, click **Create** to finish the stack creation wizard.

You can select **Run Apply** and skip Tasks 2 and 3, but it is recommended you perform these tasks separately so you can review the Terraform plan before applying.

## Task 2: Run Plan Job

<!-- TODO screenshot-->

1. Click on the **Plan** button

This will bring up a window on the right side. Click **Plan** again to initiate the plan job.

2. Review completed plan

<!-- TODO screenshot-->

The plan job may take a couple minutes to complete. After it is completed, you can search through the logs to see the resources that will be created/updated/deleted as well as their configuration parameters.


## Task 3: Run Apply Job


1. Click on the **Apply** button



<!-- TODO screenshot-->

2. In the **Apply job plan resolution** dropdown menu, select the Plan job you just reviewed

3. Click **Apply** again to initiate the job

4. Wait for the job to be completed


## Task 4: Inspect Created Resources

1. Navigate to the **Stack Details** page

2. Click on the **Stack Resources** view in the lower left

3. Review created Resources


## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - <Name, Title, Group>
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>