# CONNECT TO MYSQL DATABASE SYSTEM
![mds heatwave](./images/00_mds_heatwave_2.png "mds heatwave") 


## Introduction

When working in the cloud, there are often times when your servers and services are not exposed to the public internet. The Oracle Cloud Infrastructure (OCI) MySQL cloud service is an example of a service that is only accessible through private networks. Since the service is fully managed, we keep it siloed away from the internet to help protect your data from potential attacks and vulnerabilities. It’s a good practice to limit resource exposure as much as possible, but at some point, you’ll likely want to connect to those resources. That’s where Compute Instance, also known as a Bastion host, enters the picture. This Compute Instance Bastion Host is a resource that sits between the private resource and the endpoint which requires access to the private network and can act as a “jump box” to allow you to log in to the private resource through protocols like SSH.  This bastion host requires a Virtual Cloud Network and Compute Instance to connect with the MySQL DB Systems. 

Today, you will use the Compute Instance to connect from the browser to a MDS DB System

_Estimated Lab Time:_ 20 minutes

Watch the video below for a quick walk through of the lab.

[](youtube:h5ueWMhLH2g)

### Objectives

In this lab, you will be guided through the following tasks:

- Create SSH Key on OCI Cloud 
- Create Compute Instance
- Setup Compute Instance with MySQL Shell
- Install airportdb sample data
- Connect to MySQL DB System

### Prerequisites

- An Oracle Trial or Paid Cloud Account
- Some Experience with MySQL Shell
- Must Complete Lab 1

## Task 1: Create SSH Key on OCI Cloud Shell

The Cloud Shell machine is a small virtual machine running a Bash shell which you access through the Oracle Cloud Console (Homepage). You will start the Cloud Shell and generate a SSH Key to use  for the Bastion  session.

1.  To start the Oracle Cloud shell, go to your Cloud console and click the cloud shell icon at the top right of the page. This will open the Cloud Shell in the browser, the first time it takes some time to generate it.

    ![cloud shell button](./images/cloudshellopen.png "cloud shell button ")

    ![open cloud shell](./images/cloudshell01.png "open cloud shell")

    *Note: You can use the icons in the upper right corner of the Cloud Shell window to minimize, maximize, restart, and close your Cloud Shell session.*

2.  Once the cloud shell has started, create the SSH Key using the following command:

    ```
    <copy>ssh-keygen -t rsa</copy>
    ```
    
    Press enter for each question.
    
    Here is what it should look like.  

    ![ssh key](./images/ssh-key01.png "ssh key ")

3.  The public  and  private SSH keys  are stored in ~/.ssh/id_rsa.pub.

4.  Examine the two files that you just created.

    ```
    <copy>cd .ssh</copy>
    ```
    
    ```
    <copy>ls</copy>
    ```

    ![list .ssh ](./images/ssh-ls-01.png "list .ssh ")

    Note in the output there are two files, a *private key:* `id_rsa` and a *public key:* `id_rsa.pub`. Keep the private key safe and don't share its content with anyone. The public key will be needed for various activities and can be uploaded to certain systems as well as copied and pasted to facilitate secure communications in the cloud.

## Task 2: Create Compute instance

You will need a compute Instance to connect to your brand new MySQL database. 

1. Before creating the Compute instance open a notepad 

2. Do the followings steps to copy the public SSH key to the  notepad 

    Open the Cloud shell
    ![open cloud shell](./images/cloudshell-10.png "open cloud shell ")    

    Enter the following command  

    ```
    <copy>cat ~/.ssh/id_rsa.pub</copy>
    ``` 
    ![type into cloud shell](./images/cloudshell-11.png "type into cloud shell ") 

3. Copy the id_rsa.pub content the notepad
        
    Your notepad should look like this
    ![show ssh key](./images/notepad-rsa-key-1.png "show ssh key")  

4. To launch a Linux Compute instance, go to 
    Navigation Menu
    Compute
    Instances
    ![launch linux](./images/05compute01.png "launch linux ")

5. On Instances in **(root)** Compartment, click  **Create Instance**
    ![compute compartment](./images/05compute02_00.png "compute compartment ")

6. On Create Compute Instance 

 Enter Name
    ```
    <copy>MDS-Client</copy>
    ```   
7. Make sure **(root)** compartment is selected 

8. On Placement, keep the selected Availability Domain

9. On Image and Shape, keep the selected Image, Oracle Linux 8 

      ![compute image](./images/05compute03.png "compute image ")  

10. Select Instance Shape: VM.Standard.E2.2

      ![compute shape](./images/05compute-shape.png "compute shape ")  

11. On Networking, make sure '**MDS-VCN**' is selected

    'Assign a public IP address' should be set to Yes 
   
    ![assign public ip](./images/05compute04.png "assign public ip ")

12. On Add SSH keys, paste the public key from the notepad. 
  
    ![paste ssh key](./images/05compute-id-rsa-paste.png "paste ssh key ")

13. Click '**Create**' to finish creating your Compute Instance. 

14. The New Virtual Machine will be ready to use after a few minutes. The state will be shown as 'Provisioning' during the creation
    ![vm provisioning](./images/05compute07.png "vm provisioning ")

15.	The state 'Running' indicates that the Virtual Machine is ready to use. 

    ![vm ready](./images/05compute08-a.png "vm ready")

## Task 3: Connect to MySQL Database System

1. Copy the public IP address of the active Compute Instance to your notepad

    - Go to Navigation Menu 
            Compute 
            Instances
    ![compute menu](./images/db-list.png "compute menu ")

    - Click the `MDS-Client` Compute Instance link
    
    ![compute instance link](./images/05compute08-b.png "compute instance link ")
    
    - Copy `MDS-Client` plus  the `Public IP Address` to the notepad

2. Copy the private IP address of the active MySQl Database Service Instance to your notepad

    - Go to Navigation Menu 
            Databases 
            MySQL
     ![mysql menu](./images/db-list.png " mysql menu")

    - Click the `MDS-HW` Database System link

     ![mysql menu](./images/db-active.png "batabse instance link ")
    
    - Copy `MDS-HW` plus the `Private IP Address` to the notepad

3. Your notepad should look like the following:
     ![show notepad](./images/notepad-rsa-key-compute-mds-1.png "show notepad ")
    
4. Indicate the location of the private key you created earlier with **MDS-Client**. 
    
    Enter the username **opc** and the Public **IP Address**.

    Note: The **MDS-Client**  shows the  Public IP Address as mentioned on TASK 5: #11
    
    (Example: **ssh -i ~/.ssh/id_rsa opc@132.145.170...**) 

    ```
    <copy>ssh -i ~/.ssh/id_rsa opc@<your_compute_instance_ip></copy>
    ```
    ![vm connect](./images/06connect01-signin.png "vm connect ")

    **Install MySQL Shell on the Compute Instance**

5. You will need a MySQL client tool to connect to your new MySQL DB System from your client machine.

    Install MySQL Shell with the following command (enter y for each question)

    **[opc@…]$**

     ```
    <copy>sudo yum install mysql-shell -y</copy>
    ```
    ![mysql shell install](./images/06connect02-shell.png "mysql shell install ")

 
## Task 4: Install airportdb sample data

 The installation procedure involves downloading the airportdb database to a Compute instance and importing the data from the Compute instance into the MySQL DB System using the MySQL Shell Dump Loading utility. For information about this utility, see Dump Loading Utility.

 To install the airportdb database:

1. Download the airportdb sample database and unpack it. The airportdb sample database is provided for download as a compressed tar or Zip archive. The download is approximately 640 MBs in size.

    a. Get sample file

    ```
    <copy> sudo wget https://downloads.mysql.com/docs/airport-db.zip unzip airport-db.zip</copy>
    ```
  
    b. Unzip sample file

    ```
    <copy>sudo unzip airport-db.zip</copy>
    ```

   **Connect to MySQL Database Service**

2. From your Compute instance, connect to MDS-HW MySQL using the MySQL Shell client tool. 
   
   The endpoint (IP Address) can be found in your notepad or  the MDS-HW MySQL DB System Details page, under the "Endpoint" "Private IP Address". 

    ![compute ip](./images/06connect03.png "compute ip ")

3.  Use the following command to connect to MySQL using the MySQL Shell client tool. Be sure to add the MDS-HW private IP address at the end of the command. Also enter the admin user and the db password created on Lab 1

    (Example  **mysqlsh -uadmin -p -h10.0.1..   --sql**)

    **[opc@...]$**

    ```
    <copy>mysqlsh -uadmin -p -h 10.0.1.... --sql</copy>
    ```

    ![connect mysql](./images/06connect04-myslqsh.png "connect mysql ")

4. Load the airportdb database into the MySQL DB System using the MySQL Shell Dump Loading Utility.

    
    ```
    <copy>util.loadDump("airport-db", {threads: 16, deferTableIndexes: "all", ignoreVersion: true})</copy>
    ```


5. View  the airportdb total records per table in 
    ```
    <copy>SELECT table_name, table_rows FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'airportdb';</copy>
    ```
        
    ![airportdb total records](./images/airportdb-list.png "airportdb total records ") 
    
You may now proceed to the next lab.

## Learn More

* [Cloud Shell](https://www.oracle.com/devops/cloud-shell/?source=:so:ch:or:awr::::Sc)
* [Virtual Cloud Network](https://docs.oracle.com/en-us/iaas/Content/Network/Concepts/overview.htm)
* [OCI Bastion Service ](https://docs.public.oneportal.content.oci.oraclecloud.com/en-us/iaas/Content/Bastion/Tasks/connectingtosessions.htm)
## Acknowledgements
* **Author** - Perside Foster, MySQL Solution Engineering 
* **Contributor** - Frédéric Descamps, MySQL Community Manager 
* **Last Updated By/Date** - Perside Foster, February 2022
