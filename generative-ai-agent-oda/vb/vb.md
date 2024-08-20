# Setup OCI Visual Builder (VB)

## Introduction

This lab will take you through the steps needed to provision Oracle Visual Builder (VB)

Estimated Time: 30 minutes

### About Visual Builder

Oracle Visual Builder is a cloud-based software development platform and a hosted environment for your application development infrastructure. It provides an open source standards-based solution to develop, collaborate on, and deploy applications within Oracle Cloud.

In this workshop, we are using Visual Builder as the frontend solution end users will interact with. You can substitute this with any [frontend technology](https://docs.oracle.com/en/cloud/paas/digital-assistant/use-chatbot/channels-topic.html) with the ability to embed an ODA channel

### Objectives

In this lab, you will:

* Create a Visual Builder Instance
* Deploy a Visual Builder Application
* Customize the Application to use your ODA skill
* Provide end user access to the Application

### Prerequisites

This lab assumes you have:

* All previous labs successfully completed
* Must have an Administrator Account or Permissions to manage several OCI Services: Visual Builder, IDCS/Identity Domain Confidential Applications

## Task 1: Create VBCS Instance & Embed ODA Skill in VBCS Application

1. Click on main hamburger menu on OCI cloud console and navigate Developer Services > Visual Builder

    ![Visual Builder Navigation](images/vb_nav.png)

2. Create Visual Builder Instance by providing the details and click Create Visual Builder Instance:
    * Name =
    * Compartment =
    * Node =

    ![Visual Builder Create Wizard](images/vb_create_wizard.png)

3. Wait for the instance to come to Active (green color) status

4. Click on the link to download the VB application (zip file): ATOM_VB.zip
    [ATOM_VB.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/UcaJRNLr-UXQ55zFIOdS_rloRYfUSYA49sRGZsBON3ZNYncODcwC1DLdz7Xw4PJd/n/c4u02/b/hosted_workshops/o/ATOM_VB.zip)

5. Import the application in provisioned instance as per the screenshots. Users only need one VCBS instance created. They can import/create multiple applications in the instance for each additional chatbot they have
    * Click on Import from Visual Builder Instance

    ![Visual Builder Import](images/vb_import.png)

    * Choose the option as below

    ![Visual Builder import application from file](images/vb_import_type.png)

    * Provide the App Name with other details and select the provided application zip file

    ![Visual Builder import configuration](images/vb_import_config.png)

6. Once import is completed, update the index.html file
    * In the Web Applications sidebar on the left
    * Click on **atom**
    * On the main screen, make sure you are on the **HTML** tab for the **atom** Web Application
    * update the details as follows:
        * URI = 'oda-XXXXXXXXXXXX.data.digitalassistant.oci.oraclecloud.com/'
            * URI is the hostname of the ODA instance provisioned in Task 1 of the previous lab
        * channelId = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXX'
            * channelId is created during Task 5 - Step 3 of the previous lab
    ![Visual Builder update HTML](images/vb_update.png)

7. The UI of the chatbot such as theme, color and icon can be changed by modifying the parameters under var chatWidgetSetting from index.html

8. Click on the Play button shown in the above image on the top right corner to launch ATOM chatbot and start chatting with ATOM.

## Task 2: (optional) Setup Production version of VB

In this Task, we will use VB's development lifecycle to create a **Live** version of the app and get the corresponding url. Then we will setup access the app through OCI IAM. Once complete, you can distribute this app url to your end users. Before accessing the app, users will need to login using your Tenancy's login page.

1. Promote app to Live
    Visual Builder has management tools for application versioning and environments. Your app starts out with a 1.0 Development environment

    ![vb all applications](images/vb_all_applications.png)
    * In the Visual Builder Service Console, the first page to load should be the **All Applications** page (also available via hamburger menu in top left)
        * If you don't see the desired application, check the **Administered by me** box
        * click on the carrot button next to the name to see all versions of the app
    * To promote a version from Development to Staging, click on the ellipses menu on the right -> **Stage**
        **Note** Your choice for **Business Object Data** does not matter as this VB app stores no data.
    * To promote a version from Staging to Live, click on the ellipses menu on the right -> **Publish**
    * After publishing a live version, you will no longer be able to make changes to that version. You can create a new version of the app by clicking on the ellipses menu on the right -> **New Version**
        * The new version of the app will start in Development, and can be similarly promoted
    * To get the live url, click on the carrot button next to Live -> atom. The live app will open in a new Browser window
        * The url will follow the format `https://<VB_service_name>-vb-<tenancy_namespace>.builder.<region>.ocp.oraclecloud.com/ic/builder/rt/<VB_app_name>/live/webApps/atom/`

2. Enable Access to VB Apps
    * Note your VB instance name that was [created in Task 1 step 2](#task-1-create-vbcs-instance--embed-oda-skill-in-vbcs-application)
    * Navigate in the OCI Console to Identity & Security -> Identity -> Domains
        * If your tenancy does not have Identity Domains yet, follow [these instructions](https://docs.oracle.com/en/cloud/paas/app-builder-cloud/visual-builder-oci-admin/setting-users-and-groups-cloud-accounts-that-do-not-use-identity-domains-1.html#GUID-8B11C575-3CB9-4E46-BD09-17BD9B9897EE)
    ![Domain navigation](images/domain_nav.png)
    * Click on the domain tied to your VB instance
        * Likely the current domain, **Default** domain, or **OracleIdentityCloudService** domain
        * If you do not see these domains, change the compartment view to **root**
    * Under **Oracle Cloud Services**, search for your VB instance name or **VisualBuilder Cloud Service**
    ![domain cloud services](images/domain_cloud_services.png)
    * Click on the VB instance with naming convention {VB instance Name}-vb-{tenancy namespace}
    ![domain application roles](images/domain_app_roles.png)
    * under **Application roles** add users or groups (preferred) to the appropriate roles
        * Fellow Developers and Admins should be added to ServiceDeveloper or ServiceAdministrator roles
        * End Users should be added to the ServiceUser role
        * [See the documentation for privilege details](https://docs.oracle.com/en/cloud/paas/app-builder-cloud/visual-builder-oci-admin/oracle-visual-builder-roles-and-privileges-1.html#GUID-198BB498-5B16-4408-9E9C-86A1F6252083)
    ![domain add group](images/domain_add_group.png)
    * To add a group to a role:
        * click on the carrot button on the right side
        * click **Manage** under assigned groups
        * click **Show available groups**
        * check the box next to each group to add
        * click **Assign**

3. Troubleshooting Errors
    * You may face an issue when you go to publish the live link of the application. It may throw a "forbidden" error. The solution is to remove the "Admin" and "User" role in the JSON tab from all the vb pages - main-start, main-embedded-chat, and the shell page as shown in the image below.
    ![vb forbidden error](images/vb_forbidden_error.png)

<!-- TODO: no mention of security access or roles in shell page

  "security": {
    "access": {
      "requiresAuthentication": false
    }
  }
-->


<!--TODO: add optional step to track application access: https://console.us-ashburn-1.oraclecloud.com/loganalytics/explorer?savedSearchId=ocid1.manageme[…]df7ouna&jobId=77990570-11a2-ee33-03c8-62170cac7f82-->

## Acknowledgements

* **Author**
    * **Kaushik Kundu**, Master Principal Cloud Architect, NACIE
    * **JB Anderson**, Senior Cloud Engineer, NACIE
* **Contributors**
    * **Abhinav Jain**, Senior Cloud Engineer, NACIE
* **Last Updated By/Date**
    * **JB Anderson**, Senior Cloud Engineer, NACIE, August 2024
