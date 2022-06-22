# Introduction

## About This Workshop

In this workshop, you'll create a load balancer that can be used as a front end for securely accessing Cloudera Manager, Hue, and Oracle Data Studio on your highly-available (HA) Big Data Service cluster.

(If you want to create a load balancer for a non-HA cluster, see the [Use a Load Balancer to Access Services on Big Data Service (non-HA Cluster)](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=811) workshop.)  

Typically, a load balancer is used to spread workloads across multiple mirrored servers (for example, cluster nodes), to optimize resource usage and to ensure high-availability (HA). However, in this lab you'll use a load balancer to direct traffic to multiple ports on just two Big Data Service nodes.

One advantage of using a load balancer is that you can configure it to use the Secure Sockets Layer (SSL) protocol to secure traffic to and from the services on your cluster. SSL uses digital certificates and keys to encrypt and decrypt transmitted data, to ensure the identities of the sender and the receiver of data, and to sign the data to verify its integrity.  In this workshop, you'll implement end-to-end SSL, which means that the load balancer will accept SSL encrypted traffic from clients and encrypt traffic to the cluster.

When you complete this workshop, you'll be able to open Cloudera Manager, Hue, and Oracle Data Studio by using the IP address (or hostname) of the load balancer, plus the port number on which each service listens (regardless of cluster node). For example, if the IP address of the load balancer is `203.0.113.1`, and Cloudera Manager listens on port `7183`, you can open Cloudera Manager by entering `https://203.0.113.1:7183` in your web browser. Hue listens on port `8889`, so you can open Hue by entering `https://203.0.113.1:8889`.

Estimated workshop time: 2 hours, if you've already created the environment and cluster, as explained in [Prerequisites](#prerequisites), below.

### Objectives

In this workshop, you will:

* Create an Oracle Cloud Infrastructure load balancer for an existing HA Big Data Service cluster.

* Configure the load balancer to function as a front end for connecting to Cloudera Manager, Hue, and Big Data Studio on the cluster.

* Implement end-to-end SSL encryption for the load balancer by using the self-signed SSL certificates included with the cluster.

### Prerequisites

* This workshop requires an **Oracle Cloud account**. For the HA cluster that this workshop requires, you must use your own cloud account. See [Oracle Cloud Infrastructure](https://www.oracle.com/cloud/).

* Any operating system command shell containing **Secure Shell (SSH)** and **Secure Copy (SCP)**. You can also use the open source PuTTY network file transfer application. See PuTTY documentation for instructions.

  This workshop assumes you're using a recent installation of Windows, such as Windows 10, which includes Windows PowerShell, `ssh`, and `scp`.  

  * An **Oracle Cloud Infrastructure environment** with a **Virtual Cloud Network (VCN)**, a **public subnet**, the appropriate **security rules** for creating a load balancer, and a **Big Data Service HA cluster**. The fastest way to set up the environment for this workshop is to complete the [Getting Started with Oracle Big Data Service (HA Cluster)](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=674&session=3565379308288)  workshop. You can complete the entire workshop if you want, but you must complete at least the following labs:

    * **Lab 1: Set Up Your BDS Environment**
    * **Lab 2: Create a BDS Hadoop Cluster**
    * **Lab 4: Access a BDS Node Using a Public IP Address**

    Once you've completed those labs, you can start with [STEP 1: Gather Information](#Step1:GatherInformation), below. (But first, be sure to read the Workshop Overview, below.)

If you choose ***not*** to complete the [Getting Started with Oracle Big Data Service (HA Cluster)](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=674&session=3565379308288) workshop, you must create and configure:

* An **HA Oracle Big Data Service cluster** running in a **VCN** with an internet gateway and a public regional subnet (for a public load balancer). See [Set Up Oracle Cloud Infrastructure for Oracle Big Data Service](https://docs-uat.us.oracle.com/en/cloud/paas/big-data-service/user/set-oracle-cloud-infrastructure-oracle-big-data-service.html) and [Create a Cluster](https://docs.oracle.com/en/cloud/paas/big-data-service/user/create-cluster.html) in *Using Big Data Service*.

* **Security rules** that allow incoming traffic on the ports where services run in the cluster: Cloudera Manager (port 7183), Hue (port 8889), and Big Data Studio (port 30000). See [Create Ingress Rules \(Open Ports\)](https://docs.oracle.com/en/cloud/paas/big-data-service/user/define-security-rules.html#GUID-CE7BE686-4047-4DAA-BCE7-3B46BABC321F) in *Using Big Data Service*.

* **Administrative access** to manage load balancers.  See "Let network admins manage load balancers" in [Common Policies](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Concepts/commonpolicies.htm) in the Oracle Cloud Infrastructure documentation.

* An **SSH key pair**. The SSH key pair must include the private key that was associated with the cluster when it was created. See [Create a Cluster](https://docs.oracle.com/en/cloud/paas/big-data-service/user/create-cluster.html) in *Using Big Data Service*.

* **Access to the cluster file system** (via SSH). You must be able to connect directly to the first and second utility nodes of your cluster. To do this, prior to creating a load balancer, you must set up your environment to allow that access. For example you can use Oracle FastConnect or Oracle IpSec VPN, you can set up a bastion host, or you can map private IPs to public IP addresses. See  [Establish Connections to Nodes with Private IP Addresses](https://docs.oracle.com/en/cloud/paas/big-data-service/user/establish-connections-nodes-private-ip-addresses.html) in *Using Big Data Service*.

### Workshop Overview

| STEP  | Task |
| --- | --- |
| [1](#Step1:GatherInformation) | Gather information you'll need for subsequent steps in this lab: <br/> - the ***SSH file*** associated with your cluster<br/> - the ***private IP address*** of the ***first*** utility node in the cluster<br/> - the ***public IP address*** of the ***first*** utility node in the cluster<br/> - the ***private IP address*** of the ***second*** utility node in the cluster<br/> - the ***public IP address*** of the ***second*** utility node in the cluster |
| [2](#Step2:CopySSLCertificatesfromtheCluster) | Download the ***SSL certificate*** and ***key*** files from the first and second utility nodes of your cluster.  <br/><br/>**Note:** For highest security on a production system, you should obtain certificates from a trusted SSL certificate authority like IdenTrust or DigiCert. However, Big Data Service includes certificate and key files which you can use for learning and testing. (The certificates are self-signed, which means that the certificates aren't issued by a trusted certificate authority.) |
| [3](#Step3:CreatetheLoadBalancer) | a. Create the ***load balancer***. <br/><br/>b. Create a ***backend set*** for Cloudera Manager. A backend set routes incoming traffic to the specified target(s), checks the health of the server, and optionally uses SSL to encrypt traffic. You'll complete the configuration of this backend set in STEP 5. <br/><br/>c. Create a ***listener*** for Cloudera Manager. A listener is an entity that checks for incoming traffic on the load balancer's IP address. You'll complete the configuration of this listener in STEP 11. |
| [4](#Step4:CreateaCertificateBundle) | Create ***certificate bundles*** from the SSL certificates and keys you downloaded from your cluster in STEP 2. <br/><br/>You'll create one bundle with the files downloaded from the first utility node (for Cloudera Manager) and another bundle with the files downloaded from the second utility node (for Hue and Data Studio). In later steps, you'll apply these bundles to your backend sets and listeners, to implement SSL for the load balancer. |
| [5](#Step5:ConfiguretheBackendSetforClouderaManager) | Complete the configuration of the ***backend set*** you created in STEP 3, for Cloudera Manager. You'll apply the first certificate bundle you created in STEP 4 here. |
| [6](#Step6:CreateaBackendSetforHue) | Create and configure the ***backend set*** for Hue. |
| [7](#Step7:CreateaBackendSetforBigDataStudio) | Create and configure the ***backend set*** for Oracle Data Studio. |
| [8](#Step8:AddaBackendServerforClouderaManager) | Add a ***backend server*** to the backend set you created for Cloudera Manager in STEP 3. <br/><br/>Backend servers receive incoming TCP or HTTP traffic and generate content in reply. For this load balancer, you'll use two backend servers: the first utility node of your cluster (where Cloudera Manager runs) and the second utility node (where Hue and Data Studio  run). |
| [9](#Step9:AddaBackendServerforHue) | Add the ***backend server*** for Hue.|
| [10](#Step10:AddaBackendServerforBigDataStudio) | Add the ***backend server*** for Data Studio. |
| [11](#Step11:ConfiguretheListenerforClouderaManager) | Complete the configuration of the ***listener*** for Cloudera Manager, which you created in STEP 3.  You'll apply the second certificate bundle you created in STEP 4 here. |
| [12](#Step12:CreateaListenerforHue) | Create and configure a ***listener*** for Hue. |
| [13](#Step13:CreateaListenerforBigDataStudio) | Create and configure a ***listener*** for Big Data Studio. |
| [14](#Step14:AccesstheCluster) | Access Cloudera Manager, Hue, and Data Studio by using the IP address assigned to the load balancer, appended by the port number for the service. |

**Note:** If you want to use SSL certificates from a trusted certificate authority, see [Use a Load Balancer to Connect to Services on a Cluster](https://docs.oracle.com/en/cloud/paas/big-data-service/user/use-load-balancer-connect-cluster.html) in *Using Big Data Service*.

You may now [proceed to the next lab](#next).

## Acknowledgements

* **Last Updated Date:** April 2021
