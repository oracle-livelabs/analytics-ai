# Introduction

## About this Workshop

Welcome to **Lakehouse Analytics with AI Data Platform**!  
This hands-on workshop guides you through building a modern data analytics pipeline on Oracle Cloud using **Oracle AI Data Platform** (AIDP), **Autonomous AI Lakehouse**, and **Oracle Analytics Cloud** (OAC). You will experience the full "lakehouse" pattern: extracting transactional data from a source system, ingesting, transforming, and analyzing airline operations data step by step.

You'll learn how to:
- Set up a transactional source system with sample airline data
- Extract and process data through bronze, silver, and gold layers in AIDP
- Publish curated gold data to Autonomous AI Lakehouse
- Visualize insights and KPIs in OAC dashboards

> **Estimated Workshop Time:** 3 hours

---

### Objectives

By completing this workshop, you will:
- Understand key lakehouse architecture principles using Oracle Cloud services
- Set up a transactional source (ATP) and extract data
- Build ETL (Extract, Transform, Load) pipelines with Spark and Delta Lake in **AI Data Platform**
- Prepare and publish analytics-ready data to **Autonomous AI Lakehouse**
- Design data visualizations and dashboards with **Oracle Analytics Cloud** (OAC)

**Architecture Overview:**  
![Lakehouse Architecture Diagram](images/ai-lakehouse-aidp-2.png)

**Key Oracle Services Touched:**
* **Autonomous Transaction Processing (ATP):** Transactional source for operational data
* **AI Data Platform:** Modern data engineering, Spark/Delta-based ETL, AI/ML-ready platform
* **Autonomous AI Lakehouse:** Fast, secure, and scalable analytics/lakehouse SQL
* **Oracle Analytics Cloud:** Interactive dashboards and self-service analytics
* **Object Storage:** Landing zone for raw data files

---

### Prerequisites

This workshop assumes you have:
- An Oracle Cloud account or lab credentials
- Access to **Autonomous Transaction Processing (ATP)**, **Oracle AI Data Platform** (AIDP), **Autonomous AI Lakehouse**, **Analytics Cloud** (OAC), **Generative AI** and **Object Storage** in your tenancy/region
- Familiarity with databases and basic data/analytics concepts (helpful, but not required)
- Basic comfort with navigating web-based Oracle Cloud interfaces

---

### Lab Sequence

- **Lab 1: Set Up Source System and Extract Transactional Data** - Provision ATP, create source schema, load sample data.
- **Lab 2: Process and Refine Data in AI Data Platform and Lakehouse** - Extract from ATP, process in AIDP, publish to AI Lakehouse gold schema.
- **Lab 3: Gather Insights with Oracle Analytics Cloud (OAC)** - Connect to gold schema and build visualizations.

---

## Learn More

* [Overview of Oracle AI Data Platform (AIDP)](https://docs.oracle.com/en/cloud/paas/ai-data-platform/aidug/introduction-oracle-ai-data-platform.html#GUID-24F65368-D399-4680-8D05-A0FD6B82F99F)
* [What is Autonomous AI Data Lakehouse?](https://docs.oracle.com/en/cloud/paas/autonomous-database/serverless/index.html)
* [What is Oracle Analytics Cloud?](https://docs.oracle.com/en/cloud/paas/analytics-cloud/)
* [Apache Spark Documentation](https://spark.apache.org/docs/latest/sql-ref-syntax.html#dml-statements)
* [Delta Lake Documentation](https://docs.delta.io/latest/delta-update.html)

---

## Acknowledgements

**Authors**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform

**Contributors**
* **Enjing Li**, Senior Cloud Engineer, ONA Data Platform

**Last Updated By/Date:**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform, November 2025
