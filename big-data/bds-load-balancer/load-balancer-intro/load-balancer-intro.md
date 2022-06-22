# Introduction

## About This Workshop

You'll create a load balancer that can be used as a front end for securely accessing Cloudera Manager, Hue, and Oracle Data Studio on your non highly available (HA) Big Data Service cluster.  

If you want to create a load balancer for a HA cluster, see the [Use a Load Balancer to Access Services on Big Data Service (HA Cluster)](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=810) workshop.

Typically, a load balancer is used to spread workloads across multiple mirrored servers (for example, cluster nodes), to optimize resource usage and to ensure high-availability. However, in this workshop you'll use a load balancer to direct traffic to multiple ports on a single Big Data Service node.

One advantage of using a load balancer is that you can configure it to use the Secure Sockets Layer (SSL) protocol to secure traffic to and from the services on your cluster. SSL uses digital certificates and keys to encrypt and decrypt transmitted data, to ensure the identities of the sender and the receiver of data, and to sign the data to verify its integrity.  In this workshop, you'll implement end-to-end SSL, which means that the load balancer will accept SSL encrypted traffic from clients and encrypt traffic to the cluster.

When you complete this workshop, you'll be able to open Cloudera Manager, Hue, and Oracle Data Studio by using the IP address (or hostname) of the load balancer, plus the port number on which each service listens. For example, if the IP address of the load balancer is `203.0.113.1`, and Cloudera Manager listens on port `7183`, you can open Cloudera Manager by entering `https://203.0.113.1:7183` in your web browser. Hue listens on port `8889`, so you can open Hue by entering `https://203.0.113.1:8889`.

Estimated time: 90 minutes, if you've already created the environment and cluster, as explained in [Prerequisites](#prerequisites), below.

### Objectives

In this workshop, you will:

* Create an Oracle Cloud Infrastructure (OCI) load balancer for an existing non-HA Big Data Service cluster.

* Configure the load balancer to function as a front end for connecting to Cloudera Manager, Hue, and Big Data Studio on the cluster.

* Implement end-to-end SSL encryption for the load balancer by using the self-signed SSL certificates included with the cluster.

### Prerequisites

* This workshop requires an **Oracle Cloud account**. You may use your own cloud account or you can get a Free Trial account as described in the **Get Started** workshop in the **Contents** menu on the left side of this page.

* Any operating system command shell containing **Secure Shell (SSH)** and **Secure Copy (SCP)**. You can also use the open source PuTTY network file transfer application. See PuTTY documentation for instructions.

* This workshop assumes you're using a recent installation of Windows, such as Windows 10, which includes Windows PowerShell, `ssh`, and `scp`.  

  * An **Oracle Cloud Infrastructure environment** with a **virtual cloud network (VCN)**, a **public subnet**, the appropriate **security rules** for creating a load balancer, and a **Big Data Service non-HA cluster**. The fastest way to set up the environment for this workshop is to complete the [Getting Started with Oracle Big Data Service (Non-HA Cluster)](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=762&session=3565379308288) workshop. You can complete the entire workshop if you want, but you must complete at least the following labs:

    * **Set Up Your BDS Environment**
    * **Create a BDS Hadoop Cluster**
    * **Access a BDS Node Using a Public IP Address**

    Once you've completed those labs, you can start with TASK 1: Gather Information. (But first, be sure to read the overview)

* If you choose *not* to complete the [Getting Started with Oracle Big Data Service (Non-HA Cluster)](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=762&session=3565379308288) workshop, you must create and configure:

  * A **non-HA Oracle Big Data Service cluster** running in a **VCN** with an internet gateway and a public regional subnet (for a public load balancer). See [Set Up Oracle Cloud Infrastructure for Oracle Big Data Service](https://docs-uat.us.oracle.com/en/cloud/paas/big-data-service/user/set-oracle-cloud-infrastructure-oracle-big-data-  service.html) and [Create a Cluster](https://docs.oracle.com/en/cloud/paas/big-data-service/user/create-cluster.html) in *Using Big Data Service*.

  * **Security rules** that allow incoming traffic on the ports where services run in the cluster: Cloudera Manager (port 7183), Hue (port 8889), and Big Data Studio (port 30000). See [Create Ingress Rules \(Open Ports\)](https://docs.oracle.com/en/cloud/paas/big-data-service/user/define-security-rules.html#GUID-CE7BE686-4047-4DAA-BCE7-3B46BABC321F) in *Using Big Data Service*.

  * **Administrative access** to manage load balancers.  See "Let network admins manage load balancers" in [Common Policies](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Concepts/commonpolicies.htm) in the Oracle Cloud Infrastructure documentation.

  * An **SSH key pair**: The SSH key pair must include the private key that was associated with the cluster when it was created. See [Create a Cluster](https://docs.oracle.com/en/cloud/paas/big-data-service/user/create-cluster.html) in *Using Big Data Service*.

* **Access to the cluster file system** (via SSH): You must be able to connect directly to the first utility node of your cluster. To do this, prior to creating a load balancer, you must set up your environment to allow that access. For example you can use Oracle FastConnect or Oracle IpSec VPN, you can set up a bastion host, or you can map private IPs to public IP addresses. See  [Establish Connections to Nodes with Private IP Addresses](https://docs.oracle.com/en/cloud/paas/big-data-service/user/establish-connections-nodes-private-ip-addresses.html) in *Using Big Data Service*.

**Note:** If you want to use SSL certificates from a trusted certificate authority, see [Use a Load Balancer to Connect to Services on a Cluster](https://docs.oracle.com/en/cloud/paas/big-data-service/user/use-load-balancer-connect-cluster.html) in *Using Big Data Service*.

## Acknowledgements

* **Last Updated Date:** April 2021
