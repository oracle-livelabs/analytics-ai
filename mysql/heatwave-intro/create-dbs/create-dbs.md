# Create MySQL Database System and HeatWave Cluster
![mds heatwave](./images/00_mds_heatwave_2.png "mds heatwave")

## Introduction

In this lab, you will create and configure a MySQL DB System and  will add a HeatWave Cluster comprise of two or more HeatWave nodes.  

_Estimated Time:_ 20 minutes

Watch the video below for a quick walk through of the lab.

[](youtube:Uz_PXHzO9ac)

### Objectives

In this lab, you will be guided through the following tasks:

- Create Virtual Cloud Network
- Create MySQL Database for HeatWave (DB System) instance
- Add a HeatWave Cluster to MySQL Database System

### Prerequisites

- An Oracle Trial or Paid Cloud Account
- Some Experience with MySQL Shell

## Task 1: Create Virtual Cloud Network

1. Click **Navigation Menu**, **Networking**, then **Virtual Cloud Networks**  
    ![menu vcn](./images/03vcn01.png "menu vcn ")

2. Click **Start VCN Wizard**
    ![vcn wizard](./images/03vcn02.png "vcn wizard ")

3. Select 'Create VCN with Internet Connectivity'

    Click 'Start VCN Wizard'
    ![start vcn wizard](./images/03vcn03.png "start vcn wizard ")

4. Create a VCN with Internet Connectivity

    On Basic Information, complete the following fields:

 VCN Name:
    ```
    <copy>MDS-VCN</copy>
    ```
 Compartment: Select  **(root)**

 Your screen should look similar to the following
    ![select compartment](./images/03vcn04.png "select compartment")

5. Click 'Next' at the bottom of the screen

6. Review Oracle Virtual Cloud Network (VCN), Subnets, and Gateways

    Click 'Create' to create the VCN
    ![create vcn](./images/03vcn04-1.png "create vcn")

7. The Virtual Cloud Network creation is completing
    ![vcn creation completing](./images/03vcn05.png "vcn creation completing")

8. Click 'View Virtual Cloud Network' to display the created VCN
    ![view vcn](./images/03vcn06.png "view vcn")

9. On MDS-VCN page under 'Subnets in (root) Compartment', click  '**Private Subnet-MDS-VCN**'
     ![vcn subnet](./images/03vcn07.png "vcn subnet")

10.	On Private Subnet-MDS-VCN page under 'Security Lists',  click  '**Security List for Private Subnet-MDS-VCN**'
    ![VCN](./images/03vcn08.png "vcn security list")

11.	On Security List for Private Subnet-MDS-VCN page under 'Ingress Rules', click '**Add Ingress Rules**'
    ![vcn private subnet](./images/03vcn09.png "vcn private subnet")

12.	On Add Ingress Rules page under Ingress Rule 1

 Add an Ingress Rule with Source CIDR
    ```
    <copy>0.0.0.0/0</copy>
    ```
 Destination Port Range
     ```
    <copy>3306,33060</copy>
     ```
 Description
     ```
    <copy>MySQL Port Access</copy>
     ```
 Click 'Add Ingress Rule'
    ![add ingres rule](./images/03vcn10.png "add ingres rule")

13.	On Security List for Private Subnet-MDS-VCN page, the new Ingress Rules will be shown under the Ingress Rules List
    ![show ingres rule](./images/03vcn11.png "show ingres rule")

## Task 2: Create MySQL Database for HeatWave (DB System) instance

1. Go to Navigation Menu
         Databases
         MySQL
         DB Systems
    ![mysql menu](./images/04mysql01.png "mysql menu ")

2. Click 'Create MySQL DB System'
    ![mysql create button](./images/04mysql02.png " mysql create button")

3. Create MySQL DB System dialog complete the fields in each section

    - Provide basic information for the DB System
    - Setup your required DB System
    - Create Administrator credentials
    - Configure Networking
    - Configure placement
    - Configure hardware
    - Exclude Backups
    - Advanced Options - Data Import

4. Provide basic information for the DB System:

 Select Compartment **(root)**

 Enter Name
    ```
    <copy>MDS-HW</copy>
    ```
 Enter Description
    ```
    <copy>MySQL Database Service HeatWave instance</copy>
    ```

 Select **HeatWave** to specify a HeatWave DB System
    ![heatwave db](./images/04mysql03-3.png "heatwave db")

5. Create Administrator Credentials

    **Enter Username** (write username to notepad for later use)

    **Enter Password** (write password to notepad for later use)

    **Confirm Password** (value should match password for later use)

    ![mysql admin](./images/04mysql04.png "mysql admin ")

6. On Configure networking, keep the default values

    Virtual Cloud Network: **MDS-VCN**

    Subnet: **Private Subnet-MDS-VCN (Regional)**

    ![mds vcn](./images/04mysql05.png "mds vcn ")

7. On Configure placement under 'Availability Domain'

    Select AD-3

    Do not check 'Choose a Fault Domain' for this DB System.

    ![Fault Domain default](./images/04mysql06-3.png "Fault Domain default")

8. On Configure hardware, keep default shape as **MySQL.HeatWave.VM.Standard.E3**

    Data Storage Size (GB) Set value to:  **1024**

    ```
    <copy>1024</copy>
    ```
    ![data storage size](./images/04mysql07-3-100-2.png"data storage size ")

9. On Configure Backups, disable 'Enable Automatic Backup'

    ![auto backup](./images/04mysql08.png " auto backup")

10. Click on Show Advanced Options

11. Go to the Networking tab, in the Hostname field enter (same as DB System Name):

    ```bash
        <copy>MDS-HW</copy> 
    ```

15. Review **Create MySQL DB System**  Screen

    ![review creete db screen](./images/04mysql09-3.png "review creete db screen ")

    Click the '**Create**' button

16. The New MySQL DB System will be ready to use after a few minutes

    The state will be shown as 'Creating' during the creation
    ![show creeation state](./images/04mysql10-3.png"show creeation state")

17. The state 'Active' indicates that the DB System is ready for use

    On MDS-HW Page, check the MySQL Endpoint (Private IP Address)

    ![mds endpoint](./images/04mysql11-3.png"mds endpoint")

## Task 3: Add a HeatWave Cluster to MDS-HW MySQL Database System

1. Open the navigation menu  
    Databases
    MySQL
    DB Systems
2. Choose the root Compartment. A list of DB Systems is displayed.
    ![mysql menu](./images/10addheat01.png "mysql menu ")
3. In the list of DB Systems, click the **MDS-HW** system. click **More Action ->  Add HeatWave Cluster**.
    ![db list](./images/10addheat02.png " db list")
4. On the “Add HeatWave Cluster” dialog, select “MySQL.HeatWave.VM.Standard.E3” shape
5. Click “Estimate Node Count” button
    ![node count estimate](./images/10addheat03.png "node count estimate ")
6. On the “Estimate Node Count” page, click “Generate Estimate”. This will trigger the auto
provisioning advisor to sample the data stored in InnoDB and based on machine learning
algorithm, it will predict the number of nodes needed.
    ![predict number of nodes](./images/10addheat04.png "predict number of nodes ")
7. Once the estimations are calculated, it shows list of database schemas in MySQL node. If you expand the schema and select different tables, you will see the estimated memory required in the Summary box, There is a Load Command (heatwave_load) generated in the text box window, which will change based on the selection of databases/tables
8. Select the airportdb schema and click “Apply Node Count Estimate” to apply the node count
    ![apply node count](./images/10addheat05.png "apply node count ")
9. Click “Add HeatWave Cluster” to create the HeatWave cluster
    ![create heatwave cluster](./images/10addheat06.png " create heatwave cluster")
10. HeatWave creation will take about 10 minutes. From the DB display page scroll down to the Resources section. Click the **HeatWave** link. Your completed HeatWave Cluster Information section will look like this:
    ![completed heatatwave cluster](./images/10addheat07.png "completed heatatwave cluster ")

## Acknowledgements

* **Author** - Perside Foster, MySQL Solution Engineering
* **Contributors** - Mandy Pang, MySQL Principal Product Manager,  Priscila Galvao, MySQL Solution Engineering, Nick Mader, MySQL Global Channel Enablement & Strategy Manager, Frédéric Descamps, MySQL Community Manager
* **Last Updated By/Date** - Perside Foster, MySQL Solution Engineering, February 2022
