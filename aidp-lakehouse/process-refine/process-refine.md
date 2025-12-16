
# Lab 2: Process and Refine Data in AI Data Platform and Lakehouse

## Introduction

This lab builds on Lab 1 by loading sample airline data in ATP, extracting transactional airline data from ATP, processing it through bronze, silver, and gold layers in Oracle AI Data Platform (AIDP) using Spark and Delta Lake, and publishing the refined gold data to Autonomous AI Lakehouse for analytics.

> **Estimated Time:** 1 hour

---

### Objectives

In this lab, you will:
- Load sample airline transactional data into ATP
- Connect AIDP to ATP source and AI Lakehouse
- Extract data from ATP to bronze layer in AIDP
- Clean, enrich, and transform to silver and gold layers
- Publish refined gold data to GOLD schema in AI Lakehouse

---

### Prerequisites

This lab assumes you have:
- Completed Lab 1 with ATP and AIDP and Autonomous AI Lakehouse set up
- Access to AIDP

---


## Task 1: Load Sample Airline Data into Source_XX Schema in ATP instance

1. Navigate back to SQL Developer browser tab for the ATP database "airline-source-atp", that you created in Lab 1. Ensure that you can see the SOURCE\_XX user in the top right of the screen.

Create the AIRLINE_SAMPLE table.

Paste the following SQL statement in the Worksheet and click the 'Run Statement' button

```sql
<copy>
CREATE TABLE AIRLINE_SAMPLE (
  FLIGHT_ID   NUMBER,
  AIRLINE     VARCHAR2(20),
  ORIGIN      VARCHAR2(3),
  DEST        VARCHAR2(3),
  DEP_DELAY   NUMBER,
  ARR_DELAY   NUMBER,
  DISTANCE    NUMBER
);
</copy>
```

![Create Schema](./images/source_schema_create1.png)

2. Insert sample data:

Paste the following SQL statements in the Worksheet and click the 'Run Script' button

![Create Data](./images/source_schema_populate1.png)

```sql
<copy>
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1001, 'Skynet Airways', 'JFK', 'LAX', 10, 5, 2475);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1002, 'Sunwind Lines', 'ORD', 'SFO', -3, -5, 1846);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1003, 'BlueJet', 'ATL', 'SEA', 0, 15, 2182);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1004, 'Quantum Flyers', 'DFW', 'MIA', 5, 20, 1121);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1005, 'Nebula Express', 'BOS', 'DEN', 12, 8, 1754);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1006, 'Skynet Airways', 'SEA', 'ORD', -5, -2, 1721);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1007, 'Sunwind Lines', 'MIA', 'ATL', 7, 4, 595);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1008, 'BlueJet', 'SFO', 'BOS', 22, 18, 2704);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1009, 'Quantum Flyers', 'LAX', 'JFK', -1, 0, 2475);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1010, 'Nebula Express', 'DEN', 'DFW', 14, 20, 641);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1011, 'Skynet Airways', 'PHX', 'SEA', 3, -2, 1107);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1012, 'BlueJet', 'ORD', 'ATL', -7, -10, 606);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1013, 'Quantum Flyers', 'BOS', 'JFK', 9, 11, 187);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1014, 'Sunwind Lines', 'LAX', 'DFW', 13, 15, 1235);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1015, 'Nebula Express', 'SFO', 'SEA', 0, 3, 679);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1016, 'Skynet Airways', 'ATL', 'DEN', 6, 5, 1199);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1017, 'BlueJet', 'DFW', 'PHX', -2, 1, 868);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1018, 'Quantum Flyers', 'ORD', 'BOS', 8, -1, 867);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1019, 'Sunwind Lines', 'JFK', 'MIA', 10, 16, 1090);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1020, 'Nebula Express', 'DEN', 'ORD', -4, 0, 888);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1021, 'Skynet Airways', 'SEA', 'ATL', 16, 12, 2182);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1022, 'BlueJet', 'MIA', 'LAX', 5, 7, 2342);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1023, 'Quantum Flyers', 'DEN', 'BOS', 2, -2, 1754);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1024, 'Sunwind Lines', 'SFO', 'JFK', -6, -8, 2586);
INSERT INTO AIRLINE_SAMPLE (FLIGHT_ID, AIRLINE, ORIGIN, DEST, DEP_DELAY, ARR_DELAY, DISTANCE) VALUES (1025, 'Nebula Express', 'ORD', 'MIA', 11, 13, 1197);
</copy>
```

3. Verify the data:

Paste the following SQL statement in the Worksheet and click the 'Run Statement' button

You should be able to view the data you inserted in the database table.

```sql
<copy>
SELECT * FROM AIRLINE_SAMPLE;
</copy>
```

![View Data](./images/source_schema_data1.png)

---

## Task 2: Connect AIDP to ATP Source

1. Navigate back to the tab in your browser where you logged into the Oracle Cloud. Using the Navigation menu,  navigate to Analytics & AI -> Data Lake -> AI Data Platform 

![AI Data Platform](./images/create-aidp.png)

2. Select the icon to open a new tab with the AIDP interface.

![AIDP Instance](./images/aidp-instance1.png)

3. The AIDP Console opens up.

![AIDP Home](./images/aidp-home1.png)

4. Select Create > Catalog 

![Create Catalog](./images/create-catalog-a.png)

5. For ATP: Provide catalog name (e.g. **atp\_external\_catalog\_xx**), select External Catalog, External source type Oracle Autonomous Transaction Processing

![ATP External Catalog](./images/atp-external-catalog2.png)

6. Select the 'Choose ATP Instance' and select the 'aidp-lab' compartment from the drop down.

![ATP External Catalog](./images/atp-external-catalog3.png)

7. Select the ATP instance 'airline-source-atp' you created in Lab 1. 

![ATP External Catalog](./images/atp-external-catalog4.png)

8. Set the connection type to airlinesource_medium

![ATP External Catalog](./images/atp-external-catalog5.png)

9. Provide Source_XX username and password.

![ATP External Catalog](./images/atp-external-catalog6.png)

10. Click on Test Connection, and ensure that the Connection Status is Successful. Then click the Create button.

![ATP External Catalog](./images/atp-external-catalog7.png)

11. Wait till connection is completed. You will see your connection being created.

![ATP External Catalog](./images/atp-external-catalog8.png)

12. Once the catalog is active proceed to the next step. 

![ATP External Catalog](./images/atp-external-catalog9.png)

---

## Task 3: Launch AIDP Workspace and Notebook

1. In AIDP, create new workspace - Click on Workspace -> Create button

![Create AIDP Workspace](./images/create-aidp-workspace2.png)

2. Name Workspace name as **airline-workspace_xx** with default catalog **atp\_external\_catalog\_xx**. Click the Create button.

![Create AIDP Workspace](./images/create-aidp-workspace3.png)

3. The airline-workspace_xx workspace gets created.

![Create AIDP Workspace](./images/create-aidp-workspace4.png)

4. Click on the airline-workspace_xx link to navigate to that workspace. Create folder **demo**.

![Create Demo Folder](./images/create-folder-workspace1.png)

5. Create new notebook.

![Create Notebook](./images/create-notebook2.png)

6. Rename the new notebook to **airlines-notebook**.

![Create Notebook](./images/create-notebook3.png)

![Create Notebook](./images/create-notebook4.png)

7. Click Cluster, and then Create Cluster

![Create Cluster](./images/create-cluster1.png)

8. Set Cluster name as **my\_workspace\_cluster\_xx**. Keep other values default. Click on Create button.

![Create Cluster](./images/create-cluster2.png)

9. Cluster creation initiates. Wait for 1 minute for cluster to create.

![Create Cluster](./images/create-cluster3.png)

10. Click on 'Cluster' and then 'Attach existing cluster'. After cluster creation completes, you'll be able to see that cluster there.

Attach your newly created cluster

![Create Cluster](./images/create-cluster4.png)

11. You will see the following as the cluster attaches

![Create Cluster](./images/create-cluster5.png)

12. Once the cluster is attached you'll get the message

![Create Cluster](./images/create-cluster6.png)

---

## Task 4: Extract from ATP to Bronze Layer

1. Paste the code block into the airlines-notebook, and make sure the language selected is Python. Click the Run button

![AIDP Notebook](./images/aidp-notebook1.png)

![AIDP Notebook](./images/aidp-notebook2.png)

```python
<copy>
airlines_sample_table = "atp_external_catalog_xx.source_xx.AIRLINE_SAMPLE"

# Confirm AIRLINE_SAMPLE table is reflected in spark
spark.sql("SHOW TABLES IN atp_external_catalog_xx.source_xx").show(truncate=False)

df = spark.table(airlines_sample_table)

df.show()
</copy>
```

You should see the following results if the code runs correctly. 

![AIDP Notebook](./images/aidp-notebook3.png)

**NOTE** 
For each iteration of code blocks it's recommended to run that section individually to validate the scripts. Once all the code blocks are validated, you can run this entire notebook as a job in a workflow.

2. For creating next code block in a new cell, click on the "+" icon.

![AIDP Notebook](./images/aidp-notebook4.png)

Paste the code block. Click the Run button.

![AIDP Notebook](./images/aidp-notebook5.png)

The code block below will write a new data frame to the object storage bucket you created in Lab 1. The **aidp-demo-bucket_xx** refers to the bucket name in OCI. After pasting in the code you will need to replace **your-os-namespace** with your Object Storage namespace. Please refer to "Lab 1 Task 11 Step 5" for getting your Object Storage namespace.”

```python
<copy>
delta_path = "oci://aidp-demo-bucket_xx@your-os-namespace/delta/airline_sample"
df.write.format("delta").mode("overwrite").save(delta_path)
</copy>
```

You should see the following results if the code runs correctly. 

![AIDP Notebook](./images/aidp-notebook6.png)

The output of this code should look like this in the object storage bucket created in Lab 1. 

![OS Bucket](./images/os-bucket-2.png)


**NOTE** Only one table can be associated with a given delta path. If a table is created on a path that already is associated with another table, it will throw an error. The associated table will have to be deleted then re-write the dataframe to the path. 

3. For creating next code block in a new cell, click on the "+" icon.

![AIDP Notebook](./images/aidp-notebook7.png)

Create bronze table for first stage of Medallion architecture. Here you will create a new (standard) catalog, called "**airlines\_data\_catalog\_xx**". This is distinct from the external catalog created earlier. The "**airlines\_data\_catalog\_xx**" will be used to store the bronze, silver, and gold layers of the Medallion Architecture.

Paste the code block. Click the Run button.

![AIDP Notebook](./images/aidp-notebook8.png)

```python
<copy>
bronze_table = "airlines_data_catalog_xx.bronze.airline_sample_delta"

# Create New Internal Catalog & Schema to store data
spark.sql("CREATE CATALOG IF NOT EXISTS airlines_data_catalog_xx")
spark.sql("CREATE SCHEMA IF NOT EXISTS airlines_data_catalog_xx.bronze")

# Drop the table if it exists, to avoid conflicts
spark.sql(f"DROP TABLE IF EXISTS {bronze_table}")

# Create new bronze table
spark.sql(f"""
  CREATE TABLE IF NOT EXISTS {bronze_table}
  USING DELTA
  LOCATION '{delta_path}'
""")
</copy>
```

You should see the following results if the code runs correctly. 

![AIDP Notebook](./images/aidp-notebook9.png)

4. Click the "+" button to create new code block

![AIDP Notebook](./images/aidp-notebook11.png)

Clean the data - this block will look at the existing data and delete the records where distance is null or distance is less than 0.

Paste the code block. Click the Run button.

![AIDP Notebook](./images/aidp-notebook10.png)

```python
<copy>
spark.sql(f"""
    DELETE FROM {bronze_table}
    WHERE DISTANCE IS NULL OR DISTANCE < 0
""")
</copy>
```

You should see the following results if the code runs correctly. 

![AIDP Notebook](./images/aidp-notebook12.png)

5. Click the "+" button to create new code block

![AIDP Notebook](./images/aidp-notebook13.png)

Test versioning capabilities of delta tables. With delta lake capabilities the user can now show older versions of tables before they were modified.

In this example the results will look back at version 0 before you deleted the records where distance is null or distance is less than 0.

Paste the code block. Click the Run button.

![AIDP Notebook](./images/aidp-notebook14.png)

```python 
<copy>
df_v0 = spark.read.format("delta").option("versionAsOf", 0).load(delta_path)
df_v0.show()
</copy>
```

You should see the following results if the code runs correctly. 

![AIDP Notebook](./images/aidp-notebook15.png)

---

## Task 5: Create Silver Medallion Schema & Enrich Data with Generative AI 

1. Click the "+" button to create new code block

![AIDP Notebook](./images/aidp-notebook16.png)

Write to silver schema of Medallion Architecture. With our bronze layer in place the next code block you will begin the enrichment process. As a first step you will create a silver schema.

Paste the code block. Click the Run button.

![AIDP Notebook](./images/aidp-notebook17.png)

The **aidp-demo-bucket_xx** refers to the bucket name in OCI. After pasting in the code you will need to replace **your-os-namespace** with your Object Storage namespace. Please refer to "Lab 1 Task 11 Step 5" for getting your Object Storage namespace.”

```python
<copy>
df_clean = spark.table(bronze_table)

silver_path = "oci://aidp-demo-bucket_xx@your-os-namespace/delta/silver/airline_sample"
silver_table = "airlines_data_catalog_xx.silver.airline_sample_delta"

# Create Silver Schema to store data
spark.sql("CREATE SCHEMA IF NOT EXISTS airlines_data_catalog_xx.silver")

# Write cleaned DataFrame to object storage as Delta
df_clean.write.format("delta").mode("overwrite").save(silver_path)

# Remove table registration if it already exists
spark.sql(f"DROP TABLE IF EXISTS {silver_table}")

# Register cleaned data as new Silver table
spark.sql(f"""
  CREATE TABLE {silver_table}
  USING DELTA
  LOCATION '{silver_path}'
""")

# Check table to make sure it's cleaned 
spark.sql(f"SELECT * FROM {silver_table}").show()
</copy>
```

You should see the following results if the code runs correctly. 

![AIDP Notebook](./images/aidp-notebook18.png)

The output of this code should look like this in the object storage bucket created in Lab 1. 

![OS Bucket](./images/os-bucket-3.png)

2. Click the "+" button to create new code block

![AIDP Notebook](./images/aidp-notebook19.png)

Enrich the data by adding aggregates/average delays and distance.

Paste the code block. Click the Run button.

![AIDP Notebook](./images/aidp-notebook20.png)

```python
<copy>
# Enrich data by adding aggregates/average delays and distance 
from pyspark.sql import functions as F

df = spark.table("airlines_data_catalog_xx.silver.airline_sample_delta")

# Calculate averages by airline
avg_df = df.groupBy("AIRLINE").agg(
    F.avg("DEP_DELAY").alias("AVG_DEP_DELAY"),
    F.avg("ARR_DELAY").alias("AVG_ARR_DELAY"),
    F.avg("DISTANCE").alias("AVG_DISTANCE")
)

# Join with the detail table
enhanced_df = df.join(avg_df, on="AIRLINE", how="left")

enhanced_df.show()
</copy>
```

You should see the following results if the code runs correctly. 

![AIDP Notebook](./images/aidp-notebook21.png)

3. Click the "+" button to create new code block

![AIDP Notebook](./images/aidp-notebook22.png)

Add new column for Sentiment Analysis 

Paste the code block. Click the Run button.

![AIDP Notebook](./images/aidp-notebook23.png)

```python
<copy>
# Add New Review Column for Sentiment Analysis 
import random

sample_reviews = [
    "The flight was on time and comfortable.",
    "Long delay and unfriendly staff.",
    "Quick boarding and smooth flight.",
    "Lost my luggage, not happy.",
    "Great service and tasty snacks."
]

from pyspark.sql.functions import udf
from pyspark.sql.types import StringType

random_review_udf = udf(lambda: random.choice(sample_reviews), StringType())
df_with_review = enhanced_df.withColumn("REVIEW", random_review_udf())
df_with_review.show()
</copy>
```

You should see the following results if the code runs correctly. 

![AIDP Notebook](./images/aidp-notebook24.png)

4. Click the "+" button to create new code block

![AIDP Notebook](./images/aidp-notebook25.png)

Test and run AI model against reviews of flights

Paste the code block. Click the Run button.

![AIDP Notebook](./images/aidp-notebook26a.png)

```python
<copy>
# test model 
spark.sql("select query_model('xai.grok-4','What is Intelligent Data Lake Service in Oracle?') as questions").show(truncate=False)

# Run Sentiment Analysis Against Review with LLM 
from pyspark.sql.functions import expr
enhanced_df = df_with_review.withColumn("SENTIMENT",\
                     expr("query_model('xai.grok-4', concat('What is the sentiment for this review: ', REVIEW))"))\
#.show(10, False)

enhanced_df.show(10, False)
</copy>
```

You should see the following similar results if the code runs correctly. The output might slightly vary, based on the LLM Model used.

![AIDP Notebook](./images/aidp-notebook27a.png)

**NOTE** AIDP as of writing (Dec 2025) supports cohere and grok models, and it's region specific. 

For example, you can use "**xai.grok-4**" LLM Model when the AIDP Instance is in "**US East (Ashburn)**" or "**US West (Phoenix)**" or "**US Midwest (Chicago)**" regions. You can also use "**cohere.command-latest**" LLM Model when the AIDP Instance is in "**US Midwest (Chicago)**" region.

Dragging and dropping the other sample models from the catalog can result in 'model not found' errors. A temporary workaround can be to remove the '**default.oci\_ai\_models**' prefix from the model path. This should be fixed in the near future. 

---

## Task 6: Connect AIDP to AI Lakehouse

1. In AIDP Console, select Create > Catalog 

![Create Catalog](./images/create-catalog-a.png)

2. For AI Lakehouse: Provide catalog name (e.g. **airlines\_external\_adb\_gold\_xx**), select External Catalog, External source type Oracle Autonomous Data Warehouse

![ADL External Catalog](./images/adl-external-catalog2.png)

3. Select the 'Choose ADW Instance' and select the 'aidp-lab' compartment from the drop down.

![ADL External Catalog](./images/adl-external-catalog3.png)

4. Select the Lakehouse instance 'aidp-db' you created in Lab 1. 

![ADL External Catalog](./images/adl-external-catalog4.png)

5. Set the connection type to aidpdb_medium

![ADL External Catalog](./images/adl-external-catalog5.png)

6. Provide Gold_XX username and password.

![ADL External Catalog](./images/adl-external-catalog6.png)

7. Click on Test Connection, and ensure that the Connection Status is Successful. Then click the Create button.

![ADL External Catalog](./images/adl-external-catalog7.png)

8. Wait till connection is completed. You will see your connection being created.

![ADL External Catalog](./images/adl-external-catalog8.png)

9. Once the catalog is active proceed to the next step. 

![ADL External Catalog](./images/adl-external-catalog9.png)

## Task 7: Write Enriched Data to Gold Schema 

1. To go back to your notebook, click airline-workspace_xx workspace link, and then airline-notebook.ipynb link

![AIDP Notebook](./images/aidp-gold-notebook1.png)

2. Click the "+" button to create new code block

![AIDP Notebook](./images/aidp-gold-notebook2a.png)

With our silver layer in place the next code block will write the enriched data. As a first step we will create a Gold Schema, and save Averaged Data to Gold Schema.

Paste the code block. Click the Run button.

![AIDP Notebook](./images/aidp-gold-notebook3.png)

Save new data to gold schema 

The **aidp-demo-bucket_xx** refers to the bucket name in OCI. After pasting in the code you will need to replace **your-os-namespace** with your Object Storage namespace. Please refer to "Lab 1 Task 11 Step 5" for getting your Object Storage namespace.”

```python
<copy>
# Save Averaged Data to Gold Schema 

gold_path = "oci://aidp-demo-bucket_xx@your-os-namespace/delta/gold/airline_sample_avg"
gold_table = "airlines_data_catalog_xx.gold.airline_sample_avg"

# Create Gold Schema 
spark.sql("CREATE SCHEMA IF NOT EXISTS airlines_data_catalog_xx.gold")

enhanced_df.write.format("delta").option("mergeSchema", "true").mode("overwrite").save(gold_path)

spark.sql(f"DROP TABLE IF EXISTS {gold_table}")

spark.sql(f"""
  CREATE TABLE {gold_table}
  USING DELTA
  LOCATION '{gold_path}'
""")

df_gold = spark.table(gold_table) 
df_gold.show()
</copy>
```

You should see the following results if the code runs correctly. 

![AIDP Notebook](./images/aidp-gold-notebook4.png)

The output of this code should look like this in the object storage bucket created in Lab 1. 

![OS Bucket](./images/os-bucket-4.png)

3.Click the "+" button to create new code block

![AIDP Notebook](./images/aidp-gold-notebook5.png)

Confirm all columns are upper case. This is because OAC requires upper case columns for visualizations, otherwise results in errors. 

Paste the code block. Click the Run button.

![AIDP Notebook](./images/aidp-gold-notebook6.png)

```python
<copy>
# Before pushing dataframe, make sure all columns are upper case to prevent visualization issues in OAC
# (OAC needs all columns capitalized in order to analyze data) 
for col_name in df_gold.columns:
    df_gold = df_gold.withColumnRenamed(col_name, col_name.upper())

df_gold.show()
</copy>
```

You should see the following results if the code runs correctly. 

![AIDP Notebook](./images/aidp-gold-notebook7.png)


4. Click the "+" button to create new code block

![AIDP Notebook](./images/aidp-gold-notebook8.png)

Cast columns to decimal type. This is to conform the spark data frames to the AI Lakehouse column definitions. 

Paste the code block. Click the Run button.

![AIDP Notebook](./images/aidp-gold-notebook9.png)

```python
<copy>
from pyspark.sql.functions import col
from pyspark.sql.types import DecimalType, StringType

# Cast columns in the DataFrame to the exact types expected by the Oracle table.
# Use DecimalType for NUMBER fields, StringType for VARCHAR2/text.

df_gold_typed = (
    df_gold
    # Cast numeric columns to DecimalType (matches NUMBER in Oracle)
    .withColumn("FLIGHT_ID", col("FLIGHT_ID").cast(DecimalType(38,10)))
    .withColumn("DEP_DELAY", col("DEP_DELAY").cast(DecimalType(38,10)))
    .withColumn("ARR_DELAY", col("ARR_DELAY").cast(DecimalType(38,10)))
    .withColumn("DISTANCE", col("DISTANCE").cast(DecimalType(38,10)))
    .withColumn("AVG_DEP_DELAY", col("AVG_DEP_DELAY").cast(DecimalType(38,10)))
    .withColumn("AVG_ARR_DELAY", col("AVG_ARR_DELAY").cast(DecimalType(38,10)))
    .withColumn("AVG_DISTANCE", col("AVG_DISTANCE").cast(DecimalType(38,10)))
    # Cast text columns to StringType (matches VARCHAR2 in Oracle)
    .withColumn("AIRLINE", col("AIRLINE").cast(StringType()))
    .withColumn("ORIGIN", col("ORIGIN").cast(StringType()))
    .withColumn("DEST", col("DEST").cast(StringType()))
    .withColumn("REVIEW", col("REVIEW").cast(StringType()))
    .withColumn("SENTIMENT", col("SENTIMENT").cast(StringType()))
)

# Specify the desired column order to match the target Oracle table
col_order = [
    "FLIGHT_ID", "AIRLINE", "ORIGIN", "DEST", "DEP_DELAY", "ARR_DELAY", "DISTANCE",
    "AVG_DEP_DELAY", "AVG_ARR_DELAY", "AVG_DISTANCE", "REVIEW", "SENTIMENT"
]

# Select only these columns, in this order, to create a clean DataFrame for insertion
df_gold_typed = df_gold_typed.select(col_order)

# Print the final DataFrame schema for validation (should match the Oracle table exactly)
print(df_gold_typed.printSchema())

# Register the DataFrame as a temp view for Spark SQL use (for INSERT INTO ... or further queries)
df_gold_typed.createOrReplaceTempView("df_gold")
</copy>
```

You should see the following results if the code runs correctly. 

![AIDP Notebook](./images/aidp-gold-notebook10.png)

---

## Task 8: Create Gold Table and Insert Data

1. Navigate back to SQL Developer browser tab for the AI Lakehouse database "aidp-db", that you created in Lab 1. Ensure that you can see the GOLD\_XX user in the top right of the screen.

Create the AIRLINE\_SAMPLE\_GOLD table

Paste the following SQL statement in the Worksheet and click the 'Run Statement' button

![Create Gold Table](./images/adl-gold-table-creation11.png)

```sql
<copy>
CREATE TABLE AIRLINE_SAMPLE_GOLD (
  FLIGHT_ID   NUMBER,
  AIRLINE     VARCHAR2(20),
  ORIGIN      VARCHAR2(3),
  DEST        VARCHAR2(3),
  DEP_DELAY   NUMBER,
  ARR_DELAY   NUMBER,
  DISTANCE    NUMBER,
  AVG_DEP_DELAY   NUMBER,
  AVG_ARR_DELAY   NUMBER,
  AVG_DISTANCE    NUMBER,
  REVIEW      VARCHAR2(4000),
  SENTIMENT VARCHAR2(10000)
);
</copy>
```

2. Back in AIDP Master Catalog, refresh the external catalog "airlines\_external\_adb\_gold\_xx" from Master_Catalog

![Refresh Catalog](./images/refresh-catalog.png)

3. To go back to your notebook, click airline-workspace_xx workspace link and then airline-notebook.ipynb link.

![AIDP Notebook](./images/aidp-gold-notebook1.png)

4. Click the "+" button to create new code block

![AIDP Notebook](./images/aidp-gold-notebook11.png)

Insert data in airline\_sample\_gold table in AI Lakehouse :

Paste the code block. Make sure the language selected is SQL. Click the Run button.

![AIDP Notebook](./images/aidp-gold-notebook12.png)

```sql
<copy>
%sql
INSERT into airlines_external_adb_gold_xx.gold_xx.airline_sample_gold select * from df_gold
</copy>
```

You should see the following results if the code runs correctly. 

![AIDP Notebook](./images/aidp-gold-notebook14.png)

**NOTE** We use the sql insert instead of the native spark insert, because spark causes the dataframe to be pushed with lowercase column names. This results in OAC unable to visualize the data. Using sql INSERT into avoids this issue. 

**TROUBLESHOOTING NOTE:** If you encounter a CONNECTOR_0084 error ("Exception while writing data. Possible cause: Unable to determine if path is a directory") during the INSERT, restart the AIDP workspace cluster and re-run the notebook. This resolves connectivity issues with the external catalog. If this error occurs in other spark code blocks (e.g. when writing to delta lake), re-running the code block usually resolves the issue. 

---

## Next Steps

Proceed to Lab 3 to visualize the gold data in Oracle Analytics Cloud.

---

## Acknowledgements

**Authors**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform
* **Kaushik Kundu**, Master Principal Cloud Architect, ONA Data Platform


**Last Updated By/Date:**
* **Kaushik Kundu**, Master Principal Cloud Architect, ONA Data Platform, December 2025
