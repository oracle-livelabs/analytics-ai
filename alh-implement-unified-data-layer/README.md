# Unify the Data Layer with Oracle Autonomous AI Lakehouse

This repository contains the first-draft Oracle LiveLabs workshop **Unify the Data Layer with Oracle Autonomous AI Lakehouse**.

The workshop follows an 80-minute, three-lab structure:

1. Explore the Unified Lakehouse Foundation
2. Unify Data for AI Applications
3. Deliver Trusted Data Products

The attendee environment is expected to be pre-provisioned. Representative Fusion ERP, Primavera, CRM, and on-premises data is supplied as simulated CSV source extracts. Contracts, engineering specifications, and inspection reports are supplied as PDF documents in OCI Object Storage. The workshop does not require access to the source enterprise applications.

## Transformation approach

This workshop demonstrates an Autonomous AI Lakehouse-native implementation. Attendees use Data Studio to link Object Storage data and Catalog to explore entities, metadata, and lineage; focused SQL exercises cover transformation, validation, reconciliation, and vector retrieval. Bronze, Silver, and Gold are created and maintained with ALH Data Studio, SQL, Data Transforms, and database-native jobs. AIDP remains part of the broader solution story, but AIDP notebooks do not execute this workshop's seeded transformations.

The complementary AIDP pattern is documented in the workshop: teams can use Spark-powered AIDP notebooks and workflows for distributed or notebook-centric processing, then publish selected products to ALH. The workshop presents the choice as workload-driven rather than positioning either approach as universally preferred.

## Workshop entry point

Open `workshops/sandbox/index.html` through the LiveLabs publishing workflow. The adjacent `manifest.json` defines the tutorial order and points to the shared Markdown files at the repository root.

The expanded customer-tenancy variant begins at `workshops/tenancy/index.html`. Its manifest adds manual ALH provisioning, staged setup automation, Excel, AWS Glue, Iceberg, remote relational data, optional Delta Sharing, and explicit cleanup while preserving the tested sandbox path.

## Test environment package

Use `files/setup/alh-unified-data-layer-stack.zip` to create an OCI Resource Manager stack. The archive places the Terraform configuration at its root and includes all CSV, PDF, and SQL bootstrap assets. The editable Terraform source is under `files/setup/terraform`, and `files/setup/package-stack.ps1` regenerates the archive after seed or provisioning changes.

The stack intentionally displays `database_admin_password`, `workshop_username`, and `workshop_user_password` as plain-text Terraform outputs for ephemeral testing. The Autonomous AI Lakehouse ADMIN username is the fixed value `ADMIN`.

## Draft data contracts

The first draft assumes these schemas and products:

- `SEER_BRONZE`: faithful source extracts and ingestion metadata
- `SUPPLIER_TRANSFORM_EXT`: attendee-created Bronze external table linked to `source-data/suppliers/supplier_extract.csv` with Data Studio
- `SUPPLIER_STANDARDIZED_DEMO`: attendee-created Silver demonstration view retaining source-system and ingestion-batch context, with Object Storage lineage visible in Catalog
- `SEER_SILVER`: standardized and reconciled enterprise entities
- `SEER_SILVER.SUPPLIER_SOURCE_MAPPINGS`: seeded comparison result for the transformation exercise
- `SEER_GOLD`: governed, consumer-ready data products
- `SEER_GOLD.PROJECT_CONTEXT`
- `SEER_GOLD.SUPPLIER_RECOMMENDATIONS`
- `SEER_GOLD.SUPPLIER_PROFILE`
- `SEER_GOLD.DOCUMENT_CHUNKS`
- `SEER_GOLD.PIPELINE_RUN_SUMMARY` and `SEER_GOLD.PIPELINE_RUN_EVENTS`: workshop audit records for ALH pipeline execution
- Seeded pipeline audit tables that illustrate outcomes from SQL, Data Transforms, and database-job execution

The names are design contracts for the sample-data and environment build. Terraform, seed CSVs, PDF documents, SQL bootstrap scripts, and an OCI Resource Manager-ready packaging workflow are under `files`. They must be verified during end-to-end deployment and attendee-path validation.

## Content status

This is a narrative and instructional first draft. Exact Autonomous AI Lakehouse UI labels, screenshots, SQL output, resource names, and timings must be validated against the final workshop environment before publication. Any AIDP screenshots or instructions should appear only in clearly labeled comparison or downstream-context material.
