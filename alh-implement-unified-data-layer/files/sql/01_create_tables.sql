WHENEVER SQLERROR EXIT SQL.SQLCODE
SET DEFINE OFF
SET ECHO ON
SET FEEDBACK ON

CREATE TABLE seer_bronze.source_record_inventory (
  source_system       VARCHAR2(40),
  source_object       VARCHAR2(80),
  storage_format      VARCHAR2(20),
  record_count        NUMBER,
  extracted_at        TIMESTAMP WITH TIME ZONE,
  ingestion_batch_id  VARCHAR2(40)
);

CREATE TABLE seer_bronze.erp_purchase_orders (
  source_record_id    VARCHAR2(40),
  po_number           VARCHAR2(30),
  project_reference   VARCHAR2(40),
  supplier_reference  VARCHAR2(40),
  asset_reference     VARCHAR2(40),
  description         VARCHAR2(400),
  amount              NUMBER(14,2),
  currency_code       VARCHAR2(3),
  po_status           VARCHAR2(30),
  extracted_at        TIMESTAMP WITH TIME ZONE,
  ingestion_batch_id  VARCHAR2(40)
);

CREATE TABLE seer_bronze.document_registry (
  document_name       VARCHAR2(200),
  document_type       VARCHAR2(40),
  object_uri          VARCHAR2(1000),
  project_reference   VARCHAR2(40),
  asset_reference     VARCHAR2(40),
  version_label       VARCHAR2(20),
  source_modified_at  TIMESTAMP WITH TIME ZONE
);

CREATE TABLE seer_silver.assets (
  asset_id                 VARCHAR2(40),
  canonical_asset_name     VARCHAR2(200),
  project_id               VARCHAR2(40),
  asset_type               VARCHAR2(60),
  normalized_status        VARCHAR2(30),
  source_system_count      NUMBER,
  reconciliation_status    VARCHAR2(30)
);

CREATE TABLE seer_silver.suppliers (
  supplier_id                 VARCHAR2(40),
  canonical_supplier_name     VARCHAR2(200),
  qualification_status        VARCHAR2(40),
  compliance_status           VARCHAR2(40),
  matched_source_count        NUMBER
);

CREATE TABLE seer_silver.supplier_source_mappings (
  source_record_id             VARCHAR2(40),
  supplier_id                  VARCHAR2(40),
  canonical_supplier_name      VARCHAR2(200),
  qualification_status         VARCHAR2(40),
  normalized_certification     VARCHAR2(80),
  normalized_location          VARCHAR2(120)
);

CREATE TABLE seer_silver.source_record_mappings (
  source_system            VARCHAR2(40),
  source_object            VARCHAR2(80),
  source_record_id         VARCHAR2(40),
  source_description       VARCHAR2(400),
  canonical_event_id       VARCHAR2(40),
  canonical_business_term  VARCHAR2(120),
  project_name             VARCHAR2(200),
  match_method             VARCHAR2(60),
  match_confidence         NUMBER(5,4)
);

CREATE TABLE seer_silver.project_events (
  event_id          VARCHAR2(40),
  project_name      VARCHAR2(200),
  asset_name        VARCHAR2(200),
  event_type        VARCHAR2(80),
  planned_date      DATE,
  actual_date       DATE,
  supplier_name     VARCHAR2(200),
  financial_status  VARCHAR2(40),
  inspection_status VARCHAR2(40)
);

CREATE TABLE seer_silver.quarantined_records (
  source_system      VARCHAR2(40),
  source_record_id   VARCHAR2(40),
  failed_rule        VARCHAR2(120),
  failure_reason     VARCHAR2(500),
  quarantine_status  VARCHAR2(30)
);

CREATE TABLE seer_gold.project_context (
  project_id             VARCHAR2(40),
  project_name           VARCHAR2(200),
  asset_id               VARCHAR2(40),
  asset_name             VARCHAR2(200),
  current_milestone      VARCHAR2(200),
  committed_cost         NUMBER(14,2),
  inspection_status      VARCHAR2(40),
  primary_supplier       VARCHAR2(200),
  supplier_name          VARCHAR2(200),
  data_freshness_at      TIMESTAMP WITH TIME ZONE,
  milestone_status       VARCHAR2(40),
  purchase_order_status  VARCHAR2(40),
  decision_readiness     VARCHAR2(40)
);

CREATE TABLE seer_gold.data_quality_results (
  layer_name        VARCHAR2(20),
  rule_name         VARCHAR2(120),
  rule_dimension    VARCHAR2(40),
  records_evaluated NUMBER,
  records_failed    NUMBER,
  status            VARCHAR2(20),
  evaluated_at      TIMESTAMP WITH TIME ZONE
);

CREATE TABLE seer_gold.lineage_summary (
  target_object       VARCHAR2(200),
  source_object       VARCHAR2(200),
  transformation_name VARCHAR2(200),
  pipeline_run_id     VARCHAR2(40),
  completed_at        TIMESTAMP WITH TIME ZONE
);

CREATE TABLE seer_gold.data_product_catalog (
  product_name       VARCHAR2(80),
  business_purpose   VARCHAR2(500),
  product_owner      VARCHAR2(120),
  refresh_frequency  VARCHAR2(80),
  quality_status     VARCHAR2(30),
  intended_consumers VARCHAR2(500),
  classification     VARCHAR2(40),
  contract_version   VARCHAR2(20)
);

CREATE TABLE seer_gold.supplier_recommendations (
  project_name          VARCHAR2(200),
  supplier_name         VARCHAR2(200),
  fit_score             NUMBER(5,2),
  risk_level            VARCHAR2(30),
  recommendation_status VARCHAR2(40),
  missing_information   VARCHAR2(1000)
);

CREATE TABLE seer_gold.supplier_profile (
  supplier_id          VARCHAR2(40),
  supplier_name        VARCHAR2(200),
  qualification_status VARCHAR2(40),
  certifications       VARCHAR2(500),
  unresolved_ncr_count NUMBER,
  capacity_status      VARCHAR2(40),
  compliance_summary   VARCHAR2(1000)
);

CREATE TABLE seer_gold.asset_profiles (
  asset_id        VARCHAR2(40),
  project_name    VARCHAR2(200),
  asset_name      VARCHAR2(200),
  specifications  JSON
);

CREATE TABLE seer_gold.asset_relationships (
  from_entity_name    VARCHAR2(200),
  relationship_type   VARCHAR2(80),
  to_entity_name      VARCHAR2(200),
  relationship_source VARCHAR2(120)
);

CREATE TABLE seer_gold.document_catalog (
  document_id      VARCHAR2(40),
  document_name    VARCHAR2(200),
  document_type    VARCHAR2(40),
  project_id       VARCHAR2(40),
  project_name     VARCHAR2(200),
  asset_id         VARCHAR2(40),
  asset_name       VARCHAR2(200),
  version_label    VARCHAR2(20),
  object_uri       VARCHAR2(1000),
  classification  VARCHAR2(40)
);

CREATE TABLE seer_gold.document_chunks (
  chunk_id         VARCHAR2(40),
  document_id      VARCHAR2(40),
  document_name    VARCHAR2(200),
  document_type    VARCHAR2(40),
  project_id       VARCHAR2(40),
  project_name     VARCHAR2(200),
  asset_id         VARCHAR2(40),
  asset_name       VARCHAR2(200),
  section_title    VARCHAR2(200),
  page_number      NUMBER,
  chunk_sequence   NUMBER,
  chunk_text       CLOB,
  character_count  NUMBER,
  embedding_model  VARCHAR2(80),
  embedding_status VARCHAR2(30),
  embedding        VECTOR(384, FLOAT32)
);

CREATE TABLE seer_gold.document_provenance (
  document_name      VARCHAR2(200),
  object_uri         VARCHAR2(1000),
  object_version     VARCHAR2(80),
  source_modified_at TIMESTAMP WITH TIME ZONE,
  extracted_at       TIMESTAMP WITH TIME ZONE,
  chunking_policy    VARCHAR2(200),
  embedding_model    VARCHAR2(80),
  classification     VARCHAR2(40)
);

CREATE TABLE seer_gold.pipeline_run_summary (
  pipeline_run_id     VARCHAR2(40),
  pipeline_name       VARCHAR2(120),
  execution_engine    VARCHAR2(80),
  pipeline_purpose    VARCHAR2(500),
  started_at          TIMESTAMP WITH TIME ZONE,
  completed_at        TIMESTAMP WITH TIME ZONE,
  run_status          VARCHAR2(30),
  records_read        NUMBER,
  records_written     NUMBER,
  records_quarantined NUMBER
);

CREATE TABLE seer_gold.pipeline_run_events (
  pipeline_run_id  VARCHAR2(40),
  pipeline_name    VARCHAR2(120),
  execution_engine VARCHAR2(80),
  step_name        VARCHAR2(120),
  severity         VARCHAR2(20),
  message          VARCHAR2(1000),
  recorded_at      TIMESTAMP WITH TIME ZONE
);

CREATE TABLE seer_gold.data_product_freshness (
  product_name            VARCHAR2(80),
  last_successful_refresh TIMESTAMP WITH TIME ZONE,
  freshness_sla_minutes   NUMBER,
  freshness_status        VARCHAR2(30)
);

CREATE TABLE seer_gold.data_product_columns (
  product_name        VARCHAR2(80),
  column_sequence     NUMBER,
  column_name         VARCHAR2(80),
  business_definition VARCHAR2(500),
  data_type           VARCHAR2(80),
  nullable_flag       VARCHAR2(1),
  sensitivity_label   VARCHAR2(40)
);

CREATE TABLE seer_gold.data_product_consumers (
  product_name     VARCHAR2(80),
  consumer_name    VARCHAR2(120),
  access_pattern   VARCHAR2(120),
  contract_version VARCHAR2(20),
  approval_status  VARCHAR2(30)
);

CREATE TABLE seer_gold.ai_readiness_assessment (
  product_name      VARCHAR2(80),
  identifiers_ready VARCHAR2(10),
  quality_ready     VARCHAR2(10),
  freshness_ready   VARCHAR2(10),
  lineage_ready     VARCHAR2(10),
  security_ready    VARCHAR2(10),
  retrieval_ready   VARCHAR2(10),
  overall_readiness VARCHAR2(30)
);

PROMPT All Bronze, Silver, and Gold tables created.
EXIT SUCCESS
