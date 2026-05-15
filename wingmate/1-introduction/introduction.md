# Introduction

## About this Workshop
The scope of this workshop is to create an Oracle Cloud Infrastructure (OCI) Wingmate that helps monitor security and deliver operational insights for a tenancy. This workshop uses Oracle 26ai Autonomous AI Database to store data collected from a tenancy and APEX to generate a dashboard that delivers operational insights.

[**Resource Analytics**](https://www.oracle.com/manageability/resource-analytics/) is a new OCI product that provides near real-time information to enhance visibility across IT infrastructure. This lab serves as a guide for new users looking to get started with Resource Analytics and begin building with APEX.

This lab was designed to enable users to develop an app from scratch using a combination of data sources: synthetic flat files, RESTful APIs, and/or Resource Analytics.
* First, for convenience, synthetic data is populated into flat files (CSVs) to simulate batch data gathered from an API or other methods.
* Second, direct RESTful API connectivity is simulated by showing users how to connect to tenancy resources, which may or may not be supported by other means (for example, Resource Analytics).
* Third, Resource Analytics simulates a near real-time direct connection to tenancy information to populate the app and begin asking complex natural language questions (using Wingmate) or visualizing scenarios with Property Graphs.

> **Note:** Wingmate is not an Oracle-branded product, but rather a new way to create a data model and unlock insights from your data using APEX, which may or may not be supported by Resource Analytics. The advantage of building on APEX is that it is free and allows for a more customizable experience. **This lab gives you the option to build on an Always Free Autonomous AI Database or use resources provisioned by Resource Analytics.**

![navigate home buttons](./images/cover-page.png "")

Utilizing natural language to query tenancy information makes operations oversight a breeze.

![navigate home buttons](./images/cover-page-2.png "")

Using all features of a sophisticated data model on a converged database allows deeper insights into how resources depend on each other. For example, PDBs in a multitenant architecture can be visualized with Graph to better understand noisy neighbors.

![navigate home buttons](./images/cover-page-3.png "")

Visualize resources from an interactive experience.

![navigate home buttons](./images/cover-page-4.png "")

> **NOTE:** Your tenancy must be subscribed to the **US Midwest (Chicago), US-Phoenix-1, or US-Ashburn-1** region in order to run this workshop. See the [OCI documentation](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingregions.htm) for more details.

### What is Generative AI?

Generative AI enables users to quickly generate new content based on a variety of inputs. Inputs and outputs to these models can include text, images, sounds, animation, 3D models, and other types of data.

### What is Natural Language?

Natural language processing is the ability of a computer application to understand human language as it is spoken and written. It is a component of artificial intelligence (AI). We will leverage Natural Language Processing for our RAG Chatbot to understand user queries and provide relevant responses.


Estimated time - 1 hour

### Objectives

In this workshop, you will learn how to:

* Build Wingmate in APEX
* Build a Data Model to support Wingmate
* Build Security Wingmate
* Build MultiCloud Wingmate

### Prerequisites

* An OCI cloud account
* Subscription to the US Midwest (Chicago), US-Ashburn-1, or US-Phoenix-1 region
* Basic database and SQL knowledge.
* Familiarity with Oracle Cloud Infrastructure (OCI) is helpful.
* Familiarity with the role of REST services.

You may now **proceed to the next lab**.

## Learn more

* [Oracle Autonomous Database Documentation](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/index.html)
* [Additional Autonomous Database Tutorials](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/tutorials.html)
* [Overview of Generative AI Service](https://docs.oracle.com/en-us/iaas/Content/generative-ai/overview.html)
* [Resource Analytics Product Page](https://www.oracle.com/manageability/resource-analytics/)


## Acknowledgements

* **Authors:**
	* Nicholas Cusato - Cloud Architect
	* Royce Fu - Master Principal Cloud Architect
* **Last Updated by/Date** - Nicholas Cusato, February 2026
