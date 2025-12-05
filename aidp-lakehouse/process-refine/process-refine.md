# Lab 2: Process and Refine Data in AI Data Platform and Lakehouse

## Introduction

This lab builds on Lab 1 by extracting transactional airline data from ATP, processing it through bronze, silver, and gold layers in Oracle AI Data Platform (AIDP) using Spark and Delta Lake, and publishing the refined gold data to Autonomous AI Lakehouse for analytics.

> **Estimated Time:** 1.5 hours

---

### About Oracle AI Data Platform (AIDP) and Autonomous AI Lakehouse

AIDP enables scalable data engineering with Spark and Delta Lake. Autonomous AI Lakehouse provides fast, secure analytics storage. Together, they form a modern lakehouse for transforming raw data into insights.

---

### Objectives

In this lab, you will:
- Provision Autonomous AI Lakehouse and AIDP
- Connect AIDP to ATP source and AI Lakehouse
- Extract data from ATP to bronze layer in AIDP
- Clean, enrich, and transform to silver and gold layers
- Create GOLD schema in AI Lakehouse with required permissions and publish refined data

---

### Prerequisites

This lab assumes you have:
- Completed Lab 1 with ATP and SOURCE_DATA schema set up
- Access to AIDP and Autonomous AI Lakehouse

---

## Task 1: Provision Autonomous AI Lakehouse

1. Log in to your cloud tenancy and navigate to Oracle AI Database > Autonomous AI Database

![AI Database](./images/ai-database.png)

2. Select Create Autonomous AI Database 

3. Give it a name (e.g. **aidp-db**) and select workload type as Lakehouse. Select database version 26ai and leave other options as default. 

![Create AI Database](./images/create-aidp-db.png)

4. Provide a password and set Access Type to 'Secure access from everywhere' 

![Create AI Database](./images/create-aidp-db-2.png)

**NOTE** If you would like to use a private database, a DB Tools Connection will need to be created to use SQL Developer web. This is outside the scope of this lab. For details, see [Create Database Tools Connection](https://docs.oracle.com/en-us/iaas/database-tools/doc/using-oracle-cloud-infrastructure-console.html).

5. Create the AI Database. The provisioning process will take a few minutes.

6. Once provisioned, navigate to Database actions > SQL. This will open SQL Developer as admin user. 

![SQL Developer](./images/sql-developer.png)

---

## Task 2: Create Gold Schema 

1. Create a Gold Schema (User) in Autonomous Data Lakehouse. Replace "strong\_password" with your own password.

```sql
<copy>
CREATE USER gold IDENTIFIED BY "strong_password";
</copy>
```

2. Grant Required Roles/Privileges to Gold Schema

```sql
<copy>
-- Data privileges
GRANT CONNECT, RESOURCE TO gold;

-- Allow creation of tables, views, and other objects
GRANT CREATE SESSION TO gold;
GRANT CREATE TABLE TO gold;
GRANT CREATE VIEW TO gold;
GRANT CREATE SEQUENCE TO gold;
GRANT CREATE PROCEDURE TO gold;
GRANT UNLIMITED TABLESPACE TO gold;

-- Enable DBMS_CLOUD 
GRANT EXECUTE ON DBMS_CLOUD TO gold;

-- Grant access to data_pump_dir (used for saveAsTable operation in spark)
GRANT READ, WRITE ON DIRECTORY DATA_PUMP_DIR TO gold;
</copy>
```

3. Log out of admin schema once gold schema is created.

## Task 3: Add REST capabilities to GOLD Schema

**NOTE** If unable to sign in directly as gold schema, enable REST access

1. Navigate to AI DB > database actions > database users > search for 'gold' > select three dots > enable rest > log in to sql developer web as gold

![Enable REST](./images/enable-rest-gold.png)

## Task 4: Log in to SQL Developer as GOLD Schema 

1. Navigate back to AI DB > database actions > SQL > Once in SQL Developer select ADMIN (top right) > Sign Out

2. Provide gold as username and give password as defined in previous task. Sign in. 

![Sign in Gold Schema](./images/sign-in-gold.png)

**NOTE** If still unable to log in, try navigating back to database user page and click the following link - 

![Access REST Gold](./images/access-rest-gold.png)

3. Navigate to Development > SQL. Once access is confirmed you can proceed to next task.

## Task 5: Provision AI Data Platform Instance

1. Navigate to Analytics & AI > AI Data Platform 

![AI Data Platform](./images/create-aidp.png)

2. Provide a name for AIDP and workspace

![Create AIDP](./images/create-aidp-2.png)

3. Set the access level as standard and explicitly 'Add' the policies. If the policies aren't added it will fail to create. Optional policies can also be added depending on the use case. For this lab, we will need to enable object deletion - 

![Enable Object Deletion](./images/aidp-add-additional-policies.png)

![Add Policies](./images/aidp-save-policies.png)

4. Create the instance. This will take a few minutes to provision.

---

## Task 6: Connect AIDP to ATP and AI Lakehouse

1. Once AIDP is provisioned, navigate to the service console - 

![AIDP Home](./images/aidp-home.png)

2. Select Create > Catalog 

![Create Catalog](./images/create-catalog.png)

3. For ATP: Provide catalog name (e.g. **atp\_external\_catalog**), select External Catalog, External source type Oracle Autonomous Transaction Processing, choose your ATP instance, provide SOURCE_DATA username and password.

![ATP External Catalog](./images/atp-external-catalog.png)

4. For AI Lakehouse: Provide catalog name (e.g. **airlines\_external\_adb\_gold**), select External Catalog, External source type Oracle Autonomous Data Warehouse, choose your AI Lakehouse instance, provide GOLD username and password.

![Create External Catalog](./images/adl-external-catalog.png)

---

## Task 7: Set Up Object Storage

1. Navigate to **Object Storage** in the OCI Console.

2. Create bucket **aidp-demo-bucket** in the AIDP compartment.

3. Create a folder 'delta' in the bucket.

![Create New Bucket Folder](./images/bucket-create-new-folder.png)

---

## Task 8: Launch AIDP Workspace and Notebook

1. In AIDP, create workspace **airline-workspace** with default catalog **airlines\_external\_adb\_gold**.

![Create AIDP Workspace](./images/create-aidp-workspace.png)

2. Create folder 'demo'.

![Create Demo Folder](./images/create-folder-workspace.png)

3. Create notebook 'airlines-notebook'.

![Create Notebook](./images/create-notebook.png)

4. Create/attach cluster **my_workspace_cluster**.

![Create Cluster](./images/create-cluster.png)

![Airline Notebook](./images/airline-notebook.png)

---

## Task 9: Extract from ATP to Bronze Layer

1. In the notebook, confirm ATP table:

```python
<copy>
airlines_sample_table = "atp_external_catalog.source_data.AIRLINE_SAMPLE"

# Confirm AIRLINE_SAMPLE table is reflected in spark
spark.sql("SHOW TABLES IN atp_external_catalog.source_data").show(truncate=False)

df = spark.table(airlines_sample_table)

df.show()
</copy>
```

**NOTE** for each iteration of code blocks it's recommended to run that section individually to validate the scripts. Once all the code blocks are validated, you can run this entire notebook as a job in a workflow.

2. Write the new data frame to your Object Storage bucket. Replace '**aidp-demo-bucket**' with your oci bucket name and '**your-os-namespace**' with object storage namespace - 

```python
<copy>
delta_path = "oci://aidp-demo-bucket@your-os-namespace/delta/airline_sample"
df.write.format("delta").mode("overwrite").save(delta_path)
</copy>
```

**NOTE** **aidp-demo-bucket** refers to the bucket name in OCI, and **your-os-namespace** is the namespace found in the bucket - 

![Get OS Namespace](./images/get-os-namespace.png)

**NOTE** Only one table can be associated with a given delta path. If a table is created on a path that already is associated with another table, it will throw an error. The associated table will have to be deleted then re-write the dataframe to the path. 

3. Create bronze table for first stage of medallian architecture. Here we will create a new (standard) catalog, called "**airlines\_data\_catalog**". This is distinct from the external catalog to the ATP & AI Lakehouse created earlier. "**airlines\_data\_catalog**" will be used to store the bronze, silver, and gold layers of the medallian architecture.

```python
<copy>
bronze_table = "airlines_data_catalog.bronze.airline_sample_delta"

# Create New Internal Catalog & Schema to store data
spark.sql("CREATE CATALOG IF NOT EXISTS airlines_data_catalog")
spark.sql("CREATE SCHEMA IF NOT EXISTS airlines_data_catalog.bronze")

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

4. Clean the data 

```python
<copy>
spark.sql(f"""
    DELETE FROM {bronze_table}
    WHERE DISTANCE IS NULL OR DISTANCE < 0
""")
</copy>
```

5. Test versioning capabilities of delta tables. With delta lake capabilities the user can now show older versions of tables before they were modified.

```python 
<copy>
df_v0 = spark.read.format("delta").option("versionAsOf", 0).load(delta_path)
df_v0.show()
</copy>
```

---

## Task 10: Create Silver Medallian Schema & Enrich Data with Generative AI 

1. Write to silver schema of medallian architecture 

```python
<copy>
df_clean = spark.table(bronze_table)

silver_path = "oci://aidp-demo-bucket@your-os-namespace/delta/silver/airline_sample"
silver_table = "airlines_data_catalog.silver.airline_sample_delta"

# Create Silver Schema to store data
spark.sql("CREATE SCHEMA IF NOT EXISTS airlines_data_catalog.silver")

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

2. Enrich the data 

```python
<copy>
# Enrich data by adding aggregates/average delays and distance 
from pyspark.sql import functions as F

df = spark.table("airlines_data_catalog.silver.airline_sample_delta")

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

3. Add new column for Sentiment Analysis 

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

4. Test and run AI model against reviews of flights

```python
<copy>
# test model 
spark.sql("select query_model('cohere.command-latest','What is Intelligent Data Lake Service in Oracle?') as questions").show(truncate=False)

# Run Sentiment Analysis Against Review with LLM 
from pyspark.sql.functions import expr
enhanced_df = df_with_review.withColumn("SENTIMENT",\
                     expr("query_model('cohere.command-latest', concat('What is the sentiment for this review: ', REVIEW))"))\
#.show(10, False)

enhanced_df.show(10, False)
</copy>
```

**NOTE** AIDP as of writing (Nov 2025) supports cohere and grok models. Dragging and dropping the other sample models from the catalog can result in 'model not found' errors. A temporary workaround can be to remove the '**default.oci\_ai\_models**' prefix from the model path. This should be fixed in the near future. 

**NOTE** Cohere on demand is only available in Chicago region. In Ashburn, a different model would need to be used e.g. xai.grok-4. For more details on availablility, see [Pretrained Foundational Models](https://docs.oracle.com/en-us/iaas/Content/generative-ai/pretrained-models.htm)

---

## Task 11: Write Enriched Data to Gold Schema 

1. Save new data to gold schema 

```python
<copy>
# Save Averaged Data to Gold Schema 

gold_path = "oci://aidp-demo-bucket@your-os-namespace/delta/gold/airline_sample_avg"
gold_table = "airlines_data_catalog.gold.airline_sample_avg"

# Create Gold Schema 
spark.sql("CREATE SCHEMA IF NOT EXISTS airlines_data_catalog.gold")

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

2. Confirm all columns are upper case. This is because OAC requires upper case columns for visualizations, otherwise results in errors. 

```python
<copy>
# Before pushing dataframe, make sure all columns are upper case to prevent visualization issues in OAC
# (OAC needs all columns capitalized in order to analyze data) 
for col_name in df_gold.columns:
    df_gold = df_gold.withColumnRenamed(col_name, col_name.upper())

df_gold.show()
</copy>
```

3. Cast columns to decimal type. This is to conform the spark data frames to the AI Lakehouse column definitions. 

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

---

## Task 12: Create Gold Table and Insert Data

1. In AI Lakehouse SQL Developer, sign in as GOLD, create the gold table:

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
  SENTIMENT VARCHAR2(200)
);
</copy>
```

2. Back in AIDP notebook, insert data:

```sql
<copy>
%sql
INSERT into airlines_external_adb_gold.gold.airline_sample_gold select * from df_gold
</copy>
```

**NOTE** We use the sql insert instead of the native spark insert, because spark causes the dataframe to be pushed with lowercase column names. This results in OAC unable to visualize the data. Using sql INSERT into avoids this issue. 

**TROUBLESHOOTING NOTE:** If you encounter a CONNECTOR_0084 error ("Exception while writing data. Possible cause: Unable to determine if path is a directory") during the INSERT, restart the AIDP workspace cluster and re-run the notebook. This resolves connectivity issues with the external catalog. If this error occurs in other spark code blocks (e.g. when writing to delta lake), re-running the code block usually resolves the issue. 

---

## Next Steps

Proceed to Lab 3 to visualize the gold data in Oracle Analytics Cloud.

---

## Acknowledgements

**Authors**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform

**Contributors** 
* **Enjing Li**, Senior Cloud Engineer, ONA Data Platform
* **Kaushik Kundu**, Master Principal Cloud Architect, ONA Data Platform

**Last Updated By/Date:**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform, December 2025
