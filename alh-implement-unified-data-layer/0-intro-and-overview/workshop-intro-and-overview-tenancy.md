# Workshop Introduction and Overview

## Introduction

Seer Construction Group manages projects through financial systems, schedules, supplier records, inspection databases, project documents, partner exchanges, and analyst tools. Each source describes the same assets and events differently. This tenancy workshop shows how Oracle Autonomous AI Lakehouse (ALH) becomes the governed data layer that connects those sources without forcing every workload into one ingestion pattern.

Unlike the sandbox variant, you will build the OCI environment in your own tenancy. You will provision ALH, configure resource-principal access, load source extracts, and run explained automation that creates the Bronze, Silver, Gold, document, and vector foundation. You will then extend that foundation to Excel, AWS Glue, Apache Iceberg, a remote Oracle database, and an optional Delta Sharing provider.

**Estimated Time:** 4 hours 35 minutes–5 hours, including setup and cleanup

### Objectives

In this workshop, you will:

- Build an Autonomous AI Lakehouse landing zone in your OCI tenancy.
- Implement and explain Bronze, Silver, and Gold responsibilities.
- Compare managed loads, external tables, catalog synchronization, live relational links, and shared data.
- Unify structured facts, JSON attributes, relationships, documents, and vectors.
- Deliver governed Gold products to applications, agents, and Excel users.
- Query AWS Glue and Iceberg data without copying it into ALH.
- Link a remote relational source and choose between live access and a Silver snapshot.
- Evaluate the trust and security requirements of partner data sharing.

### Prerequisites

- OCI permissions to create Autonomous AI Database, Object Storage, and IAM policies
- Budget and quota for a 2-ECPU, 1-TB Autonomous AI Lakehouse
- Microsoft Excel desktop for Lab 5
- An AWS account with S3, Glue, Athena, and restricted IAM permissions for Labs 6 and 7
- A second reachable Oracle Database for Lab 8
- Permission to download a public Delta Sharing profile for optional Lab 9
- Basic familiarity with SQL, cloud object storage, and data integration concepts

## The Seer data challenge

Before this workshop, Alex used Oracle AI Data Platform to catalog representative systems and approve an ontology connecting their shared business meaning. This workshop moves beneath that ontology and builds the implementation layer in ALH.

The source estate includes:

- Fusion ERP-style financial assets and purchase orders
- Primavera-style milestones and schedules
- CRM-style supplier and certification records
- Remote inspection and compliance data
- Contracts, engineering specifications, and inspection reports
- AWS Glue and Iceberg datasets
- Partner-shared data and analyst workbooks

The workshop uses representative extracts rather than live Fusion ERP, Primavera, or CRM instances. OCI and ALH services, AWS integrations, database links, Excel connectivity, and Delta Sharing are real platform interactions.

## Reference architecture

```text
<copy>
OCI files and documents    AWS Glue and Iceberg    Remote Oracle database
          \                        |                         /
           Loads, links, catalog synchronization, and database links
                                      |
                   Bronze: faithful source-aligned data
                                      |
                  Silver: standardize and reconcile
                                      |
                  Gold: governed data products
                                      |
       SQL | JSON | relationships | vectors | Excel | applications | agents
</copy>
```

## Choose the right access pattern

| Pattern | Result in ALH | Best fit |
|---|---|---|
| Data Loader managed load | Database table | Stable performance, transformation, retention, or source independence |
| Object Storage link | External table | Current file contents without another copy |
| AWS Glue synchronization | Generated external tables | Catalog-scale discovery and schema automation |
| Iceberg access protocol | Iceberg-aware external table | Open table-format data and committed source changes |
| Remote database link | Linked view | Current operational relational data |
| Silver snapshot or ETL | Managed table | Repeatability, availability, quality controls, or agent serving |
| Delta Sharing | Shared external table | Governed cross-organization exchange |
| Excel add-in | Local worksheet result | Analyst consumption of governed database queries |

## ALH and AIDP transformation choices

Both AIDP and ALH can implement medallion transformations. AIDP is a strong choice for Spark notebooks, distributed processing, and broader platform workflows. This workshop uses ALH-native SQL, Data Studio, Data Transforms concepts, database jobs, JSON, vector search, and governed database serving because the source data is already in or directly reachable from ALH.

For a deeper dive on organizing data with Oracle AI Data Platform, see [Getting Started with Oracle AI Data Platform Workbench – Data Engineering](https://livelabs.oracle.com/ords/r/dbpm/livelabs/view-workshop?wid=4295&clear=RR,180).

## Workshop flow

1. **Lab 1:** Build the ALH landing zone and medallion environment.
2. **Lab 2:** Link Object Storage data and explore medallion design and lineage.
3. **Lab 3:** Combine structured context with documents and vector retrieval.
4. **Lab 4:** Validate trusted data products and consumer readiness.
5. **Lab 5:** Consume Gold products from Microsoft Excel.
6. **Lab 6:** Synchronize an AWS Glue catalog and query generated external tables.
7. **Lab 7:** Query an Apache Iceberg table through AWS Glue.
8. **Lab 8:** Link a remote Oracle source and materialize a Silver snapshot.
9. **Lab 9:** Optionally consume partner data through Delta Sharing.

## Learn More

- [Oracle Autonomous AI Database](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/overview-autonomous-database.html)
- [Query External Data](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/query-external.html)
- [Data Sharing](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/data-sharing-autonomous.html)

## Acknowledgements

- **Author:** Eli Schilling, Cloud Architect || Evangelist
- **Contributors:** Oracle LiveLabs and ONA Lab Experience Teams
- **Last Updated By / Date:** ONA Lab Experience team, July 2026
