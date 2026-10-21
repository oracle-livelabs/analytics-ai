WHENEVER SQLERROR EXIT SQL.SQLCODE
SET DEFINE ON
SET VERIFY OFF
SET ECHO OFF
SET FEEDBACK ON

DEFINE object_base_uri = '&1'

INSERT ALL
  INTO seer_bronze.source_record_inventory VALUES ('FUSION_ERP','PURCHASE_ORDERS','CSV',4,TIMESTAMP '2026-07-13 22:15:00 UTC','BATCH-20260714-01')
  INTO seer_bronze.source_record_inventory VALUES ('FUSION_ERP','FINANCIAL_ASSETS','CSV',3,TIMESTAMP '2026-07-13 22:15:00 UTC','BATCH-20260714-01')
  INTO seer_bronze.source_record_inventory VALUES ('PRIMAVERA','PROJECT_MILESTONES','CSV',4,TIMESTAMP '2026-07-13 23:00:00 UTC','BATCH-20260714-01')
  INTO seer_bronze.source_record_inventory VALUES ('CRM','SUPPLIER_EXTRACT','CSV',8,TIMESTAMP '2026-07-14 00:00:00 UTC','BATCH-20260714-01')
  INTO seer_bronze.source_record_inventory VALUES ('ON_PREM_INSPECTION','INSPECTION_FINDINGS','CSV',4,TIMESTAMP '2026-07-14 00:05:00 UTC','BATCH-20260714-01')
  INTO seer_bronze.source_record_inventory VALUES ('OCI_OBJECT_STORAGE','PROJECT_DOCUMENTS','PDF',3,TIMESTAMP '2026-07-14 00:10:00 UTC','BATCH-20260714-01')
SELECT 1 FROM dual;

INSERT ALL
  INTO seer_bronze.erp_purchase_orders VALUES ('ERP-PO-88142','PO-88142','AUS-BANK-01','ERP-VEN-2044','ERP-AST-7781','Reinforced structural steel frame delivery',1487500,'USD','RECEIVED',TIMESTAMP '2026-07-13 22:15:00 UTC','BATCH-20260714-01')
  INTO seer_bronze.erp_purchase_orders VALUES ('ERP-PO-88157','PO-88157','AUS-BANK-01','ERP-VEN-2044','ERP-AST-7781','High strength bolts and connection plates',186400,'USD','OPEN',TIMESTAMP '2026-07-13 22:15:00 UTC','BATCH-20260714-01')
  INTO seer_bronze.erp_purchase_orders VALUES ('ERP-PO-77402','PO-77402','HOU-MIXED-02','ERP-VEN-2071','ERP-AST-6610','Structural steel package for podium levels',2125000,'USD','APPROVED',TIMESTAMP '2026-07-13 22:15:00 UTC','BATCH-20260714-01')
  INTO seer_bronze.erp_purchase_orders VALUES ('ERP-PO-66321','PO-66321','HAR-SEISMIC-03','ERP-VEN-2105','ERP-AST-5504','Seismic brace fabrication and delivery',932000,'USD','HOLD',TIMESTAMP '2026-07-13 22:15:00 UTC','BATCH-20260714-01')
SELECT 1 FROM dual;

INSERT ALL
  INTO seer_bronze.document_registry VALUES ('austin_structural_engineering_specification.pdf','ENGINEERING_SPECIFICATION','&object_base_uri'||'documents/austin_structural_engineering_specification.pdf','AUS-BANK-01','STR-AUS-STEEL-01','R3',TIMESTAMP '2026-06-28 16:00:00 UTC')
  INTO seer_bronze.document_registry VALUES ('atlas_supplier_framework_agreement.pdf','SUPPLIER_CONTRACT','&object_base_uri'||'documents/atlas_supplier_framework_agreement.pdf','AUS-BANK-01','STR-AUS-STEEL-01','V1',TIMESTAMP '2026-04-01 15:00:00 UTC')
  INTO seer_bronze.document_registry VALUES ('austin_receiving_inspection_report.pdf','INSPECTION_REPORT','&object_base_uri'||'documents/austin_receiving_inspection_report.pdf','AUS-BANK-01','STR-AUS-STEEL-01','V1',TIMESTAMP '2026-07-09 20:30:00 UTC')
SELECT 1 FROM dual;

INSERT ALL
  INTO seer_silver.assets VALUES ('STR-AUS-STEEL-01','Reinforced Steel Framework','PRJ-AUS-001','BUILDING_STRUCTURE','ERECTION_IN_PROGRESS',4,'RECONCILED')
  INTO seer_silver.assets VALUES ('STR-HOU-POD-02','Podium Structural Steel','PRJ-HOU-002','BUILDING_STRUCTURE','PROCUREMENT',3,'RECONCILED')
  INTO seer_silver.assets VALUES ('STR-HAR-BRACE-03','Seismic Bracing System','PRJ-HAR-003','BUILDING_IMPROVEMENT','ON_HOLD',3,'REVIEW_REQUIRED')
SELECT 1 FROM dual;

INSERT ALL
  INTO seer_silver.suppliers VALUES ('SUP-ATLAS-001','Atlas Structural Fabrication','APPROVED','COMPLIANT',2)
  INTO seer_silver.suppliers VALUES ('SUP-WEST-002','Westbridge Steel Supply','REQUEST_INFORMATION','DOCUMENT_EXPIRED',2)
  INTO seer_silver.suppliers VALUES ('SUP-NORTH-003','Northline Industrial Metals','REVIEW_REQUIRED','REVIEW_REQUIRED',1)
  INTO seer_silver.suppliers VALUES ('SUP-PREC-004','Precision Air Systems','APPROVED','COMPLIANT',1)
  INTO seer_silver.suppliers VALUES ('SUP-COAST-005','Coastal Retrofit Metals','REQUEST_INFORMATION','DOCUMENT_MISSING',1)
  INTO seer_silver.suppliers VALUES ('SUP-CIVIC-006','Civic Steel Partners','APPROVED','COMPLIANT',1)
SELECT 1 FROM dual;

INSERT ALL
  INTO seer_silver.supplier_source_mappings VALUES ('CRM-SUP-1001','SUP-ATLAS-001','Atlas Structural Fabrication','APPROVED','AISC','AUSTIN, TX')
  INTO seer_silver.supplier_source_mappings VALUES ('ERP-VEN-2044','SUP-ATLAS-001','Atlas Structural Fabrication','APPROVED','AISC','AUSTIN, TX')
  INTO seer_silver.supplier_source_mappings VALUES ('CRM-SUP-1002','SUP-WEST-002','Westbridge Steel Supply','REQUEST_INFORMATION','MISSING','DALLAS, TX')
  INTO seer_silver.supplier_source_mappings VALUES ('ERP-VEN-2071','SUP-WEST-002','Westbridge Steel Supply','APPROVED','AISC','DALLAS, TX')
  INTO seer_silver.supplier_source_mappings VALUES ('CRM-SUP-1003','SUP-NORTH-003','Northline Industrial Metals','REVIEW_REQUIRED','AWS D1.1','SAN ANTONIO, TX')
  INTO seer_silver.supplier_source_mappings VALUES ('ERP-VEN-2099','SUP-PREC-004','Precision Air Systems','APPROVED','ISO 9001','ROUND ROCK, TX')
  INTO seer_silver.supplier_source_mappings VALUES ('CRM-SUP-1004','SUP-COAST-005','Coastal Retrofit Metals','REQUEST_INFORMATION','MISSING','GALVESTON, TX')
  INTO seer_silver.supplier_source_mappings VALUES ('CRM-SUP-1005','SUP-CIVIC-006','Civic Steel Partners','APPROVED','AISC','HOUSTON, TX')
SELECT 1 FROM dual;

INSERT ALL
  INTO seer_silver.source_record_mappings VALUES ('FUSION_ERP','PURCHASE_ORDERS','ERP-PO-88142','Reinforced structural steel frame delivery','EVT-AUS-STEEL-DELIVERY','STEEL DELIVERY','Austin Regional Bank Structure','PROJECT_ASSET_SUPPLIER_KEYS',0.9900)
  INTO seer_silver.source_record_mappings VALUES ('PRIMAVERA','PROJECT_MILESTONES','P6-ACT-44018','Steel delivery complete','EVT-AUS-STEEL-DELIVERY','STEEL DELIVERY','Austin Regional Bank Structure','PROJECT_ASSET_DATE_MATCH',0.9700)
  INTO seer_silver.source_record_mappings VALUES ('CRM','SUPPLIER_EXTRACT','CRM-SUP-1001','Atlas structural steel commitment','EVT-AUS-STEEL-DELIVERY','STEEL DELIVERY','Austin Regional Bank Structure','SUPPLIER_PROJECT_MATCH',0.9600)
  INTO seer_silver.source_record_mappings VALUES ('ON_PREM_INSPECTION','INSPECTION_FINDINGS','INSP-55091','Receiving inspection for steel shipment','EVT-AUS-STEEL-DELIVERY','STEEL DELIVERY','Austin Regional Bank Structure','PROJECT_ASSET_INSPECTION_MATCH',0.9850)
SELECT 1 FROM dual;

INSERT INTO seer_silver.project_events VALUES ('EVT-AUS-STEEL-DELIVERY','Austin Regional Bank Structure','Reinforced Steel Framework','STEEL_DELIVERY',DATE '2026-07-08',DATE '2026-07-09','Atlas Structural Fabrication','RECEIVED','PASS');

INSERT ALL
  INTO seer_silver.quarantined_records VALUES ('CRM','CRM-SUP-1002','CURRENT_CERTIFICATION_REQUIRED','AISC certificate expiration date is not present','AWAITING_SOURCE_CORRECTION')
  INTO seer_silver.quarantined_records VALUES ('ON_PREM_INSPECTION','INSP-33210','SEISMIC_WPS_REQUIRED','Demand-critical weld procedure evidence is incomplete','OPEN')
SELECT 1 FROM dual;

INSERT ALL
  INTO seer_gold.project_context VALUES ('PRJ-AUS-001','Austin Regional Bank Structure','STR-AUS-STEEL-01','Reinforced Steel Framework','Frame erection complete',1673900,'PASS','Atlas Structural Fabrication','Atlas Structural Fabrication',TIMESTAMP '2026-07-14 00:30:00 UTC','IN_PROGRESS','RECEIVED','READY')
  INTO seer_gold.project_context VALUES ('PRJ-HOU-002','Downtown Mixed-Use Tower','STR-HOU-POD-02','Podium Structural Steel','Podium steel release',2125000,'REQUEST_INFO','Westbridge Steel Supply','Westbridge Steel Supply',TIMESTAMP '2026-07-14 00:30:00 UTC','NOT_STARTED','APPROVED','CONDITIONAL')
  INTO seer_gold.project_context VALUES ('PRJ-HAR-003','Harbor Seismic Retrofit','STR-HAR-BRACE-03','Seismic Bracing System','Brace package approval',932000,'FAIL','Coastal Retrofit Metals','Coastal Retrofit Metals',TIMESTAMP '2026-07-14 00:30:00 UTC','AT_RISK','HOLD','NOT_READY')
SELECT 1 FROM dual;

INSERT ALL
  INTO seer_gold.data_quality_results VALUES ('BRONZE','Required source identifier','COMPLETENESS',23,0,'PASS',TIMESTAMP '2026-07-14 00:20:00 UTC')
  INTO seer_gold.data_quality_results VALUES ('SILVER','Canonical supplier match','CONSISTENCY',8,0,'PASS',TIMESTAMP '2026-07-14 00:24:00 UTC')
  INTO seer_gold.data_quality_results VALUES ('SILVER','Current supplier certification','VALIDITY',8,2,'WARNING',TIMESTAMP '2026-07-14 00:24:00 UTC')
  INTO seer_gold.data_quality_results VALUES ('GOLD','Unique project and asset key','UNIQUENESS',3,0,'PASS',TIMESTAMP '2026-07-14 00:30:00 UTC')
SELECT 1 FROM dual;

INSERT ALL
  INTO seer_gold.lineage_summary VALUES ('SEER_GOLD.PROJECT_CONTEXT','SEER_SILVER.PROJECT_EVENTS','PUBLISH_PROJECT_CONTEXT','RUN-GOLD-20260714',TIMESTAMP '2026-07-14 00:30:00 UTC')
  INTO seer_gold.lineage_summary VALUES ('SEER_GOLD.PROJECT_CONTEXT','SEER_SILVER.ASSETS','PUBLISH_PROJECT_CONTEXT','RUN-GOLD-20260714',TIMESTAMP '2026-07-14 00:30:00 UTC')
  INTO seer_gold.lineage_summary VALUES ('SEER_GOLD.PROJECT_CONTEXT','SEER_SILVER.SUPPLIERS','PUBLISH_PROJECT_CONTEXT','RUN-GOLD-20260714',TIMESTAMP '2026-07-14 00:30:00 UTC')
  INTO seer_gold.lineage_summary VALUES ('SEER_GOLD.PROJECT_CONTEXT','SEER_BRONZE.ERP_PURCHASE_ORDERS','RECONCILE_PURCHASING','RUN-SILVER-20260714',TIMESTAMP '2026-07-14 00:24:00 UTC')
SELECT 1 FROM dual;

INSERT ALL
  INTO seer_gold.data_product_catalog VALUES ('PROJECT_CONTEXT','Unified project, asset, schedule, purchasing, supplier, and inspection context','Project Data Products','Hourly','PASS','Applications; Construction Evaluation Agent','INTERNAL','1.0')
  INTO seer_gold.data_product_catalog VALUES ('SUPPLIER_RECOMMENDATIONS','Ranked supplier fit and risk for a project','Supplier Data Products','Hourly','PASS','Sourcing applications; Construction Evaluation Agent','CONFIDENTIAL','1.0')
  INTO seer_gold.data_product_catalog VALUES ('SUPPLIER_PROFILE','Governed supplier qualification and compliance evidence','Supplier Data Products','Daily','PASS','Sourcing applications; Construction Evaluation Agent','CONFIDENTIAL','1.0')
  INTO seer_gold.data_product_catalog VALUES ('DOCUMENT_CHUNKS','Traceable engineering and policy evidence for semantic retrieval','Document Intelligence','Daily','PASS','Search; RAG; Construction Evaluation Agent','CONFIDENTIAL','1.0')
SELECT 1 FROM dual;

INSERT ALL
  INTO seer_gold.supplier_recommendations VALUES ('Austin Regional Bank Structure','Atlas Structural Fabrication',97,'LOW','RECOMMENDED','None')
  INTO seer_gold.supplier_recommendations VALUES ('Downtown Mixed-Use Tower','Westbridge Steel Supply',76,'MEDIUM','REQUEST_INFORMATION','Updated AISC certification and delivery confirmation')
  INTO seer_gold.supplier_recommendations VALUES ('Downtown Mixed-Use Tower','Northline Industrial Metals',68,'MEDIUM','REQUEST_INFORMATION','Inspection history and mill certificate package')
  INTO seer_gold.supplier_recommendations VALUES ('Harbor Seismic Retrofit','Coastal Retrofit Metals',38,'HIGH','DENIED','Seismic welding qualification and NCR closeout')
SELECT 1 FROM dual;

INSERT ALL
  INTO seer_gold.supplier_profile VALUES ('SUP-ATLAS-001','Atlas Structural Fabrication','APPROVED','AISC; AWS D1.1',0,'AVAILABLE','Current certifications; accepted Austin receiving inspection')
  INTO seer_gold.supplier_profile VALUES ('SUP-WEST-002','Westbridge Steel Supply','REQUEST_INFORMATION','AISC - expiration evidence required',0,'AVAILABLE','Qualification remains conditional pending updated evidence')
  INTO seer_gold.supplier_profile VALUES ('SUP-COAST-005','Coastal Retrofit Metals','REQUEST_INFORMATION','Certification package incomplete',1,'CONSTRAINED','Open seismic welding nonconformance')
SELECT 1 FROM dual;

INSERT INTO seer_gold.asset_profiles VALUES ('STR-AUS-STEEL-01','Austin Regional Bank Structure','Reinforced Steel Framework',JSON('{"material_grade":"ASTM A992 Grade 50","design_standard":"AISC 360","fire_rating_minutes":120,"bolt_grade":"ASTM F3125 Grade A325"}'));

INSERT ALL
  INTO seer_gold.asset_relationships VALUES ('Austin Regional Bank Structure','CONTAINS','Reinforced Steel Framework','Canonical project-asset mapping')
  INTO seer_gold.asset_relationships VALUES ('Reinforced Steel Framework','SUPPLIED_BY','Atlas Structural Fabrication','Reconciled purchasing and CRM records')
  INTO seer_gold.asset_relationships VALUES ('Reinforced Steel Framework','GOVERNED_BY','austin_structural_engineering_specification.pdf','Document metadata mapping')
  INTO seer_gold.asset_relationships VALUES ('Austin Regional Bank Structure','HAS_MILESTONE','Steel delivery complete','Reconciled Primavera milestone')
SELECT 1 FROM dual;

INSERT ALL
  INTO seer_gold.document_catalog VALUES ('DOC-AUS-SPEC-042','austin_structural_engineering_specification.pdf','ENGINEERING_SPECIFICATION','PRJ-AUS-001','Austin Regional Bank Structure','STR-AUS-STEEL-01','Reinforced Steel Framework','R3','&object_base_uri'||'documents/austin_structural_engineering_specification.pdf','CONFIDENTIAL')
  INTO seer_gold.document_catalog VALUES ('DOC-AUS-CONTRACT-017','atlas_supplier_framework_agreement.pdf','SUPPLIER_CONTRACT','PRJ-AUS-001','Austin Regional Bank Structure','STR-AUS-STEEL-01','Reinforced Steel Framework','V1','&object_base_uri'||'documents/atlas_supplier_framework_agreement.pdf','CONFIDENTIAL')
  INTO seer_gold.document_catalog VALUES ('DOC-AUS-INSP-55091','austin_receiving_inspection_report.pdf','INSPECTION_REPORT','PRJ-AUS-001','Austin Regional Bank Structure','STR-AUS-STEEL-01','Reinforced Steel Framework','V1','&object_base_uri'||'documents/austin_receiving_inspection_report.pdf','INTERNAL')
SELECT 1 FROM dual;

INSERT ALL
  INTO seer_gold.document_chunks (chunk_id,document_id,document_name,document_type,project_id,project_name,asset_id,asset_name,section_title,page_number,chunk_sequence,chunk_text,character_count,embedding_model,embedding_status) VALUES ('CHUNK-SPEC-001','DOC-AUS-SPEC-042','austin_structural_engineering_specification.pdf','ENGINEERING_SPECIFICATION','PRJ-AUS-001','Austin Regional Bank Structure','STR-AUS-STEEL-01','Reinforced Steel Framework','Purpose and scope',1,1,q'~This specification establishes material, fabrication, delivery, erection, inspection, and documentation requirements for the reinforced structural steel framework at the Austin Regional Bank Structure. It governs project AUS-BANK-01 and asset STR-AUS-STEEL-01.~',246,'ALL_MINILM_L12_V2','PENDING')
  INTO seer_gold.document_chunks (chunk_id,document_id,document_name,document_type,project_id,project_name,asset_id,asset_name,section_title,page_number,chunk_sequence,chunk_text,character_count,embedding_model,embedding_status) VALUES ('CHUNK-SPEC-002','DOC-AUS-SPEC-042','austin_structural_engineering_specification.pdf','ENGINEERING_SPECIFICATION','PRJ-AUS-001','Austin Regional Bank Structure','STR-AUS-STEEL-01','Reinforced Steel Framework','Austin structural framing requirements',2,2,q'~The structural frame uses ASTM A992 Grade 50 wide-flange members with ASTM A572 Grade 50 connection material. Column splices shall occur only at approved elevations. Substitution of member grade, connection geometry, or bolt diameter requires written approval by the engineer of record.~',274,'ALL_MINILM_L12_V2','PENDING')
  INTO seer_gold.document_chunks (chunk_id,document_id,document_name,document_type,project_id,project_name,asset_id,asset_name,section_title,page_number,chunk_sequence,chunk_text,character_count,embedding_model,embedding_status) VALUES ('CHUNK-SPEC-003','DOC-AUS-SPEC-042','austin_structural_engineering_specification.pdf','ENGINEERING_SPECIFICATION','PRJ-AUS-001','Austin Regional Bank Structure','STR-AUS-STEEL-01','Reinforced Steel Framework','Fabrication and delivery controls',2,3,q'~Every shipping bundle shall identify purchase order PO-88142, project AUS-BANK-01, and asset STR-AUS-STEEL-01. The supplier shall transmit the bill of lading, packing list, material test reports, bolt lot certificates, and nonconformance status before shipment.~',251,'ALL_MINILM_L12_V2','PENDING')
  INTO seer_gold.document_chunks (chunk_id,document_id,document_name,document_type,project_id,project_name,asset_id,asset_name,section_title,page_number,chunk_sequence,chunk_text,character_count,embedding_model,embedding_status) VALUES ('CHUNK-SPEC-004','DOC-AUS-SPEC-042','austin_structural_engineering_specification.pdf','ENGINEERING_SPECIFICATION','PRJ-AUS-001','Austin Regional Bank Structure','STR-AUS-STEEL-01','Reinforced Steel Framework','Documentation and retention',3,4,q'~The contractor shall preserve the relationship between each physical member, supplier record, purchase order, schedule activity, inspection, and supporting document. Records shall retain source identifiers and revisions so each project decision can be traced to original evidence.~',258,'ALL_MINILM_L12_V2','PENDING')
  INTO seer_gold.document_chunks (chunk_id,document_id,document_name,document_type,project_id,project_name,asset_id,asset_name,section_title,page_number,chunk_sequence,chunk_text,character_count,embedding_model,embedding_status) VALUES ('CHUNK-CONTRACT-001','DOC-AUS-CONTRACT-017','atlas_supplier_framework_agreement.pdf','SUPPLIER_CONTRACT','PRJ-AUS-001','Austin Regional Bank Structure','STR-AUS-STEEL-01','Reinforced Steel Framework','Austin delivery commitment',1,1,q'~For purchase order PO-88142, Atlas Structural Fabrication commits to sequence shipment for Primavera milestone A44018 and identify project AUS-BANK-01 on every packing list. A schedule variance requires written project approval.~',218,'ALL_MINILM_L12_V2','PENDING')
  INTO seer_gold.document_chunks (chunk_id,document_id,document_name,document_type,project_id,project_name,asset_id,asset_name,section_title,page_number,chunk_sequence,chunk_text,character_count,embedding_model,embedding_status) VALUES ('CHUNK-INSP-001','DOC-AUS-INSP-55091','austin_receiving_inspection_report.pdf','INSPECTION_REPORT','PRJ-AUS-001','Austin Regional Bank Structure','STR-AUS-STEEL-01','Reinforced Steel Framework','Inspection summary',1,1,q'~Receiving inspection INS-55091 verified bundle quantities, member shipping marks, visible condition, and material traceability. Mill certificates matched observed heat numbers. No shipping damage or distortion requiring quarantine was found.~',221,'ALL_MINILM_L12_V2','PENDING')
SELECT 1 FROM dual;

INSERT ALL
  INTO seer_gold.document_provenance VALUES ('austin_structural_engineering_specification.pdf','&object_base_uri'||'documents/austin_structural_engineering_specification.pdf','R3-20260628',TIMESTAMP '2026-06-28 16:00:00 UTC',TIMESTAMP '2026-07-14 00:26:00 UTC','Section-aware chunks; target 300-600 characters','ALL_MINILM_L12_V2','CONFIDENTIAL')
  INTO seer_gold.document_provenance VALUES ('atlas_supplier_framework_agreement.pdf','&object_base_uri'||'documents/atlas_supplier_framework_agreement.pdf','V1-20260401',TIMESTAMP '2026-04-01 15:00:00 UTC',TIMESTAMP '2026-07-14 00:26:00 UTC','Section-aware chunks; target 300-600 characters','ALL_MINILM_L12_V2','CONFIDENTIAL')
  INTO seer_gold.document_provenance VALUES ('austin_receiving_inspection_report.pdf','&object_base_uri'||'documents/austin_receiving_inspection_report.pdf','V1-20260709',TIMESTAMP '2026-07-09 20:30:00 UTC',TIMESTAMP '2026-07-14 00:26:00 UTC','Section-aware chunks; target 300-600 characters','ALL_MINILM_L12_V2','INTERNAL')
SELECT 1 FROM dual;

INSERT ALL
  INTO seer_gold.pipeline_run_summary VALUES ('RUN-BRONZE-20260714','REGISTER_SOURCE_EXTRACTS','ALH Data Studio','Register structured extracts and project documents',TIMESTAMP '2026-07-14 00:10:00 UTC',TIMESTAMP '2026-07-14 00:18:00 UTC','SUCCEEDED',26,26,0)
  INTO seer_gold.pipeline_run_summary VALUES ('RUN-SILVER-20260714','STANDARDIZE_AND_RECONCILE','ALH Data Transforms','Standardize identifiers and reconcile projects, assets, suppliers, and events',TIMESTAMP '2026-07-14 00:18:00 UTC',TIMESTAMP '2026-07-14 00:24:00 UTC','SUCCEEDED_WITH_WARNINGS',23,21,2)
  INTO seer_gold.pipeline_run_summary VALUES ('RUN-DOCS-20260714','PREPARE_DOCUMENT_VECTORS','ALH SQL Job','Chunk documents, generate embeddings, and refresh vector index',TIMESTAMP '2026-07-14 00:24:00 UTC',TIMESTAMP '2026-07-14 00:29:00 UTC','SUCCEEDED',3,6,0)
  INTO seer_gold.pipeline_run_summary VALUES ('RUN-GOLD-20260714','PUBLISH_GOLD_PRODUCTS','ALH Data Transforms','Publish governed application and agent data products',TIMESTAMP '2026-07-14 00:29:00 UTC',TIMESTAMP '2026-07-14 00:30:00 UTC','SUCCEEDED',21,18,0)
SELECT 1 FROM dual;

INSERT ALL
  INTO seer_gold.pipeline_run_events VALUES ('RUN-SILVER-20260714','STANDARDIZE_AND_RECONCILE','ALH Data Transforms','VALIDATE_SUPPLIER_CERTIFICATIONS','WARNING','Two supplier records were quarantined pending current certification evidence',TIMESTAMP '2026-07-14 00:23:00 UTC')
  INTO seer_gold.pipeline_run_events VALUES ('RUN-BRONZE-20260714','REGISTER_SOURCE_EXTRACTS','ALH Data Studio','VALIDATE_CSV_HEADERS','WARNING','Source status values require Silver normalization; raw values were preserved',TIMESTAMP '2026-07-14 00:16:00 UTC')
SELECT 1 FROM dual;

INSERT ALL
  INTO seer_gold.data_product_freshness VALUES ('PROJECT_CONTEXT',TIMESTAMP '2026-07-14 00:30:00 UTC',60,'CURRENT')
  INTO seer_gold.data_product_freshness VALUES ('SUPPLIER_RECOMMENDATIONS',TIMESTAMP '2026-07-14 00:30:00 UTC',60,'CURRENT')
  INTO seer_gold.data_product_freshness VALUES ('SUPPLIER_PROFILE',TIMESTAMP '2026-07-14 00:30:00 UTC',1440,'CURRENT')
  INTO seer_gold.data_product_freshness VALUES ('DOCUMENT_CHUNKS',TIMESTAMP '2026-07-14 00:29:00 UTC',1440,'CURRENT')
SELECT 1 FROM dual;

INSERT ALL
  INTO seer_gold.data_product_columns VALUES ('PROJECT_CONTEXT',1,'PROJECT_ID','Stable enterprise identifier for the construction project','VARCHAR2(40)','N','INTERNAL')
  INTO seer_gold.data_product_columns VALUES ('PROJECT_CONTEXT',2,'PROJECT_NAME','Approved project display name','VARCHAR2(200)','N','INTERNAL')
  INTO seer_gold.data_product_columns VALUES ('PROJECT_CONTEXT',3,'ASSET_ID','Stable enterprise identifier for the physical asset','VARCHAR2(40)','N','INTERNAL')
  INTO seer_gold.data_product_columns VALUES ('PROJECT_CONTEXT',4,'ASSET_NAME','Canonical physical asset name','VARCHAR2(200)','N','INTERNAL')
  INTO seer_gold.data_product_columns VALUES ('PROJECT_CONTEXT',5,'CURRENT_MILESTONE','Most relevant reconciled schedule milestone','VARCHAR2(200)','Y','INTERNAL')
  INTO seer_gold.data_product_columns VALUES ('PROJECT_CONTEXT',6,'COMMITTED_COST','Approved purchasing commitment in USD','NUMBER(14,2)','Y','CONFIDENTIAL')
  INTO seer_gold.data_product_columns VALUES ('PROJECT_CONTEXT',7,'INSPECTION_STATUS','Latest governed inspection disposition','VARCHAR2(40)','Y','INTERNAL')
SELECT 1 FROM dual;

INSERT ALL
  INTO seer_gold.data_product_consumers VALUES ('PROJECT_CONTEXT','get_project_context','Parameterized SQL tool','1.0','APPROVED')
  INTO seer_gold.data_product_consumers VALUES ('SUPPLIER_RECOMMENDATIONS','get_supplier_recommendations','Parameterized SQL tool','1.0','APPROVED')
  INTO seer_gold.data_product_consumers VALUES ('SUPPLIER_PROFILE','get_supplier_profile','Parameterized SQL tool','1.0','APPROVED')
  INTO seer_gold.data_product_consumers VALUES ('DOCUMENT_CHUNKS','Construction policy RAG','Vector similarity search','1.0','APPROVED')
SELECT 1 FROM dual;

INSERT ALL
  INTO seer_gold.ai_readiness_assessment VALUES ('PROJECT_CONTEXT','YES','YES','YES','YES','YES','N/A','READY')
  INTO seer_gold.ai_readiness_assessment VALUES ('SUPPLIER_RECOMMENDATIONS','YES','YES','YES','YES','YES','N/A','READY')
  INTO seer_gold.ai_readiness_assessment VALUES ('SUPPLIER_PROFILE','YES','YES','YES','YES','YES','N/A','READY')
  INTO seer_gold.ai_readiness_assessment VALUES ('DOCUMENT_CHUNKS','YES','YES','YES','YES','YES','YES','READY')
SELECT 1 FROM dual;

COMMIT;
PROMPT Workshop data seeded.
EXIT SUCCESS
