# Infrastructure Configuration

## Introduction

In this lab we will build the infrastructure that we will use to run the rest of the workshop. The main three elements that we will be creating are a Virtual Cloud Network which helps you define your own data center network topology inside the Oracle Cloud by defining some of the following components (Subnets, Route Tables, Security Lists, Gateways, etc.), bastion host which is a compute instance that serves as the public entry point for accessing a private network from external networks like the internet, and we will create an Oracle Analytics Cloud instance which is embedded with machine learning, that helps organizations to discover unique insights faster with automation and intelligence. Finally, we will create a MySQL DB Service instance that we will allow us to configure a heatwave cluster later. 

Estimated Time: 35 minutes

### Objectives

In this lab, you will:
- Create a Virtual Cloud Network and allow traffic through MySQL Database Service port
- Create a Bastion Host compute instance 
- Connect to the Bastion Host, install MySQL Shell and download the workshop Dataset
- Create an Oracle Analytics Cloud (OAC) instance
- Create an Instance of MySQL in the Cloud
- Configure Private Access Channel - OAC

### Prerequisites

- Oracle Free Trial Account.
  
[Lab 1 Demo](youtube:W4JaHA-Fzp8)

## Task 1: Create a Virtual Cloud Network and allow traffic through MySQL Database Service port

1. Login to your OCI tenancy. From the _**Navigation menu**_, select _**Networking > Virtual cloud networks**_.

  ![OCI Dashboard](./images/open-vcn.png)

2. Select your compartment from the list, and click _**Start VCN Wizard**_.

    > **Note:** If you have not selected a compartment, you can select the root compartment which was created by default when you created your tenancy (ie when you registered for the trial account). It is possible to create everything in the root compartment, but Oracle recommends that you create sub-compartments to help manage your resources more efficiently.

  ![VCN Dashboard](./images/start-vcn-wizard.png)

3. Select _**Create VCN with Internet Connectivity**_ and click _**Start VCN Wizard**_.
    
  ![VCN Creation](./images/vcn-wizard-select.png)

4. In the _**VCN name**_ field enter the value, 
  **`analytics-vcn`**, (or any name at your convenience), and make sure that the selected compartment is the right one. Leave the default settings, and click _**Next**_.

  ![VCN creation](./images/vcn-config-name.png)

5. Review the information and click _**Create**_.

  ![VCN creation](./images/vcn-config-review.png)

6. Once the VCN is created, under _**Subnets**_, click _**`private subnet-analytics-vcn`**_. 

  ![VCN creation](./images/select-private-subnet.png)

7. Customize the default security list of the VCN to allow traffic through MySQL Database Service ports by clicking _**`security list for private subnet-analytics-vcn`**_.

  ![security list](./images/edit-security-list.png)

8. Under _**Security rules**_, click _**Add Ingress Rules**_.

  ![security rules](./images/add-security-rules.png)

9. Add the necessary rule to the default security list to enable traffic through MySQL HeatWave Service port, and click _**Add Ingress Rules**_.

	```  
	Source CIDR:  <copy> 0.0.0.0/0 </copy>
	```
	```  
	Destination Port Range: <copy>3306,33060</copy>
	```
	```  
	Description:  <copy> MySQL Port </copy>
	```
	
  ![security list](./images/confirm-ingress-changes.png)

## Task 2: Create a Bastion Host compute instance  

1. From the _**Navigation menu**_, select _**Compute > Instances**_.
	
  ![OCI Console](./images/open-instances.png)

2. Select the same compartment where you created the VCN. Click _**Create instance**_.

  ![Compute Instance Dashboard](./images/create-instance.png)

3. In the **Name** field, insert _**mysql-analytics-bastion**_ (or any other name at your convenience). This name will be used also as internal FQDN. 
	
	For the scope of this workshop leave _**Placement**_  as default.

  ![Compute Instance creation](./images/select-instance-name.png)

4. Click _**Next**_, and then _**Next**_ again to see the _**Networking**_ section. Check that your previously created _**VCN**_ is selected, and select your public subnet _**`public subnet-analytics-vcn (regional)`**_ from the dropdown menu.
	
  ![Compute instance creation](./images/select-instance-networking.png)

5. Scroll down and under _**Add SSH keys**_, select _**Generate a key pair for me**_, and click _**Download private key**_. You will use it to connect to the compute instance later on.
  Once done, click _**Next**_ and then _**Create**_.

  ![Compute instance creaion](./images/download-private-key.png)

5. Once the compute instance is up and running, you will see the icon turning green. However, you can proceed to the next **Task** until the provisioning is done.
	
  ![compute instance creation](./images/instance-running.png)

## Task 3: Connect to the Bastion Host, install MySQL Shell and download the workshop Dataset

1. In order to connect to the bastion host, we will use the cloud shell, a small linux terminal embedded in the OCI interface. To access cloud shell, click _**Cloud Shell**_.

  ![Cloud shell](./images/open-cloud-shell.png)

	Once the cloud shell is opened, you will see the command line:
	
  ![Cloud Shell](./images/view-command-line.png)

2. Drag and drop the previously saved private key into the cloud shell.   

  ![Cloud Shell Drag & Drop Private key](./images/drag-private-key-to-cloud-shell.png)

  You can verify the key file name with the following command:
	
	```
	<copy>ll *.key </copy>
	```
  ![Cloud Shell list files](./images/verify-filename.png)

3. Copy the _**Public IP Address**_ of the compute instance you have just created. Remember, you can find this by going to _**Navigation menu**_ > _**Compute**_ > _**Instances**_ > _**mysql-analytics-bastion**_.

	![Compute Instance Ip Address](./images/copy-public-ip.png)

4. In Cloud Shell, give the right access to the key file:
	```
	<copy>
	chmod 400 *.key
	</copy>
	```

5. In order to establish an ssh connection with the bastion host using the Public IP, execute the following command in your Cloud Shell. Ensure to enter  the actual key filename and the public IP address of the Bastion compute instance:

	```
	<copy>
	ssh -i <private-key-file-name>.key opc@<compute_instance_public_ip>
	</copy>
	```
	![connect to compute instance](./images/connect-to-compute-instance.png)

	If prompted to accept the finger print, type _**yes**_ and hit _**Enter**_.

6. Run the following command to install MySQL Shell on the compute instance.

	```
	<copy>
  sudo yum install mysql-shell -y
	```
	</copy>
  
  The result should look like this:
  ![Result installation of MySQL Shell](./images/mysqlshell-installation-succeeded.png)

7. Download the airportdb sample database that we will use for this workshop using the following commands:

	```
	<copy>
	cd /home/opc
	</copy>
	```

	```
	<copy>wget -O airport-db.zip https://bit.ly/3pZ1PiW</copy>
	```

	![database sample download](./images/download-db-sample.png)


## Task 4: Create an Oracle Analytics Cloud instance

In this task we will create an Oracle Analytics Cloud instance.

1. From the home page, click the _**Navigation menu**_ and click _**Analytics & AI > Analytics Cloud**_.

  ![OCI Console](./images/open-oac.png)

2. Click _**Create instance**_.

  ![Analytics Creation](./images/oac-create-instance.png)

3. Enter/select the following details, and click _**Create**_.

   - Name: **OACDemo**
   - Create in Compartment: Verify that the compartment is the same as the one you select for MySQL
   - Capacity Type: **OCPU**
   - OCPU Count: **2**
   - License Type: **License Included**
   - Edition: **Enterprise Edition**

  ![Analytics Creation](./images/oac-create.png)

4. It takes anywhere between 10-35 minutes to create the OAC instance. **Please proceed to the next task in the meantime**

  ![Analytics Creation](./images/oac-config-name.png)

## Task 5: Create MySQL Database

1. From the console, click _**Navigation menu > Databases > DB Systems**_.
	
  ![OCI Console](./images/open-db-systems.png)

2. Click _**Create DB System**_. 

   Since this is for experimentation, choose _**Development or testing**_. 

   Check the compartment, it should be the same as the compartment you created the VCN, and assign a name to the DB System:

	```
	<copy>mysql-analytics-test</copy>
	```
   
	![MySQL DB System](./images/mysql-db-form.png)

3. In the _**Create administrator credentials**_ section enter the username and choose a password, but make sure to note it as you will use it later:
	
	```
	username: <copy>admin</copy>
	```	
	```
	password: <copy>**PASSWORD**</copy>
	```

4. In the _**Setup**_, select _**Standalone**_.

5. In _**Configure networking**_, make sure you select the same VCN, _**`analytics-vcn`**_, and the private subnet, _**`private subnet-analytics-vcn (Regional)`**_.

	  ![MySQL DB System](./images/options.png)


6. Confirm that in the _**Configure hardware**_ section, _**Enable HeatWave cluster**_ is enabled. Change the MySQL shape to **MySQL.16**.

  ![MySQL DB system creation](./images/mysql-db-form2.png)

7. Click _**Configure HeatWave cluster**_, and then click _**Change shape**_.

8. Select _**HeatWave.512GB**_, and click _**Select a shape**_.

  ![MySQL HeatWave cluster](./images/heatwave-cluster-shape.png)
 
 9. Update the Nodes to **2**.

  ![MySQL HeatWave cluster](./images/heatwave-cluster.png)

10. Update the _**Initial data storae size (GB)**_ to **1024**.

   ![MySQL DB system storage](./images/data-storage.png)

11. In the _**Configure backup plan**_ section leave the default backup window of **7** days. Disable _**Enable point-in-time recovery**_.

  ![MySQL DB system creation](./images/backup.png)

12. Scroll down and click on _**Show advanced options**_. 
	
  ![Advanced option MySQL DB Syatem](./images/mysql-db-advanced-options.png)

13. Go to the _**Connections**_ tab, and enter the following:
	
  	Hostname: **mysql-anaytics-test**
		
	MySQL Port: **3306**

	MySQL X Protocol Port: **33060**

	Once done, click _**Create**_.

	![MySQL DB System Networking Configuration](./images/mysql-db-networking.png)

14. The MySQL DB System will be in _**CREATING**_ state. 
	
	![MySQL DB System Creating](./images/mysql-db-creating.png)

## Task 6: Configure Private Access Channel

This task is necessary so that Oracle Analytics Cloud can access the data of MySQL HeatWave, that's connected to the private network.

1. From the home page, click the _**Navigation menu**_ and click _**Analytics & AI > Analytics Cloud**_.

  ![OCI Console](./images/open-oac.png)

2. By now the status of the instance should have changed to _Active_. 

   ![OCI Console](./images/open-oac-1.png)

3. Click on the instance _**OACDemo**_ to go to the _**Instance Details**_ page.

   Under _**Private Access Channel**_, click _**Configure Private Access Channel**_ to create a private access to the MySQL HeatWave Service instance.

   ![Configuring private channel OAC](./images/select-private-access-channel.png)

4. In _**Configure Private Access Channel**_, fill the name. Then, choose the VCN created earlier, _**`analytics-vcn`**_, and make sure you select the correct subnet, _**`Public Subnet-analytics-vcn`**_, otherwise you won't be able to connect!
   
5. Check _**Virtual Cloud Network's domain name as DNS zone**_, and remove the additional _**DNS Zone**_, using the X icon on the right side of the DNS Zone section, and finally click _**Configure**_.  

	> **Note:** It will take up to _**50 minutes**_ to create the private channel. In the meantime you can go ahead and work on the next lab.

	![Configuring private channel OAC](./images/configure-form-pac.png)

   Well done, you can now proceed to the next lab!

## Acknowledgements
  - **Author** - Rawan Aboukoura - Technology Product Strategy Manager, Vittorio Cioe - MySQL Solution Engineer
  - **Contributors** - Priscila Iruela - Technology Product Strategy Director, Victor Martin - Technology Product Strategy Manager 
  - **Last Updated By/Date** - Aijaz Fatima, Product Manager, Oct 2025
