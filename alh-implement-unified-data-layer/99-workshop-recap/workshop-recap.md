# Workshop Recap

## Introduction

You began with source systems and documents that described the same projects, suppliers, assets, and events in different ways. You finished with governed products that applications and agents can consume without reconstructing the enterprise data estate themselves.

**Estimated Time:** 10 minutes

### Objectives

In this recap, you will:

- Review what you accomplished in each lab.
- Reconnect the medallion layers to application and agent outcomes.
- Identify production considerations beyond the workshop.
- Understand the handoff to the AppDev and Construction Evaluation Agent workshops.

### Prerequisites

- Completion of Labs 1 through 3

## What you accomplished

### Lab 1: Explore the Unified Lakehouse Foundation

You inspected representative Fusion ERP-, Primavera-, CRM-, and on-premises-style source extracts, together with actual project documents in OCI Object Storage. In Data Studio, you created the `SEER_LAKE_SOURCE` cloud-store location with the database resource principal and linked `source-data/suppliers/supplier_extract.csv` as the Bronze external table `SUPPLIER_TRANSFORM_EXT`. You retained source-system and ingestion-batch context, used Catalog to compare Bronze, Silver, and Gold entities, and visually verified the Object Storage lineage of your demonstration flow. You then used ALH SQL to create `SUPPLIER_STANDARDIZED_DEMO`, standardizing supplier names, qualification statuses, certifications, and locations. You compared all four standardized fields with the seeded Silver supplier mapping and traced the Austin steel-delivery event from source-specific records to a canonical Silver entity and consumer-ready Gold product.

### Lab 2: Unify Data for AI Applications

You used Data Studio Catalog to explore application-ready Gold products and document entities, then compared relational, JSON, relationship, and vector representations of the governed data. You searched for Austin structural specifications by meaning and combined the retrieved passage with purchasing, schedule, supplier, and inspection context.

### Lab 3: Deliver Trusted Data Products

You reviewed ALH Data Transforms and database-job evidence, validated quality and freshness, inspected product contracts, and mapped the Gold products to developer interfaces and the downstream Construction Evaluation Agent.

## The completed data journey

```text
<copy>
CSV source feeds and PDF project documents in Object Storage
                       |
 Data Studio link, catalog, classifications, provenance
                       |
        Bronze: faithful source capture
                       |
    Silver: standardize, validate, reconcile
                       |
        Gold: trusted data products
                       |
 SQL | JSON | relationships | vectors | RAG
                       |
     Applications and governed AI agents
</copy>
```

## Key takeaways

- AI readiness begins with data-engineering discipline.
- Data Studio can expose Object Storage data as an external Bronze table without copying the source file into the database.
- Source identifiers and ingestion-batch context should survive the Bronze-to-Silver transition, with source-object lineage visible through Catalog.
- Bronze, Silver, and Gold represent different contracts and responsibilities.
- Structured facts and unstructured evidence can share one governed foundation.
- Semantic retrieval depends on chunking, metadata, provenance, and evaluation quality.
- Gold products establish the interface between data engineers and developers.
- Agents should consume governed products instead of raw source data.

## Choose the transformation approach for the workload

You implemented a small transformation directly in ALH, but the medallion architecture does not require one specific execution engine.

| Choose this pattern | When it is a strong fit |
| --- | --- |
| AIDP notebooks and workflows | Distributed Spark processing, open lakehouse tables, Python or Scala libraries, notebook collaboration, and broad data-lake orchestration |
| ALH SQL and Data Transforms | Database-centric transformations, data already in or reachable from ALH, governed database serving, and relational, JSON, relationship, or vector consumers |
| Combined AIDP and ALH | AIDP performs large-scale upstream processing and publishes selected products to ALH for governed database and AI application access |

The choice is workload-driven. The AIDP Data Engineering workshop demonstrates the notebook-and-workflow pattern. This workshop demonstrates the self-contained ALH-native pattern. Neither approach invalidates the other, and many production solutions use both.

## Business value for Seer

### Faster project and supplier decisions

Teams can evaluate project requirements, supplier qualifications, schedule status, and engineering evidence without manually reconciling systems for every question.

### Reduced compliance and delivery risk

Inspection findings, certifications, nonconformance records, contracts, and specifications remain connected to the assets and suppliers they govern.

### Reusable application foundation

The same products can support analytics, application APIs, semantic search, and multiple agents. Teams do not need to build a separate data pipeline for every interface.

### Governance without losing context

Lineage, classifications, ownership, and source-document references remain part of the product. Consumers can explain where an answer came from.

## Production considerations

The workshop uses a compact, pre-provisioned environment. A production implementation should also address:

- Pipeline monitoring, restart, and incident response
- Selection and governance of AIDP versus ALH execution responsibilities
- Quality and freshness service-level objectives
- Schema and data-product contract evolution
- Partitioning, caching, and workload optimization
- Embedding-model and vector-index lifecycle management
- Retrieval evaluation and regression testing
- Retention, legal hold, and document-version policy
- Least-privilege access, masking, auditing, and separation of duties
- Governed sharing across organizations or clouds

Oracle can incorporate data from storage and database services in other clouds, including Amazon S3, Azure Blob Storage, and Oracle Database deployments outside OCI. Those integrations are architectural options, not hands-on exercises in this workshop.

## What's next

### Data Fundamentals for AI Application Development

Developers explore how relational SQL, JSON, property graphs, and vector search can be combined in Oracle AI Database. They begin with curated data that the data-engineering team has already prepared.

### Assemble and Deploy an AI Agent using RAG and SQL

Agent builders configure a governed document knowledge base and create the Construction Evaluation Agent. The agent uses:

- `get_project_context`
- `get_supplier_recommendations`
- `get_supplier_profile`
- Construction policy and guidance documents through RAG

This workshop prepared the trusted foundation those tools depend on.

## Learn More

- [Oracle Autonomous AI Lakehouse](https://www.oracle.com/autonomous-database/autonomous-data-warehouse/)
- [Oracle AI Data Platform Workbench overview](https://docs.oracle.com/en/cloud/paas/ai-data-platform/aidug/overview-oracle-ai-data-platform.html)
- [Transform Data with Data Transforms in Autonomous AI Database](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/autonomous-data-transforms.html)
- [Oracle AI Vector Search](https://docs.oracle.com/en/database/oracle/oracle-database/26/vecse/)
- [OCI Object Storage](https://docs.oracle.com/en-us/iaas/Content/Object/home.htm)
- [OCI Data Catalog](https://docs.oracle.com/en-us/iaas/data-catalog/home.htm)

## Acknowledgements

- **Author:** Eli Schilling, Cloud Architect || Evangelist
- **Contributors:** Oracle LiveLabs and ONA Lab Experience Teams
- **Last Updated By / Date:** ONA Lab Experience team, July 2026
