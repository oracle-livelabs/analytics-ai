# Access AIDP Workbench Instance and Populate the Catalog

## Introduction

This lab guides you through the process of accessing an Oracle AI Data Platform (AIDP) Workbench instance, accessing the Autonomous AI Lakehouse (ALH) created alongside the AIDP Workbench, creating catalogs, and managing data within those catalogs. You'll learn how to set up access to your data and organize it for future use in notebooks and jobs.

Estimated Time: 45 minutes

### Objectives

In this lab, you will:

- Access an AIDP Workbench instance.
- Access Autonomous AI Lakehouse.
- Access the master catalog.
- Create internal and external catalogs.
- Manage data by creating schemas, tables, and volumes.

### Prerequisites

This lab assumes you have:

- An Oracle Cloud account.
- The necessary permissions to create and manage AIDP Workbench instances.

## Task 1: Access AIDP Workbench Instance and Add Yourself to the Admin Role

1. Log in to your Oracle Cloud Infrastructure (OCI) account and access the OCI Console.

2. From the OCI Console homepage, select the Navigation Menu, navigate to **Analytics and AI**, and select **AI Data Platform Workbench**.

    ![Accessing AIDP Workbench area in OCI](images/navigate-aidp.png)

3. Navigate to the compartment that was assignd to your reservation. Select the arrow under **Compartment**. Expand the root compartment then the **Livelabs** compartment. Select the compartment name you were assigned from the list. You can find your assigned compartment in the **Tenancy Information** section of your reservations information.

    ![Choose Compartment](images/find-compartment.png)

4. When you select your compartment you will see an AIDP Workbench instance appear. Select its name to access it. You may be prompted to login using the username assigned to your reservation and the password you set for it.

    ![Select AIDP instance](images/select-aidp-instance.png)

5. You are brought to the AIDP Workbench homepage. Before you can do anything, you first need to add yourself to the admin role. Select the **Roles** tab. 

    ![select roles](images/access-roles.png)

6. Select the **AI\_DATA\_PLATFORM\_ADMIN** role.

    ![select admin role](images/choose-admin-role.png)

7. Navigate to the **Members** tab then select the plus icon. 

    ![navigate to members](images/access-admin-members.png)

8. Under **Compartment** select the root compartment, **oaccommunity3**. For **Domain** select **Default**. You will see a list of users appear. Select your user, leave all other selections as is, and select **Create**. 

    ![add user to admin role](images/add-user-as-admin.png)

9. You will see your username populate on the **Members** tab. You are now a part of the admin group. Select the **Home** icon to return to the homepage.
    > **Note:** It is generally bad practice for a user to grant themselves permissons in this way, but is required for this lab setup.

    ![return home](images/return-home.png)


## Task 2: Access Autonomous AI Lakehouse Through an External Catalog

1. For this lab you will need an Autonomous AI lakehouse database. Luckily, AIDP Workbench creates spins one up for you when it is created. To access it, navigate to the **Master Catalog**. 
    > **Note:** This database is also accessible from the OCI console. From the navigator select **Oracle AI Database** then **Autonomous AI Database**.

    ![select master catalog](images/select-master-catalog.png)

2. On the Master Catalog tab, select the **vectordb26ai** catalog

    ![select catalog](images/choose-catalog.png)

3. Select the **Details** tab. This catalog connects to the Autonomous AI Lakehouse that our AIDP Workbench created for us, which you can confirm by looking at the details. Any data stored in this catalog will be stored in the underlying ALH.

    ![Show catalog details](images/catalog-details.png)

4. Select the **Actions** menu then **Rename Catalog**. Change its name to **supplier\_external\_26ai**.

    ![rename catalog](images/rename.png)

5. Select the Master Catalog breadcrumb to return to it.

    ![Select SQL database action](images/breadcrumb.png)

6. If you needed to connect to an already existing database, you could do so by selecting **Create Catalog** then selecting **External** for **Catalog type**. This opens the dialog to define the connection to the external database. Select **Cancel**.

    ![create catalog](images/create-catalog2.png)

    ![create external dialog](images/external-dialog.png)

7. Large Language Models that you will use later are also accessible through the Master Catalog. You can view the available foundational models by expanding the **default** catlog and the **oci\_ai\_models** schema. 
    ![show models](images/show-models.png)


## Task 3: Create and Populate a Standard Catalog in AIDP Workbench

Next you will create a standard catalog. Data in a standard catalog is stored with the AIDP Workbench in OCI, as opposed to an external database.

1. Use the breadcrumb menu to return to the master catalog if you are not already there. Select **Create catalog**.

    ![Create Catalog](images/create-catalog.png)

2. Enter the catalog name **Supplier**. Leave the **Catalog type** as **Standard catalog**. Select the same compartment your other lab assets are in and select **Create**.

    ![create catalog](images/create-supplier-catalog.png)

3. When the creation of the catalog is complete, select its name to access it.

    ![select catalog](images/view-standard-catalog.png)

4. Select **Create schema**.

    ![create schema](images/create-schema.png)

5. Enter the Schema Name **supplier\_schema** and select **Create**.

    ![create supplier schema](images/create-supplier-schema.png)

6. Select the **supplier_schema**.

    ![select schema](images/select-supplier-schema.png)

7. Select **Add to schema** and then **Table**.

    ![Create table](images/create-table-clicks.png)

8. Keep the **Table type** as **Managed**. Upload the **basic\_supplier.csv** file. Select **Preview data** and then **Create**. You can download the **basic\_supplier.csv** file and all other lab files at [this link](https://objectstorage.us-ashburn-1.oraclecloud.com/n/idmqvvdwzckf/b/LiveLab-Files_Bucket/o/aidp-workbench-ll-files.zip). This table is now viewable by selecting **Tables**.

    ![create table](images/create-basic-supplier.png)

9. Create another managed table, using the **supplier\_emotions.csv** file. Be sure to select **Preview** before creating the table.

    ![create emotions table](images/create-supplier-emotions-table.png)

10. Now you'll create a volume. Select **Add to schema**, and then **Volume**.

    ![create volume](images/create-volume-clicks.png)

11. Enter the Volume Name **supplier\_volume** and select **Managed** as the Volume type.

    ![set as managed volume](images/create-supplier-volume.png)

12. Select the **Volumes** tab and then the **supplier\_volume** volume you just created.

    ![select volume](images/access-supplier-volume.png)

13. Select the plus icon and then **Upload file**. Select the **supplier\_info.txt** file from your computer then choose **Upload**.

    ![upload file to volume](images/upload-to-volume.png)

You have now created your structured and unstructured data assets in AIDP Workbench that are ready to be processed into the bronze, silver, and gold tiers of a medallion architecture.

## Learn More

- [Oracle AI Data Platform Community Site](https://community.oracle.com/products/oracleaidp/)
- [Oracle AI Data Platform Documentation](https://docs.oracle.com/en/cloud/paas/ai-data-platform/)
- [Oracle Analytics Training Form](https://community.oracle.com/products/oracleanalytics/discussion/27343/oracle-ai-data-platform-webinar-series)
- [AIDP Workbench Creation Documentation](https://docs.oracle.com/en/cloud/paas/ai-data-platform/aidug/get-started-oracle-ai-data-platform.html#GUID-487671D1-7ACB-4A56-B3CB-272B723E573C)
- [AIDP Workbench Master Catalog Documentation](https://docs.oracle.com/en/cloud/paas/ai-data-platform/aidug/manage-master-catalog.html)
- [Permissions for AIDP Workbench Creation](https://docs.oracle.com/en/cloud/paas/ai-data-platform/aidug/iam-policies-oracle-ai-data-platform.html#GUID-C534FDF6-B678-4025-B65A-7217D9D9B3DA)

## Acknowledgements
* **Author** - Miles Novotny, Senior Product Manager, Oracle Analytics Service Excellence
* **Contributors** -  Farzin Barazandeh, Senior Principal Product Manager, Oracle Analytics Service Excellence
* **Last Updated By/Date** - Miles Novotny, March 2026
