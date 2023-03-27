# Provision Resources

## Introduction

In this lab you will provision the resources required for this workshop.

Estimated Time: 30 minutes

### Objectives

Provision an Autonomous Data Warehouse instance and an Analytics Cloud instance.

### Prerequisites

- Method 1
    - IDCS Access Token to provision an analytics instance as part of the stack.
    - Necessary permissions to provision the stack in a compartment.

- Method 2
    - Necessary permissions to provision an analytics instance and an autonomous database.

## **METHOD 1:** Using a Resource Manager Stack

In order to provision an analytics cloud instance as part of a **Resource Manager** stack, an IDCS access token is required. If you don't have the necessary privileges, then proceed to Method 2.

### Task 1: Obtain IDCS Access Token

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

**Note:** If you don't have access to the required APIs, follow **Method 2**.

6. Open the token.tok file that you just downloaded. Keep it handy because in a few minutes you will need to copy the contents of this file.

    ![Keep the token handy](./images/open-the-token-file.png "Keep the token handy")

**Note:** You may follow the video [here](https://objectstorage.us-ashburn-1.oraclecloud.com/p/VEKec7t0mGwBkJX92Jn0nMptuXIlEpJ5XJA-A6C9PymRgY2LhKbjWqHeB5rVBbaV/n/c4u04/b/livelabsfiles/o/data-management-library-files/mdw%20-%20idcs.mp4), if you are unsure of the steps above.

7. You may now close the Identity Cloud Service Console.

### Task 2: Provision the Stack

1. Click on the **Navigation Menu** in the upper left, navigate to **Developer Services**, and select **Stacks**.

	![OCI Console Stacks](https://oracle-livelabs.github.io/common/images/console/developer-resmgr-stacks.png "OCI Console Stacks")

2. Click on the **Create Stack** button.

    ![Create Stack](./images/create-stack.png "Create Stack")

3. Select the **Template** radio button. Then, click on the **Select template** button.

    ![Select Template](./images/select-template.png "Select Template")

4. In the side menu that opens, select the **Architecture** tab and then check the **Departmental Data Warehousing** template and hit the **Select template** button.

    ![Departmental Data Warehouse Template](./images/select-departmental-data-warehousing.png "Departmental Data Warehouse Template")

5. Provide a name to the stack and hit **Next**.

    ![Provide Name](./images/configure-stack-variables.png "Provide Name")

6. On the **Configure Variables** screen, enter the admin password, database name and database display name.![Configure Variables](./images/configure-stack-variables2.png "Configure Variables")

7. Check the **Auto Scaling** box to enable auto-scaling of the database. Enabling this is optional, but recommended. Also, enter 0.0.0.0/0 in the public IP address field.

    ![Computer's Public IP Address](./images/configure-stack-variables3.png "Computer's Public IP Address")

8. Scroll down and provide a name to the analytics instance and paste the access token that you had downloaded earlier. Now, hit **Next**.

    ![Paste IDCS Access Token](./images/configure-stack-variables4.png "Paste IDCS Access Token")

9. Review all the details and click on the **Create** button.

    ![Review and Create](./images/review-create-stack.png "Review and Create")

10. Now that the stack has been created, click on **Apply**. In the panel that appears, click on **Apply**, again.

    ![Apply Terraform](./images/apply-terraform.png "Apply Terraform")

    ![Approve Job](./images/start-job.png "Approve Job")

    ![Monitor Terraform Logs](./images/monitor-logs.png "Monitor Terraform Logs")

**Note:**  If you have followed the steps above, the job should succeed without any issues. Keep an eye on the logs to monitor the progress. If the job fails, please fix the issues and proceed. To do so, click on **Stack Details** at the top of the page. Then, click on the **Edit** dropdown and select **Edit Stack** to get to the stack configuration page. Thereafter, you need to fix the errors and save the changes.

![View Stack Details](./images/see-stack-details.png "View Stack Details")
    
![Edit Stack Details](./images/edit-stack.png "Edit Stack Details")

11. If everything goes to plan, the status of the job will change to **SUCCEEDED**.

    ![Success Message](./images/successful-resource-creation.png "Success Message")

12. On the same page, you will find the **Job resources** under the **Resources** menu. Click on it to get the links to the provisioned resources.

    ![Links to Associated Resources](./images/links-to-provisioned-resources.png "Links to Associated Resources")

13. Clicking on the links to the resources should take you to their pages.

**Note:** In case there is no link to get to analytics instance, follow the two steps given below, else proceed to the next lab.

14. Click on the **Navigation Menu** in the upper left, navigate to **Analytics & AI**, and select **Analytics Cloud**. 
	
	![OCI Console Analytics Cloud](https://oracle-livelabs.github.io/common/images/console/analytics-oac.png "OCI Console Analytics Cloud")

15. Click on the analytics instance to get to its page. Thereafter, click on the **Analytics Home Page** button to access the instance.

    ![Access Analytics Instance](./images/access-analytics-instance.png "Access Analytics Instance")

    ![Go to Analytics Home Page](./images/go-to-analytics-home-page.png "Go to Analytics Home Page")

## **METHOD 2:** Independently Provision the Resources

### Task 1: Provision the Autonomous Data Warehouse

1. Click on the **Navigation Menu** in the upper left, navigate to **Oracle Database**, and select **Autonomous Data Warehouse**.
	
	![OCI Console Autonomous Data Warehouse](https://oracle-livelabs.github.io/common/images/console/database-adw.png "OCI Console Autonomous Data Warehouse")

2. Click on the **Create Autonomous Database** button.

    ![Create Autonomous Data Warehouse](./images/create-autonomous-database.png "Create Autonomous Data Warehouse")

3. Choose a compartment, enter the **Display Name** and also enter a name for the **Database**. Leave everything else set to the default values.

    ![Configure Variables](./images/configure-adw-variables.png "Configure Variables")

4. Scroll down and provide a password for the administrator.

    ![Provide Password](./images/provide-adw-password.png "Provide Password")

5. Choose an appropriate licence type and thereafter, hit **Create Autonomous Database**.

    ![Select Licence and Create](./images/choose-adw-licence.png "Select Licence and Create")

6. The database should be up and running in a couple of minutes.

    ![Autonomous Database Home Page](./images/access-adw-home-page.png "Autonomous Database Home Page")

**Note:** Keep this page open or make note of how to get here, since you will need to visit this page for the information required to connect to the database.

### Task 2: Provision the Analytics Cloud Instance

1. Click on the **Navigation Menu** in the upper left, navigate to **Analytics & AI**, and select **Analytics Cloud**. 
	
	![OCI Console Analytics Cloud](https://oracle-livelabs.github.io/common/images/console/analytics-oac.png "OCI Console Analytics Cloud")

2. On the next page, click on the **Create Instance** button.

    ![Create Analytics Instance](./images/create-analytics-instance.png "Create Analytics Instance")

3. Choose a compartment and provide a name for the instance. Let everything else stay the same. Then click on **Create**.

    ![Configure Variables](./images/set-analytics-variables.png "Configure Variables")

4. The instance will be up in 12-14 minutes. Once the instance is available, click on the **Open URL** button to gain access to the instance.

    ![Go to Analytics Home Page](./images/go-to-analytics-home-page.png "Go to Analytics Home Page")

You may now **proceed to the next lab**.

## Acknowledgements
 - **Authors** - Yash Lamba, Senior Cloud Engineer; Massimo Castelli, Senior Director Product Management. September 2020
 - **Contributors** - Maharshi Desai, Frankie OToole, Clarence Ondieki, Shikhar Mishra, Srihareendra Bodduluri, Arvi Dinavahi, Devika Chandrasekhar, Shikhar Mishra
 - **Last Updated By/Date** - Yash Lamba, March 2023

