# Introduction

## 

## Task 1: About this Workshop

The workshop focuses on demonstrating how Oracle Manufacturing Lakehouse helps the business in monitoring the Operational matrices and optimizing the supply chain using the Out of the box AI and ML capabilities of OCI. The Workshop has been designed to get a hands-on experience in Manufacturing Lakehouse and learn to leverage the next-age OCI AI/ML services for customer demonstrations, designing POC and as an implementation accelerator for MY SQL Heatwave Lakehouse.

A data Lakehouse is a modern, open architecture that enables you to store, understand, and analyze all your data. It combines the power and richness of data warehouses with the breadth and flexibility of the most popular open-source data technologies you use today. A data Lakehouse can be built from the ground up on Oracle Cloud Infrastructure (OCI) to work with the latest AI frameworks and prebuilt AI services like Oracle’s language service.

Estimated Workshop Time: 6 Hours

## Task 2: About MySQL Heatwave Lakehouse

**MySQL HeatWave Lakehouse** allows you to query data in object storage, MySQL databases, or a combination of both with record speed—and automatically build, train, run, and explain machine learning (ML) models. It’s available on Oracle Cloud Infrastructure (OCI), Amazon Web Services (AWS), and Microsoft Azure.

## Task 3: How It Works

HeatWave is a distributed, scalable, shared-nothing, in-memory, hybrid columnar, query processing engine designed for extreme performance. It is enabled when you add a HeatWave cluster to a MySQL DB System. To know more about [HeatWave Cluster]("https://www.oracle.com/in/mysql/lakehouse/")

MySQL HeatWave Lakehouse processes data in a variety of file formats, such as CSV, Parquet, Avro, and exports from other databases. You can query data in object storage and, optionally, combine it with transactional data in MySQL databases. Applications can use large language models to interact with HeatWave Lakehouse in natural language. Data loaded into the HeatWave cluster for processing is automatically transformed into the HeatWave in-memory format, and object storage data is not copied to the MySQL database. You can also take advantage of HeatWave AutoML, a built-in feature that automates the pipeline to build, train, deploy, and explain ML models using data in object storage, the database, or both. No need to move the data to a separate ML cloud service. No need to be an ML expert.

**HeatWave Architecture**

  ![heatwave](images/architectturehw.png)


## Task 4: Objectives

In this workshop, you will learn how to:
* Develop end to end OCI modern data platform using MYSQL HW .
* Provision OCI Streaming Service and OCI Connector Hub - for ingesting streaming work loads .
* Dvelop and deploy Machine Learning Model using OCI Data science .
* Provision OCI Functions .
* Provision HeatWave cluster on OCI .
* Provision OCI Data FLow for bulk data inserts .
* Load Sample data into HeatWave Cluster .
* Provision Oracle Analytics Cloud and build Dashbaords .
* Provision OCI Data Catalog .


## Task 5: Prerequisites

This lab assumes you have:
* You have an Oracle account.
* You have one Compute instance having (https://dev.mysql.com/doc/mysql-shell/8.0/en/mysql-shell-install.html) installed on it.

## Task 6: Livelab Files location

 Download [`MYSQLLakehouse_labfiles.zip`](https://objectstorage.us-ashburn-1.oraclecloud.com/p/RPka_orWclfWJmKN3gTHfEiv-uPckBJTZ3FV0sESZ3mm3PDCQcVDCT-uM2dsJNGf/n/orasenatdctocloudcorp01/b/MYSQLLakehouse_labfiles/o/MYSQLLakehouse_labfiles.zip) and save to a folder on your laptop or workstation.
 
## Acknowledgements

- **Author** - Perside Foster, MySQL Solution Engineering
- **Contributors** - Abhinav Agarwal, Senior Principal Product Manager, Nick Mader, MySQL Global Channel Enablement & Strategy Manager
- **Last Updated By/Date** - Perside Foster, MySQL Solution Engineering, May 2023