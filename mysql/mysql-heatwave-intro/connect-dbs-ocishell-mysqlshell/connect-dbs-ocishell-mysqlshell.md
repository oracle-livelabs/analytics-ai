# Connect to MySQL HeatWave With Cloud Shell Private Access and OCI Shell

![mysql heatwave](./images/mysql-heatwave-logo.jpg "mysql heatwave")

## Introduction

When working in the cloud, there are often times when your servers and services are not exposed to the public internet. The Oracle Cloud Infrastructure (OCI) MySQL HeatWave is an example of a service that is only accessible through private networks. Since the service is fully managed, we keep it siloed away from the internet to help protect your data from potential attacks and vulnerabilities. It’s a good practice to limit resource exposure as much as possible, but at some point, you’ll likely want to connect to those resources. That’s where Cloud Shell Private Access enters the picture. Cloud Shell Private Access allows you to connect a Cloud Shell session to a private network so you can access  your MySQL HeatWave Database without having the network traffic flow over public networks

_Estimated Lab Time:_ 10 minutes

### Objectives

In this lab, you will be guided through the following tasks:

- Connect to Cloud Shell
- Setup Cloud Shell Private Access
- Use MySQL Shell to Connect to your Heatwave Database

### Prerequisites

- An Oracle Trial or Paid Cloud Account
- Some Experience with MySQL Shell
- Must Complete Lab 1

## Task 1: Access Cloud Shell via the Console

1. Login to the OCI Console.
2. Click the Cloud Shell icon in the Console header. Note that the OCI CLI running in the Cloud Shell will execute commands against the region selected in the Console's Region selection menu when the Cloud Shell was started.

    ![cloudshell console button](./images/cloudshell-console-button.png "cloudshell console button")

    This displays the Cloud Shell in a "drawer" at the bottom of the console:

    ![cloudshell console drawer](./images/cloudshell-console-drawer.png "cloudshell console drawer")

    You can use the icons in the upper right corner of the Cloud Shell window to minimize, maximize, restart, and close your Cloud Shell session.

## Task 2: Setup Cloud Shell Private Access

1. To change the network your Cloud Shell session is using to the HeatWave Database network, use the drop-down Network menu at the top of the Cloud Shell terminal window:

    ![cloud shell private access dropdown terminal](./images/cloud_shell_private_access_dropdown_terminal.png "cloud shell private access dropdown terminal")

2. Select the Private Network Setup menu item. this will bring up the Private Network Setup panel. This panel allows you to select details for the private network you want to use:

    ![cloud shell private access vcn](./images/cloud_shell_private_access_dropdown_vcn.png "cloud shell private access vcn")

3. Select the compartment that you want to use, and then select the VCN and the Subnet to use from the drop-down list boxes. You can also optionally select one or more Network Security groups to use.

    ![cloud shell private network setup](./images/cloud_shell_private_network_setup.png "cloud shell private network setup")

4. Click on the Connect to this network button to switch your Cloud Shell network connection to the HeatWave Database network.

    Your Cloud Shell session is now connected to your HeatWave private network, as indicated in the Networking drop-down at the top of the Cloud Shell terminal session:

    ![cloud shell private network connected](./images/cloud_shell_private_network_connected.png "cloud shell private network connected")

    You can see details about your private network connection by clicking the Details link.

    ![cloud shell private network details](./images/cloud_shell_private_network_details.png "cloud shell private network details")

## Task 3: Install airportdb sample data

The installation procedure involves downloading the airportdb database to cloud shell and importing the data from cloud shell into the MySQL DB System using the MySQL Shell Dump Loading utility. For information about this utility, see Dump Loading Utility: [https://dev.mysql.com/doc/mysql-shell/8.0/en/mysql-shell-utilities-load-dump.htmly](https://dev.mysql.com/doc/mysql-shell/8.0/en/mysql-shell-utilities-load-dump.html)

 To install the airportdb database:

1. Download the airportdb sample database and unpack it. The airportdb sample database is provided for download as a compressed tar or Zip archive. The download is approximately 640 MBs in size.



    a. Get sample file

    ```bash
    <copy>wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/MdFkX2s2_x9Miktl08UoorNTIyE-bIULjDXcbYuU1ukSfw1g48AEUkmH0-UcN5bQ/n/idazzjlcjqzj/b/irportdb-bucket-20230123-2124/o/airportdb_ysqlsh_331.zip</copy>
    ```
  
    b. Unzip sample file

    ```bash
    <copy>unzip airportdb_ysqlsh_331.zip</copy>
    ```

   **Connect to MySQL Database Service**

2. From your cloud shell, connect to HEATWAVE-DB  using the MySQL Shell client tool.

   The endpoint (IP Address) can be found in your notepad or  the HEATWAVE-DB  System Details page, under the "Endpoint" "Private IP Address". 

    ![mysql endpoint private ip](./images/mysql-endpoint-private-ip.png "mysql endpoint private ip")

3. Use the following command to connect to MySQL using the MySQL Shell client tool. Be sure to add the MDS-HW private IP address at the end of the command. Also enter the admin user and the db password created on Lab 1

    (Example  **mysqlsh -uadmin -p -h10.0.1..**)

    **[opc@...]$**

    ```bash
    <copy>mysqlsh -uadmin -p -h 10.0.1... </copy>
    ```

    ![mysql shell first connect](./images/mysql-shell-first-connect.png "mysql shell first connect ")

4. Load the airportdb database into the MySQL DB System using the MySQL Shell Dump Loading Utility.

    ```bash
    <copy>\js</copy>
    ```

    ```bash
    <copy>util.loadDump("airportdb", {threads: 16, deferTableIndexes: "all", ignoreVersion: true, loadIndexes:false})</copy>
    ```

    ![mysql load data](./images/mysql-load-data.png "mysql load data ")

5. View  the airportdb total records per table

    ```bash
    <copy>\sql</copy>
    ```

    ```bash
    <copy>SELECT table_name, table_rows FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'airportdb';</copy>
    ```

    ![airportdb total records](./images/airportdb-list.png "airportdb total records") 

6. Exit MySQL Shell

      ```bash
      <copy>\q</copy>
      ```

You may now **proceed to the next lab**

## Acknowledgements

- **Author** - Perside Foster, MySQL Principal Solution Engineering
- **Contributors** - Mandy Pang, MySQL Principal Product Manager,  Nick Mader, MySQL Global Channel Enablement & Strategy Manager
- **Last Updated By/Date** - Perside Foster, MySQL Solution Engineering, July 2023