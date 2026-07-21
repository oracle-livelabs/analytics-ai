# Workshop Recap

## Introduction

You began with an empty customer-tenancy environment and finished with a governed ALH foundation that loads, links, synchronizes, reconciles, searches, and serves data across several platforms and consumption patterns.

**Estimated Time:** 10 minutes

### Objectives

In this recap, you will:

- Review the environment and integrations you built.
- Compare when data moved and when it remained at the source.
- Reconnect the technical patterns to application and agent readiness.
- Identify the controls required before production adoption.

### Prerequisites

- Completion of Labs 1 through 8
- Optional completion of Lab 9

## What you accomplished

### Lab 1: Build the Unified Lakehouse Landing Zone

You provisioned ALH, created a private Object Storage landing zone, enabled governed resource-principal access, loaded five source extracts, and ran staged automation that built the medallion, document, embedding, and vector environment.

### Lab 2: Explore the Unified Lakehouse Foundation

You linked the supplier CSV as an external table, compared managed and linked access, standardized a Bronze source into a Silver demonstration view, and inspected visual lineage.

### Lab 3: Unify Data for AI Applications

You queried relational, JSON, relationship, document, and vector products and combined semantic evidence with structured project context.

### Lab 4: Deliver Trusted Data Products

You reviewed pipeline evidence, quality, freshness, contracts, consumers, and AI readiness.

### Lab 5: Analyze Trusted Data with Oracle Database for Excel

You retrieved a governed Gold product into Excel and identified the boundary between database controls and local workbook data.

### Labs 6 and 7: AWS Glue and Apache Iceberg

You synchronized conventional Glue metadata into generated external tables and then queried an Iceberg table through its open table-format metadata.

### Lab 8: Link a Remote Relational Source

You queried remote operational inspection data through a live link and materialized a Silver snapshot when local availability and repeatability were required.

### Lab 9: Consume Partner Data through Delta Sharing

If you completed the optional lab, you registered a provider profile, linked a shared table, and evaluated partner data as a governed external product.

## Source-access matrix

| Source or consumer | ALH representation | Data copied into ALH? | Refresh behavior |
|---|---|---:|---|
| Local CSV through Data Loader | Managed table | Yes | New load job |
| OCI Object Storage CSV | External table | No | Reads current object contents |
| Project PDFs | Objects, registry, chunks, and vectors | Extracted metadata/chunks are stored | Document pipeline refresh |
| AWS Glue/S3 | Generated external table | No | Glue synchronization manages definitions |
| AWS Glue Iceberg | Iceberg external table | No | Resolves committed Iceberg state |
| Remote Oracle database | Linked view | No | Live source query |
| Remote inspection snapshot | Silver table | Yes | Scheduled ETL or job |
| Delta Sharing provider | Shared external table | No | Provider and share-version dependent |
| Microsoft Excel | Local worksheet result | Result only | User refresh or rerun |

## Key takeaways

- Unifying the data layer does not mean copying every source into one storage system.
- Bronze, Silver, and Gold describe contracts and responsibilities, not specific products or file formats.
- External tables accelerate access, but source availability, credentials, schema changes, and latency remain operational dependencies.
- Managed Silver and Gold products add standardization, quality, ownership, security, freshness, and consumer contracts.
- Documents require traceable extraction, chunks, model ownership, and vector lifecycle controls.
- Agents should consume approved products and evidence rather than reconstructing source semantics themselves.
- Excel and partner sharing extend the audience, but also extend the governance boundary.

## Production considerations

- Replace workshop credentials with secret-management and rotation processes.
- Narrow IAM and AWS policies to approved buckets, objects, catalogs, and operations.
- Schedule catalog synchronization, snapshot refresh, quality checks, and vector refresh.
- Monitor source availability and schema drift.
- Record lineage for links, transformations, snapshots, and shared products.
- Classify and mask sensitive data before it reaches external tools.
- Establish owners and service-level objectives for each Gold product.
- Test disaster recovery and credential-expiration behavior.

## What's next

The governed products created here are designed to support downstream application-development and Construction Evaluation Agent experiences. Developers can rely on relational keys, JSON attributes, relationships, and vector evidence without manually stitching each source together.

## Learn More

- [Oracle Autonomous AI Database](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/overview-autonomous-database.html)
- [Query External Data](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/query-external.html)
- [Share and Consume Data](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/autonomous-data-share.html)

## Acknowledgements

- **Author:** Eli Schilling, Cloud Architect || Evangelist
- **Contributors:** Oracle LiveLabs and ONA Lab Experience Teams
- **Last Updated By / Date:** ONA Lab Experience team, July 2026
