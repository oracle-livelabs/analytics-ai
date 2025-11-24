# Introduction

## About this Workshop

This workshop is to get you started with Oracle AI Data Platform which allows you to manage your data and AI assets. You will learn how to provision your AI Data Platform Workbench, create essential components like a workspace and a compute cluster. You will also create your first catalog items, notebooks and run those.
We will follow the structure of a medallion architecture where the raw data lands in the bronze layer as files. From there we will create and run some data processing notebooks to promote data from Bronze to Silver layer in an open table format. Once done we will use the notebook functionality to use the data in the  silver layer and bring that in the external catalog, being the autonomous AI Lakehouse as Gold layer ready for analytics usage.


Estimated Workshop Time: 4 hours (This estimate is for the entire workshop - it is the sum of the estimates provided for each of the labs included in the workshop.)

### Objectives

In this workshop, you will learn how to:
* Provision an AI Data Platform Workbench
* Setup a workspace.
* Create a compute cluster
* Create and run notebooks to process the data
* Create a workflow to automate data processing

### Prerequisites (Optional)

This lab assumes you have:
* An Oracle Cloud account
* An active OCI tenancy
* Compartment where the AI Data Platform Workbench needs to be deployed.
* You have an object storage bucket in the same compartment to store some data files.
* An Autonomous AI Lakehouse provisioned. https://livelabs.oracle.com/pls/apex/r/dbpm/livelabs/view-workshop?wid=928&clear=RR,180&session=108251526920614
* Necessary IAM policies in place. Documentation can be found: https://docs.oracle.com/en/cloud/paas/ai-data-platform/aidug/iam-policies-oracle-ai-data-platform.html#GUID-C534FDF6-B678-4025-B65A-7217D9D9B3DA

### content to be covered in this workshop

Lab 1: Create AI Data Platform - Instance in your tenancy
Lab 2: Create AI Data Platform - Workspace and compute cluster
Lab 3: Load files from Github into OCI Bucket and create Files to Bronze layer
Lab 4: Cleanse and curate data from Bronze and save results into Silver layer into internal catalog entry
Lab 5: Prepare data in Silver layer for serving Gold layer and save results into Gold layer into internal catalog
Lab 6: Create external catalog with Autonomous AI Database and reuse content from Lab 5 to save in Autonomous AI DB
Lab 7: Create workflows for Bronze, Silver, Gold and run each workflow
Lab 8: Create workflow of workflows to run all notebooks and plan scheduling.

*This is the "fold" - below items are collapsed by default*

In general, the Introduction does not have Steps.

## Learn More

*(optional - include links to docs, white papers, blogs, etc)*

* [AI Data Platform documentation](https://docs.oracle.com/en/cloud/paas/ai-data-platform/index.html)

## Acknowledgements
* **Author** - Wilbert Poeliejoe, AI Data Platform Black Belt
* **Contributors** -  Massimo Dalla Rovere, AI Data Platform Black Belt
* **Last Updated By/Date** - <Name, Month Year>
