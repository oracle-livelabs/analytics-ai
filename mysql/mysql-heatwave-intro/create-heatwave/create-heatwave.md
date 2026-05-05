# Create a HeatWave instance

## Introduction

In this lab, you will create a create a compartment, a Virtual Cloud Network,  and a Heatwave instance.  

_Estimated Time:_ 30 minutes

### Objectives

In this lab, you will be guided through the following tasks:

- Create compartment.
- Create Virtual Cloud Network.
- Configure security list to allow incoming connections.
- Configure security list to allow HTTP incoming connections.
- Create a HeatWave instance.

### Prerequisites

- An Oracle trial or paid cloud account.
- Some experience with MySQL Shell.
- You have logged into the OCI Console using the default identity domain.

## Task 1: Create Compartment

1. Click the **Navigation menu** in the upper left, navigate to **Identity & Security**, and under **Identity**, select **Compartments**.

    ![Select compartment](./images/1-select-compartment.png "Select compartment")

2. On the Compartments page, click **Create Compartment**.

3. In the **Create Compartment** dialog box, enter the following:

    **Name**:

    ```bash
    <copy>turbo</copy>
    ```

    **Description**:

    ```bash
    <copy>Compartment for Turbocharge</copy>
    ```

4. Click **Create Compartment**.

    ![Create a compartment](./images/2-create-compartment.png "Create a compartment")

## Task 2: Create Virtual Cloud Network

1. Click the **Navigation menu** in the upper left, navigate to **Networking**, and select **Virtual cloud networks**.

    ![Select VCN](./images/3-select-vcn.png "Select VCN")

2. Under **Compartment**, select **turbo**, and Click **Start VCN Wizard**.

    ![Start VCN Wizard](./images/4-start-vcn-wizard.png "Start VCN Wizard ")

3. In the **Start VCN Wizard** dialog box, select **Create VCN with Internet Connectivity**, and click **Start VCN Wizard**.

    ![Start VCN Wizard](./images/5-start-vcn-wizard-dialog-box.png "Start VCN Wizard ")

4. Under **Basic information**, provide a **VCN name**:

    ```bash
    <copy>heatwave-vcn</copy>
    ```

5. Ensure that **turbo** compartment is selected, and click **Next**.

    ![VCN configuration](./images/6-create-vcn-internet-connectivity.png "VCN configuration")

6. Review Oracle Virtual Cloud Network (VCN), Subnets, and Gateways, and click **Create**.

    ![Create VCN](./images/7-create-vcn.png "Create VCN")

7. When the Virtual Cloud Network is created, click **View VCN** to display the created VCN.

    ![View VCN](./images/8-view-vcn.png "View VCN")

## Task 3: Configure security list to allow incoming connections

1. On the **heatwave-vcn** page, under **Subnets**, click  **private subnet-heatwave-vcn**.

     ![Show subnet details](./images/9-heatwave-vcn-subnets.png "Show subnet details")

2. On **private subnet-heatwave-vcn** page, under **Security**, click  **security list for private subnet-heatwave-vcn**.

    ![Select security lists](./images/10-select-security-list.png "Select security lists")

3. Click  **security list for private subnet-mysql-vcn**.

    ![Select security lists](./images/11-select-security-list.png "Select security lists")

4. On the **security list for private subnet-heatwave-vcn** page, under **Ingress Rules**, click **Add Ingress Rules**.

    ![Add ingress rules](./images/11-add-ingress-rules.png "Add ingress rules")

5. On **Add Ingress Rules** panel, enter the following, and click **Add Ingress Rules**:

    **Source CIDR**:

    ```bash
    <copy>0.0.0.0/0</copy>
    ```

    **Destination Port Range**:

    ```bash
    <copy>3306,33060</copy>
    ```

    ![Ingress rules](./images/12-enter-ingress-rules.png "Ingress rules")

6. On **security list for private subnet-heatwave-vcn** page, the new ingress rules are shown under **Ingress Rules**.

    ![New ingress rules](./images/13-new-ingress-rules.png "New ingress rules")

## Task 4: Configure security list to allow HTTP incoming connections

1. Click the **Navigation menu** in the upper left, navigate to **Networking**, and select **Virtual cloud networks**.

    ![Select VCN](./images/3-select-vcn.png "Select VCN")

2. Under **Compartment**, ensure **turbo** is selected, and click the VCN you created, **heatwave-vcn**.

    ![Select VCN](./images/14-select-vcn.png "Select VCN")

3. On **mysql-vcn** page, click **Subnets**

    ![Select Subnet](./images/17-mysql-vcn.png "Select Subnet")

4. On the **heatwave-vcn** page, under **Subnets**, click  **public subnet-heatwave-vcn**.

    ![Select public subnet](./images/15-public-subnet.png "Select public subnet")

5. On the **public subnet-mysql-vcn** page, click **Security**.

    ![Select public subnet](./images/19-public-subnet-security.png "Select public subnet")

6. Under **Security**, click **Default Security List for heatwave-vcn**.

    ![Default security list](./images/16-default-security-list.png "Default security list")

7. Under **Security**, click **Security Rules**.

    ![Default Security Rules](./images/21-default-security-list.png "Default Security Rules")

8. On **Default Security List for heatwave-vcn** page, under **Ingress Rules**, click **Add Ingress Rules**.

    ![Add ingress rules in default security list](./images/17-add-ingress-rules-default-security-list.png "Add ingress rules in default security list")

9. On **Add Ingress Rules** panel, enter the following, and click **Add Ingress Rules**:

    **Source CIDR**:

    ```bash
    <copy>0.0.0.0/0</copy>
    ```

    **Destination Port Range**:

    ```bash
    <copy>80,443</copy>
    ```

    ![Ingress rules](./images/18-enter-ingess-rules-default-security-list.png "Ingress rules") 

10. On **Default Security List for heatwave-vcn** page, the new ingress rules are shown under **Ingress Rules**.

    ![New ingress rules](./images/19-new-ingress-rules-default-security-list.png "New ingress rules")

## Task 5: Create a HeatWave instance

1. Click the **Navigation menu** in the upper left, navigate to **Databases**, and under **HeatWave MySQL**, select **DB Systems**.

    ![Select HeatWave DB System](./images/20-select-heatwave-db-system.png "Select HeatWave DB System")

2. Ensure that **turbo** compartment is selected, and click **Create DB system**.

    ![Create DB system](./images/21-create-dbs.png "Create DB system")

3. In the **Create DB system** panel, select **Development or testing**.

4. Under **Create in compartment**, ensure **turbo** is selected, and enter a name and description for the DB system.

    **Name**:

    ```bash
    <copy>heatwave-db</copy>
    ```

    **Description**:

    ```bash
    <copy>HeatWave Database Instance</copy>
    ```

5. Enter the administrator credentials. *Note* the administrator credentials as you will need them to connect to the DB system.

    ![HeatWave DB system details](./images/22-create-dbs-admin.png "HeatWave DB system details")

6. Select **Standalone** instance, and select the VCN, **heatwave-vcn**, and private subnet, **private subnet-heatwave-vcn**, which you created earlier.

   ![Configure networking](./images/23-configure-networking.png "Configure networking")

7. Let the **Configure placement** settings remain as is.

    <!-- 8. Under **Configure hardware**, select **Enable HeatWave cluster**, and click **Change shape**.
           ![Change shape](./images/24-change-shape.png "Change shape")
    -->

8. Let the  **Configure hardware** settings remain as is.

    **Keep Shape**
       ![Keep shape](./images/24-keep-shape.png "Keep shape")

    **Keep HeatWave cluster**.
       ![Keep cluster](./images/24-keep-cluster.png "Keep cluster")


    <!-- 9. In the **Browse all shapes** page, ensure the compute model is **ECPU**, select **MySQL.32** shape, and click **Select a shape**. The ECPU Shape of the DB system must be MySQL.32.

    ![Select MySQL.32 shape](./images/25-select-mysql-32.png "Select MySQL.32 shape")

    10. Click **Configure HeatWave cluster**.

        ![Configure HeatWave cluster](./images/26-configure-heatwave-cluster.png "Configure HeatWave cluster")

    11. In **Configure HeatWave cluster** page, click **Change shape**.

        ![Change HeatWave shape](./images/27-change-heatwave-shape.png "Change Heatwave shape")

    12. In the **Browse all shapes** page, select **HeatWave.512** shape, and click **Select a shape**. The HeatWave Shape must be HeatWave.512.

        ![Change HeatWave shape](./images/28-select-heatwave-512.png "Change Heatwave shape")

    13. Select **HeatWave Lakehouse**, and click **Save changes**. HeatWave Lakehouse must be enabled on the DB system.

        ![Enable Lakehouse](./images/29-enable-lakehouse.png "Enable Lakehouse")

    -->

9. Disable backup by turning off the **Enable automatic backups** button and Click **Show advanced options**.
    ![Setup Backup Advanced](./images/24-backup-advanced.png "Setup Backup Advanced")

10. Go to the **Configuration** tab, and under **Database version**, select version **9.0.0 - Innovation** or higher version.

    ![Select database innovation version](./images/31-innovation-version.png "Select database innovation version")

11. Go to the **Connections** tab, enter the **Hostname**, which is same as DB system name, and click **Create**:

    **Hostname**:

    ```bash
    <copy>heatwave-db</copy>
    ```

    ![HeatWave hostname](./images/32-heatwave-hostname.png "HeatWave hostname")

12. While the DB system is created, the state is shown as **CREATING**.

    ![Show creating state](./images/33-dbs-creating.png "Show creating state")

You may now **proceed to the next lab**.

## Learn More

- [HeatWave User Guide](https://dev.mysql.com/doc/heatwave/en/)

- [HeatWave on OCI User Guide](https://docs.oracle.com/en-us/iaas/mysql-database/index.html)

- [MySQL Documentation](https://dev.mysql.com/)

## Acknowledgements

- **Author** - Aijaz Fatima, Product Manager
- **Contributors** - Mandy Pang, Senior Principal Product Manager
- **Last Updated By/Date** - Aijaz Fatima, Product Manager, July 2025
