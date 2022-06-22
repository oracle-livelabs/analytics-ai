# Create MySQL Database Service

![MySQL Database Service](images/mds-banner.png)

## Introduction

**MySQL Database Service** is a fully-managed Oracle Cloud Infrastructure service, developed, managed, and supported by the MySQL team in Oracle.

[](youtube:f-fVabi1tRA)

Estimated Time: 30 minutes.

### Objectives

In this section, you will:

- Create an instance of MySQL in Oracle Cloud.
- Connect and create the Database.
- Enable HeatWave Analytics Engine.

### Prerequisites

- All previous sections have been successfully completed.

## Task 1: Create an Instance of MySQL in the Cloud

1. Go to **Menu**, **Databases** and then click **DB Systems**.

   ![DB System Dashboard](images/mysql-menu.png)

2. Click **Create MySQL DB System**.

   Make sure your **root** compartment (or the one you want) is selected.

   ![Create MySQL DB System](images/mysql-create-button.png)

      - Name your MySQL instance: `mysql-analytics`
         ```
         <copy>mysql-analytics</copy>
         ```
      - Description (optional): `MySQL instance for Analytics`
         ```
         <copy>MySQL instance for Analytics</copy>
         ```

3. Between the three options, pick `HeatWave`. `Standalone` will work for the test, but it doesn't include the Analytics Engine that will improve performance for Analytics.

   For Username and password:

      - Username: `root`
         ```
         <copy>root</copy>
         ```
      - Password: `<your_password>`
      - Confirm Password: `<your_password>`

   ![MySQL create db fields](images/mysql-create-db-fields.png)

4. **Network** configuration:

      - Virtual Cloud Network: `nature`
      - Subnet: `Private Subnet-nature (Regional)`

   ![MySQL vcn fields](images/mysql-vcn-fields.png)

5. Everything else is good by **default**:

      - Configure placement: `AD-1`
      - Configure hardware: `MySQL.HeatWave.VM.Standard.E3` or Standalone (selected above) `MySQL.VM.Standard.E3.1.8GB`
      - Data Storage Size (GB): `50`
         ```
         <copy>50</copy>
         ```
      - Configure Backups: `Enable Automatic Backups`

6. Click **Create**.

   ![MySQL shape fields](images/mysql-shape-fields.png)

   The provisioning is around **10 minutes**. The icon should change to `ACTIVE` in green:

   ![Provisioning](images/mds-provisioning.png)

   ![Active](images/mds-active.png)

7. **Copy the Private IP address** from the MySQL DB System Information page. It will look like `10.0.1.xxx`.

   ![MySQL private IP](images/mysql-private-ip.png)

---

## Task 2: Connect and Create DB

1. Connect with **Cloud Shell** (if you close it or it is no longer active).

   ![Cloud Shell Dashboard](images/cloud-shell.png)

      - (If you are NOT inside the bastion host already) SSH into the bastion host: `ssh -i ~/.ssh/bastion opc@PUBLIC_IP`
      - Run MySQL Shell (replace `PRIVATE_IP` with your MDS IP value): 
         ```
         <copy>curl -sL https://bit.ly/3yoHvem | mysqlsh --sql --save-passwords=always root@PRIVATE_IP</copy>
         ```
   This command will download the SQL script, and pipe the content to MySQL Shell to be executed as SQL code. We also indicate with `--save-passwords=always` to save the password securely for future uses of MySQL Shell. It can take a few minutes, be patient.

2. If the terminal asks for the **password** (`Please provide the password for 'root@PRIVATE_IP':`).

      - Type the MySQL DB password: `<your_password>`

   If there is no error on the console, everything is ready to proceed.

   ![Create Schema Terminal](images/create-schema-mysql-terminal.png)

---

## Task 3: Enable HeatWave (Optional)

1. If and only if you have selected the **HeatWave** Shape `MySQL.HeatWave.VM.Standard.E3`, you should be able to **enable HeatWave Analytics Engine**.

2. Go to the **Resources Menu** > **HeatWave**.

   ![MDS Heatwave menu](images/mds-heatwave-menu.png)

3. Your HeatWave is disabled, add the HeatWave Cluster. Click **Add HeatWave Cluster**.

   ![MDS Heatwave Add cluster](images/mds-heatwave-add-cluster.png)

4. Leave the default values, and click **Add HeatWave Cluster**.

   ![MDS Heatwave shape](images/mds-heatwave-select-shape.png)

   Wait for the Cluster to be **created**.

   ![MDS Heatwave creating](images/mds-heatwave-creating.png)

5. **HeatWave** will be `Active` and the cluster nodes will be as well in `Active` state.

   ![MDS Heatwave active](images/mds-heatwave-active.png)

Congratulations! You are ready to go to the next Lab!

---

## **Acknowledgements**

- **Author** - Victor Martin, Technology Product Strategy Director
- **Contributors** - Priscila Iruela
- **Last Updated By/Date** - Priscila Iruela, June 2022