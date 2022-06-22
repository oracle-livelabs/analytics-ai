# Infrastructure Configuration

## Introduction

In this lab we will build the infrastructure that we will use to run the rest of the workshop. The main three elements that we will be creating are a Virtual Cloud Network which helps you define your own data center network topology inside the Oracle Cloud by defining some of the following components (Subnets, Route Tables, Security Lists, Gateways, etc.), bastion host which is a compute instance that serves as the public entry point for accessing a private network from external networks like the internet, and we will create an Oracle Analytics Cloud instance which is embedded with machine learning, that helps organizations to discover unique insights faster with automation and intelligence. Finally, we will create a MySQL DB Service instance that we will allow us to configure a heatwave cluster later. 

Estimated Time: 35 minutes

### Objectives

In this lab, you will:
-	Create a Virtual Cloud Network and allow traffic through MySQL Database Service port
-	Create a Bastion Host compute instance 
-	Connect to the Bastion Host, install MySQL Shell and download the workshop Dataset
- Create an Oracle Analytics Cloud instance
- Create an Instance of MySQL in the Cloud

### Prerequisites

- Oracle Free Trial Account.
  
[Lab 1 Demo](youtube:W4JaHA-Fzp8)

## Task 1: Create a Virtual Cloud Network and allow traffic through MySQL Database Service port

1. Log-in to your OCI tenancy. Once you have logged-in, select _**Networking >> Virtual Cloud Networks**_ from the _**menu icon**_ on the top left corner.

  ![OCI Dashboard](./images/Lab1-task1.1.png)

2. From the Compartment picker on the bottom left side, select your compartment from the list.

    > **Note:** If you have not picked a compartment, you can pick the root compartment which was created by default when you created your tenancy (ie when you registered for the trial account). It is possible to create everything in the root compartment, but Oracle recommends that you create sub-compartments to help manage your resources more efficiently.

  ![VCN Dashboard](./images/Lab1-task1.2.png)

3. To create a virtual cloud network, click on _**Start VCN Wizard**_.
    
  ![VCN Dashboard](./images/Lab1-task1.3.png)

4. Create _**VCN with Internet Connectivity**_ and click _**Start VCN Wizard**_.

  ![VCN Creation](./images/Lab1-task1.4.png)

5. Now you need to complete some information and set the configuration for the VCN. In the _**VCN Name**_ field enter the value 
  **`analytics_vcn_test`** (or any name at your convenience), and make sure that the selected compartment is the right one. Leave all the rest as per default, Click _**Next**_.

  ![VCN creation](./images/Lab1-task1.5.png)

6. Review the information showed is correct and click _**Create**_.

  ![VCN creation](./images/Lab1-task1.6.png)

7. Once the VCN will be created click _**View Virtual Cloud Network**_.

  ![VCN creation](./images/Lab1-task1.7.png)

8. Click on the _**`Private Subnet-analytics_vcn_test`**_. 

  ![VCN creation](./images/Lab1-task1.8.png)

9. Earlier we set up the subnet to use the VCN's default security list, that has default rules, which are designed to make it easy to get started with Oracle Cloud Infrastructure. 
   Now we will customize the default security list of the VCN to allow traffic through MySQL Database Service ports by clicking on  _**`Security List for Private Subnet-analytics_vcn_test`**_.

  ![scurity list](./images/Lab1-task1.9.png)

10. Click on _**Add Ingress Rules**_.

  ![security list](./images/Lab1-task1.10.png)

11. Add the necessary rule to the default security list to enable traffic through MySQL Database Service port. 

  Insert the details as below:
	```  
	Source CIDR:  <copy> 0.0.0.0/0 </copy>
	```
	```  
	Destination Port Range: <copy>3306,33060</copy>
	```
	```  
	Description:  <copy> MySQL Port </copy>
	```
	At the end click the blue button _**Add Ingress Rules**_.

  ![security list](./images/Lab1-task1.11.png)

## Task 2: Create a Bastion Host compute instance  

1. From the main menu on the top left corner select _**Compute >> Instances**_.
    
  ![OCI Console](./images/Lab1-task2.1.png)

2. In the compartment selector on the bottom left corner, select the same compartment where you created the VCN. Click on the _**Create Instance**_ blue button to create the compute instance.

  ![Compute Instance Dashboard](./images/Lab1-task2.2.png)

3. In the **Name** field, insert _**mysql-analytics-test-bridge**_ (or any other name at your convenience). This name will be used also as internal FQDN. 
  	
	The _**Placement and Hardware section**_ is the section where you can change Availability Domain, Fault Domain, Image to be used, and Shape of resources. For the scope of this workshop leave everything as default.

  ![Compute Instance creation](./images/Lab1-task2.3.png)


  	As you scroll down you can see the **Networking** section, check that your previously created **VCN** is selected, and select your PUBLIC subnet _**`Public Subnet-analytics_vcn_test(Regional)`**_ from the dropdown menu.
    
  ![Compute instance creation](./images/Lab1-task2.3-1.png)

4. Scroll down and MAKE SURE TO DOWNLOAD the proposed private key. 
  You will use it to connect to the compute instance later on.
  Once done, click _**Create**_.

  ![Compute instance craetion](./images/Lab1-task2.4.png)

5. Once the compute instance will be up and running, you will see the square icon on the left turning green. However, you can proceed to the next **Task** until the provisioning is done.
    
  ![compute instance creation](./images/Lab1-task2.5.png)

## Task 3: Connect to the Bastion Host, install MySQL Shell and download the workshop Dataset

1. In order to connect to the bastion host, we will use the cloud shell, a small linux terminal embedded in the OCI interface.
  
  	To access cloud shell, click on the shell icon next to the name of the OCI region, on the top right corner of the page.

  ![Cloud shell](./images/Lab1-task3.1.png)


  	Once the cloud shell is opened, you will see the command line:
    
  ![Cloud Shell](./images/Lab1-task3.1-1.png)

2. Drag and drop the previously saved private key into the cloud shell.   

  ![Cloud Shell Darg&Drop Private key](./images/Lab1-task3.2.png)

  You can verify the key file name with the following command:
    
	```
    <copy>ll</copy>
    ```
  ![](./images/Lab1-task3.2-1.png)

3. Copy the _**Public IP Address**_ of the compute instance you have just created.

  	![Compute Instance Ip Address](./images/Lab1-task3.3.png)

  	In order to establish an ssh connection with the bastion host using the Public IP, execute the following commands:
	```
	<copy>
	chmod 400 <private-key-file-name>.key
	</copy>
	```

	```
	<copy>
	ssh -i <private-key-file-name>.key opc@<compute_instance_public_ip>
	</copy>
	```
  	![connect to compute instance](./images/Lab1-task3.3-1.png)

  	If prompted to accept the finger print, type _**yes**_ and hit enter, then you will get a Warning.

	> **Note:** Warning: Permanently added '130. . . ' (ECDSA) to the list of known hosts.

  Now that you have connected to the instance you can proceed to the next Task.

4. From the established ssh connection, install MySQL Shell executing the following command, and the expected output should be as following:
   
	```
	<copy>sudo yum install -y mysql-shell</copy>  
	```
	![MySQL shell install](./images/Lab1-task3.4-2.png)

5. Confirm that MySQL Shell is installed by printing its version.
	```
	<copy>mysqlsh --version</copy>
	```
	![MySQL version](images/Lab1-task3.5.png)

6. Download the airportdb sample database that we will use for this workshop using the following commands:
	```
	<copy>
	cd /home/opc
	</copy>
	```

	```
	<copy>wget -O airport-db.zip https://bit.ly/3pZ1PiW</copy>
	```

	![database sample download](./images/Lab1-task3.6-2.png)


## Task 4: Create an Oracle Analytics Cloud instance

In this task we will create an Oracle Analytics Cloud instance before we proceed to the next lab, since it may takes sometime to be provisioned, so it will be **Running** status when we will use it later in this workshop.

1. Click on the menu icon on the left. Verify that you are signed in as a **Single Sign On** (Federated user) user by selecting the **Profile** icon in the top right hand side of your screen. If your username is shown as:

	```
    oracleidentitycloudservice/<your username>
	```

	Then you are **connected** as a **Single Sign On** user.

  	![Federated User](./images/Lab1-task4.1.png)

  	If your username is shown as:

	```
    <your username>
	```

	Then you are **signed in** as an **Oracle Cloud Infrastructure** user and you may proceed to the **Task 4.2**.

  	If your user does not contain the identity provider (**oracleidentitycloudprovider**), please logout and select to authenticate using **Single Sign On**.

  	![Federated User](./images/Lab1-task4.1-1.png)

   	To be capable of using **Oracle Analytics Cloud** we need to be Sign-On as a **Single Sign-On** (SSO) user.

   	For more information about federated users, see **[User Provisioning for Federated Users.](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/usingscim.htm)**

2. Go to main page click the _**hamburger menu**_ in the upper left corner and click on _**Analytics & AI -> Analytics Cloud**_.

  ![OCI Console](./images/Lab1-task4.2.png)


3. Click _**Create instance**_ and in the new window, fill out the fields as shown in the image below. Make sure to select 2 OCPUs, the Enterprise version and the _**License Included**_ button. Finally click _**Create**_ to start the provisioning of the instance.

  	![Analytics Creation](./images/Lab1-task4.3.png)

  	```
    Name: <copy>OACDemo</copy>
  	```
  	```
    OCPU: 2
  	```	
  	```
    License Type: License Included
  	```

  ![Analytics Creation](./images/Lab1-task4.3-1.png)

  	> **Note:** It takes about _**15-20 minutes**_ to create the OAC instance you can proceed to the next task until it is done.

  ![Analytics Creation](./images/Lab1-task4.3-2.png)

## Task 5: Create MySQL Database

1. From the console main menu on the left side select _**Databases >> DB Systems**_.
    
  ![OCI Console](./images/Lab1-task5.1.png)

2. It will bring you to the DB System creation page. 
  Look at the compartment selector on the left and check that you are using the same compartment used to create the VCN and the Compute Instance. Once done, click on _**Create MySQL DB System**_.

  ![MySQL DB System creation](./images/Lab1-task5.2.png)

3. Start creating the DB System. Cross check again the compartment and assign to the DB System the name:
    ```
    <copy> mysql-analytics-test</copy>
    ```
   Select the HeatWave box, this will allow to create a MySQL DB System which will be HeatWave-ready. 
    
  ![MySQL DB System](./images/Lab1-task5.3.png)

4. In the _**Create Administrator Credentials**_ section enter the username and choose a password of your own, but make sure to note it as you will be using it later through the workshop:
    
    ```
    username: admin
 
    password: **PASSWORD**
    ```
	- In the _**Configure Networking**_ section make sure you select the same VCN, _**`analytics_vcn_test`**_ you have used to create the Compute Instance but for MySQL you will use a different subnet, the private one called _**`Private Subnet-analytics_vcn_test(Regional)`**_.

	- Leave the default availability domain and proceed to the _**Configure Hardware**_ section.
   
    ![Configure hardware MySQL DB System craetion](./images/Lab1-task5.4.png)

5. Confirm that in the _**Configure Hardware**_ section, the selected shape is **MySQL.HeatWave.VM.Standard.E3**, CPU Core Count: **16**, Memory Size: **512 GB**, Data Storage Size: **1024**.
  In the _**Configure Backup**_ section leave the default backup window of **7** days.

  ![MySQL DB system creation](./images/Lab1-task5.5.png)

6. Scroll down and click on _**Show Advanced Options**_. 
    
  ![Advanced option MySQL DB Syatem](./images/Lab1-task5.6.png)

  	- Go to the Networking tab, in the Hostname field enter (same as DB System Name):
		```
		<copy> mysql-analytics-test</copy> 
		```
		Check that port configuration corresponds to the following:


		MySQL Port: **3306**

		MySQL X Protocol Port: **33060**

		Once done, click the _**Create**_ button.

		![MySQL DB System Networking Configuration](./images/Lab1-task5.6-1.png)


  	- The MySQL DB System will have _**CREATING**_ state (as per picture below). 
    
  	![MySQL DB Syatem Creating](./images/Lab1-task5.6-2.png)


  As a recap we have created a VCN and added an additional Ingress rules to the Security list, and created a compute instance that serves as a bastion host and launched the cloud shell to import the private keys to connect to the compute instance, we also installed MySQL Shell and the MySQL client, and downloaded the dataset that will be used later on for benchmark analysis.
  Also, we created an Oracle Analytics Cloud instance which we will eventually use later in this workshop. Finally, created MySQL Database instance which will be used to enable the HeatWave service later.

  Well done, you can now proceed to the next lab!

## Acknowledgements
  - **Author** - Rawan Aboukoura - Technology Product Strategy Manager, Vittorio Cioe - MySQL Solution Engineer
  - **Contributors** - Priscila Iruela - Technology Product Strategy Director, Victor Martin - Technology Product Strategy Manager 
  - **Last Updated By/Date** - Anoosha Pilli, September 2021
