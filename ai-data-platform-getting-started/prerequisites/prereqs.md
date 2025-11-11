# Prerequisites before you start 

## Introduction

This step gives you the necessary steps to make sure that you have have the right prerequisites in place to complete the entire workshop.

Estimated Time: 15 minutes

### About prerequisites for provisioning AI Data platform Workbench
The AI Data Platform Workbench ames use of various components of OCI like Object Storage and Autonomous AI Lakehouse. Next to that you may want to connect to various sources and targets that run in OCI or even outside. To be able to do so a set of policies needs to be in place. This can be done  in 2 basic forms. 1 is a more narrow scope while th other has a more OCI wide scope.
Next to that, to demonstrate the integration with Autonomous AI Lakehouse it is useful to it already deployed and the credentials and wallet at hand.
It is also very useful to have a compartment structure in place and that you have identified the compartment for AI Data Platform Workbench

### Objectives

*List objectives for this lab using the format below*

In this lab, you will:
check if prerequisistes are met and  if not, take the time to do the needful to meet those prerequisites.

### Prerequisites (Optional)

*List the prerequisites for this lab using the format below. Fill in whatever knowledge, accounts, etc. is needed to complete the lab. Do NOT list each previous lab as a prerequisite.*

This lab assumes you have:
* An Oracle Cloud account
* An active tenancy
* Compartment where the AI Data Platform Workbench needs to be deployed.
* An Autonomous AI Lakehouse provisioned. https://livelabs.oracle.com/pls/apex/r/dbpm/livelabs/view-workshop?wid=928&clear=RR,180&session=108251526920614
* Necessary IAM policies in place. Documentation can be found: https://docs.oracle.com/en/cloud/paas/ai-data-platform/aidug/iam-policies-oracle-ai-data-platform.html#GUID-C534FDF6-B678-4025-B65A-7217D9D9B3DA

For the  creation of the IAM policies you may need the help of the OCI administrator.

When you start to deploy your AI Data Platform Workbench the OCI console will perform a check if policies are in place.

Similar message like this may show up and policy creation as per instructions in above link are required.
    ![Policy validation message](images/AIDP-Policies-message.png)

*This is the "fold" - below items are collapsed by default*

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [URL text 1](http://docs.oracle.com)
* [URL text 2](http://docs.oracle.com)

## Acknowledgements
* **Author** - Wilbert Poeliejoe
* **Last Updated By/Date** - <Name, Month Year>
