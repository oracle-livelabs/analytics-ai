# Workshop Introduction and Overview

The labs in this workshop walk you through all the steps to get started using **Oracle Big Data Service (BDS)**.

Estimated Workshop Time: 6 hours

## What is Oracle Big Data Service?

**Oracle Big Data Service (BDS)** provides enterprise-grade Hadoop as a service, with end-to-end security, high performance, and ease of management and upgradeability.

BDS is an Oracle Cloud Infrastructure service designed for a diverse set of big data use cases and workloads. From short-lived clusters used to tackle specific tasks to long-lived clusters that manage large data lakes, BDS scales to meet an organization’s requirements at a low cost and with the highest levels of security. It includes :

* Choice of distribution of hadoop Oracle Distribution of Hadoop(ODH) or Cloudera Distribution of Hadoop (CDH) .
* Offers a range of Hadoop technology stack including HDFS, Yarn and other Open source Apache service such Kafka, Flink, and Spark.
* Highly secure and highly available clusters provisioned in minutes.
* Expand on premise Hadoop; deploy test and development to the cloud.
* Any scale using high performance bare metal or cost effective virtual machine (VM) shapes.
* End-to-end data management; use with Autonomous Database, Analytics Cloud, OCI Streaming, OCI Data Catalog, OCI Data Science, and OCI Data Flow.
* Use Oracle SQL to query across Hadoop, Object Stores, Kafka, and NoSQL with Cloud SQL.

Watch our short video that explains key features in Oracle Big Data Service:

[](youtube:CAmaIGKkEIE)

## Workshop Objectives

- Prepare for using Oracle Big Data Service (BDS).
- Create a Highly-Available (HA) BDS cluster using Oracle Distribution including Apache Hadoop(ODH) from the Oracle Cloud Infrastructure Console (OCI).
- Add Cloud SQL to the cluster and maintain your cluster.
- Access a BDS utility node using a public IP address.
- Use Ambari and Hue to access a Big Data Service (BDS) cluster and add ingress rules to the default security rule that enables you to access both Ambari and Hue.
- Map the private IP address of the first master node in your cluster to a new public IP address to make this node publicly available on the internet and create a Hadoop Administrator user.
- Upload data from your master node in your cluster to new HDFS directories and new object storage buckets.

## Lab Breakdown

- **Lab 1:** Prepare your Big Data Service Environment
- **Lab 2:** Create a BDS Hadoop Cluster
- **Lab 3:** Add Oracle Cloud SQL to the Cluster
- **Lab 4:** Access a BDS Utility Node Using a Public IP Address
- **Lab 5:** Use Ambari and Hue to Access a BDS Cluster
- **Lab 6:** Create a Hadoop Administrator User
- **Lab 7:** Upload Data to Hadoop Distributed File System and Object Storage
- **Lab 8:** Clean up Resources Used in this Workshop (Optional)

## Workshop Prerequisites

This workshop requires an Oracle Cloud account. You may use your own cloud account or you can get a Free Trial account as described in the **Getting Started** lab in the **Contents** menu.

*Note: If you have a **Free Trial** account, when your Free Trial expires your account will be converted to an **Always Free** account. You will not be able to conduct Free Tier workshops unless the Always Free environment is available. **[Click here for the Free Tier FAQ page.](https://www.oracle.com/cloud/free/faq.html)***

**Notes:**

+ For more information about service limits, see [Service Limits](https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/servicelimits.htm) in the Oracle Cloud Infrastructure documentation.
+ To submit a request to increase your service limits, see [Requesting a Service Limit Increase](https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/servicelimits.htm#Requesti) in the Oracle Cloud Infrastructure documentation.

You are all set to begin the labs in this workshop! Click **Lab 1: Set Up the BDS Environment** in the **Contents** menu.

## Want to Learn More About Oracle Big Data Service?

Use the following links to get more information about BDS and OCI:

* [Using Oracle Big Data Service](https://docs.oracle.com/en/cloud/paas/big-data-service/user/index.html)
* [Oracle Cloud Infrastructure Documentation](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
* [Overview of Oracle Cloud Infrastructure Identity and Access Management (IAM)](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Concepts/overview.htm)
* [Oracle Cloud Infrastructure Self-paced Learning Modules](https://www.oracle.com/cloud/iaas/training/foundations.html)
* [Overview of Compute Service](https://www.oracle.com/pls/topic/lookup?ctx=cloud&id=oci_compute_overview)
* [VCN and Subnets](https://docs.cloud.oracle.com/iaas/Content/Network/Tasks/managingVCNs.htm)

## Acknowledgements

* **Author:**

  * Anand Chandak, Principal Product Manager, Big Data Services
  * Justin Zou, Principal Data Engineer,Japan & APAC Hub
* **Last Updated By/Date:** Justin Zou, March 2023
