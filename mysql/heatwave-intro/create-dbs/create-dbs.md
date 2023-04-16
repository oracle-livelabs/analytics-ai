# Create MySQL HeatWave Database System

![mysql heatwave](./images/mysql-heatwave-logo.jpg "mysql heatwave")

## Introduction

In this lab, you will create and configure a MySQL DB System and  will add a HeatWave Cluster comprise of two or more HeatWave nodes.  

_Estimated Time:_ 20 minutes

[//]:    [](youtube:Uz_PXHzO9ac)

### Objectives

In this lab, you will be guided through the following tasks:

- Create Virtual Cloud Network
- Create MySQL Database for HeatWave (DB System) instance

### Prerequisites

- An Oracle Trial or Paid Cloud Account
- Some Experience with MySQL Shell

## Task 1: Create Virtual Cloud Network

1. You should be signed in to Oracle Cloud!

    Click **Navigation Menu**,

    ![OCI Console Home Page](./images/homepage.png " home page")

2. Click  **Networking**, then **Virtual Cloud Networks**  
    ![menu vcn](./images/home-menu-networking-vcn.png "home menu networking vcn ")

3. Click **Start VCN Wizard**
    ![vcn wizard](./images/vcn-wizard-menu.png "vcn wizard ")

4. Select 'Create VCN with Internet Connectivity'

    Click 'Start VCN Wizard'
    ![start vcn wizard](./images/vcn-wizard-start.png "start vcn wizard ")

5. Create a VCN with Internet Connectivity

    On Basic Information, complete the following fields:

    VCN Name:
    ```
    <copy>MDS-VCN</copy>
    ```
    
    Compartment: Select  **(root)**

    Your screen should look similar to the following
    ![select compartment](./images/vcn-wizard-compartment.png "select compartment")

6. Click 'Next' at the bottom of the screen

7. Review Oracle Virtual Cloud Network (VCN), Subnets, and Gateways

    Click 'Create' to create the VCN
    ![create vcn](./images/vcn-wizard-create.png "create vcn")

8. When the Virtual Cloud Network creation completes, click 'View Virtual Cloud Network' to display the created VCN
    ![vcn creation completing](./images/vcn-wizard-view.png "vcn creation completing")

9. On MDS-VCN page under 'Subnets in (root) Compartment', click  '**Private Subnet-MDS-VCN**'
     ![vcn subnet](./images/vcn-details-subnet.png "vcn detqails subnet")

10. On Private Subnet-MDS-VCN page under 'Security Lists',  click  '**Security List for Private Subnet-MDS-VCN**'
    ![VCN](./images/vcn-private-security-list.png "vcn private security list")

11.	On Security List for Private Subnet-MDS-VCN page under 'Ingress Rules', click '**Add Ingress Rules**'
    ![vcn private subnet](./images/vcn-private-security-list-ingress.png "vcn private security list ingress")

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
    ![add ingres rule](./images/vcn-private-security-list-ingress-rules-mysql.png "vcn private security list ingress rukes mysql")

13.	On Security List for Private Subnet-MDS-VCN page, the new Ingress Rules will be shown under the Ingress Rules List
    ![show ingres rule](./images/vcn-private-security-list-ingress-display.png "vcn private security list ingress display")

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


You may now **proceed to the next lab**.

## Acknowledgements

* **Author** - Perside Foster, MySQL Solution Engineering
* **Contributors** - Mandy Pang, MySQL Principal Product Manager,  Priscila Galvao, MySQL Solution Engineering, Nick Mader, MySQL Global Channel Enablement & Strategy Manager, Frédéric Descamps, MySQL Community Manager
* **Last Updated By/Date** - Perside Foster, MySQL Solution Engineering, February 2022
