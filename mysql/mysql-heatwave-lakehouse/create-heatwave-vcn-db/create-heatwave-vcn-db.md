# Create Compartment, VCN, sbunet for workshop.

## Introduction

In this lab, you will create a Compartment and  Virtual Cloud Network (VCN) to connect your OCI resources. 

_Estimated Time:_ 15 minutes

### Objectives

In this lab, you will be guided through the following tasks:

- Create a Compartment
- Create a Virtual Cloud Network
- Configure a security list to allow MySQL incoming connections



### Prerequisites

- An Oracle Trial or Paid Cloud Account
- Some Experience with MySQL Shell
- Login to OCI to land on OCI Dashboard

![INTRO](./images/oci-dashboard.png "land on oci dashboard")

## Task 1: Create Compartment

1. Click the **Navigation Menu** in the upper left, navigate to **Identity & Security** and select **Compartments**.

2. On the Compartments page, click **Create Compartment**.

3. In the Create Compartment dialog box, complete the following fields:

    Name:

    ```bash
    <copy>e2e-demo-specialist-eng</copy>
    ```

    Description:

    ```bash
    <copy>Compartment for end to end workshop </copy>
    ```
   *** You can use any other compartment name based up on your needs .Please ensure to create all the OCI services under the same compartment and region which you created in the step No 3.
4. The **Parent Compartment** should be **root** and click **Create Compartment**
    ![VCN](./images/compartment-create.png "create the compartment")

## Task 2: Create Virtual Cloud Network

1. Click Navigation Menu
    Select Networking
    Select Virtual Cloud Networks
    ![VCN Menu](./images/menuvcn.png "show vcn menu")

2. Click **Start VCN Wizard**
    ![VCN Wizard](./images/networking-main.png "show networking main dialog")

3. Select 'Create VCN with Internet Connectivity'

    Click 'Start VCN Wizard'
    ![Use VCN Wizard](./images/vcn-wizard-start.png "start vcn wizard")

4. Create a VCN with Internet Connectivity

    On Basic Information, complete the following fields:

    VCN Name:

    ```bash
    <copy>vcn_phoenix</copy>
    ```

    Compartment: Select - e2e-demo-specialist-eng 
    
    The VCN name can be customized but ensure you use the same VCN through out the demo where ever required.
    Your screen should look similar to the following
        ![Configure VCN](./images/vcn-internet-connect-config.png "Configured VCN internet connection ")

5. Click 'Next' at the bottom of the screen

6. Review Oracle Virtual Cloud Network (VCN), Subnets, and Gateways

    Click 'Create' to create the VCN

7. The Virtual Cloud Network creation is completing
    ![Completed VCN](./images/vcn-wizard-review.png "Review complete vcn wizard work")

8. Click 'View VCN' to display the created VCN
    ![Created VCN](./images/wizard-view-vcn.png "display the created")

## Task 3: Configure security list to allow MySQL incoming connections

1. On pheonix-vcn page under 'Subnets in lakehouse Compartment', click  '**Crete subnet**'

2. Create a subnet **subnetB**
     ![Subnet creations](./images/subnet-create-a.png "Subnet creation")
     *** Assign the IPV4-CICR Block ip -10.0.2.0/24
     ![Subnet creation](./images/subnet-create-b.png "Subnet creation")

     ![Subnet creation](./images/subnetcreate-c.png "Subnet creation")
3. Delete the other two subnets created by default .

4. Create a subnet **subnetA**
     ![Subnet creations](./images/subnet-create-aa.png "Subnet creation")
     *** Assign the IPV4-CICR Block ip -10.0.1.0/24

     ![Subnet creation](./images/subnet-create-b.png "Subnet creation")

     ![Subnet creation](./images/subnetcreate-c.png "Subnet creation")

5. On vcn_phoenix page under 'Subnets in lakehouse Compartment', click  '**subnetB**'
     ![VCN Details](./images/vcn-details.png "Show VCN Details")

6. On Private subnetB page under 'Security Lists',  click  '**Security List for subnetB**'
    ![VCN Security list](./images/vcn-security-list.png "Show Security Lists")

7. On Security List for Private subnetB page under 'Ingress Rules', click '**Add Ingress Rules**'
    ![VCN Ingress Rule](./images/vcn-mysql-ingress.png "Prepar for add Add Ingress Rules")

8. On Add Ingress Rules page under Ingress Rule

    Add an Ingress Rule with Source CIDR

    ```bash
    <copy>0.0.0.0/0</copy>
    ```

    Destination Port Range

    ```bash
    <copy>3306,33060</copy>
    ```

    Description

    ```bash
       <copy>MySQL Port Access</copy>
    ```

9. Click 'Add Ingress Rule'
    ![Add VCN Ingress Rule](./images/vcn-mysql-add-ingress.png "Save  MySQL Ingress Rule  entries")

10. On Security List for Private subnetB page, the new Ingress Rules will be shown under the Ingress Rules List
    ![View VCN Ingress Rule](./images/vcn-mysql-ingress-completed.png "view  MySQL Ingress Rules")

## Task 4: Configure security list to allow HTTP incoming connections

1. Navigation Menu > Networking > Virtual Cloud Networks

2. Open vcn_phoenix

3. Click  public subnetB

4. Click Default Security List for vcn_phoenix

5. Click Add Ingress Rules page under Ingress Rule

    Add an Ingress Rule with Source CIDR

    ```bash
    <copy>0.0.0.0/0</copy>
    ```

    Destination Port Range

    ```bash
    <copy>80,443</copy>
    ```

    Description

    ```bash
    <copy>Allow HTTP connections</copy>
    ```

6. Click 'Add Ingress Rule'

    ![Add VCN HTTP](./images/vcn-ttp-add-ingress.png "Add HTTP Ingress Rule")

7. On Security List for Default Security List for vcn_phoenix page, the new Ingress Rules will be shown under the Ingress Rules List

    ![View VCN HTTP](./images/vcn-ttp-ingress-completed.png"View VCN Completed HTTP Ingress rules")


You may now **proceed to the next lab**

## Acknowledgements
* **Author** - Biswanath Nanda, Principal Cloud Architect, North America Cloud Infrastructure - Engineering
* **Contributors** -  Biswanath Nanda, Principal Cloud Architect,Bhushan Arora ,Principal Cloud Architect,Sharmistha das ,Master Principal Cloud Architect,North America Cloud Infrastructure - Engineering
* **Last Updated By/Date** - Biswanath Nanda, March 2024
