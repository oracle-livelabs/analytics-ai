# Lab 5: Build a Compute Wingmate Agent

## Introduction

This lab walks you through configuring the imported Compute Wingmate Agent page in Oracle APEX. You will use Resource Analytics materialized views from Lab 1, or query the `OCIRA` schema views directly, to provide compute instance metadata. You will also configure the OCI Metrics Collector to write compute utilization metrics into Autonomous Database so the APEX app can overlay CPU and memory metrics on top of compute instance metadata.

The result is a Compute Wingmate page that can answer natural language questions about compute inventory and utilization while also displaying APEX visualization widgets for operational monitoring.

> **SME Gate:** Confirm the final Resource Analytics compute view columns before publishing. The metrics collector writes a known `OCI_COMPUTE_METRICS` table, but the join column from Resource Analytics compute metadata must be verified in the target tenancy.

Estimated Time: 60 minutes

### Objectives

In this lab, you will:

* Confirm Resource Analytics compute metadata sources
* Configure OCI Metrics Collector for compute CPU and memory metrics
* Load compute metrics into the `WINGMATE` Autonomous Database schema
* Create SQL views that overlay metrics on compute instance metadata
* Configure APEX visualization widgets on the imported Compute Wingmate page
* Configure the Compute Wingmate Agent AI assistant

### Prerequisites

* Completed Labs 1 through 4
* Access to the `WINGMATE` APEX application
* Imported `OCI Wingmate` framework application from Lab 2
* `OCI_GENAI` Generative AI service object created in APEX
* Resource Analytics compute materialized views created in Lab 1, or direct access to the `OCIRA` schema views through `OCIRA_RO`
* An OCI VM or local environment that can run Python and access OCI Monitoring
* Autonomous Database wallet downloaded for the Resource Analytics-provisioned Autonomous AI Database
* `WINGMATE` database user with privileges to create and insert into tables

## Task 1: Confirm Compute Metadata Sources

Compute Wingmate can use the materialized views created in Lab 1 or query the `OCIRA` schema views directly. The materialized view option is recommended for APEX because the app owns stable objects in the `WINGMATE` schema.

1. Sign in to Database Actions as `WINGMATE`.

2. Confirm which Resource Analytics compute materialized views are available.

	```sql
	<copy>
	SELECT mview_name
	FROM user_mviews
	WHERE mview_name LIKE 'MV_COMPUTE\_%' ESCAPE '\'
	   OR mview_name = 'MV_INSTANCE_VOLUME_DETAILS_V'
	ORDER BY mview_name;
	</copy>
	```

3. If the materialized views are not available, confirm direct `OCIRA` view access.

	```sql
	<copy>
	SELECT view_name
	FROM all_views
	WHERE owner = 'OCIRA'
	AND (
	       view_name LIKE 'COMPUTE\_%' ESCAPE '\'
	    OR view_name = 'INSTANCE_VOLUME_DETAILS_V'
	)
	ORDER BY view_name;
	</copy>
	```

4. Preview the compute instance metadata source.

	```sql
	<copy>
	SELECT *
	FROM MV_COMPUTE_INSTANCE_DIM_V
	FETCH FIRST 10 ROWS ONLY;
	</copy>
	```

	> **Note:** If you did not create the materialized view in Lab 1, replace `MV_COMPUTE_INSTANCE_DIM_V` with `OCIRA.COMPUTE_INSTANCE_DIM_V`.

5. Identify the Resource Analytics column that contains the compute instance OCID.

	```sql
	<copy>
	SELECT column_name, data_type
	FROM user_tab_columns
	WHERE table_name = 'MV_COMPUTE_INSTANCE_DIM_V'
	ORDER BY column_id;
	</copy>
	```

	> **SME Gate:** Confirm the compute instance OCID column. Later steps use `<compute_instance_ocid_column>` as a placeholder until the target Resource Analytics column name is confirmed.

## Task 2: Configure OCI Metrics Collector

The OCI Metrics Collector collects compute metrics from OCI Monitoring, enriches the data with compute instance metadata, and writes the results to Autonomous Database.

1. Provision or select an OCI VM to run the collector.

	> **Note:** An OCI VM is recommended because the collector can use instance principal authentication and run continuously with `systemd`.

2. Create a dynamic group for the collector VM.

	Example matching rule:

	```text
	<copy>
	instance.id = 'ocid1.instance.oc1..YOUR_INSTANCE_OCID'
	</copy>
	```

3. Add IAM policies for the dynamic group.

	```text
	<copy>
	Allow dynamic-group <dg-name> to read metrics in compartment <compartment-name>
	Allow dynamic-group <dg-name> to read instances in compartment <compartment-name>
	</copy>
	```

	> **Note:** Add Log Analytics permissions only if you also enable the Log Analytics destination.

4. Connect to the collector VM and clone the metrics collector repository.

	```bash
	<copy>
	git clone https://github.com/jujufugh/oci-metrics-collector-py /home/opc/oci-metrics-collector-py
	cd /home/opc/oci-metrics-collector-py
	</copy>
	```

5. Create and activate a Python virtual environment.

	```bash
	<copy>
	python3 -m venv venv
	source venv/bin/activate
	pip install -e .
	</copy>
	```

6. Copy the sample configuration.

	```bash
	<copy>
	cp config.yaml.example config.yaml
	</copy>
	```

7. Edit `config.yaml`.

	Use the following values as the starting point:

	```yaml
	<copy>
	oci:
	  auth_method: "instance_principal"

	scope:
	  compartment_id: "<target_compartment_ocid>"

	metrics:
	  namespace: "oci_computeagent"
	  resolution: "5m"
	  lookback_minutes: 10

	adb:
	  enabled: true
	  wallet_dir: "/home/opc/wallet_<adb_name>"
	  dsn: "<adb_name>_high"
	  user: "WINGMATE"
	  table_name: "OCI_COMPUTE_METRICS"

	log_analytics:
	  enabled: false
	</copy>
	```

	> **Note:** Use `<adb_name>_public_high` if you connect through the public Autonomous Database endpoint. Use the private endpoint alias if the VM is in a VCN that can resolve the private Autonomous Database hostname.

8. Store database secrets in `/home/opc/.env`.

	```bash
	<copy>
	cat > /home/opc/.env <<'EOF'
	OCI_METRICS_ADB_PASSWORD=<wingmate_database_password>
	OCI_METRICS_ADB_WALLET_PASSWORD=<wallet_password>
	OCI_METRICS_COMPARTMENT_ID=<target_compartment_ocid>
	EOF

	chmod 600 /home/opc/.env
	</copy>
	```

9. Load the environment variables and test connectivity.

	```bash
	<copy>
	set -a; source /home/opc/.env; set +a
	source /home/opc/oci-metrics-collector-py/venv/bin/activate
	oci-metrics-collector test-connection --config config.yaml
	</copy>
	```

10. Run one collection cycle.

	```bash
	<copy>
	oci-metrics-collector collect --config config.yaml
	</copy>
	```

11. Optional: run the collector continuously.

	```bash
	<copy>
	oci-metrics-collector collect --config config.yaml --continuous
	</copy>
	```

12. Optional: install the collector as a `systemd` service for continuous collection.

	```bash
	<copy>
	sudo tee /etc/systemd/system/oci-metrics-collector.service >/dev/null <<'EOF'
	[Unit]
	Description=OCI Metrics Collector
	After=network-online.target
	Wants=network-online.target

	[Service]
	Type=simple
	User=opc
	WorkingDirectory=/home/opc/oci-metrics-collector-py
	EnvironmentFile=/home/opc/.env
	ExecStart=/home/opc/oci-metrics-collector-py/venv/bin/oci-metrics-collector collect --config config.yaml --continuous
	Restart=on-failure
	RestartSec=10

	[Install]
	WantedBy=multi-user.target
	EOF

	sudo systemctl daemon-reload
	sudo systemctl enable --now oci-metrics-collector
	sudo systemctl status oci-metrics-collector
	</copy>
	```

	> **Note:** Do not also schedule the collector with `cron` if you enable the `systemd` service. Continuous mode already performs recurring collection cycles.

## Task 3: Validate the Metrics Table in Autonomous Database

The metrics collector creates and writes to `OCI_COMPUTE_METRICS` in the `WINGMATE` schema.

1. Sign in to Database Actions as `WINGMATE`.

2. Confirm that the table exists.

	```sql
	<copy>
	SELECT table_name
	FROM user_tables
	WHERE table_name = 'OCI_COMPUTE_METRICS';
	</copy>
	```

3. Review the table columns.

	```sql
	<copy>
	SELECT column_name, data_type
	FROM user_tab_columns
	WHERE table_name = 'OCI_COMPUTE_METRICS'
	ORDER BY column_id;
	</copy>
	```

4. Confirm recent metric rows.

	```sql
	<copy>
	SELECT collection_time,
	       instance_id,
	       instance_name,
	       shape,
	       cpu_utilization_pct,
	       memory_utilization_pct,
	       cpu_usage_ocpus,
	       memory_used_gbs
	FROM oci_compute_metrics
	ORDER BY collection_time DESC
	FETCH FIRST 20 ROWS ONLY;
	</copy>
	```

## Task 4: Create Compute Overlay Views

Create APEX-friendly views that combine compute metadata with the latest metrics.

> **SME Gate:** Replace `<compute_instance_ocid_column>` with the confirmed Resource Analytics compute instance OCID column from Task 1.

1. Create a latest-metrics view.

	```sql
	<copy>
	CREATE OR REPLACE VIEW compute_metrics_latest_v AS
	SELECT *
	FROM (
	    SELECT m.*,
	           row_number() OVER (
	               PARTITION BY instance_id
	               ORDER BY collection_time DESC
	           ) AS rn
	    FROM oci_compute_metrics m
	)
	WHERE rn = 1;
	</copy>
	```

2. Create a metadata and metrics overlay view.

	```sql
	<copy>
	CREATE OR REPLACE VIEW compute_wingmate_overlay_v AS
	SELECT ci.*,
	       ml.collection_time,
	       ml.cpu_allocated_ocpus,
	       ml.memory_allocated_gbs,
	       ml.cpu_utilization_pct,
	       ml.cpu_utilization_pct_p95,
	       ml.cpu_utilization_pct_p99,
	       ml.memory_utilization_pct,
	       ml.memory_utilization_pct_p95,
	       ml.memory_utilization_pct_p99,
	       ml.cpu_usage_ocpus,
	       ml.memory_used_gbs
	FROM mv_compute_instance_dim_v ci
	LEFT JOIN compute_metrics_latest_v ml
	    ON ml.instance_id = ci.<compute_instance_ocid_column>;
	</copy>
	```

	> **Note:** If you are querying Resource Analytics directly instead of using materialized views, replace `mv_compute_instance_dim_v` with `OCIRA.COMPUTE_INSTANCE_DIM_V`.

3. Create an assistant context view.

	```sql
	<copy>
	CREATE OR REPLACE VIEW compute_wingmate_context_v AS
	SELECT json_object(
	           'instance_id' VALUE instance_id,
	           'instance_name' VALUE instance_name,
	           'shape' VALUE shape,
	           'lifecycle_state' VALUE lifecycle_state,
	           'cpu_utilization_pct' VALUE cpu_utilization_pct,
	           'memory_utilization_pct' VALUE memory_utilization_pct,
	           'cpu_usage_ocpus' VALUE cpu_usage_ocpus,
	           'memory_used_gbs' VALUE memory_used_gbs,
	           'collection_time' VALUE to_char(collection_time, 'YYYY-MM-DD HH24:MI:SS')
	       RETURNING CLOB) AS context_prompt
	FROM compute_metrics_latest_v;
	</copy>
	```

## Task 5: Configure the Compute Wingmate APEX Page

Use the imported Compute Wingmate framework page from Lab 2, but focus the page content on compute metadata and metrics.

1. In App Builder, open the `WINGMATE` application.

2. Open the imported **OCI Compute Wingmate** page.

3. Create or select a region named **Compute Overview**.

4. Add a **Classic Report** region using the source:

	```sql
	<copy>
	SELECT *
	FROM compute_wingmate_overlay_v
	</copy>
	```

5. Add a **Chart** region named **CPU Utilization by Instance**.

	Use this source query:

	```sql
	<copy>
	SELECT instance_name,
	       cpu_utilization_pct
	FROM compute_metrics_latest_v
	WHERE cpu_utilization_pct IS NOT NULL
	ORDER BY cpu_utilization_pct DESC
	</copy>
	```

	Recommended chart settings:

	* **Type:** Bar
	* **Label:** `INSTANCE_NAME`
	* **Value:** `CPU_UTILIZATION_PCT`

6. Add a **Chart** region named **Memory Utilization by Instance**.

	Use this source query:

	```sql
	<copy>
	SELECT instance_name,
	       memory_utilization_pct
	FROM compute_metrics_latest_v
	WHERE memory_utilization_pct IS NOT NULL
	ORDER BY memory_utilization_pct DESC
	</copy>
	```

	Recommended chart settings:

	* **Type:** Bar
	* **Label:** `INSTANCE_NAME`
	* **Value:** `MEMORY_UTILIZATION_PCT`

7. Add a **Chart** region named **CPU and Memory Usage Trend**.

	Use this source query:

	```sql
	<copy>
	SELECT collection_time,
	       instance_name,
	       cpu_utilization_pct,
	       memory_utilization_pct
	FROM oci_compute_metrics
	WHERE collection_time >= systimestamp - INTERVAL '24' HOUR
	ORDER BY collection_time
	</copy>
	```

	Recommended chart settings:

	* **Type:** Line
	* **Label:** `COLLECTION_TIME`
	* **Series:** one series for CPU utilization and one series for memory utilization

## Task 6: Configure the Compute Wingmate Agent

1. Add or select a button named **StartComputeWingmate** on the OCI Compute Wingmate page.

2. Create or update a dynamic action named **Chat** for the button.

3. Add or update the **Show AI Assistant** true action.

4. Select the `OCI_GENAI` service created in Lab 2.

5. Add this system prompt:

	```text
	<copy>
	You are OCI Compute Wingmate, an assistant for OCI compute operations. Use the application's Resource Analytics compute metadata and OCI compute metrics data to answer questions about inventory, CPU utilization, memory utilization, allocated OCPUs, allocated memory, and usage trends. Be concise, explain operational impact, and call out missing data instead of guessing.
	</copy>
	```

6. Configure the assistant context with this SQL query:

	```sql
	<copy>
	SELECT context_prompt
	FROM compute_wingmate_context_v
	FETCH FIRST 100 ROWS ONLY
	</copy>
	```

	> **SME Gate:** Confirm the final context row limit and whether the assistant should include only latest metrics or a time window of historical metrics.

7. Save and run the page.

## Task 7: Validate Compute Wingmate

1. Confirm the **Compute Overview** report renders metadata and metric fields.

2. Confirm the CPU and memory charts display recent metrics.

3. Start the Compute Wingmate chat.

4. Ask:

	```text
	<copy>Which compute instances have the highest CPU utilization?</copy>
	```

5. Ask:

	```text
	<copy>Which compute instances look underutilized based on CPU and memory?</copy>
	```

6. Compare the assistant responses with the chart values and SQL query results.

7. If the assistant cannot answer, validate:

	* `OCI_COMPUTE_METRICS` contains recent rows
	* `compute_metrics_latest_v` returns one row per instance
	* The assistant context query returns rows
	* The `OCI_GENAI` service object and `api_key` web credential still work

You have completed the workshop.

## Learn more

* [OCI Metrics Collector](https://github.com/jujufugh/oci-metrics-collector-py)
* [Resource Analytics Compute Data Model Reference](https://docs.oracle.com/en-us/iaas/Content/resource-analytics/reference-compute.htm)

## Acknowledgements

* **Authors:**
	* Royce Fu - Master Principal Cloud Architect
* **Last Updated by/Date** - Royce Fu, May 2026
