# Lab 4: Build a Multicloud Wingmate Agent

## Introduction

This lab walks you through the creation of a Multicloud Wingmate Agent dashboard. You will import the Multicloud Overview page into the Ask Oracle application from Lab 2, create a reusable Multicloud RAG AI Configuration, and build reports and charts for cross-cloud resource analysis.

Estimated Time: 60 minutes

### Objectives

* Import the Multicloud Overview page into the existing Lab 2 application
* Create the `wingmate_multicloud_rag` AI Configuration
* Generate Report Period View
* Create Host Insights Widgets
* Compare Insights Across CPU and Memory
* Visualize CPU Combinations for Historical and Forecast Analysis
* Operationalize MultiCloud with Property Graph
* Review MultiCloud Insights

### Prerequisites

* Completed Labs 1, 2, and 3
* Access to the Ask Oracle APEX application imported in Lab 2
* `OCI_GENAI` Generative AI service object created in APEX
* Multicloud, host-insights, documentation-reference, and graph objects loaded or mapped in the `WINGMATE` schema
* `wingmate_data.zip` extracted, including `apex-pages/wingmate-page-21-multicloud-overview.sql`
* Some SQL knowledge is preferred but not necessary

## Task 1: Import and Configure the Multicloud Overview Page

> **SME Gate:** Confirm the final multicloud data model, host-insights objects, imported page ID, AI Configuration settings, RAG Source SQL, screenshots, and expected validation responses.

1. In App Builder, open the **Ask Oracle** application imported in Lab 2.

2. Select **Import**, then upload `wingmate_data/apex-pages/wingmate-page-21-multicloud-overview.sql`.

3. Confirm **File Type** is set to **Application, Page or Component Export**, select the existing Lab 2 application as the target, and keep the page number as **21**.

4. Continue through the wizard and select **Import**.

	> **Note:** The page export removes and recreates only Page 21. It does not change the Ask Oracle application pages from Lab 2 or the Security page from Lab 3.

5. Open Page 21, **Multicloud Overview**, in Page Designer.

6. Navigate to the Shared Components of the app, select **Lists**, then open **LLM Conversations - Top**.

7. Edit the following at the end sequence and select **Create**.

    * **image/class:** `fa-cloud`
    * **List Entry Label:** `Multicloud Wingmate`
    * **Page:** `21`

8. Open Page 21, **Multicloud Overview**, in Page Designer to verify the list entry.

9. Create a new region named **WingmateChat** in the page body.

10. Set the new **WingmateChat** region **Static ID** to `wingmate-chat`.

11. Create a new **StartWingmate** button in the **WingmateChat** region.

12. Create a new dynamic action named **Chat** on the **StartWingmate** button.

13. Create a new **Show AI Assistant** true action. You will connect this action to `wingmate_multicloud_rag` after creating the AI Configuration.

14. Create a new **Hide** action for the **StartWingmate** button, then save the page.

15. Create Resource Analytics adapter views for the Multicloud page.

	The Multicloud page uses the same chart and assistant patterns as the original host-insights demo, but this lab should use Resource Analytics data by default. Run the following SQL as `WINGMATE` to create app-owned views over the Resource Analytics materialized views from Lab 1.

	> **Note:** In APEX SQL Commands, run each `CREATE OR REPLACE VIEW` statement below separately. If you use SQL Worksheet, SQL Developer, or SQLcl, you can also paste all statements into a script and run them together.

	Create the base Resource Analytics host insights view.

	```sql
	<copy>
	CREATE OR REPLACE VIEW ra_hostinsights_base_v AS
	SELECT i.id AS instance_id,
	       i.display_name AS hostname,
	       NVL(i.lifecycle_state, 'UNKNOWN') AS lifecycle_state,
	       i.region,
	       i.availability_domain,
	       i.shape,
	       c.name AS compartment_name,
	       NVL(i.shape_config_ocpus, f.ocpu_usage) AS cpu_capacity,
	       CASE
	           WHEN i.lifecycle_state = 'RUNNING'
	           THEN NVL(f.ocpu_usage, i.shape_config_ocpus)
	           ELSE 0
	       END AS cpu_usage,
	       NVL(i.shape_config_memory_in_gbs, f.memory_usage_mb / 1024) AS memory_capacity,
	       CASE
	           WHEN i.lifecycle_state = 'RUNNING'
	           THEN NVL(f.memory_usage_mb / 1024, i.shape_config_memory_in_gbs)
	           ELSE 0
	       END AS memory_usage,
	       NVL(f.attached_volumes_count, 0) AS attached_volumes_count,
	       i.time_created,
	       i.ocira_update_date
	FROM mv_compute_instance_dim_v i
	LEFT JOIN mv_compute_fact_v f
	    ON f.instance_id = i.id
	LEFT JOIN mv_compartment_dim_v c
	    ON c.id = i.compartment_id
	WHERE NVL(i.lifecycle_state, 'UNKNOWN') <> 'TERMINATED';
	</copy>
	```

	Create the report period view.

	```sql
	<copy>
	CREATE OR REPLACE VIEW ra_hostinsights_report_period AS
	SELECT hostname,
	       region,
	       availability_domain,
	       compartment_name,
	       lifecycle_state,
	       shape,
	       'OCPU' AS usageunit,
	       'Configured OCPU' AS resourcemetric,
	       cpu_capacity AS capacity,
	       cpu_usage AS usage,
	       time_created,
	       ocira_update_date
	FROM ra_hostinsights_base_v
	UNION ALL
	SELECT hostname,
	       region,
	       availability_domain,
	       compartment_name,
	       lifecycle_state,
	       shape,
	       'GB' AS usageunit,
	       'Configured Memory' AS resourcemetric,
	       memory_capacity AS capacity,
	       memory_usage AS usage,
	       time_created,
	       ocira_update_date
	FROM ra_hostinsights_base_v;
	</copy>
	```

	Create the CPU summary view.

	```sql
	<copy>
	CREATE OR REPLACE VIEW ra_hostinsights_cpu_usage_summary AS
	SELECT SUM(cpu_usage) AS usage,
	       SUM(cpu_capacity) AS capacity
	FROM ra_hostinsights_base_v;
	</copy>
	```

	Create the memory summary view.

	```sql
	<copy>
	CREATE OR REPLACE VIEW ra_hostinsights_memory_usage_summary AS
	SELECT SUM(memory_usage) AS usage,
	       SUM(memory_capacity) AS capacity
	FROM ra_hostinsights_base_v;
	</copy>
	```

	Create the CPU per-host statistics view.

	```sql
	<copy>
	CREATE OR REPLACE VIEW ra_hostinsights_res_stat AS
	SELECT hostname,
	       cpu_capacity AS capacity,
	       cpu_usage AS usage,
	       ROUND(AVG(cpu_usage) OVER (), 2) AS average,
	       CASE
	           WHEN cpu_capacity > 0 THEN ROUND(cpu_usage / cpu_capacity * 100, 2)
	           ELSE 0
	       END AS utilizationpercent,
	       0 AS usagechangepercent,
	       region,
	       shape,
	       compartment_name,
	       lifecycle_state
	FROM ra_hostinsights_base_v
	WHERE cpu_capacity IS NOT NULL;
	</copy>
	```

	Create the memory per-host statistics view.

	```sql
	<copy>
	CREATE OR REPLACE VIEW ra_hostinsights_res_stat_memory AS
	SELECT hostname,
	       memory_capacity AS capacity,
	       memory_usage AS usage,
	       ROUND(AVG(memory_usage) OVER (), 2) AS average,
	       CASE
	           WHEN memory_capacity > 0 THEN ROUND(memory_usage / memory_capacity * 100, 2)
	           ELSE 0
	       END AS utilizationpercent,
	       0 AS usagechangepercent,
	       region,
	       shape,
	       compartment_name,
	       lifecycle_state
	FROM ra_hostinsights_base_v
	WHERE memory_capacity IS NOT NULL;
	</copy>
	```

	Create the host insights assistant context view.

	```sql
	<copy>
	CREATE OR REPLACE VIEW ra_hostinsights_report_sv AS
	WITH summary AS (
	    SELECT 'Compute inventory summary: '
	           || COUNT(*) || ' non-terminated instances; '
	           || SUM(CASE WHEN lifecycle_state = 'RUNNING' THEN 1 ELSE 0 END) || ' running; running OCPUs '
	           || ROUND(SUM(cpu_usage), 2) || ' of configured '
	           || ROUND(SUM(cpu_capacity), 2) || '; running memory GB '
	           || ROUND(SUM(memory_usage), 2) || ' of configured '
	           || ROUND(SUM(memory_capacity), 2) || '.' AS summary_text
	    FROM ra_hostinsights_base_v
	),
	host_lines AS (
	    SELECT LISTAGG(
	               '- hostname: ' || hostname
	               || '; lifecycle_state: ' || lifecycle_state
	               || '; configured_ocpus: ' || ROUND(cpu_capacity, 2)
	               || '; running_ocpus: ' || ROUND(cpu_usage, 2)
	               || '; configured_memory_gb: ' || ROUND(memory_capacity, 2)
	               || '; running_memory_gb: ' || ROUND(memory_usage, 2)
	               || '; region: ' || region
	               || '; shape: ' || shape,
	               CHR(10)
	           ) WITHIN GROUP (
	               ORDER BY cpu_usage ASC NULLS FIRST,
	                        cpu_capacity DESC NULLS LAST,
	                        hostname
	           ) AS host_detail_text
	    FROM (
	        SELECT *
	        FROM ra_hostinsights_base_v
	        ORDER BY cpu_usage ASC NULLS FIRST,
	                 cpu_capacity DESC NULLS LAST,
	                 hostname
	        FETCH FIRST 50 ROWS ONLY
	    )
	)
	SELECT summary.summary_text
	       || CHR(10) || CHR(10)
	       || 'Host allocation details sorted by lowest running OCPU allocation first:'
	       || CHR(10)
	       || host_lines.host_detail_text AS context_prompt
	FROM summary
	CROSS JOIN host_lines;
	</copy>
	```

	Create the multicloud assistant context view.

	```sql
	<copy>
	CREATE OR REPLACE VIEW ra_multicloud_details_v AS
	SELECT 'Resource Analytics multicloud summary: '
	       || COUNT(*) || ' non-terminated compute instances across '
	       || COUNT(DISTINCT region) || ' region(s), '
	       || COUNT(DISTINCT compartment_name) || ' compartment(s), and '
	       || COUNT(DISTINCT shape) || ' shape(s). Running configured capacity is '
	       || ROUND(SUM(cpu_usage), 2) || ' OCPUs and '
	       || ROUND(SUM(memory_usage), 2) || ' GB memory. Total configured capacity is '
	       || ROUND(SUM(cpu_capacity), 2) || ' OCPUs and '
	       || ROUND(SUM(memory_capacity), 2) || ' GB memory.'
	       AS context_prompt
	FROM ra_hostinsights_base_v;
	</copy>
	```

	Create the multicloud inventory report view.

	```sql
	<copy>
	CREATE OR REPLACE VIEW ra_multicloud_inventory_v AS
	SELECT 'Compute Instance' AS resource_type,
	       hostname AS resource_name,
	       region,
	       compartment_name AS compartment,
	       lifecycle_state,
	       shape AS resource_shape,
	       TO_CHAR(cpu_capacity) || ' OCPU / '
	           || TO_CHAR(memory_capacity) || ' GB memory' AS resource_summary
	FROM ra_hostinsights_base_v
	UNION ALL
	SELECT 'Attached Volume' AS resource_type,
	       volume_display_name AS resource_name,
	       region,
	       instance_compartment AS compartment,
	       volume_lifecycle_state AS lifecycle_state,
	       volume_attachment_type AS resource_shape,
	       TO_CHAR(volume_size_in_gbs) || ' GB volume attached to '
	           || instance_name AS resource_summary
	FROM mv_instance_volume_details_v
	WHERE volume_id IS NOT NULL;
	</copy>
	```

	Use these Resource Analytics adapter views in the page SQL. Keep the original synthetic `HOSTINSIGHTS_*`, `OCI_EXA_*`, `OCI_CDB`, and `OCI_PDB` objects as an optional backup only when Resource Analytics has no rows or when you need predictable demo forecast data.

	> **Flat-file fallback:** If your environment uses the uploaded flat files instead of Resource Analytics materialized views, skip the `RA_*` adapter views and use the fallback queries called out in the remaining steps.

16. Navigate to **Shared Components**, then **AI Configurations**.

	> **Note:** APEX 24.2 uses **AI Configurations** and **RAG Sources**. In APEX 26.1, the same capability appears under AI Agent tooling. Use the labels shown in your APEX environment, but keep the static ID values in this lab unchanged.

17. Create an AI Configuration with these values:

	* **Name:** `Multicloud Wingmate RAG`
	* **Static ID:** `wingmate_multicloud_rag`
	* **Service:** `OCI_GENAI`
	* **System Prompt** or **Role:** `You are OCI Multicloud Wingmate. Answer capacity, allocation, inventory, and documentation-reference questions using the configured RAG sources. Treat Resource Analytics host insights data as configured capacity and running allocation, not live OCI Monitoring metrics. Be concise and say when retrieved context is insufficient.`

18. Add SQL-based RAG Sources to `wingmate_multicloud_rag`:

	```sql
	<copy>
	SELECT context_prompt
	FROM ra_hostinsights_report_sv
	</copy>
	```

	```sql
	<copy>
	SELECT context_prompt
	FROM ra_multicloud_details_v
	</copy>
	```

	```sql
	<copy>
	SELECT context_prompt
	FROM oci_doc_ref_compute_sv
	</copy>
	```

	**Flat-file fallbacks:**

	```sql
	<copy>
	SELECT context_prompt
	FROM hostinsights_report_sv
	</copy>
	```

	```sql
	<copy>
	SELECT context_prompt
	FROM cis_multicloud_details_v
	</copy>
	```

19. Validate the RAG source SQL as `WINGMATE`.

	```sql
	<copy>
	SELECT 'host_insights' AS source_name, context_prompt
	FROM ra_hostinsights_report_sv
	UNION ALL
	SELECT 'multicloud_summary' AS source_name, context_prompt
	FROM ra_multicloud_details_v
	UNION ALL
	SELECT 'doc_ref_compute' AS source_name, context_prompt
	FROM oci_doc_ref_compute_sv;
	</copy>
	```

20. Configure the new AI Assistant action by navigating to **Show AI Assistant** in the navigation tree under the Multicloud chat region: **StartWingmate** -> **Chat** -> **Show AI Assistant**.

	Configure the action:

	* **Configuration:** `wingmate_multicloud_rag`
	* **Display As:** `Inline`
	* **Container Selector:** `#wingmate-chat`

	![system prompt](./images/show-ai-prompt.png "")

	Under **Welcome Message**, enter:

	```text
	<copy>
	Welcome! You can chat with OCI Multicloud Wingmate.
	</copy>
	```

	Under **Quick Actions**, add these messages:

	* **Message 1:** `What are the allocated CPUs for the hosts with the hostname?`
	* **Message 2:** `Which hostnames have the lowest or zero running OCPU allocation?`

	![example prompts](./images/quick-prompt.png "")

21. Save the page.

22. Create a **Classic Report** region for the Multicloud inventory summary.

	![Identity Table](./images/update-identity.png "")

23. Name the report **MultiCloud Insights** and set the **SQL Query** to the following:

	```
	<copy>
	SELECT *
	FROM ra_multicloud_inventory_v
	</copy>
	```

	**Flat-file fallback:**

	```sql
	<copy>
	SELECT *
	FROM oci_exa_infr
	UNION
	SELECT *
	FROM oci_exa_vm_cluster
	UNION
	SELECT *
	FROM oci_cdb
	UNION
	SELECT *
	FROM oci_pdb
	</copy>
	```

	![SQL Query for MultiCloud Insights](./images/multicloud-insights.png "")

	> **Note:** This report serves as the bottom of the dashboard. Place the host insights regions you create later above this table.

## Task 2: Generate Report Period View

> **SME Gate:** Confirm all table and view names used by the host-insights and multicloud reports, charts, AI Configuration RAG sources, and source SQL.

1. Create a table for viewing the host period by creating a region to contain it. Expand the **bottom module** (if not open) by selecting the arrow at the bottom center of the screen. Select **Regions** and pick the **Help** icon. Drop it under the Chat Region.

	![Help Region](./images/help-region.png "")

2. Name it **Host CPU Insights**.

	![Host CPU Insights name](./images/host-cpu-insights.png "")

3. Drag and drop **Classic Report** into the body of the newly created region.

	![Classic Report in Body](./images/host-cpu-insights-report.png "")

4. Name the Report **ReportPeriod** and select the table **RA_HOSTINSIGHTS_REPORT_PERIOD**.

	**Flat-file fallback:** Select **HOSTINSIGHTS_REPORT_PERIOD** instead.

	![Host Insights Report Period Table](./images/report-period-table.png "")

5. Expand the ReportPeriod columns by clicking **the arrow** and and right-click **USAGEUNIT** and **RESOURCEMETRIC**, selecting **Comment Out**.

	![metrics commented out](./images/metrics-hostinsights.png "")

## Task 3: Create Host Insights Widgets

1. Drag and drop **Static Content** into the sub-region. Name the region **HOST INSIGHTS Metrics**.

	![Static Content sub region](./images/host-insights-static.png "")

2. Drag and drop **Chart** in the sub region of the HOST INSIGHTS Metrics static content. Name it **CPU Usage over Capacity**

	![Host Insights Metrics Chat](./images/chart-host-insights-metrics.png "")

3. Select **Attributes** at the top of the right module and change the chart type to **Status Gauge**. 

	![Status Gauge](./images/cpu-gauge.png "")

4. Update the style of the gauge by scrolling down on the right and change the **Indicator Size** to **.5** and **Inner Radius** to **.9**.

	![Gauge style Update](./images/cpu-gauge-size.png "")

5. Scroll down more change **Value** and **Format** to **Percent** with 0 decimal places.

	![Status Gauge](./images/cpu-gauge-percent.png "")

6. Select **Series** under the chart created and name it **CPU Metrics**. Change from Table/View to **SQL Query** and paste the following:

	```
	<copy>
	SELECT usage as cpu_usage, capacity as cpu_capacity FROM RA_HOSTINSIGHTS_CPU_USAGE_SUMMARY
	</copy>
	```

	**Flat-file fallback:**

	```sql
	<copy>
	SELECT usage AS cpu_usage, capacity AS cpu_capacity
	FROM hostinsights_cpu_usage_summary
	</copy>
	```

	![CPU Metrics SQL Query](./images/cpu-metrics-sql.png "")

7. Scroll down and add a mapping of **CPU Usage** for **Label** and **Value** and **CPU Capacity** for **Maximum Value**.  

	![CPU mapping](./images/cpu-gauge-mapping.png "")

8. Right-click to duplicate the **CPU Usage Over Capacity** gauge. Update the **Name** to **Memory Usage over Capacity**. Select **Attributes** and adjust the gauge size:
	* Indicator Size: **.5**
	* Inner Radius: **.6**

	![Memory Metrics](./images/memory-gauge-size.png "")

9. Select Series and rename it **Memory Metrics**. Update the SQL Query to the following:

	```
	<copy>
	SELECT usage as mem_usage, capacity as mem_capacity FROM RA_HOSTINSIGHTS_MEMORY_USAGE_SUMMARY
	</copy>
	```

	**Flat-file fallback:**

	```sql
	<copy>
	SELECT usage AS mem_usage, capacity AS mem_capacity
	FROM hostinsights_memory_usage_summary
	</copy>
	```

	![Memory Metrics SQL Query](./images/memory-metrics-sql.png "")

10. Scroll down and change the mapping with **Memory Usage** for **Label** and **Value** and **Memory Capacity** for **Maximum Value**. 

	![Memory Gauge Mapping](./images/memory-guage-mapping.png "")

Next, Visuals for Host Insights across both CPU and Memory will be generated.

## Task 4: Compare Insights Across CPU and Memory

1. Drag and drop another **Static Region** into the same region **Host CPU Insights**. Name this Sub Region **HOST INSIGHTS CPU and MEMORY**. 

	![Host insights region](./images/host-insights-cpu-memory-name.png "")

2. Drag and drop a chart into the Body and name it **CPU Usage across Host**. 

	![CPU Usage across hosts name](./images/cpu-usage-across-hosts.png "")

3. Select Attributes and change it to **Pie**. 

	![Chart Attributes](./images/cpu-usage-across-hosts-pie.png "")

4. Scroll down and toggle off **Dim On Hover** and select **Highlight and Explode** for **Settings**.

	![Pie settings](./images/cpu-usage-across-hosts-settings.png "")

5. For the series, name it **Tasks**. Add the following **SQL Query**:

	```
	<copy>
	SELECT
    hostname,
    capacity,
    usage,
    average,
    usagechangepercent
	FROM
    ra_hostinsights_res_stat
	</copy>
	```

	**Flat-file fallback:**

	```sql
	<copy>
	SELECT
    hostname,
    capacity,
    usage,
    average,
    usagechangepercent
	FROM
    hostinsights_res_stat
	</copy>
	```

	![SQL Query CPU Usage](./images/cpu-usage-sql.png "")

6. Scroll down and Select **HOSTNAME** for Label and **USAGE** for Value.

	![CPU usage across hosts Column Mapping](./images/cpu-usage-across-hosts-mapping.png "")

7. Drag and drop a second chart next to CPU Usage across Hosts and name it **Key Metrics Distribution**.

	![Key Metrics Chart](./images/key-metrics-drop.png "")

8. Select **Attributes** and change chart type to **Polar**.

	![Key Metrics Chart Type](./images/key-metrics-polar.png "")

9. Scroll down and toggle **Stack** under Appearance to **ON**.

	![Appearance toggle](./images/key-metrics-stack.png "")

10. Update the series name to **CPU Utilization** and change the type to **Line with Area**.

11. Update the **CPU Utilization SQL Query** to match:

	```
	<copy>
	select HOSTNAME, 
       UTILIZATIONPERCENT AS CPU_UTIL, 
       'CPU Utilization' as MetricType
	from RA_HOSTINSIGHTS_RES_STAT
	</copy>
	```

	**Flat-file fallback:**

	```sql
	<copy>
	select HOSTNAME,
       UTILIZATIONPERCENT AS CPU_UTIL,
       'CPU Utilization' as MetricType
	from hostinsights_res_stat
	</copy>
	```

	![CPU Utilization SQL](./images/cpu-utilization.png "")

12. Scroll down and update the mapping to the following:
	* Label: **HOSTNAME**
	* Value: **CPU_UTIL**

	![CPU utilization mapping](./images/key-metrics-cpu-mapping.png "")

13. Right-click **Series** and select **Create Series**.

	![Create Series](./images/create-series.png "")

14. Name the Series **Memory Utilization** and change **Type** to **Line with Area**.

	![Memory Utilization type](./images/key-metrics-memory.png "")

15. Scroll down and change **Type** to **SQL Query** and paste the following into the query box:

	```
	<copy>
	select HOSTNAME, 
		UTILIZATIONPERCENT AS MEM_UTIL, 
		'MEMORY Utilization' as MetricType
	from RA_HOSTINSIGHTS_RES_STAT_MEMORY
	</copy>
	```

	**Flat-file fallback:**

	```sql
	<copy>
	select HOSTNAME,
		UTILIZATIONPERCENT AS MEM_UTIL,
		'MEMORY Utilization' as MetricType
	from hostinsights_res_stat_memory
	</copy>
	```

	![SQL Query Memory Utilization](./images/key-metrics-memory-query.png "")

16. Right-click **CPU Usage across Hosts** and select **Duplicate**. Rename the new chart: **Memory Usage across Hosts**.

	![Memory Usage Chart name](./images/memory-usage-name.png "")

17. Select the **Tasks** Series and update the SQL Query to the following:

	```
	<copy>
	SELECT
    hostname,
    capacity,
    usage,
    average,
    usagechangepercent
	FROM
    ra_hostinsights_res_stat_memory
	</copy>
	```

	**Flat-file fallback:**

	```sql
	<copy>
	SELECT
    hostname,
    capacity,
    usage,
    average,
    usagechangepercent
	FROM
    hostinsights_res_stat_memory
	</copy>
	```

	![Memory Usage SQL Query](./images/memory-usage-query.png "")

18. Adjust the charts to be aligned on the horizontal axis by selecting the new chart in the center module and dragging it to the right of the **Key Metrics Distribution Chart**.

	![Drag and drop Chart](./images/drag-memory.png "")

## Task 5: Visualize CPU Combinations for Historical and Forecasting Analysis

> **Note:** Resource Analytics provides current inventory and configured resource allocation, not a native CPU forecast series. Use the synthetic `HOSTINSIGHTS_CPU_FORECAST_TREND` object in this task as an optional backup dataset when you need predictable historical and forecast chart data.

1. Drag and drop a **static region** into the body of **Host CPU Insights** and name it **CPU Combination Chart**.

	![CPU Combination Chart Region](./images/cpu-usage-historic-region.png "")

	![CPU Combination Name](./images/cpu-combination-name.png "")

2. Drag and drop a **chart** into the body of **CPU Combination Chart** region. Name it **CPU Usage Historic and Forecast**.

	![CPU Usage historic name](./images/cpu-usage-historic-name.png "")

3. Change the chart type to **Combination**.

	![Combination chart type](./images/cpu-usage-historic-combination.png "")

4. Untoggle the **Dim on Hover** to off.

	![CPU Dim on hover off](./images/cpu-combination-toggle.png "")

5. Select the **Series** and rename it to **CPU Historic Usage**.

	![CPU Historic Usage Name](./images/cpu-historic-usage.png "")

6. Scroll down and paste the following SQL Query:

	```
	<copy>
	SELECT 
    to_char(cut.endTimestamp, 'DD-MON-YYYY HH24:MI:SS') AS HISTORIC_TIMESTAMP,
    cut.usage as historical_usage,
    'CPU Historic Usage' as CPU_HIST
	FROM 
    HOSTINSIGHTS_CPU_FORECAST_TREND CPU_FORECAST_TREND,
    JSON_TABLE(
        CPU_FORECAST_TREND.HISTORICALDATA,
        '$[*]' 
        COLUMNS (
            endTimestamp DATE PATH '$.endTimestamp',
            usage NUMBER PATH '$.usage'
        )
    ) cut
	ORDER BY cut.endTimestamp ASC
	</copy>
	```

	![CPU Historic Usage](./images/cpu-historic-usage-sql.png "")

7. Scroll down and update the **Column Mapping** to the following:
		* Label: **HISTORIC_TIMESTAMP**
		* Value: **HISTORICAL_USAGE**

	![Column Mapping](./images/cpu-historic-mapping.png "")

8. Right-click **Series** and select **Create Series**.

	![Create Series button](./images/create-series-forecast.png "")

9. Name the new series **CPU Forecast Usage** and select the type as **Line with Area**

	![Name CPU Forecast](./images/cpu-forecast-usage-name.png "")

10. Scroll down and change the source to **SQL Query** and paste the following SQL Query:

	```
	<copy>
	SELECT 
    to_char(cft.endTimestamp, 'DD-MON-YYYY HH24:MI:SS') AS PROJECTED_TIMESTAMP,
    cft.usage as projected_usage,
    cft.highValue as projected_highValue,
    cft.lowValue as projected_lowValue,
    'CPU Historic Usage' as CPU_HIST    
	FROM 
    HOSTINSIGHTS_CPU_FORECAST_TREND CPU_FORECAST_TREND,
    JSON_TABLE(
        CPU_FORECAST_TREND.PROJECTEDDATA,
        '$[*]' 
        COLUMNS (
            endTimestamp DATE PATH '$.endTimestamp',
            usage NUMBER PATH '$.usage',
            highValue NUMBER PATH '$.highValue',
            lowValue NUMBER PATH '$.lowValue'
        )
    ) cft
	ORDER BY cft.endTimestamp ASC
	</copy>
	```

	![SQL Query CPU Forecast](./images/cpu-forecast-usage-sql.png "")

11. Drag and drop a **Chart** inside the body of **CPU Combination Chart** region. 

	![CPU Usage Chart](./images/cpu-usage-drop.png "")

12. Name the chart **CPU Usage Historic and Forecast - Mixed Frequency**.

	![Name of CPU Usage](./images/cpu-usage-mixed-name.png "")

13. Select **Attributes** and change the Type to **Combination**.

	![Mixed Frequency Combination Chart Type](./images/cpu-usage-mixed-combination.png "")

14. Scroll down and change the settings for Time Axis Type to **Mixed Frequency**.

	![Mixed Frequency Settings](./images/cpu-usage-mixed-settings.png "")

15. Select the **Series** and change the name to **CPU Historic Usage**. 

	![CPU Historic Usage name](./images/cpu-historic-usage-bar.png "")

16. Scroll down and select **SQL Query** and paste the following SQL:

	```
	<copy>
	SELECT 
    to_char(cut.endTimestamp, 'DD-MON-YYYY HH24:MI:SS') AS HISTORIC_TIMESTAMP,
    cut.usage as historical_usage,
    'CPU Historic Usage' as CPU_HIST
	FROM 
    HOSTINSIGHTS_CPU_FORECAST_TREND CPU_FORECAST_TREND,
    JSON_TABLE(
        CPU_FORECAST_TREND.HISTORICALDATA,
        '$[*]' 
        COLUMNS (
            endTimestamp DATE PATH '$.endTimestamp',
            usage NUMBER PATH '$.usage'
        )
    ) cut
	ORDER BY cut.endTimestamp ASC
	</copy>
	```

	![CPU Historic Usage SQL](./images/cpu-historic-usage-bar-sql.png "")

17. Right-click **Series** and select **Create Series**. 

	![Create series button](./images/cpu-historic-usage-bar-create-series.png "")

18. Name the series **CPU Forecast MAX** and change the Type to **Line**.

	![CPU Forecast MAX Line](./images/cpu-historic-usage-bar-forecast-max.png "")

19. Scroll down and change the Source Type to **SQL Query** and paste the following in the SQL Query:

	```
	<copy>
	SELECT 
    to_char(cft.endTimestamp, 'DD-MON-YYYY HH24:MI:SS') AS PROJECTED_TIMESTAMP,
    cft.highValue as projected_highValue,
    'CPU Forecast Max Usage' as CPU_FORECAST_MAX  
	FROM 
    HOSTINSIGHTS_CPU_FORECAST_TREND CPU_FORECAST_TREND,
    JSON_TABLE(
        CPU_FORECAST_TREND.PROJECTEDDATA,
        '$[*]' 
        COLUMNS (
            endTimestamp DATE PATH '$.endTimestamp',
            usage NUMBER PATH '$.usage',
            highValue NUMBER PATH '$.highValue',
            lowValue NUMBER PATH '$.lowValue'
        )
    ) cft
	ORDER BY cft.endTimestamp ASC
	</copy>
	```

	![SQL for Max Forecast](./images/cpu-historic-usage-bar-forecast-max-sql.png "")

20. Right-click **Series** and select **Create Series**.

	![Create series button](./images/cpu-historic-usage-bar-create-series.png "")

21. Name the series **CPU Forecast Usage** and change the Type to **Line**.

	![CPU Forecast Usage Line](./images/cpu-historic-usage-bar-forecast-usage.png "")

22. Scroll down and change the Source Type to **SQL Query** and paste the following in the SQL Query:

	```
	<copy>
	SELECT 
    to_char(cft.endTimestamp, 'DD-MON-YYYY HH24:MI:SS') AS PROJECTED_TIMESTAMP,
    cft.usage as projected_usage,
    cft.highValue as projected_highValue,
    cft.lowValue as projected_lowValue,
    'CPU Forecast Usage' as CPU_FORECAST
	FROM 
    HOSTINSIGHTS_CPU_FORECAST_TREND CPU_FORECAST_TREND,
    JSON_TABLE(
        CPU_FORECAST_TREND.PROJECTEDDATA,
        '$[*]' 
        COLUMNS (
            endTimestamp DATE PATH '$.endTimestamp',
            usage NUMBER PATH '$.usage',
            highValue NUMBER PATH '$.highValue',
            lowValue NUMBER PATH '$.lowValue'
        )
    ) cft
	ORDER BY cft.endTimestamp ASC
	</copy>
	```

	![SQL for Usage Forecast](./images/cpu-historic-usage-bar-forecast-usage-sql.png "")

23. Right-click **Series** and select **Create Series**.

	![Create series button](./images/cpu-historic-usage-bar-create-series.png "")

24. Name the series **CPU Forecast MIN** and change the Type to **Line**.

	![CPU Forecast MIN Line](./images/cpu-historic-usage-bar-forecast-min.png "")

25. Scroll down and change the Source Type to **SQL Query** and paste the following in the SQL Query:

	```
	<copy>
	SELECT 
    to_char(cft.endTimestamp, 'DD-MON-YYYY HH24:MI:SS') AS PROJECTED_TIMESTAMP,
    cft.usage as projected_usage,
    cft.highValue as projected_highValue,
    cft.lowValue as projected_lowValue,
    'CPU Forecast Usage' as CPU_FORECAST
	FROM 
    HOSTINSIGHTS_CPU_FORECAST_TREND CPU_FORECAST_TREND,
    JSON_TABLE(
        CPU_FORECAST_TREND.PROJECTEDDATA,
        '$[*]' 
        COLUMNS (
            endTimestamp DATE PATH '$.endTimestamp',
            usage NUMBER PATH '$.usage',
            highValue NUMBER PATH '$.highValue',
            lowValue NUMBER PATH '$.lowValue'
        )
    ) cft
	ORDER BY cft.endTimestamp ASC
	</copy>
	```

	![SQL for Min Forecast](./images/cpu-historic-usage-bar-forecast-min-sql.png "")

26. Save the work by clicking the **Save button** at the top right.

	![Save page button](./images/save-page.png "")

## Task 6: Operationalize MultiCloud with Property Graph

> **Note:** This task requires downloading a **Plug-in** to install for visualizing the SQL property graphs in APEX. Learn more by reading through the [documentation.](https://docs.oracle.com/en/database/oracle/property-graph/26.1/spgdg/visualizing-sql-graph-queries-using-apex-graph-visualization-plug.html#GUID-29126F4F-FF5E-4712-9BFE-535F2451AD3A)

> **SME Gate:** Confirm whether the APEX Graph Visualization plug-in is required, the supported APEX version, the approved download source, the graph object name, graph query, and validation steps.

1. Download the sql file from the github repo by clicking the link. Right-click in the new tab window and select **Save As**: [region_type_plugin_graphviz.sql](https://raw.githubusercontent.com/oracle/apex/3bb6d39634560035cac57743bbe232d2fb5cae2d/plugins/region/graph-visualization/region_type_plugin_graphviz.sql)

	![Graph Viz SQL file](./images/graph-viz-sql-file.png "")

2. Navigate to **App Builder** and the **Wingmate App**. Select **Import/Export**.

	![Import and Export Button](./images/import-export-app-builder.png "")

3. Drag and drop the **region_type_plugin_graphviz.sql file**, select **Plugin** and **Next**.

	![import plugin](./images/import-plugin.png "")

4. Select **Next** to proceed with the import.

	![import confirmation](./images/confirm-import.png "")

5. Select **Import** to begin the import of the plug-in.

	![import process confirmation](./images/install-plugin.png "")

6. Verify the plug-in was installed correctly. Navigate back to the **MultiCloud Overview** page of the app by selecting the imported application in the breadcrumbs bar and selecting the page.

	> **Note:** Notice the settings of **Page size** that can be modified if needed and this is available via **Shared Components** -> **Component Settings** (via the breadcrumbs).

	![verification of plugin installation](./images/plugin-success.png "")

7. Navigate back to the **MultiCloud Overview** page by selecting the **MultiCloud Overview** page.

	![MultiCloud Overview Page Icon](./images/multicloud-page.png "")

8. Drag and drop the **Graph Visualization plugin** from the regions object selector.

	![Graph Visualization Region](./images/graph-region.png "")

9. Name the region **MultiCloud Insights**.

	![MultiCloud Insights name](./images/multicloud-name.png "")

10. Scroll down and update the Source Type to **SQL Query** and paste the following SQL:

	```
	<copy>
	SELECT * FROM GRAPH_TABLE(MULTICLOUD_GRAPH
    MATCH (a) -[e]-> (b) - [f] -> (c) - [g] -> (d)
    COLUMNS(vertex_id(a) as aid, edge_id(e) as eid, vertex_id(b) as bid, edge_id(f) as fid, vertex_id(c) as cid, edge_id(g) as gid, vertex_id(d) as did)
	);
	</copy>
	```

	![SQL Query for Graph visualization](./images/multicloud-insights.png "")

## Task 7: Review MultiCloud Insights

1. Run the MultiCloud Wingmate page and verify the reports, forecast charts, and graph visualization render with the loaded data. Use the chat prompts to confirm the assistant answers from the host insights and documentation context.

You may now **proceed to the next lab**.

## Acknowledgements

* **Authors:**
	* Nicholas Cusato - Cloud Architect
	* Royce Fu - Master Principal Cloud Architect
* **Last Updated by/Date** - Royce Fu, May 2026
