# Create a BDS Hadoop Cluster

## Introduction

In this lab, you will learn how to create a Highly-Available (HA) Oracle Distribution including Apache Hadoop(ODH) cluster using the Oracle Cloud Infrastructure Console (OCI) and Big Data Service (BDS). This will be a small development cluster that is not intended to process huge amounts of data. It will be based on small Virtual Machine (VM) shapes that are perfect for developing applications and testing functionality at a minimal cost.

Estimated Lab Time: 60 minutes

### Objectives

* Create an HA Hadoop cluster using BDS and OCI.
* Monitor the cluster creation and the cluster and nodes metrics.
* Review the locations of the various services in the cluster.

### What Do You Need?

This lab assumes that you have successfully completed **Lab 1: Setup the BDS Environment** in the **Contents** menu.

### Video Preview

Watch a video demonstration of creating a simple non-HA Hadoop cluster:

[](youtube:zpASc1xvKOY)

## Prerequisites

If you want to use the bootstrap script to create the BDS cluster, please config the bootstrap and upload the bootstrap to object storage.

### Prepare the bootstrap

When you create BDS cluster, you can use the Bootstrap script to install, configure , and manage custom components in a cluster. You can config the following parameter in YARN and Hive:
yarn.scheduler.maximum-allocation-mb:4096
yarn.scheduler.maximum-allocation-vcores:2
hive.server2.tez.sessions.per.default.queue:8

You can add the custom parameter of YARN between #`<START>` and #`<END>` as following:

```
#<START>

CONFIG_FILE_TO_UPDATE="yarn-site" #this is the file we're updating in this example
propObj=$(get_property_json)
echo "calling add properties YARN"

#update key value pairs. Multiple key value pairs can be updated before doing update_ambari_config
#add_properties "dfs.namenode.https-bind-host" "0.0.0.0"    #example of how to add properties
#add_properties "fs.gs.path.encoding" "uri-path"    #example of how to add properties
add_properties "yarn.scheduler.maximum-allocation-mb" "4096"
add_properties "yarn.scheduler.maximum-allocation-vcores" "2"

#Update it to ambari
echo "updating ambari config for YARN"
update_ambari_config

#<END>
```

You can add the custom parameter of  Hive between #`<START>` and #`<END>`  as following:

```

#<START>

CONFIG_FILE_TO_UPDATE="hive-site" #this is the file we're updating in this example
propObj=$(get_property_json)
echo "calling add properties Hive"

#update key value pairs. Multiple key value pairs can be updated before doing update_ambari_config
#add_properties "dfs.namenode.https-bind-host" "0.0.0.0"    #example of how to add properties
#add_properties "fs.gs.path.encoding" "uri-path"    #example of how to add properties
add_properties "hive.server2.tez.sessions.per.default.queue" "8"

#Update it to ambari
echo "updating ambari config Hive"
update_ambari_config

#<END>

```

You can download the [odh_bootstrap_update_config.sh](https://objectstorage.us-ashburn-1.oraclecloud.com/p/zgSEUmDpIiWGLgbhGvwWMoQrhu5hBRsnAsAE0ox4mMM7iIc8yFmjc22qyqWaL4d0/n/hktwlab/b/training-bucket/o/odh/odh_bootstrap_update_config.sh).

### Upload the bootstrap script to object storage

You can create the bucket and upload the bootstrap script to it. Following are the steps:

1. Log in to the **Oracle Cloud Console** as the Cloud Administrator that you used so far in this workshop. On the **Sign In** page, select your `tenancy`, enter your `username` and `password`, and then click **Sign In**. The **Oracle Cloud Console** Home page is displayed.
2. Click the **Navigation** menu and navigate to **Storage > Buckets.**

  ![](./images/02-create-bucket-navigate.png " ")

3. On the **Buckets** page, click **Create Bucket**.

   ![1679373227858](image/create-cluster/1679373227858.png)

4.At the **Create Bucket** wizard, provide the Bucket details as follows:

·**Bucket Name:**  **traning-bucket** .

·**Default Storage Tier:** choose **Standard** .

![1679373281418](image/create-cluster/1679373281418.png)

5.Click the“**Create**” button, then there have “training-bucket” list as below:

![1679373313672](image/create-cluster/1679373313672.png)

6.Click the “training-bucket”, it will display the bucket details.

![1679383883802](image/create-cluster/1679383883802.png)

7.Navigate to  **Objects** >**Create New Folder**

![1679383896957](image/create-cluster/1679383896957.png)

8.In the “**Create New Folder**”page ,set the Name as “**odh**” as below:

![1679383915160](image/create-cluster/1679383915160.png)

![1679383933518](image/create-cluster/1679383933518.png)

9.Click “**odh**” folder and Upload the bootstrap shell file.

![1679383965557](image/create-cluster/1679383965557.png)

Select files from you local machine, and upload the odh_bootstrap_update_config.sh.

![1679383981205](image/create-cluster/1679383981205.png)

10.Click “**Upload**”button, there will bootstrap file list.

![1679384020554](image/create-cluster/1679384020554.png)

11. Right click the bootstrap file, and click “**Create Pre-Authenticated Request**”.

![1679384037317](image/create-cluster/1679384037317.png)

![1679384046583](image/create-cluster/1679384046583.png)

12.Click the“**Create Pre-Authenticated Request**” button to finish it. There will have
Pre-Authenticated Request Details page display. And Copy the Pre-Authenticated Request URL. You can use this URL in the **Task 1: Create a cluster 's step 10**.

![1679384077000](image/create-cluster/1679384077000.png)

Here is the URL sample:

[odh_bootstrap_update_config.sh](https://objectstorage.us-ashburn-1.oraclecloud.com/p/zgSEUmDpIiWGLgbhGvwWMoQrhu5hBRsnAsAE0ox4mMM7iIc8yFmjc22qyqWaL4d0/n/hktwlab/b/training-bucket/o/odh/odh_bootstrap_update_config.sh)

## Task 1: Create a Cluster

There are many options when creating a cluster. You will need to understand the sizing requirements based on your use case and performance needs. In this lab, you will create a small testing and development cluster that is not intended to process huge amounts of data. It will be based on small Virtual Machine (VM) shapes that are perfect for developing applications and testing functionality at a minimal cost. See [Compute Shapes](https://docs.cloud.oracle.com/en-us/iaas/Content/Compute/References/computeshapes.htm#vm-dense) in the Oracle Cloud Infrastructure (OCI) documentation.

Your simple HA cluster will have the following profile:

+ **Nodes:** **2** Master nodes, **2** Utility nodes, and **3** Worker nodes.
+ **Master and Utility Nodes Shapes:** **VM.Standard2.4** shape for the Master and Utility nodes. This shape provides **4 CPUs** and **60 GB** of memory.
+ **Worker Nodes Shape:** **VM.Standard2.1** shape for the Worker nodes in the cluster. This shape provides **1 CPU** and **15 GB** of memory.
+ **Storage Size:** **150 GB** block storage for the Master, Utility, and Worker nodes.

  ![](./images/cluster-layout.png " ")

Create the HA cluster as follows:

1. Log in to the **Oracle Cloud Console** as the Cloud Administrator that you used so far in this workshop. On the **Sign In** page, select your `tenancy`, enter your `username` and `password`, and then click **Sign In**. The **Oracle Cloud Console** Home page is displayed.
2. Click the **Navigation** menu and navigate to **Analytics & AI > Big Data Service**.

  ![](./images/big-data.png " ")

3. On the **Clusters** page, click **Create Cluster**.

  ![](./images/clusters-page.png " ")

4. At the top of the **Create Cluster** wizard, provide the cluster details as follows:

   * **Cluster Name:** **`training-cluster`**.
   * **Cluster Admin Password:** Enter a `cluster admin password` of your choice such as **`Training#123`**. You'll need this password to sign into Ambari and to perform certain actions on the cluster through the Cloud Console.
   * **Confirm Cluster Admin Password:** Confirm your password.
   * **Secure & Highly Available (HA):** Select this checkbox, if not already selected, to make the cluster secure and highly available. A secure cluster has the full Hadoop security stack, including HDFS Transparent Encryption, Kerberos, and Apache Sentry. This setting can't be changed for the life of the cluster.
   * **Cluster Version:** This read-only field displays the latest version of ODH that is available to Oracle which is deployed by BDS.

   ![1679391052145](image/create-cluster/1679391052145.png)
5. In the **Hadoop Nodes > Master/Utility Nodes** section, provide the following details:

   * **Choose Instance Type:** **`Virtual Machine`**.
   * **Choose Master/Utility Node Shape:** **`VM.Standard2.4`**. This is the minimum shape allowed for Master and Utility nodes.
   * **Block Storage Size Per Master/Utility Node (in GB):** **`150 GB`**.**Note:** **`150 GB`** is the minimum block storage size allowed for Master, Utility, and Worker nodes. For information on the supported cluster layout, shape, and storage, see [Plan Your Cluster](https://docs.oracle.com/en/cloud/paas/big-data-service/user/plan-your-cluster.html#GUID-0A40FB4C-663E-435A-A1D7-0292DBAC9F1D).
   * **Number of Master & Utility Nodes** _READ-ONLY_ **:** Since you are creating an HA cluster, this field shows **4** nodes: **2** Master nodes and **2** Utility nodes. For a non-HA cluster, this field would show only **2** nodes: **1** Master node and  **1** Utility node.

   ![img](./images/create-cluster-2.png " ")
6. In the **Hadoop Nodes > Worker Nodes** section, provide the following details:

   * **Choose Instance Type:** **`Virtual Machine`**.
   * **Choose Worker Node Shape:** **`VM.Standard2.1`**.  This is the minimum allowed shape for Worker nodes.
   * **Block Storage Size per Worker Node (in GB):** **`150 GB`**.
   * **Number of Worker Nodes:** **`3`**. This is the minimum allowed for a cluster.

   ![img](./images/create-cluster-3.png " ")
7. In the **Network Setting > Cluster Private Network** section, provide the following details:

   * **CIDR Block:** **`10.1.0.0/16`**. This CIDR block assigns the range of contiguous IP addresses available for the cluster's private network that BDS creates for the cluster. This private network is created in the Oracle tenancy and not in your customer tenancy. It is used exclusively for private communication among the nodes of the cluster. No other traffic travels over this network, it isn't accessible by outside hosts, and you can't modify it once it's created. All ports are open on this private network.

   **Note:** Use CIDR block **`10.1.0.0/16`** instead of the already displayed **`10.0.0.0/16`** CIDR block range. This avoids overlapping IP addresses since you already used the **`10.0.0.0/16`** CIDR block range for the **`training-vcn`** VCN that you created in **Lab 1**. A CIDR block of **`10.1.0.0/16`** provides you with **`65,536`** contiguous IP addresses, **`10.1.0.0`** to **`10.1.255.255`**. You can decrease the range of available IP addresses to free them for other uses by choosing a CIDR block such as **`10.1.0.0/24`**. This provides you with only **`256`** contiguous IP addresses, **`10.1.0.0`** to **`10.1.0.255`**.
8. In the **Network Setting > Customer Network** section, provide the following details:

   * **Choose VCN in `training-compartment`:** **`training-vcn`**. The VCN must contain a regional subnet.   **Note:** Make sure that **`training-compartment`** is selected; if it's not, click the _CHANGE COMPARTMENT_ link, and then search for and select your **`training-compartment`**.
   * **Choose Regional Subnet in `training-compartment`:** **`Public Subnet-training-vcn`**. This is the public subnet that was created for you when you created your **`training-vcn`** VCN in **Lab 1**.
   * **Networking Options:** **`DEPLOY ORACLE-MANAGED SERVICE GATEWAY AND NAT GATEWAY (QUICK START)`**. This simplifies your network configuration by allowing Oracle to provide and manage these communication gateways for private use by the cluster. These gateways are created in the Oracle tenancy and can't be modified after the cluster is created.

   **Note:** Select the **`USE THE GATEWAYS IN YOUR SELECTD CUSTOMER VCN (CUSTOMIZABLE)`** option if you want more control over the networking configuration.

   ![img](./images/create-cluster-4.png " ")
9. In the **Additional Options > SSH public key** section, associate a public Secure Shell (SSH) key with the cluster.

   Linux instances use an SSH key pair instead of a password to authenticate a remote user. A key pair file contains a private key and public key. You keep the private key on your computer and provide the public key when you create an instance. When you connect to the instance using SSH, you provide the path to the private key in the SSH command. Later in **Lab 6**, you will connect to your cluster's master node using the private SSH key that is associated with the public SSH key that you specify here for your cluster.

   **Note:** If you already have an existing public key, you can use it in this step; you don't have to create a new public key. If you need to create a new SSH key pair (using different formats), see the [Creating a Key Pair](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/creatingkeys.htm?Highlight=ssh%20key#CreatingaKeyPair) OCI documentation topic and the
   [Generate SSH key](https://oracle-livelabs.github.io/common/labs/generate-ssh-key/) lab.

   Specify an SSH public key using one of the following methods:

   * Select **Choose SSH key file**, and then either Drag and drop a public SSH key file into the box,
     or click **Select one...** and navigate to and choose a public SSH key file from your local file system.
   * Select **Paste SSH public key**, and then paste the contents from a public SSH key file into the box.

   **Note:** In this lab, we use our own SSH public key pair that we created using Windows **PuTTYgen** named `mykey.pub`. In **Lab 6**, we will connect to our cluster using Windows **PuTTY** and provide the SSH private key named `mykey.ppk` which is associated with our `mykey.pub` public key. If you create OpenSSH key pair using your Linux system or Windows PowerShell, you cannot use PuTTY to connect to your cluster; instead, you will need to use your Linux system or Windows PowerShell. PuTTY uses a different key file format than OpenSSH. To connect to your instance using SSH from a Unix-style system or from a Windows system using OpenSSH, see the [Connecting to Your Instance](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/testingconnection.htm?Highlight=connect%20to%20an%20instance%20using%20ssh) OCI documentation.

   ![img](./images/create-cluster-5.png " ")
10. (Optional)In the **Additional Options > Bootstrap script URL** section, should provide the bootstrap URL from Object Storage.

    You can can use the Bootstrap script to install, configure, and manage custom components in a cluster.
    ![img](./images/01-create-cluster-bootstrap.png " ")
11. Click **Create Cluster**. The **Clusters** page is re-displayed. The state of the cluster is initially **Creating**.

![img](./images/status-creating.png " ")

## Task 2: Monitor the Cluster Creation

The process of creating the cluster takes approximately one hour to complete; however, you can monitor the cluster creation progress as follows:

1. To view the cluster's details, click **`training-cluster`** in the **Name** column to display the **Cluster Details** page.

   ![](./images/status-creating.png " ")

   The **Cluster Information** tab displays the cluster's general and network information.

   ![](./images/cluster-details-page-2.png " ")

   The **List of cluster nodes** section displays the following information for each node in the cluster: Name, status, type, shape, private IP address, and date and time of creation.

   ![](./images/list-nodes.png " ")

   **Note:**
   The name of a node is the concatenation of the **first seven** letters of the cluster's name, **`trainin`**, followed by two letters representing the node type such as **`mn`** for a **Master** node, **`un`** for a **Utility** node, and **`wn`** for a **Worker** node. The numeric value represents the node type order in the list such as Worker nodes **`0`**, **`1`**, and **`2`**.

   ![](./images/cluster-nodes.png " ")
2. To view the details of a node, click the node's name link in the **Name** column. For example, click the **`traininmn0`** first Master node in the **Name** column to display the **Node Details** page.

   ![](./images/first-master-node.png " ")

   The **Node Information** tab displays the node's general and network information.

   ![](./images/node-details-1.png " ")
3. Click the **Cluster Details** link in the breadcrumbs at the top of the page to re-display the **Cluster Details** page.

   ![](./images/cluster-details-breadcrumb.png " ")
4. Scroll-down the **Cluster Details** page. In the **Resources** section on the left, click **Work Requests**.

   ![](./images/cluster-details-page-3.png " ")
5. The **Work Requests** section on the page displays the status of the cluster creation and other details such as the **Operation**, **Status**, **% Complete**, **Accepted**, **Started**, and **Finished**. Click the **CREATE_BDS** name link in the **Operation** column.

   ![](./images/work-requests.png " ")

   The **CREATE_BDS** page displays the work request information, logs, and errors, if any.

   ![](./images/create-bds-page.png " ")
6. Click the **Clusters** link in the breadcrumbs at the top of the page to re-display the **Clusters** page.

   ![](./images/breadcrumb.png " ")
7. Once the **`training-cluster`** cluster is created successfully, the state changes to **Active**.

  ![](./images/cluster-active.png " ")

  **Note:**
  If you are using a Free Trial account to run this workshop, Oracle recommends that you at least delete the BDS cluster when you complete the workshop to avoid unnecessary charges. You can also complete the optional **Lab 8: Clean up Resources Used in this Workshop** to delete all of the resources that you create in this workshop.

## Task 3: Monitor the Cluster and Nodes Metrics

  Once your cluster is successfully created, you can monitor the cluster's metrics and the metrics of any of its nodes.

1. From the **Clusters** page, click **`training-cluster`** in the **Name** column to display the **Cluster Details** page.

   ![img](./images/cluster-name-link.png " ")
2. Scroll-down the **Cluster Details** page. In the **Resources** section on the left, click **Cluster Metrics**.

   ![img](./images/click-cluster-metrics.png " ")
3. The **Cluster Metrics** section shows the various metrics such as **HDFS Space Used**, **HDFS Space Free**, **Yarn Jobs Completed**, and **Spark Jobs Completed**. You can adjust the Start time, End time, Interval, Statistic, and Options fields, as desired.

   ![img](./images/cluster-metrics-details.png " ")
4. In the **Resources** section on the left, click **Nodes (7)**.

   ![img](./images/click-nodes.png " ")
5. In the **List of cluster nodes** section, click any node name link to display its metrics. Click the **`traininmn0`** first Master node in the **Name** column.

   ![img](./images/click-traininmn0.png " ")
6. In the **Node Details** page, scroll-down to the **Node Metrics** section. This section is displayed at the bottom of the **Node Details** page **only after** the cluster is successfully provisioned. It displays the following charts: **CPU Utilization**, **Memory Utilization**, **Network Bytes In**, **Network Bytes Out**, and **Disk Utilization**. You can hover over any chart to get additional details.

   ![img](./images/traininmn0-metrics.png " ")
7. Click the **Cluster Details** link in the breadcrumbs at the top of the page to re-display the **Cluster Details** page.

   ![](./images/cluster-details-breadcrumb.png " ")

## Task 4: Adding Worker and Edge Nodes to a Cluster

When you add worker, compute only worker, or edge nodes to a cluster, you expand both compute and storage. The new nodes use the same instance shape and amount of block storage as the existing worker nodes in the cluster.

To add nodes to a cluster as follows:

1. On the cluster details page, click the **Add Nodes** button.

   ![1679386864463](image/create-cluster/1679386864463.png)
2. In **Add Nodes** panel that appears, enter the following details:

* **Node type**: Select the node type. The available options are as follows:

  * **Worker**: A cluster must have at least three worker nodes.
  * **Compute only worker**: You cannot add a compute only worker node while creating a cluster. Therefore, when you add a compute only worker node for the first time, you can update the shape and block storage size. After it is updated, these fields become read-only.
  * **Edge**: You cannot add an edge node while creating a cluster. Therefore, when you add an edge node for the first time, you can update the shape and block storage size. After it is updated, these fields become read-only.
* **Node shape**: This read-only field displays the shape used for the existing worker nodes. This shape is used for all the nodes you add. For information about the shapes, see [Understand Instance Types and Shapes](https://docs.oracle.com/en-us/iaas/Content/bigdata/create-cluster.htm#cluster-plan-understand "Big Data Service cluster nodes run in Oracle Cloud Infrastructure compute instances (servers).").
* **Block storage per node** : This read-only field displays the block storage used for the existing worker nodes. The same amount of storage is used for all the nodes you add.
* **Number of worker nodes**: Enter the number of worker nodes or compute only worker nodes to be added to the cluster. A cluster can have from 3 to 256 worker nodes. An ODH cluster can have from 0 to 256 compute worker nodes.
* **Cluster admin password**: Enter the administration password for the cluster.

  ![1679387338901](image/create-cluster/1679387338901.png)

3.Click "**Add**" button, the cluster is **UPDATING.**

![1679387525814](image/create-cluster/1679387525814.png)

4.You can navigate to **Work requests**, It will dispaly the add node processing.

![1679387571517](image/create-cluster/1679387571517.png)

5.After the processing done, the new work node named as **traininwn3** will be added in the cluster nodes.

![1679390436168](image/create-cluster/1679390436168.png)

![1679387830740](image/create-cluster/1679387830740.png)

## Task 5: Adding Block Storage to Worker Nodes

Block storage is a network-attached storage volume that you can use like a regular hard drive. You can attach extra block storage to the worker nodes of a cluster.

To add a block volume to the cluster as following steps:

1. On the cluster details page, click the **Add Block Storage** button.

![1679390462275](image/create-cluster/1679390462275.png)

2. In the **Add Block Storage** dialog box, enter information, as follows:

* **Additional Block Storage per Node (in GB)** - Enter a number to indicate how many gigabytes of block storage to add, between 150GB and 32TB, in increments of 50GB.
* **Cluster Admin Password** - Enter the administration password for the cluster.

![1679390737317](image/create-cluster/1679390737317.png)

3. Click **Add**.

## Task 5: Review Locations of Services in the Cluster

  The `training-cluster` cluster is a highly available (HA) cluster; therefore, the services are distributed as follows:

**First Master Node, `traininmn0`:**

* Ambari Metrics Monitor
* HDFS Client
* HDFS JournalNode
* HDFS NameNode
* HDFS ZKFailoverController
* Hive Client
* Kerberos Client
* MapReduce2 Client
* Spark3 Client
* Spark3 History Server
* YARN Client
* YARN ResourceManager
* ZooKeeper Server

**Second Master Node, `traininmn1`:**

* Ambari Metrics Monitor
* HDFS Client
* HDFS JournalNode
* HDFS NameNode
* HDFS ZKFailoverController
* Kerberos Client
* MapReduce2 Client
* MapReduce2 History Server
* Spark3 Client
* Tez Client
* YARN Client
* YARN Registry DNS
* YARN ResourceManager
* YARN Timeline Service V1.5
* ZooKeeper Server

**First Utility Node, `traininun0`:**

* Ambari Metrics Monitor
* Ambari Server
* HDFS Client
* HDFS JournalNode
* Hive Metastore
* HiveServer2
* Kerberos Client
* MapReduce2 Client
* Oozie Server
* Spark3 Client
* Tez Client
* YARN Client
* ZooKeeper Client
* ZooKeeper Server

**Second Utility Node, `traininun1`:**

* Ambari Metrics Collector
* Ambari Metrics Monitor
* HDFS Client
* Hive Client
* Kerberos Client
* MapReduce2 Client
* Spark3 Client
* YARN Client

**Worker nodes, `traininwn0`, `traininwn1`, `traininwn2`:**

* Ambari Metrics Monitor
* HDFS DataNode
* HDFS Client
* Hive Client
* Kerberos Client
* MapReduce2 Client
* Oozie Client
* Spark3 Client
* Spark3 Thrift Server
* Tez Client
* YARN Client
* YARN NodeManager
* ZooKeeper Client

**Note:** In **Lab 5, Use Ambari and Hue to Access a BDS Cluster**, you will use Ambari to view the roles, services, and gateways that are running on each node in the cluster.

This concludes this lab. You may now [proceed to the next lab](#next).

## Want to Learn More?

* [Using Oracle Big Data Service](https://docs.oracle.com/en/cloud/paas/big-data-service/user/index.html)
* [Oracle Cloud Infrastructure Documentation](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
* [Creating a Key Pair](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/creatingkeys.htm?Highlight=ssh%20key#CreatingaKeyPair)
* [Connecting to Your Instance](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/testingconnection.htm?Highlight=connect%20to%20an%20instance%20using%20ssh)
* [Overview of Oracle Cloud Infrastructure Identity and Access Management](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Concepts/overview.htm)
* [Overview of the Compute Service](https://docs.cloud.oracle.com/en-us/iaas/Content/Compute/Concepts/computeoverview.htm)
* [Compute Shapes](https://docs.cloud.oracle.com/en-us/iaas/Content/Compute/References/computeshapes.htm#vm-dense)

## Acknowledgements

* **Author:**

  + Anand Chandak, Principal Product Manager, Big Data Services
  + Justin Zou, Principal Data Engineer,Japan & APAC Hub
* **Last Updated By/Date:** Justin Zou, March 2023
