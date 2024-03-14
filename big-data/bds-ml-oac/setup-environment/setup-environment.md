<if type="livelabs">
# Review Creating BDS Environment Resources (Optional)
</if>

<if type="livelabs">
## Introduction

_In this **optional** lab, you will **only review** how to perform a few tasks that are required to get started with BDS. Since you are using the LiveLabs environment, most of the OCI resources that you need to create a BDS cluster are already created for you. We recommend that you at least review the list of OCI resources that you will use in this workshop in the table in the **Objectives** section._   

_In this LiveLabs version of the workshop, you **don't** have administrative privileges to create any OCI resources._

Several of the tasks shown in this lab need to be performed by the Cloud Administrator for your tenancy. There are also optional tasks that make it easier to manage your environment. For example, creating compartments and groups are optional; however, they will simplify administration tasks as your environment expands.

Estimated Time: 30 minutes

### Objectives

In this lab, you will review how to perform both the required and optional tasks described in the following table for educational purposes.

| Task                                                             | Purpose                                                                                                                                                                                                                                                                                                                 | Who?                                      | Required? |
|------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------|-----------|
| [Task 1: Log in to Oracle Cloud Console](#Task1:LogintotheOracleCloudConsole)                         | Log in to the Oracle Cloud Console to create a compartment, a user, a group, policies, a virtual cloud network, and a BDS cluster. | Cloud Administrator                      | No        |
| [Task 2: Create a Compartment for BDS Resources](#Task2:CreateaCompartment)                         | Create a compartment named **`training-compartment `** in your tenancy to help organize your BDS resources.                                                                                                                                         | Cloud Administrator                      | No        |
| [Task 3: Create an Identity and Access Management (IAM) User to be the BDS Administrator](#Task3:CreateanIAMUsertoBetheBDSAdministrator)           | Create a user named **`training-bds-admin`** that you will add to the administrators group to become a BDS Administrator.                                                                                                                                                                                                          | Cloud Administrator                      | No        |
| [Task 4: Create an IAM BDS Administrators Group and Add the New User to the Group](#Task4:CreateanIAMBDSAdministratorsGroupandAddtheNewUsertotheGroup) | <ul><li>Create an administrators group named **`training-bds-admin-group`** with permissions to create and manage your BDS resources.</ul></li><ul> <li>Add the new user to this group to become a BDS Administrator.</ul></li> | Cloud Administrator                      | No        |
| [Task 5: Create IAM Policies for Administering Your Service](#Task5:CreateIAMPoliciesforAdministeringYourService) |<ul><li>Create a policy named **`training-admin-policy`** to grant permissions to the BDS Administrator group to manage the cluster.</ul></li><ul><li>Create a second policy named **`training-bds-policy`** to grant permissions to BDS to create clusters in your tenancy.</ul></li>| Cloud Administrator or BDS Administrator   | **Yes**       |
| [Task 6: Create a Virtual Cloud Network (VCN)](#Task6:CreateaVirtualCloudNetwork(VCN))                             | Create a Virtual Cloud Network (VCN) in your tenancy named **`training-vcn`**, to be used by your cluster(s). Alternatively, you can use an existing VCN in the tenancy.                                                                                                                                                              | Cloud Administrator or BDS Administrator | **Yes**       |

### Prerequisites    
Login credentials and a tenancy name for the Oracle Cloud Infrastructure Console.


## Task 1: Log in to the Oracle Cloud Console

1. Log in to the **Oracle Cloud Console** as the Cloud Administrator. You will complete all the labs in this workshop using this Cloud Administrator.
See [Signing In to the Console](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/signingin.htm) in the _Oracle Cloud Infrastructure_ documentation.

2. On the **Sign In** page, select your tenancy, enter your username and password, and then click **Sign In**. The **Oracle Cloud Console** Home page is displayed.

   ![Console Home Page](./images/oracle-cloud-console-home.png " ")    

## Task 2: Create a Compartment
A Cloud Administrator can optionally create a compartment in your tenancy to help organize the Big Data Service resources. In this lab, as a Cloud Administrator, you will create a new compartment that will group all of your BDS resources that you will use in the lab.

> _**Note:** In this LiveLabs version of the workshop, you don't have administrative privileges to create any OCI resources._

1. Click the **Navigation** menu and navigate to **Identity & Security > Compartments**.

	 ![Create compartment navigation](./images/navigate-compartment.png " ")

2. On the **Compartments** page, click **Create Compartment**.

3. In the **Create Compartment** dialog box, enter **`training-compartment`** in the **Name** field and **`Training Compartment`** in the **Description** field.

4. In the **Parent Compartment** drop-down list, select your parent compartment, and then click **Create Compartment**.

   ![Create compartment](./images/create-compartment.png " ")

   The **Compartments** page is re-displayed and the newly created compartment is displayed in the list of available compartments.

   ![Compartment created](./images/compartment-created.png " ")

## Task 3: Create an IAM User to Be the BDS Administrator

A Cloud Administrator has complete control over all of the BDS resources in the tenancy; however, it's a good practice to delegate cluster administration tasks to one or more BDS administrators. To create a new BDS administrator for a service, a Cloud Administrator must create a user and then add that user to a BDS administrators group. You create Identity and Access Management (IAM) groups with access privileges that are appropriate to your needs.

Create a new **Administrator** group that will have full access rights to the new compartment that you created earlier as follows:

1. If you are still on the **Compartments** page from the previous task, click the **Users** link in the **Identity** section on the left; otherwise, click the **Navigation** menu and navigate to **Identity & Security > Users**.

2. On the **Users** page, click **Create User**.

   ![Create Users](./images/create-users-page.png " ")

3. In the **Create User** dialog box, enter **`training-bds-admin`** in the **Name** field, **`Training BDS Admin User`** in the **Description** field, an optional email address for the user in the **Email** field, and then click **Create**.

    > **Note:**
    An email address can be used as the user name, but it isn't required.

   ![Create User](./images/create-user.png " ")

4. The **User Details** page is displayed. Click **Users** in the breadcrumbs to return to the **Users** page.

   ![User details](./images/user-details.png " ")

   The new user is displayed in the list of available users.

   ![User created](./images/user-created.png " ")

    > **Note:** In this workshop, you will not login to OCI using the new **`training-bds-admin`** user that you just created in this Task; instead, you will continue your work using the same Cloud Administrator user that you used so far in this workshop. As a Cloud Administrator, you can create a one-time password for the new **`training-bds-admin`** user. The user must change the password during the first sign in to the Console. For additional information, see [Managing User Credentials](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Tasks/managingcredentials.htm) in the OCI documentation.

## Task 4: Create an IAM BDS Administrators Group and Add the New User to the Group

Create a BDS group whose members will be granted permissions to manage the BDS cluster life cycle.

1. If you are still on the **Users** page from the previous task, click the **Groups** link in the **Identity** section on the left; otherwise, click the **Navigation** menu and navigate to **Identity & Security > Groups**.

2. On the **Groups** Page, click **Create Group**.

   ![Create group](./images/create-group.png " ")

3. In the **Create Group** dialog box, enter **`training-bds-admin-group`** in the **Name** field, **`Training BDS Admin. Group`** in the **Description** field, and then click **Create**.

   ![Create group dialog](./images/create-group-dialog-box.png " ")

4. The **Group Details** page is displayed. In the **Group Members** section, click **Add User to Group**.   

   ![Group details page](./images/group-details-page.png " ")

5. In the **Add User to Group** dialog box, select the **`training-bds-admin`** user that you created earlier from the **Users** drop-down list, and then click **Add**.

   ![Add user to group](./images/add-user-group.png " ")

    > **Note:**
    If you haven't created the user who will be an administrator yet, go back to **Task 3: Create an IAM User to be the BDS Administrator to create the user**, create the user, and then return to this Task.

6. The **Group Details** page is re-displayed and the newly added user to this group is displayed in the **Group Members** section.

   ![User added to group](./images/user-added-to-group.png " ")

7. Click **Groups** in the breadcrumbs to re-display the **Groups** page. The newly created group is displayed in the list of available groups.

   ![Groups Page](./images/groups-page.png " ")


## Task 5: Create IAM Policies for Administering Your Service
Create Oracle Cloud Infrastructure Identity and Access Management (IAM) policies to grant privileges to users and groups to use and manage Big Data Service resources. Before you can create a cluster, you must also create a policy that grants the system access to networking resources.

1. If you are still on the **Groups** page from the previous task, click the **Policies** link in the **Identity** section on the left; otherwise, click the **Navigation** menu and navigate to **Identity & Security > Policies**.

2. On the **Policies** page, if your compartment is not selected, use the **Compartment** drop-down list in the **List Scope** section to search for and select the **`training-compartment`** where the new policies will reside.  

   ![Search box](./images/search-box.png " ")

   Type part of the compartment's name in the **Search compartments** text box. When the compartment is displayed in the list, select it.  

   ![Search compartment](./images/search-compartment.png " ")

3.  Click **Create Policy**.  

    ![Policies Page](./images/policies-page.png " ")

    The **Create Policy** dialog box is displayed.

    ![Create Policy](./images/create-policy-db-blank.png " ")


4. In the **Create Policy** dialog box, provide the following information:
    * Enter **`training-admin-policy`** in the **Name** field.
    - Enter **`Training Admin Group Policy`** in the **Description** field.
    - Select **`training-compartment`** from the **Compartment** drop-down list, if it's not already selected.
    - In the **Policy Builder** section, click and slide the **Show manual editor** slider to enable it. An empty text box is displayed in this section.

     ![Create Policy Dialog](./images/create-policy-1-dialog.png " ")

  + Click the **Copy** button in the following code box to copy the two policy statements, and then paste them in the **Policy Builder** text box. The first policy statement grants members of the `training-bds-admin-group` group manage privileges on the Virtual Cloud Network (VCN) resources in `training-compartment`. The second policy statement grants members of the `training-bds-admin-group` group manage privileges to inspect, read, update, create, delete, and move all clusters in `training-compartment`.

        ```
        <copy>allow group training-bds-admin-group to manage virtual-network-family in compartment training-compartment
        allow group training-bds-admin-group to manage bds-instance in compartment training-compartment</copy>
        ```

  + Select the **Create Another Policy** check box to create a second policy after your create the first policy.   

     ![Create policy completed](./images/create-policy-1-dialog-complete.png " ")

5. Click **Create**. A confirmation message is displayed. You can click the **View Details** link to display the **Policy Detail** page in a new tab in your browser. The **Create Policy** dialog box remains displayed because you selected the **Create Another Policy** check box. This enables you to create your second policy.

  ![Policy Created](./images/policy-created.png " ")

6. Create a new policy in the **`training-compartment`** which will contain policies about the network resources that will be used by your **`training-cluster`**. The policy statement in this new policy grants the system the rights to interact with various networking components. In the **Create Policy** dialog box, provide the following information:

    + Enter **`training-bds-policy`** in the **Name** field.
    + Enter **`Training BDS Service Policy`** in the **Description** field.
    + Use the **Compartment** drop-down list to select **training-compartment**, if you have not done that yet.
    + In the **Policy Builder** section, click the **Show manual editor** slider to enable it. An empty text box is displayed in this section.
    + Click the **Copy** button in the following code box to copy the policy statement, and then paste it in the **Policy Builder** text box. This policy statement allows the Big Data Service, **`bdsprod`**, to access the network, create instances, and more.

        ```
        <copy>allow service bdsprod to {VNC_READ, VNIC_READ, VNIC_ATTACH, VNIC_DETACH, VNIC_CREATE, VNIC_DELETE,VNIC_ATTACHMENT_READ, SUBNET_READ, VCN_READ, SUBNET_ATTACH, SUBNET_DETACH, INSTANCE_ATTACH_SECONDARY_VNIC, INSTANCE_DETACH_SECONDARY_VNIC} in compartment training-compartment</copy>
        ```

     ![Create Policy dialog](./images/create-policy-2-dialog.png " ")

     + Uncheck the **Create Another Policy** check box. Click **Create**.

     ![Create button](./images/click-create-button.png " ")

7. The **Policy Detail** page is displayed and the statement in the **training-bds-policy** is displayed in the **Statements** section.

       ![Policy detail page](./images/policy-2-detail-page.png " ")

8. Click **Policies** in the breadcrumbs to re-display the **Policies** page. The newly created policies are displayed in the list of available policies.

      ![Policy created](./images/policies-created.png " ")

      > **Note:** You can click the name of a policy on this page to view and edit its policy statements.


## Task 6: Create a Virtual Cloud Network (VCN)
In this task, you will create a new Virtual Cloud Network (VCN) that will be used by your Big Data Service cluster. In general, if you already have an existing VCN, you can use it instead of creating a new one; however, your existing VCN must be using a `Regional` subnet and the appropriate ports must be opened. In addition, if you want to make the cluster accessible from the public internet, the subnet must be public.      

1. Click the **Navigation** menu and navigate to **Networking > Virtual Cloud Networks**.

	![Nagiage VCN](./images/navigate-vcn.png " ")

2. On the **Virtual Cloud Networks** page, click **Start VCN Wizard**.  

   ![VCN details](./images/vcn-page.png " ")

3. In the **Start VCN Wizard** dialog box, select **VCN with Internet Connectivity**, and then click **Start VCN Wizard**.

   ![VCN Wizard](./images/start-vcn-wizard.png " ")        

3. The **Configuration** page of the wizard is displayed.

    In the **Basic Information** section, provide the following information:
    + **VCN NAME:** Enter **`training-vcn`**.
    + **COMPARTMENT:** Select **`training-compartment`**.

    ![Basic VCN Info](./images/basic-information.png " ")        

    In the **Configure VCN and Subnets** section, provide the following information:
    + **VCN CIDR BLOCK:** Enter the range of IP addresses for the network as a Classless Inter-Domain Routing (CIDR) block such as **`10.0.0.0/16`**.
    + **PUBLIC SUBNET CIDR BLOCK:** Enter the CIDR block for the public subnet such as **`10.0.0.0/24`**.
    + **PRIVATE SUBNET CIDR BLOCK:** Enter the CIDR block for the private subnet such as **`10.0.1.0/24`**.
    + In the **DNS RESOLUTION** section, select the **USE DNS HOSTNAMES IN THIS VCN** check box. This allows the use of host names instead of IP addresses for hosts to communicate with each other.

    ![Create subnets](./images/configure-vcn-subnets.png " ")        

4. Click **Next**. The **Review and Create** wizard's page is displayed. Review the details of the VCN. If you need to make any changes, click **Previous** and make the desired changes.

   ![VCN review](./images/vcn-review.png " ")

5. Click **Create**.

   ![Create VCN](./images/create-vcn.png " ")

6. When the VCN is created, you can click **View Virtual Cloud Network** to see the details of the network on the **Virtual Cloud Network Details** page.

   ![View VCN](./images/view-vcn.png " ")

7. The newly created VCN details page is displayed.

   ![VCN details](./images/vcn-details.png " ")

This concludes this lab. You may now proceed to the next lab.
</if>


<if type="freetier">
# Set Up Your BDS Environment Resources

## Introduction

In this lab, you will perform a few tasks that are required to get started with BDS. Several of these tasks need to be performed by the Cloud Administrator for your tenancy. There are also optional tasks that make it easier to manage your environment. For example, creating compartments and groups are optional; however, they will simplify administration tasks as your environment expands.

Estimated Lab Time: 30 minutes

### Objectives

In this lab, you will practice performing both the required and optional tasks described in the following table for educational purposes. If you have restrictions on what you can create in your setup, you can use your existing resources; however, make a note of your resources' names which you will need when you create your cluster in the next lab.

### Prerequisites    
The Tasks in this lab and any other labs should be performed sequentially.

| Task                                                             | Purpose                                                                                                                                                                                                                                                                                                                 | Who?                                      | Required? |
|------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------|-----------|
| [Task 1: Log in to Oracle Cloud Console](#Task1:LogintotheOracleCloudConsole)                         | Log in to the Oracle Cloud Console to create a compartment, a user, a group, policies, a virtual cloud network, and a BDS cluster. | Cloud Administrator                      | No        |
| [Task 2: Create a Compartment for BDS Resources](#Task2:CreateaCompartment)                         | Create a compartment named **`training-compartment `** in your tenancy to help organize your BDS resources.                                                                                                                                         | Cloud Administrator                      | No        |
| [Task 3: Create an Identity and Access Management (IAM) User to be the BDS Administrator](#Task3:CreateanIAMUsertoBetheBDSAdministrator)           | Create a user named **`training-bds-admin`** that you will add to the administrators group to become a BDS Administrator.                                                                                                                                                                                                          | Cloud Administrator                      | No        |
| [Task 4: Create an IAM BDS Administrators Group and Add the New User to the Group](#Task4:CreateanIAMBDSAdministratorsGroupandAddtheNewUsertotheGroup) | <ul><li>Create an administrators group named **`training-bds-admin-group`** with permissions to create and manage your BDS resources.</ul></li><ul> <li>Add the new user to this group to become a BDS Administrator.</ul></li> | Cloud Administrator                      | No        |
| [Task 5: Create IAM Policies for Administering Your Service](#Task5:CreateIAMPoliciesforAdministeringYourService) |<ul><li>Create a policy named **`training-admin-policy`** to grant permissions to the BDS Administrator group to manage the cluster.</ul></li><ul><li>Create a second policy named **`training-bds-policy`** to grant permissions to BDS to create clusters in your tenancy.</ul></li>| Cloud Administrator or BDS Administrator   | **Yes**       |
| [Task 6: Create a Virtual Cloud Network (VCN)](#Task6:CreateaVirtualCloudNetwork(VCN))                             | Create a Virtual Cloud Network (VCN) in your tenancy named **`training-vcn`**, to be used by your cluster(s). Alternatively, you can use an existing VCN in the tenancy.                                                                                                                                                              | Cloud Administrator or BDS Administrator | **Yes**       |

### Prerequisites    
Login credentials and a tenancy name for the Oracle Cloud Infrastructure Console.


## Task 1: Log in to the Oracle Cloud Console

1. Log in to the **Oracle Cloud Console** as the Cloud Administrator. You will complete all the labs in this workshop using this Cloud Administrator.
See [Signing In to the Console](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Tasks/signingin.htm) in the _Oracle Cloud Infrastructure_ documentation.

2. On the **Sign In** page, select your tenancy, enter your username and password, and then click **Sign In**. The **Oracle Cloud Console** Home page is displayed.

   ![Oracle Cloud Console](./images/oracle-cloud-console-home.png " ")    

## Task 2: Create a Compartment
A Cloud Administrator can optionally create a compartment in your tenancy to help organize the Big Data Service resources. In this task, as a Cloud Administrator, you will create a new compartment that will group all of your BDS resources that you will use in the workshop.

1. Click the **Navigation** menu and navigate to **Identity & Security > Compartments**.

	 ![Navigate Compartment](./images/navigate-compartment.png " ")

3. On the **Compartments** page, click **Create Compartment**.

4. In the **Create Compartment** dialog box, enter **`training-compartment`** in the **Name** field and **`Training Compartment`** in the **Description** field.

5. In the **Parent Compartment** drop-down list, select your parent compartment, and then click **Create Compartment**.

   ![Create Compartment](./images/create-compartment.png " ")

   The **Compartments** page is re-displayed and the newly created compartment is displayed in the list of available compartments.

   ![Compartment created](./images/compartment-created.png " ")

## Task 3: Create an IAM User to Be the BDS Administrator

A Cloud Administrator has complete control over all of the BDS resources in the tenancy; however, it's a good practice to delegate cluster administration tasks to one or more BDS administrators. To create a new BDS administrator for a service, a Cloud Administrator must create a user and then add that user to a BDS administrators group. You create Identity and Access Management (IAM) groups with access privileges that are appropriate to your needs.

Create a new **Administrator** group that will have full access rights to the new compartment that you created earlier as follows:

1. If you are still on the **Compartments** page from the previous task, click the **Users** link in the **Identity** section on the left; otherwise, click the **Navigation** menu and navigate to **Identity & Security > Users**.

2. On the **Users** page, click **Create User**.

   ![Create Users](./images/create-users-page.png " ")

3. In the **Create User** dialog box, enter **`training-bds-admin`** in the **Name** field, **`Training BDS Admin User`** in the  **Description** field, an optional email address for the user in the **Email** field, and then click **Create**.

    > **Note:**
    An email address can be used as the user name, but it isn't required.

   ![Create User](./images/create-user.png " ")

4. The **User Details** page is displayed. Click **Users** in the breadcrumbs to return to the **Users** page.

   ![User details](./images/user-details.png " ")

   The new user is displayed in the list of available users.

   ![User created](./images/user-created.png " ")

    > **Note:** In this workshop, you will not login to OCI using the new **`training-bds-admin`** user that you just created in this Task; instead, you will continue your work using the same Cloud Administrator user that you used so far in this workshop. As a Cloud Administrator, you can create a one-time password for the new **`training-bds-admin`** user. The user must change the password during the first sign in to the Console. For additional information, see [Managing User Credentials](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Tasks/managingcredentials.htm) in the OCI documentation.

## Task 4: Create an IAM BDS Administrators Group and Add the New User to the Group

Create a BDS group whose members will be granted permissions to manage the BDS cluster life cycle.

1. If you are still on the **Users** page from the previous task, click the **Groups** link in the **Identity** section on the left; otherwise, click the **Navigation** menu and  navigate to **Identity & Security > Groups**.

3. On the **Groups** Page, click **Create Group**.

   ![Create group](./images/create-group.png " ")

4. In the **Create Group** dialog box, enter **`training-bds-admin-group`** in the **Name** field, **`Training BDS Admin. Group`** in the **Description** field, and then click **Create**.

   ![Create group dialog](./images/create-group-dialog-box.png " ")

5. The **Group Details** page is displayed. In the **Group Members** section, click **Add User to Group**.   

   ![Group details](./images/group-details-page.png " ")

6. In the **Add User to Group** dialog box, select the **`training-bds-admin`** user that you created earlier from the **USERS** drop-down list, and then click **Add**.

   ![Add user to group](./images/add-user-group.png " ")

    > **Note:**
    If you haven't created the user who will be an administrator yet, go back to **Task 3: Create an IAM User to be the BDS Administrator to create the user**, create the user, and then return to this Task.

7. The **Group Details** page is re-displayed and the newly added user to this group is displayed in the **Group Members** section.

   ![User added to group](./images/user-added-to-group.png " ")

8. Click **Groups** in the breadcrumbs to re-display the **Groups** page. The newly created group is displayed in the list of available groups.

   ![Groups Page](./images/groups-page.png " ")


## Task 5: Create IAM Policies for Administering Your Service
Create Oracle Cloud Infrastructure Identity and Access Management (IAM) policies to grant privileges to users and groups to use and manage Big Data Service resources. Before you can create a cluster, you must also create a policy that grants the system access to networking resources.

1. In the **Identity** section on the left, select **Policies**. Alternatively, click the **Navigation** menu and navigate to **Identity & Security > Policies**.

2. On the **Policies** page, if your compartment is not selected, use the **Compartment** drop-down list in the **List Scope** section to search for and select the **`training-compartment`** where the new policies will reside.  

   ![Search box](./images/search-box.png " ")

   Type part of the compartment's name in the **Search compartments** text box. When the compartment is displayed in the list, select it.  

   ![Search Compartment](./images/search-compartment.png " ")

3.  Click **Create Policy**.  

    ![Policies Page](./images/policies-page.png " ")

    The **Create Policy** dialog box is displayed.

    ![Create Policy](./images/create-policy-db-blank.png " ")


4. In the **Create Policy** dialog box, provide the following information:
    * Enter **`training-admin-policy`** in the **Name** field.
    - Enter **`Training Admin Group Policy`** in the **Description** field.
    - Select **`training-compartment`** from the **Compartment** drop-down list, if it's not already selected.
    - In the **Policy Builder** section, click and slide the **Show manual editor** slider to enable it. An empty text box is displayed in this section.

     ![Create Policy](./images/create-policy-1-dialog.png " ")

    + Click the **Copy** button in the following code box to copy the two policy statements, and then paste them in the **Policy Builder** text box. The first policy statement grants members of the `training-bds-admin-group` group manage privileges on the Virtual Cloud Network (VCN) resources in `training-compartment`. The second policy statement grants members of the `training-bds-admin-group` group manage privileges to inspect, read, update, create, delete, and move all clusters in `training-compartment`.

        ```
        <copy>allow group training-bds-admin-group to manage virtual-network-family in compartment training-compartment
        allow group training-bds-admin-group to manage bds-instance in compartment training-compartment</copy>
        ```

    + Select the **Create Another Policy** check box to create a second policy after your create the first policy.   

     ![Create Policy Completed](./images/create-policy-1-dialog-complete.png " ")

5. Click **Create**. A confirmation message is displayed. You can click the **View Details** link to display the **Policy Detail** page in a new tab in your browser. The **Create Policy** dialog box remains displayed because you selected the **Create Another Policy** check box. This enables you to create your second policy.

  ![Policy Created](./images/policy-created.png " ")

6. Create a new policy in the **`training-compartment`** which will contain policies about the network resources that will be used by your **`training-cluster`**. The policy statement in this new policy grants the system the rights to interact with various networking components. In the **Create Policy** dialog box, provide the following information:

    + Enter **`training-bds-policy`** in the **Name** field.
    + Enter **`Training BDS Service Policy`** in the **Description** field.
    + Use the **Compartment** drop-down list to select **training-compartment**, if you have not done that yet.
    + In the **Policy Builder** section, click the **Show manual editor** slider to enable it. An empty text box is displayed in this section.
    + Click the **Copy** button in the following code box to copy the policy statement, and then paste it in the **Policy Builder** text box. This policy statement allows the Big Data Service, **`bdsprod`**, to access the network, create instances, and more.

        ```
        <copy>allow service bdsprod to {VNC_READ, VNIC_READ, VNIC_ATTACH, VNIC_DETACH, VNIC_CREATE, VNIC_DELETE,VNIC_ATTACHMENT_READ, SUBNET_READ, VCN_READ, SUBNET_ATTACH, SUBNET_DETACH, INSTANCE_ATTACH_SECONDARY_VNIC, INSTANCE_DETACH_SECONDARY_VNIC} in compartment training-compartment</copy>
        ```

     ![Create Policy](./images/create-policy-2-dialog.png " ")

    + Uncheck the **Create Another Policy** check box. Click **Create**.

     ![Create Policy](./images/click-create-button.png " ")

7. The **Policy Detail** page is displayed and the statement in the **training-bds-policy** is displayed in the **Statements** section.

     ![Policy Details](./images/policy-2-detail-page.png " ")

8. Click **Policies** in the breadcrumbs to re-display the **Policies** page. The newly created policies are displayed in the list of available policies.

     ![Policy Created](./images/policies-created.png " ")

      > **Note:** You can click the name of a policy on this page to view and edit it.


## Task 6: Create a Virtual Cloud Network (VCN)
In this task, you will create a new Virtual Cloud Network (VCN) that will be used by your Big Data Service cluster. In general, if you already have an existing VCN, you can use it instead of creating a new one; however, your existing VCN must be using a `Regional` subnet and the appropriate ports must be opened. In addition, if you want to make the cluster accessible from the public internet, the subnet must be public.      

1. Click the **Navigation** menu and navigate to **Networking > Virtual Cloud Networks**.

	 ![Navigate VCN](./images/navigate-vcn.png " ")

2. On the **Virtual Cloud Networks** page, click **Start VCN Wizard**.  

   ![VCN page](./images/vcn-page.png " ")

3. In the **Start VCN Wizard** dialog box, select **VCN with Internet Connectivity**, and then click **Start VCN Wizard**.

   ![Start VCN Wizard](./images/start-vcn-wizard.png " ")        

3. The **Configuration** page of the wizard is displayed.

    In the **Basic Information** section, provide the following information:
    + **VCN NAME:** Enter **`training-vcn`**.
    + **COMPARTMENT:** Select **`training-compartment`**.

    ![Basic information](./images/basic-information.png " ")        

    In the **Configure VCN and Subnets** section, provide the following information:
    + **VCN CIDR BLOCK:** Enter the range of IP addresses for the network as a Classless Inter-Domain Routing (CIDR) block such as **`10.0.0.0/16`**.
    + **PUBLIC SUBNET CIDR BLOCK:** Enter the CIDR block for the public subnet such as **`10.0.0.0/24`**.
    + **PRIVATE SUBNET CIDR BLOCK:** Enter the CIDR block for the private subnet such as **`10.0.1.0/24`**.
    + In the **DNS RESOLUTION** section, select the **USE DNS HOSTNAMES IN THIS VCN** check box. This allows the use of host names instead of IP addresses for hosts to communicate with each other.

    ![Configure Subnets](./images/configure-vcn-subnets.png " ")        

4. Click **Next**. The **Review and Create** wizard's page is displayed. Review the details of the VCN. If you need to make any changes, click **Previous** and make the desired changes.

   ![VCN Review](./images/vcn-review.png " ")

5. Click **Create**.

   ![Create VCN](./images/create-vcn.png " ")

6. When the VCN is created, you can click **View Virtual Cloud Network** to see the details of the network on the **Virtual Cloud Network Details** page.

   ![View VCN](./images/view-vcn.png " ")

7. The newly created VCN details page is displayed.

   ![VCN Details](./images/vcn-details.png " ")

This concludes this lab. You may now proceed to the next lab.
   </if>

## Want to Learn More?

* [Overview of Oracle Cloud Infrastructure Identity and Access Management (IAM)](https://docs.cloud.oracle.com/en-us/iaas/Content/Identity/Concepts/overview.htm)
* [Understand Big Data Service Resources and Permissions in IAM Policies](https://docs.oracle.com/en/cloud/paas/big-data-service/user/bds-resources-and-permissions-use-iam-policies.html)
* [VCN and Subnets](https://docs.cloud.oracle.com/iaas/Content/Network/Tasks/managingVCNs.htm)
* [Create a Network](https://docs.oracle.com/en/cloud/paas/big-data-service/user/create-network.html#GUID-36C46027-65AB-4C9B-ACD7-2956B2F1B3D4)
* [Using Oracle Big Data Service](https://docs.oracle.com/en/cloud/paas/big-data-service/user/index.html)
* [Oracle Cloud Infrastructure Documentation](https://docs.cloud.oracle.com/en-us/iaas/Content/GSG/Concepts/baremetalintro.htm)
* [Oracle Cloud Infrastructure Self-paced Learning Modules](https://www.oracle.com/cloud/iaas/training/foundations.html)
* [Overview of Compute Service](https://www.oracle.com/pls/topic/lookup?ctx=cloud&id=oci_compute_overview)


## Acknowledgements
* **Authors:**
    * Vivek Verma, Master Principal Cloud Architect, North America Cloud Engineering
* **Contributors:**
    * Anand Chandak, Principal Product Manager, Data and AI
* **Last Updated By/Date:** Vivek Verma, December 2023
