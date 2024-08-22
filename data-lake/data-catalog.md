# OCI Data Integration, OCI Data Catalog and Data Assets

## Introduction

Here we will create our OCI Data Catalog and OCI Data Integration workspace first and create a couple of additional data assets along with discovering our ADW database as a data asset.

Estimated Time: 15 minutes

### About Product

In this lab, we will learn more about the OCI Data Catalog which is used in enterprises to manage technical, business and operational metadata - see the [documentation](https://docs.oracle.com/en-us/iaas/data-catalog/home.htm) for more information.

We will also discuss OCI Data Integration as part of data asset ETL and you can learn more here - [documentation](https://docs.oracle.com/en-us/iaas/data-integration/home.htm).

### Objectives

- Learn how to create OCI Data Integration Workspace
- Learn how to create OCI Data Catalog
- Learn how to discover and create new data assets

## Task 1: Create the OCI Data Integration workspace

Creation of the OCI Data Integration workspace is needed for the data flow and other ETL procedures. Now it is a matter of navigating to the Data Integration space and creating the workspace which will in turn allow us to create ETL processes.

1. From the home navigation menu, click Analytics & AI and then click Data Integration.

    ![Data Integration](./images/nav_dataintegration.png " ")

    Here you will create a Workspace which will allow for diagramming the data flows with filters and create execution plans for data into the data assets. First, we must create the workspace and a couple more policies for the workspace to access the object storage and use and update the data in the data lake.

    ![Workspace in Lakehouse](./images/create_workspace1a.png " ")

2. Click on Create Workspace. Name it Workspace Lakehouse, uncheck the Enable the Private Network option and click the Create button.

    ![Create Workspace](./images/create_workspace.png " ")

3. As the workspace is being created copy the OCID by clicking on the menu to the far right of the workspace, and from the pop-up menu click on Copy OCID. This is needed to create policies for access to this workspace.

    ![Create Workspace](./images/workspaceOCID.png " ")

    Note: In another lab or configurations you will want to setup VPNs and a private network, but the focus is on these services for the Lakehouse and additional information on private networks can be

4. While that is creating, navigate back to Policies. Click on Identity & Security and then Policies.

5. Create a dataintegrationWS policy. Slide the Show Manual Editor to yes and then you can copy the statements and replace the text in request.principal.id with the copied OCID.

    ![Add Policies](./images/create_policy.png " ")

    Use the following three allow statements to add into the existing policy, and then Save Changes.

    ```
    <copy>
    allow any-user to use buckets in compartment lakehouse1 where ALL {request.principal.type='disworkspace',request.principal.id='REPLACE_WITH_WORKSPACE OCID'}

    allow any-user to manage objects in compartment lakehouse1 where ALL {request.principal.type='disworkspace',request.principal.id='REPLACE_WITH_WORKSPACE OCID'}

    allow any-user to manage buckets in compartment lakehouse1 where ALL {request.principal.type='disworkspace', request.principal.id='REPLACE_WITH_WORKSPACE OCID', request.permission='PAR_MANAGE'}

    </copy>
    ```

    Once the workspace has been created (a refresh of the screen might be needed to go from Processing to Active) move onto task 2.

## Task 2: Create the Data Assets in the workspace

1. In the top right hand corner navigate to user profile, click, and then click on tenancy. You want to make sure to grab the Tenancy OCI and save it off for use with different connection informations for your data assets.

    The Tenancy OCID you might have saved to the side, but if not, go to the user profile and click on Tenancy and copy the OCID. Save this OCID to copy and paste into the correct field in the data assets for the database and object storage.

    ![Create Data Asset](./images/tenancy_OCID.png =50%x*)

2. Navigate back to the Workspace Lakehouse in Data Integration.
Under Quick Actions, you want to click on **Create Data Asset**

    ![Create Data Asset](./images/create_dataasset1.png " ")

    Select Oracle ADW from the list of data asset types.

    ![Select Oracle ADW as the data asset type](./images/create_dataasset.png " ")

    The first data asset is going to be our ADW database we already created. Fill in MOVIESTREAM_ADW and select type to Oracle Autonomous Data Warehouse.

    Continue to fill with Select Database, regions, Tenancy OCID that you saved off to the side, or if you need to find it again click on your profile, then click on Tenancy and copy the OCID. Make sure the compartment is lakehouse1 and DB is lakehousedb.

    ![Create Data Asset](./images/create_dataasset2.png " ")

    Using the default connection you can put in User Name ADMIN and the password you configured for your database, and select the TNS Alias from the dropdown.

    ![Create Data Asset](./images/create_dataasset4.png " ")

    Test Connection to make sure you can connect to this data asset and then select create.

3. Now lets create the second data asset which will be the dataflow-warehouse bucket that you created for data flows. Click on Create Data Asset. Fill in the name **dataflow-warehouse-bucket** Choose **Oracle Object Storage** for **Type**.

    ![Create Data Asset](./images/create_dataasset6.png " ")

    Then copy in the Tenancy OCID. 

    The Namespace will populate once the tenancy was entered and then enter the region ID. The region ID you can get from clicking the dropdown menu by regions and click on manage region. Your current region should be listed at the top of the list.

    ![Create Data Asset](./images/regionID.png " ")

    ![Create Data Asset](./images/create_dataasset7.png " ")

    Test Connection to make sure you can connect to the this data asset. Click on 'data assets' to see both of the Data Assets that we have added.

    ![Create Data Asset](./images/create_dataasset8.png " ")

## Task 3: Create a project in the workspace

- Click on the Workspace Lakehouse.
- Click on Projects, and then Create Project
- Enter Name Project_lakehouse
- Click Create

![Create Project](./images/create_project.png " ")

![Create Project Fields](./images/create_project2.png " ")

You have now configured this data lake by creating a database, data sources in object storage. Configuration is completed from access to services and are ready to use in this project.

## Task 4: Create the OCI Data Catalog

In this task, you will create the OCI Data Catalog. Review options for creating business term to sync with the metadata for the data assets.
1. Navigate to the Data Catalog by clicking on Analytics & AI, and then Data Catalog. Then click Data Catalogs.

    ![Navigate to Analytics](./images/navdatacatalog.png " ")

    ![Navigate to Data Catalog](./images/navdatacatalog2.png " ")

2. Click on Create Data Catalog. Create in Compartment, lakehouse1, and name the catalog, lakehousecatalog. Click on Create.

    ![Create Catalog](./images/create_datacatalog1.png " ")

    ![Create Catalog](./images/create_datacatalog.png " ")

3. Explore the Data Catalog:

    - Data Assets, some we will discover and others we will just create to use with this data lake.
    - Data Entities, these come from the data assets as there can be multiple entities in each data asset
    - Glossaries, these are business terms for mappings of the data and definitions with columns and data assets.
    - Categories and Terms, more business terms can be defined here to maintain consistent groupings of data.
    - Jobs, refresh and harvest data jobs that will be run and scheduled to keep data current.

    ![View Catalog](./images/datacatalog_overview.png " ")

## Task 5: Discover data assets and configure connections

In this step, you will discover the data assets already available in the ADW and Object Storage. We will also create new data assets that we might get from another source or API.
1. From the Quick Menu on the Home tab, click Discover Data Sources.

    ![Data Discovery](./images/discoverdata.png " ")

2. As you can there is the data warehouse database available and object storage buckets. Select the box for the ADW and then click Create Data Asset. The name and description and type will automatically be filled in and you can adjust and make changes as needed. Do these steps for both the ADW Database and the Object Store.

3. If you manually add the database outside of the discovery, you will need to provide the details that were automatically loaded. The wallet file would have to be copied from the database connection information. Data discovery is the simplest way to go, and you can actually put in other compartments for the catalog.

    ![Add Data Assets](./images/catalog_addasset.png " ")

4. The connection still needs to be added to be able to harvest the data and any changes, such as new tables, views. The harvesting of the data can be scheduled to happen every hour. Click on Add Connection.

    ![Add Data Assets](./images/add_dbconnection.png " ")

    Because of all information coming in from discovery, the connection information is almost all there except for the user name and password. You should be using ADMIN and Password that you set up for the database at creation.

    ![Add Data Assets](./images/add_conn_db.png " ")

5. You can test the connection here before performing a harvest of the data asset.

    ![Add Data Assets](./images/add_conn_db2.png " ")

6. In the next task you will harvest data again, but this would normally be scheduled, but here you can harvest the data now to see the initial tables and as more are added, you will see them appear after the refresh in the entities.

    ![Harvest](./images/harvest1.png " ")


## Task 6: New table to demonstrate catalog discovery

In this step, you will simply be creating a new table to verify that the table is now part of the discovered entities in the OCI Data Catalog.

1. Navigate from the main menu to Autonomous Data Warehouse. Select the lakehousedb. If the database is not listed, double check the compartment is set to lakehouse1.

    ![Database](./images/Databaselisting.png " ")

2. Click on the database and then proceed to click on the Tools Tab and click on Open Database Actions.

    ![Database Actions](./images/dbactionssql.png " ")

3. You are going to copy and paste the following code to build the MOVIE_GENRE table that we will use later in our data feed process and end queries.

    ```
    <copy>
    CREATE TABLE MOVIE_GENRE
    (ENTERED_TIME       DATE,
    PRICE               NUMBER,
    CUSTID              NUMBER,
    GENREID             NUMBER,
    MOVIEID             NUMBER,
    ACTIVITY            NUMBER,
    RECOMMENDED         VARCHAR2(10));
    </copy>
    ```

    ![SQL query](./images/dbactionssqlquery.png " ")

4. After the create table statement executes, you can close Database Actions tab to get back to the Oracle Cloud menu.

5. Now you can verify that the entity is available as part of the OCI Data Catalog. Navigate to the Oracle Cloud Menu. Click on Analytics & AI and click on Data Catalog under the Data Lake header.

6. Click on lakehousecatalog from the Data Catalogs. Verify compartment if you do not see it listed.

    ![SQL](./images/currentcatalog.png " ")

7. Click on Data Assets and click on Harvest using the dropdown menu for the database Data Asset. This harvesting for the Data Catalog should be scheduled to automatically pull the entity information into the Data Asset, but for now in the lab you can run this manually.
Select the ADMIN data entity and run the job now.

    ![Harvest](./images/harvest1.png " ")

8. Now if you go back to the Home Tab from the Data Catalog, you will discover that there are now 7 Data Entities are being kept up to data in the Data Catalog.

    ![New Entities](./images/new_entities.png " ")

9. Click on Entities just to verify that all of the tables are now here.

    ![Entities List](./images/entities_list.png " ")

Now you are ready to work with the Data Flows and applications.

You may now proceed to the next lab.

## Acknowledgements

* **Author** - Michelle Malcher, Database Product Management, Massimo Castelli, Senior Director Product Management
* **Contributors** -  Nagwang Gyamtso, Product Management
* **Last Updated By/Date** - Michelle Malcher, Database Product Management, June 2024
