# Lab 1: Provision OCI Resource Analytics and Prepare Wingmate Data

## Introduction

This lab walks you through provisioning OCI Resource Analytics and preparing the Resource Analytics-provisioned Autonomous AI Database for the Wingmate APEX application. You will configure Resource Analytics prerequisites, create the instance, create a dedicated `WINGMATE` database user and APEX workspace, prepare curated materialized views, and load supporting data for later Wingmate agents.

Resource Analytics creates a protected `OCIRA` schema in the provisioned Autonomous AI Database. The Wingmate application should use a separate application schema and query Resource Analytics data through the read-only role granted by Resource Analytics.

The lab files are provided in the [Wingmate Data Zip](https://c4u02.objectstorage.us-ashburn-1.oci.customer-oci.com/p/9DEArLjsgbKXuJgQtSG95E8hMXRFtxgHR8jiHbqz4HgyVYXVnSo0SC_s-zq5CJA3/n/c4u02/b/hosted-files/o/wingmate_data.zip). The bundle includes APEX page imports, SQL setup scripts, and synthetic CSV data used to make the later labs repeatable. The security data supports IAM policy and Cloud Guard examples in Lab 3, the documentation reference data supports the Doc Research RAG setup in Lab 2, and the multicloud and host-insights data supports the Lab 4 dashboards, forecast examples, and property graph. Lab 5 uses Resource Analytics compute metadata plus OCI Monitoring metrics collected by the OCI Metrics Collector.

Resource Analytics is the primary source for OCI inventory, configuration, and capacity context. The synthetic files provide predictable lab examples and fallback rows where a learner tenancy may not yet have enough Resource Analytics data. ShowOCI can overlap with Resource Analytics for identity and inventory-style extracts, especially IAM policy statements, and can supplement the security dataset when more policy detail is needed. REST API data sources or custom pipelines can close gaps for OCI signals that are not currently exposed through Resource Analytics by landing API results in the `WINGMATE` schema or exposing them to APEX as REST Data Sources.

Estimated Time: 20 minutes

### Objectives

In this lab, you will:

* Configure Resource Analytics Prerequisites
* Provision Resource Analytics Instance
* Open the Resource Analytics Autonomous AI Database
* Create the Wingmate Database User
* Create the Wingmate APEX Workspace and Developer User
* Create Curated Resource Analytics Materialized Views
* Load Synthetic Data
* (Optional) Connect RESTful Data from OCI API Endpoints
* (Optional) Prepare ShowOCI IAM Policy Statement Data Loading

### Prerequisites

* An OCI cloud account
* Subscription to US Midwest (Chicago), US East (Ashburn), or US West (Phoenix)
* Permissions to create Resource Analytics prerequisites, policies, and instances
* Basic database and SQL knowledge
* Familiarity with Oracle Cloud Infrastructure (OCI)
* Familiarity with REST services is helpful for optional tasks

## Task 1: Configure Resource Analytics Prerequisites

1. Select the **hamburger menu** at the top left. Click the **Observability & Management** menu and scroll to **Resource Analytics**. Click **Instances**.

	![Resource Analytics menu](./images/nav-ra.png "")

2. Notice the warning at the top, which requires the tenancy admin to perform the prerequisites listed in the documentation. Click **View Details** to perform those actions.

	![Prerequisites for Resource Analytics](./images/prerequisites.png "")

3. Read through the details of step 1. The next steps cover VCN creation using the VCN Wizard.

	![Prerequisites step 1 details](./images/prerequisites-step1.png "")

4. Click the **hamburger menu** in the top left of the OCI Console. Under **Networking**, select **Virtual Cloud Networks**.

	![Navigate to VCN](./images/nav-vcn.png "")

5. Click **Actions** and click **VCN Wizard** to create a VCN quickly with internet connectivity.

	![VCN wizard button](./images/nav-vcn-wizard.png "")

6. Select **Create VCN with Internet Connectivity** and click **Next**.

	![VCN Wizard](./images/vcn-wizard.png "")

7. Name the VCN and leave everything else as default. Confirm the correct compartment and select **Next**.

	![VCN name](./images/name-vcn.png "")

8. Confirm the information is correct and select **Create**.

	![Confirm VCN detail](./images/confirm-vcn.png "")

9. After provisioning completes, select **Subnets** from the menu and click **private subnet**.

	![Private Subnet](./images/private-subnet.png "")

10. Select **Security** and click **Default Security List**.

	![Private subnet security list](./images/private-subnet-security.png "")

11. Select the **Security Rules** tab and click **Add Ingress Rules**.

	![Ingress Rules for Private subnet](./images/private-subnet-security-ingress.png "")

12. Add a **Source CIDR** of `0.0.0.0/0` and **Destination Port Range** of `1522,443`. Click **Add Ingress Rule**.

	![Ingress Rule](./images/private-subnet-security-ingress-rules.png "")

13. Return to the **Resource Analytics Prerequisites setup** page, read Step 2, and click **Domains** to create the Resource Analytics administrator group.

	![Step 2](./images/prerequisites-step2.png "")

14. Click the identity domain where the group should reside. If the domain is at the root level, change the compartment to match the location.

	![Domains](./images/domains.png "")

15. Click the **User Management** tab and scroll down to select **Create Group**.

	![User Management button](./images/user-management.png "")

	![Create Group button](./images/create-group.png "")

16. Name and describe the group and click **Create**.

	![Name and create group](./images/name-group.png "")

17. Click the group, select **Users**, and click **Assign user to group**. Add the desired users in the popup.

	![Assign user to group](./images/assign-users.png "")

18. Click the **hamburger menu**, select **Identity & Security**, and under Identity, click **Compartments**.

	![Compartment menu button](./images/compartment.png "")

19. Click the compartment in which the Resource Analytics instance will reside and copy the **OCID**.

	![Compartment ocid](./images/compartment-ocid.png "")

20. Navigate back to the domain and select **Dynamic Groups**. Click **Create dynamic group**.

	![Dynamic Group](./images/dynamic-groups.png "")

21. Name the dynamic group, add a description, and copy the following rule into the **Rule Builder**. Replace the placeholder with the Resource Analytics compartment OCID.

	```
	<copy>
	ALL {resource.type = 'resanalyticsinstance', resource.compartment.id = '<resource-analytics-compartment-ocid>'}
	</copy>
	```

	![Dynamic group rule builder](./images/dynamic-groups-rule.png "")

22. Return to the **Prerequisites** page, read Step 3, and click **Policy Builder**.

	![Step 3](./images/prerequisites-step3.png "")

23. Use the Policy Builder to create the Resource Analytics policies:

	* **Let Resource Analytics Instances manage Resource Analytics resources** in the root compartment for the `resource-analytics-instances` dynamic group.
	* **Let admins manage Resource Analytics resources** in the Resource Analytics compartment, or any compartment above it, for the `resource-analytics-admins` group.
	* **Let admins inspect the set of subscribed regions of the tenancy** in the root compartment for the `resource-analytics-admins` group.

	Once completed, return to Resource Analytics and select **Create Instance**.

	![Create instance button](./images/create-instance.png)

## Task 2: Provision Resource Analytics Instance

1. Provide a **Name**, **Description**, and select the correct **Compartment**.

	> **Note:** Click **View List** to see the services that you can connect to.

	![Name the Resource Analytics Instance](./images/name-ra.png "")

2. Select the **Regions** you want to collect data from. Select **Input Password** for the Autonomous Data Warehouse Admin Credentials and provide a password.

	![Region and Password for Instance](./images/region-password.png "")

3. Select a **VCN** and **Subnet**. Select **Create** at the bottom, leaving everything else as default.

	![VCN display](./images/create-complete.png "")

4. Wait for provisioning to complete.

	![Instance Provisioning](./images/provisioning-instance.png "")

## Task 3: Open the Resource Analytics Autonomous AI Database

Resource Analytics provisions an Autonomous AI Database in a private subnet. To build the Wingmate app and import supporting data, allow access from your client IP address.

1. From the Resource Analytics instance details page, open the provisioned Autonomous AI Database instance.

	![Resource Analytics Autonomous Database instance](./images/adb-instance.png "")

2. In the Autonomous Database details page, select **Update network access**.

	![Update network access](./images/update-network-access.png "")

3. Add your client IP address to the access control list and save the change.

	![Add client IP address](./images/update-network-access-ip.png "")

4. Open **Database Actions** for the Autonomous AI Database and sign in as `ADMIN` using the password supplied during Resource Analytics provisioning if requested to login.

	![Access DB SQL Actions](./images/access-sql-db-actions.png "")

## Task 4: Create the Wingmate Database User

Create a dedicated application schema for APEX instead of building directly in the protected `OCIRA` schema.

1. In Database Actions, **SQL** worksheet should show logged in as `Admin`.

	![Confirm admin DB SQL Actions](./images/confirm-admin.png "")

2. Run the following sample SQL as `ADMIN` to create the Wingmate user.

	```sql
	<copy>
	CREATE USER wingmate IDENTIFIED BY "<replace_with_strong_password>";

	GRANT UNLIMITED TABLESPACE TO wingmate;
	GRANT CREATE PROPERTY GRAPH TO wingmate;

	GRANT CREATE SESSION,
	      CREATE TABLE,
	      CREATE VIEW,
	      CREATE MATERIALIZED VIEW,
	      CREATE PROCEDURE,
	      CREATE TRIGGER,
	      CREATE SEQUENCE,
	      CREATE SYNONYM,
	      CREATE JOB
	TO wingmate;

        GRANT OCIRA_RO TO wingmate;
        GRANT DWROLE TO wingmate;

        BEGIN
            ords_admin.enable_schema(
                p_enabled => TRUE,
                p_schema => 'WINGMATE',
                p_url_mapping_type => 'BASE_PATH',
                p_url_mapping_pattern => 'wingmate',
                p_auto_rest_auth => FALSE
            );
            COMMIT;
        END;
        /
        </copy>
    ```

	> **Note:** If you already created the `WINGMATE` user before this grant was added, sign in as `ADMIN` and run `GRANT CREATE PROPERTY GRAPH TO wingmate;` before running the Multicloud graph setup script in Lab 4.

	![Run create wingmate user sql](./images/create-wingmate-user.png "")

3. Sign out as `ADMIN`, and sign back in to Database Actions as the `WINGMATE` user.

4. Validate that the `WINGMATE` user can read Resource Analytics views through the `OCIRA_RO` role.

	```sql
	<copy>
	SELECT COUNT(*) AS compute_instances
	FROM OCIRA.COMPUTE_INSTANCE_DIM_V;

	SELECT COUNT(*) AS compartments
	FROM OCIRA.COMPARTMENT_DIM_V;
	</copy>
	```

	![Run Query from wingmate user](./images/query-ocira.png "")

	> **Note:** If either query fails, verify that `OCIRA_RO` was granted and that Resource Analytics data collection has completed for the selected regions.

## Task 5: Create the Wingmate APEX Workspace and Developer User

Create the APEX workspace against the existing `WINGMATE` database schema.

1. From the Autonomous AI Database details page, copy the Oracle APEX URL and open it in a new browser tab.

	![Copy the Oracle APEX URL](./images/open-apex.png "")

2. Sign in to APEX Administration Services as `ADMIN`.

	![Sign in to APEX Administration Services](./images/access-admin.png "")

3. Select **Create Workspace**.

	![Create Workspace button](./images/create-workspace.png "")

4. Choose the option to use an existing schema.

	![Choose existing schema for workspace](./images/existing-schema.png "")

5. Use the following workspace values:

	* **Existing Schema:** `WINGMATE`
	* **Workspace Name:** `WINGMATE_LL`
	* **Workspace Username:** `WINGMATE`
	* **Workspace Password:** Use a secure password that follows your tenancy policy.

	![Enter workspace credentials](./images/workspace-creds.png "")

6. Create the workspace.

7. Sign out of Administration Services.

	![Sign out of APEX Administration Services](./images/sign-out-admin.png "")

8. Select **Return to Sign In Page**.

	![Return to the APEX sign-in page](./images/return-sign-in.png "")

9. Sign in to the `WINGMATE_LL` workspace as the `WINGMATE` APEX developer user.

	![Sign in to the WINGMATE workspace](./images/sign-in-workspace.png "")

## Task 6: Create Curated Resource Analytics Materialized Views

Create materialized views in the `WINGMATE` schema for the Resource Analytics views needed by the Compute Wingmate Agent in Lab 5. These materialized views give APEX stable, app-owned objects to query while keeping the original Resource Analytics objects in the protected `OCIRA` schema.

1. Sign in to Database Actions as the `WINGMATE` user.

2. Confirm that the current schema is `WINGMATE`.

	```sql
	<copy>
	SELECT
	    sys_context('USERENV', 'SESSION_USER') AS session_user,
	    sys_context('USERENV', 'CURRENT_SCHEMA') AS current_schema
	FROM dual;
	</copy>
	```

	![Query the workspace](./images/sql-query-wingmate.png "")

3. Preview the Resource Analytics source views that will be materialized for Compute Wingmate.

	```sql
	<copy>
	SELECT view_name
	FROM all_views
	WHERE owner = 'OCIRA'
	AND (
	       view_name LIKE 'COMPUTE\_%' ESCAPE '\'
	    OR view_name = 'INSTANCE_VOLUME_DETAILS_V'
	    OR view_name IN (
	           'TENANCY_DIM_V',
	           'COMPARTMENT_DIM_V',
	           'COMPARTMENT_HIERARCHY_V',
	           'REGION_DIM_V',
	           'AD_DIM_V',
	           'TAGS_DIM_V'
	       )
	)
	ORDER BY view_name;
	</copy>
	```

	![Query the workspace materialized views](./images/sql-query-wingmate-mv.png "")


	> **Note:** If this query returns no rows, verify that Resource Analytics provisioning and data collection completed and that the `WINGMATE` user has the `OCIRA_RO` role.

4. Run the following PL/SQL block as `WINGMATE` to create materialized views in the `WINGMATE` schema. Each materialized view is named `MV_<Resource Analytics view name>`.

	```
	<copy>
	DECLARE
	    l_source_owner    VARCHAR2(128) := 'OCIRA';
	    l_expected_schema VARCHAR2(128) := 'WINGMATE';
	    l_created_count   PLS_INTEGER := 0;
	    l_skipped_count   PLS_INTEGER := 0;

	    FUNCTION qname(p_name VARCHAR2) RETURN VARCHAR2 IS
	    BEGIN
	        RETURN dbms_assert.enquote_name(upper(p_name), false);
	    END qname;

	    FUNCTION make_mv_name(p_view_name VARCHAR2) RETURN VARCHAR2 IS
	        l_name VARCHAR2(128);
	    BEGIN
	        l_name := 'MV_' || p_view_name;

	        IF length(l_name) <= 128 THEN
	            RETURN l_name;
	        END IF;

	        RETURN substr(l_name, 1, 119)
	               || '_'
	               || substr(
	                      lpad(
	                          to_char(dbms_utility.get_hash_value(p_view_name, 0, 2147483647), 'FMXXXXXXXX'),
	                          8,
	                          '0'
	                      ),
	                      1,
	                      8
	                  );
	    END make_mv_name;
	BEGIN
	    IF upper(sys_context('USERENV', 'CURRENT_SCHEMA')) <> l_expected_schema THEN
	        raise_application_error(
	            -20001,
	            'Run this block with CURRENT_SCHEMA set to WINGMATE.'
	        );
	    END IF;

	    FOR r IN (
	        SELECT view_name
	        FROM all_views
	        WHERE owner = l_source_owner
	        AND (
	               view_name LIKE 'COMPUTE\_%' ESCAPE '\'
	            OR view_name = 'INSTANCE_VOLUME_DETAILS_V'
	            OR view_name IN (
	                   'TENANCY_DIM_V',
	                   'COMPARTMENT_DIM_V',
	                   'COMPARTMENT_HIERARCHY_V',
	                   'REGION_DIM_V',
	                   'AD_DIM_V',
	                   'TAGS_DIM_V'
	               )
	        )
	        ORDER BY view_name
	    ) LOOP
	        DECLARE
	            l_mv_name VARCHAR2(128) := make_mv_name(r.view_name);
	            l_exists  NUMBER;
	            l_stmt    VARCHAR2(32767);
	        BEGIN
	            SELECT count(*)
	            INTO l_exists
	            FROM user_mviews
	            WHERE mview_name = upper(l_mv_name);

	            IF l_exists > 0 THEN
	                l_skipped_count := l_skipped_count + 1;
	                dbms_output.put_line('Skipped existing materialized view ' || l_mv_name);
	            ELSE
	                l_stmt :=
	                       'CREATE MATERIALIZED VIEW ' || qname(l_mv_name) || chr(10)
                            || 'BUILD IMMEDIATE' || chr(10)
	                    || 'REFRESH COMPLETE ON DEMAND' || chr(10)
	                    || 'AS SELECT * FROM ' || qname(l_source_owner) || '.' || qname(r.view_name);

	                EXECUTE IMMEDIATE l_stmt;
	                l_created_count := l_created_count + 1;
	                dbms_output.put_line('Created ' || l_mv_name || ' from ' || l_source_owner || '.' || r.view_name);
	            END IF;
	        EXCEPTION
	            WHEN OTHERS THEN
	                dbms_output.put_line('Error creating materialized view for ' || r.view_name || ': ' || sqlerrm);
	        END;
	    END LOOP;

	    dbms_output.put_line('Created materialized views: ' || l_created_count);
	    dbms_output.put_line('Skipped existing views: ' || l_skipped_count);
	END;
	/
	</copy>
	```


	![Generate the workspace materialized views](./images/sql-gen-wingmate-mv.png "")


5. Confirm the materialized views were created.

	```
	<copy>
	SELECT mview_name, staleness, refresh_mode, refresh_method
	FROM user_mviews
	WHERE mview_name LIKE 'MV\_%' ESCAPE '\'
	ORDER BY mview_name;
	</copy>
	```

	![Query materialized views](./images/query-mv.png "")


6. Spot-check the materialized views that are most likely to be used by the Compute Wingmate Agent.

	```
	<copy>
	SELECT COUNT(*) AS compute_instances
	FROM MV_COMPUTE_INSTANCE_DIM_V;

	SELECT COUNT(*) AS compartments
	FROM MV_COMPARTMENT_DIM_V;
	</copy>
	```

	![Query count of compute](./images/query-count-compute.png "")

7. When you need to refresh the materialized views after Resource Analytics collects updated data, run the following block as `WINGMATE`.

	```
	<copy>
	BEGIN
	    FOR r IN (
	        SELECT mview_name
	        FROM user_mviews
	        WHERE mview_name LIKE 'MV\_%' ESCAPE '\'
	        ORDER BY mview_name
	    ) LOOP
	        dbms_mview.refresh(r.mview_name, method => 'C');
	    END LOOP;
	END;
	/
	</copy>
	```

	![Refresh MV](./images/refresh-mv.png "")

## Task 7: Load Synthetic Data

1. Download the lab files and unzip:

	[Wingmate Data Zip](https://c4u02.objectstorage.us-ashburn-1.oci.customer-oci.com/p/9DEArLjsgbKXuJgQtSG95E8hMXRFtxgHR8jiHbqz4HgyVYXVnSo0SC_s-zq5CJA3/n/c4u02/b/hosted-files/o/wingmate_data.zip)

  >**Note:** The unzipped `wingmate_data` folder includes the supporting datasets, `wingmate_ddl.sql`, APEX single-page imports under `apex-pages`, and setup scripts under `sql`, including Select AI profiles, Doc Research RAG, and the AI Ops ADB Agent Team. Keep the folder available because Labs 2 through 5 reuse those files.

2. Open **Database Actions** for the Autonomous AI Database and sign in as the `WINGMATE` database user.

  ![Database Actions signed in as WINGMATE](./images/access-sql-db-actions.png "")

3. Open **SQL** and run the `wingmate_data/sql/wingmate_ddl.sql` script.

  >**Note:** You can paste the script into the worksheet or open the file from your local machine. Run the script before loading any CSV files so the target tables already exist.

  ![Run wingmate DDL script in Database Actions SQL](./images/data-load-run-ddl-script.png "")

4. Verify the DDL script completed successfully.

  >**Note:** If you see errors, validate whether the tables or views already exist before rerunning the script.

  ![Wingmate DDL script completed successfully](./images/data-load-run-ddl-script-error.png "")

5. In Database Actions, select **Data Load**.

  ![Open Data Load from Database Actions](./images/data-load-open-data-load.png "")

6. Select **Load Data**, then select **Local File**.

  ![Select Load Data local file](./images/data-load-local-file.png "")

7. Drag the CSV files from the unzipped `wingmate_data/data` folder into the local-file cart.

  >**Note:** SQL Developer Web can stage multiple file loads together and map columns by matching the CSV headers to the existing table columns created by `wingmate_ddl.sql`.

  ![CSV files staged in the local file cart](./images/drag-and-drop.png "")

8. For each file card, select **Review Settings** or the edit icon.

  >**Note:** The local-file cart may default each card to **Create Table**, even when the target table already exists. This is expected.

  ![Review settings for a local file load card](./images/sql-data-load.png "")

9. In the **Table** settings, change **Option** to **Insert into Table**.

  >**Note:** Do not use **Create Table**, **Replace Data**, **Drop Table and Create New Table**, or **Merge into Table** for the first workshop load. **Merge into Table** is useful only when reloading data into a table that already has rows and the merge key is mapped to the table's primary key, such as `VM_CLUSTER_ID` for `OCI_EXA_VM_CLUSTER`.

  ![Change load option to Insert into Table](./images/sql-data-load-insert.png "")

10. Select the existing target table for the CSV file if not automatically detected.

11. Review the column mapping and confirm that the CSV headers are mapped to the correct target columns.

12. Return to the local-file cart and repeat the settings review for each CSV file.

  >**Note:** All cards should show **Insert into Table** and the intended existing table before you start the load.

13. Select **Start** to run the configured data loads.

  ![Start local file data loads](./images/sql-data-load-start.png "")

14. Verify that each file load completed successfully.

  >**Note:** Use the Data Load job details or log output to review any load errors. Most mapping issues are caused by a file name that does not match the table name or by a CSV header that does not match an existing column name.

  ![Completed local file data load jobs](./images/data-load-jobs-complete.png "")

15. Open **SQL** and validate that the key tables contain rows.

  ```sql
  <copy>
  SELECT 'CIS_IAM_POLICIES' table_name, COUNT(*) row_count FROM cis_iam_policies
  UNION ALL
  SELECT 'CLOUDGUARD02_LISTPROBLEMS', COUNT(*) FROM cloudguard02_listproblems
  UNION ALL
  SELECT 'LISTHOSTINSIGHTS', COUNT(*) FROM listhostinsights
  UNION ALL
  SELECT 'OCI_DOC_REF', COUNT(*) FROM oci_doc_ref;
  </copy>
  ```

  ![Validate loaded table row counts](./images/validate-data-load.png "")

>**Note:** If batch file loading give trouble, proceed with manual loading on each table via APEX SQL Commands.

  ![Data Loading](./images/data-loading.png "")

## Task 8: (Optional) Connect RESTful Data from OCI API Endpoints

This optional task models direct REST API access for tenancy data that is not yet covered by flat files or Resource Analytics. Later labs can reference this REST data source pattern when Ops Insights or other OCI API context supports the agent workflow.

1. Navigate back to the application by selecting **App Builder** and then the **WINGMATE** app name.

	![Navigate to the Application](./images/nav-back-app.png "")

2. Select **Shared Components**.

	![Navigate to the shared components](./images/shared-components.png "")

3. Select **REST Data Sources** under Data Sources.

	![Navigate to the REST Data Sources](./images/rest-data-services.png "")

4. Select **Create** to create your first RESTful data source.

	![Create RESTful Data Source Button](./images/create-rest-button.png "")

5. Select **Next** to create the RESTful data source from scratch.

	![Create RESTful Data Source from scratch button](./images/create-from-scratch.png "")

6. Name the service, such as **HostInsightsSummary**, paste an endpoint URL, and select **Next**.

	Example endpoint:

	```
	<copy>https://operationsinsights.us-ashburn-1.oci.oraclecloud.com/20200630/hostInsights/resourceStatistics</copy>
	```

	> **Note:** Check the OCI API Reference and Endpoints documentation for the complete endpoint list.

	![Create RESTful Data Source endpoint](./images/endpoint-name.png "")

7. Validate the endpoint and select **Next**.

	![Next button for remote server](./images/remote-server.png "")

8. Select **Next** if no pagination is required.

	![Next button with no pagination](./images/no-pagination.png "")

9. Select the credentials that allow API queries of the tenancy. Select **Next**.

	![Set credentials for Rest](./images/credentials-rest.png "")

10. Navigate back if the endpoint requires parameters by selecting **Back**.

	![Discovery Error](./images/discovery-error.png "")

11. Select **Advanced** to define the parameters.

	![Advanced Data Discovery](./images/advanced-data-source.png "")

12. Insert the required parameters and select **Discover**.

	![Header Compartment Example](./images/header-compartment.png "")

	> **Note:** If the response says not authorized, navigate back to the credentials and select the correct credentials. This might require separate Web Credentials for APIs and the Generative AI service. The user also needs permissions to query the target API.

	![Example Not Authorized Error](./images/not-authorized.png "")

13. Validate that successful data source discovery matches the expected profile. Select **Create REST Data Source**.

	![Host details of successful discovery](./images/host-details.png "")

	> **Note:** If not all columns are mapped, select **Configure** to map them correctly.

	![Configure map button](./images/configure-columns.png "")

	![Unmapped column](./images/unmapped-column.png "")

## Task 9: (Optional) Prepare ShowOCI IAM Policy Statement Data Loading

ShowOCI can be used as an additional source for OCI IAM policy inventory. In this task, you will run ShowOCI to generate a CSV file that contains OCI IAM policies and their individual policy statements, upload that report into the Autonomous AI Database, and make the resulting table available to APEX, SQL Developer, and MCP-based workflows.

> **Note:** An OCI VM is recommended for longer ShowOCI extracts because it can use instance principal authentication and avoids Cloud Shell timeout limits. Cloud Shell is still useful for quick validation runs.

1. Provision or select an OCI VM to run ShowOCI.

	> **Note:** You can also run ShowOCI from your local laptop if you have OCI CLI configuration and network access. For workshop consistency, use an OCI VM when possible.

2. Configure instance principal authorization for the OCI VM. Navigate to the OCI Domains and create a dynamic group for the VM instance and add a policy similar to the following:

	```
	<copy>
	allow dynamic-group ShowOCIDynamicGroup to read all-resources in tenancy
	</copy>
	```

3. Connect to the OCI VM and validate instance principal authentication.

	```
	<copy>
	oci os ns get --auth instance_principal
	</copy>
	```

4. Install the required tools and Python packages on the OCI VM.

	```
	<copy>
	sudo yum -y install git
	python3 -m pip install --upgrade pip
	python3 -m pip install --upgrade oci oci-cli oracledb
	</copy>
	```

5. Clone the OCI Python SDK repository and open the ShowOCI example directory.

	```
	<copy>
	git clone https://github.com/oracle/oci-python-sdk
	cd oci-python-sdk/examples/showoci
	</copy>
	```

6. Create an output directory for generated CSV reports.

	```
	<copy>
	mkdir -p $HOME/showoci-policy-export
	</copy>
	```

7. Run ShowOCI for Identity resources and generate CSV output.

	* For an OCI VM using instance principal authentication, run:

	```
	<copy>
	python3 showoci.py -ip -i -isc -csv $HOME/showoci-policy-export/iam
	</copy>
	```

	* For Cloud Shell using delegation token authentication, run:

	```
	<copy>
	python3 showoci.py -dt -i -isc -csv $HOME/showoci-policy-export/iam
	</copy>
	```

	* For a configured local OCI CLI profile, run:

	```
	<copy>
	python3 showoci.py -t DEFAULT -i -isc -csv $HOME/showoci-policy-export/iam
	</copy>
	```

	> **Note:** The `-i` option extracts Identity data. The `-isc` option skips user credential extraction. For classic OCI IAM policy statements, use the generated `iam_identity_policy.csv` file. Identity Domain policy artifacts are generated as separate files and are not required for this task.

8. Review the generated IAM policy statement CSV file.

	```
	<copy>
	ls -lh $HOME/showoci-policy-export/iam_identity_policy.csv
	head -5 $HOME/showoci-policy-export/iam_identity_policy.csv
	</copy>
	```

	The `iam_identity_policy.csv` file contains one row per IAM policy statement. Key columns include `compartment`, `policy_name`, `id`, `seq`, `statement`, and `compartment_id`.

9. Open the Resource Analytics-provisioned Autonomous AI Database and sign in to Database Actions as `WINGMATE`.

10. Use Database Actions or SQL Developer Web to load only the IAM policy statement CSV file into the `WINGMATE` schema.

	Recommended table naming pattern:

	* Load `$HOME/showoci-policy-export/iam_identity_policy.csv`
	* Name the table `SHOWOCI_IAM_POLICY_STATEMENTS`
	* Keep one row per policy statement during import
	* Preserve the source CSV file name in your workshop notes so learners can trace the table back to the generated report

11. Validate that the ShowOCI IAM policy statement table is available in the `WINGMATE` schema.

	```
	<copy>
	SELECT table_name
	FROM user_tables
	WHERE table_name = 'SHOWOCI_IAM_POLICY_STATEMENTS'
	ORDER BY table_name;
	</copy>
	```

12. Preview the loaded data before using it in APEX or MCP workflows.

	```
	<copy>
	SELECT compartment,
	       policy_name,
	       seq,
	       statement,
	       compartment_id
	FROM showoci_iam_policy_statements
	FETCH FIRST 10 ROWS ONLY;
	</copy>
	```

13. Use the ShowOCI IAM policy statement table from APEX, SQL Developer, or MCP servers as a supplemental security and governance source for Wingmate.

	* For APEX, select `SHOWOCI_IAM_POLICY_STATEMENTS` as a report, chart, or assistant context source.

	* For SQL Developer or Database Actions, query the table directly in the `WINGMATE` schema.

	* For MCP-based workflows, expose the `SHOWOCI_IAM_POLICY_STATEMENTS` table through the same database connection used for the `WINGMATE` schema.

You may now **proceed to the next lab**.

## Learn more

* [Manage User Access to Resource Analytics ADW](https://docs.oracle.com/en-us/iaas/Content/resource-analytics/manage-user-access-adw.htm)
* [Resource Analytics Compute Data Model Reference](https://docs.oracle.com/en-us/iaas/Content/resource-analytics/reference-compute.htm)
* [Blog for Oracle Resource Analytics Materialized View for APEX](https://www.ateam-oracle.com/building-a-cloud-configuration-management-knowledge-base-with-oci-resource-analytics)
* [ShowOCI examples](https://github.com/oracle/oci-python-sdk/tree/master/examples/showoci)

## Acknowledgements

* **Authors:**
	* Nicholas Cusato - Cloud Architect
	* Royce Fu - Master Principal Cloud Architect
* **Last Updated by/Date** - Nicholas Cusato, June 2026
