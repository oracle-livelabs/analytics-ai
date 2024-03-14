# Provision Data Integrator, Autonomous Data Warehouse and Analytics Cloud

## Introduction

In this lab you will provision Data Integrator, Autonomous Data Warehouse, Oracle Analytics and all of the required networking components that are needed to complete this workshop.

Estimated Time: 30 minutes

### Objectives

- Provision a stack comprising of Data Integrator, Autonomous Data Warehouse and an Analytics Cloud instance.

### Prerequisites

- Ability to obtain IDCS Access Token to provision an analytics instance as part of the stack.
- Necessary permissions and quota to provision the stack in a compartment.

## Task 1: Obtain IDCS Access Token

1. Click on the **Navigation Menu** in the upper left, navigate to **Identity & Security** and select **Federation**.

	![OCI Console Federation](https://oracle-livelabs.github.io/common/images/console/id-federation.png "OCI Console Federation")

2. Click on the link to the **OracleIdentityCloudService**.

    ![Identity Domain](./images/select-idcs.png "Identity Domain")

3. In the page that opens, click on the Service Console URL.

    ![IDCS Service Console URL](./images/go-to-service-console.png "IDCS Service Console URL")

4. In the Identity Cloud Service Console, click on the user icon in the top right corner and select **My Access Tokens**.

    ![IDCS Access Token](./images/go-to-idcs-access-token-page.png "IDCS Access Token")

5. If you have access to the relevant APIs, you should be able to select them, under the **Invokes Identity Cloud Service APIs** radio button. Thereafter, enter the duration of validity of the token in minutes and click on the **Download Token** button.

    ![Download Access Token](./images/download-access-token.png "Download Access Token")

6. Open the token.tok file that you just downloaded. Keep it handy because in a few minutes you will need to copy the contents of this file.

    ![Keep the token handy](./images/open-the-token-file.png "Keep the token handy")

**Note:** You may follow the video [here](https://c4u04.objectstorage.us-ashburn-1.oci.customer-oci.com/p/EcTjWk2IuZPZeNnD_fYMcgUhdNDIDA6rt9gaFj_WZMiL7VvxPBNMY60837hu5hga/n/c4u04/b/livelabsfiles/o/data-management-library-files/mdw%20-%20idcs.mp4), if you are unsure of the steps above.

7. You may now close the Identity Cloud Service Console.

## Task 2: Provision the Stack

1. On the OCI architecture centre's page for [Departmental data warehousing - an EBS integration](https://docs.oracle.com/en/solutions/oci-ebs-analysis/index.html#GUID-A8644D8A-54F2-4015-90F1-7727C68E40CD), click on **Deploy to Oracle Cloud** under the **deploy** section. This should take you to the stack creation page. If you are prompted to login to OCI instead, then login to proceed.

    ![Deploy OCI EBS Analysis Stack](./images/deploy-to-oci.png "Deploy OCI EBS Analysis Stack")

2. On the next screen, review and accept the Oracle Terms of Use by selecting the check box. Doing so will auto-populate the description section and select the terraform version. Provide a name for the stack and choose a compartment for it. Then, hit **Next**.

    ![Configure Variables](./images/configure-stack-variables.png "Configure Variables")

3. On the **Configure Variables** screen, enter the passwords you wish to use for ADW, ODI database, VNC connection to the ODI compute instance, ODI database schema and the previously downloaded IDCS access token. Select the check box to reveal the advanced options.

    ![Configure Variables](./images/configure-stack-variables2.png "Configure Variables")

    ![Configure Variables](./images/configure-stack-variables3.png "Configure Variables")

4. Enter an appropriate display name and database name for the ADW instance. We also recommend checking the **Auto Scaling** box to enable auto-scaling of the database. Enabling this is optional, but recommended. You can leave everything else, as it is.

    ![Configure Variables](./images/configure-stack-variables4.png "Configure Variables")
    
5. Scroll down and provide a name for the analytics instance. Now hit **Next**.

    ![Configure Variables](./images/configure-stack-variables5.png "Configure Variables")

6. Review all the details and click on the **Create** button.

    ![Review and Create](./images/review-create-stack.png "Review and Create")
    
7. Now that the stack has been created, click on **Apply**. In the panel that appears, click on **Apply**, again.

    ![Apply Terraform](./images/apply-terraform.png "Apply Terraform")
    
    ![Approve Job](./images/start-job.png "Approve Job")
    
    ![Monitor Terraform Logs](./images/monitor-logs.png "Monitor Terraform Logs")

**Note:**  If you have followed the steps above the job should succeed without any issues. Keep an eye on the logs to monitor the progress. If the job fails, please fix the issues and proceed. To do so, click on **Stack Details** at the top of the page. Then, click on the **Edit** dropdown and select **Edit Stack** to get to the stack configuration page. Thereafter, you need to fix the errors and save the changes.

![View Stack Details](./images/see-stack-details.png "View Stack Details")
    
![Edit Stack Details](./images/edit-stack.png "Edit Stack Details")

8. If everything goes to plan, the status of the job will change to **SUCCEEDED**.

    ![Success Message](./images/successful-resource-creation.png "Success Message")

9. On the same page, you will find the **Outputs** under the **Resources** panel. Make a note of all the outputs marked in red in the image below. You will need all of them in the coming labs. Also copy the ssh\_private\_key and save it in a file. You will need the file to ssh into both, the bastion and the ODI instance. Save this key as **odi-adw-oac** in a folder named **odi-adw-oac**.

    ![Make Note of Stack Outputs](./images/note-stack-outputs.png "Make Note of Stack Outputs")
    
**Note:** You may use any names for the files and folders. We will be using the names that we mentioned above.

## Task 3: Download Autonomous Data Warehouse wallet file

1. Go to the **Job Resources** tab to get the links to the provisioned resources.

    ![Links to Associated Resources](./images/links-to-provisioned-resources.png "Links to Associated Resources")

2. Scroll down to the **oci\_database\_autonomous\_database** and open the page in a new tab, since you would need access to the current page from time-to-time.

    ![Go to Autonomous Database](./images/go-to-autonomous-database.png "Go to Autonomous Database")
  
3. Click on the **Database Connection** button. In the panel that appears, click on **Download Wallet**. You will be prompted to enter a password for the wallet file. Feel free to choose any password. This password has no relation to any of the passwords that you provided while provisioning the stack. Hit **Download**.

    ![Open Database Connection Panel](./images/database-connection.png "Open Database Connection Panel")
    
    ![Download Wallet](./images/download-wallet.png "Download Wallet")
    
    ![Protect Wallet with Password](./images/wallet-password.png "Protect Wallet with Password")

4. Move the downloaded file to the **odi-adw-oac** folder, as well.

**Note:** In the **Associated Resources** tab, clicking on the links to the resources takes you to their respective pages. However, there could be some resources that do not have links. To get to those resources, you will have to use the navigation menu. The instructions will be provided when needed. 

You may now **proceed to the next lab**.

## Acknowledgements
- **Authors** - Yash Lamba, Senior Cloud Engineer; Massimo Castelli, Senior Director Product Management. January 2021
- **Last Updated By/Date** - Yash Lamba, March 2023
