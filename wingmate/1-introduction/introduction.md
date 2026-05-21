# Introduction

## About this Workshop

The scope of this workshop is to create an Oracle Cloud Infrastructure (OCI) Operations Wingmate that helps monitor security, compute, database, storage, networking, and multicloud operational signals for a tenancy. This workshop uses OCI Resource Analytics, the Resource Analytics-provisioned Oracle Autonomous AI Database, Oracle APEX, and OCI Generative AI to build an agentic operations assistant.

[**Resource Analytics**](https://www.oracle.com/manageability/resource-analytics/) provides near real-time information to enhance visibility across IT infrastructure. In this workshop, Resource Analytics becomes the primary data foundation for the Wingmate application.

The workshop is designed to help you build an app from multiple data sources:

* Resource Analytics tables and views for OCI inventory and operational context.
* Curated materialized views for APEX-ready access patterns.
* Synthetic flat files to support repeatable dashboard and assistant examples.
* Optional RESTful OCI API sources, such as Operations Insights endpoints.
* Optional ShowOCI exports after the data mapping is confirmed.

> **Note:** Wingmate is not an Oracle-branded product. In this workshop, Wingmate is the application pattern you build with Oracle APEX, OCI Resource Analytics, Oracle Database 26ai capabilities, and OCI Generative AI.

![navigate home buttons](./images/cover-page.png "")

Using natural language to query tenancy information makes operations oversight easier.

![navigate home buttons](./images/cover-page-2.png "")

Using the features of a converged database allows deeper insights into how resources depend on each other. For example, databases, compute resources, network components, and storage relationships can be explored through dashboard, assistant, and graph-style views.

![navigate home buttons](./images/cover-page-3.png "")

Visualize resources from an interactive experience.

![navigate home buttons](./images/cover-page-4.png "")

> **NOTE:** Your tenancy must be subscribed to the **US Midwest (Chicago), US-Phoenix-1, or US-Ashburn-1** region in order to run this workshop. See the [OCI documentation](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingregions.htm) for more details.

### What is Generative AI?

Generative AI enables users to quickly generate new content based on a variety of inputs. Inputs and outputs to these models can include text, images, sounds, animation, 3D models, and other types of data.

### What is Natural Language?

Natural language processing is the ability of a computer application to understand human language as it is spoken and written. It is a component of artificial intelligence (AI). This workshop uses natural language interactions to query and explain OCI operational data through Wingmate agents.

Estimated Workshop Time: 2 hours 45 minutes

### Objectives

In this workshop, you will learn how to:

* Provision OCI Resource Analytics and prepare Wingmate data
* Build an Agentic Operations Wingmate with Oracle APEX and OCI Generative AI
* Build a Security Wingmate Agent
* Build a Multicloud Wingmate Agent
* Build a Compute Wingmate Agent with Resource Analytics metadata and OCI compute metrics

### Prerequisites

* An OCI cloud account
* Subscription to the US Midwest (Chicago), US-Ashburn-1, or US-Phoenix-1 region
* Permissions to configure Resource Analytics prerequisites and provision Resource Analytics
* Basic database and SQL knowledge
* Familiarity with Oracle Cloud Infrastructure (OCI)
* Familiarity with REST services is helpful for optional data-source tasks

You may now **proceed to the next lab**.

## Learn more

* [Oracle Autonomous Database Documentation](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/index.html)
* [Additional Autonomous Database Tutorials](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/tutorials.html)
* [Overview of Generative AI Service](https://docs.oracle.com/en-us/iaas/Content/generative-ai/overview.html)
* [Resource Analytics Product Page](https://www.oracle.com/manageability/resource-analytics/)
* [Resource Analytics Compute Data Model Reference](https://docs.oracle.com/en-us/iaas/Content/resource-analytics/reference-compute.htm)

## Acknowledgements

* **Authors:**
	* Nicholas Cusato - Cloud Architect
	* Royce Fu - Master Principal Cloud Architect
* **Last Updated by/Date** - Royce Fu, May 2026
