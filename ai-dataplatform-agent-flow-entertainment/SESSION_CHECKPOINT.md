
## 2026-07-07 UI Validation Progress
- Opened fresh Workbench `hol-workshop-dev-xsGdA4wd` after user completed MFA.
- Confirmed Terraform AI-feature automation succeeded in the UI: Workbench home shows **Disable AI features**.
- Validated Lab 1 workspace selection and AI Compute creation path. Created `ce_compute`; initial state was `Accepted`.
- Validated Master catalog state after automated AI-feature enablement. The Workbench already contains a generated active external catalog named `vector_db_...` connected to the ALH database.
- Attempted the previous manual `ce_ext_catalog` flow. `Choose Oracle Autonomous AI Lakehouse instance` showed the expected `hol-consteng-dev-xsGdA4wd` ALH instance, but the **Service** dropdown returned **No matches found**. Updated Lab 1/Lab 2 to use the generated `vector_db_...` catalog instead of creating `ce_ext_catalog`.
- Created active standard catalog `ce_std_catalog`, opened `default` schema, created managed volume `ce_volume`, and reached the `Upload file(s) in ce_volume` panel.
- Browser automation could open the AIDP upload panel, but the panel's **browse** link did not surface a native file chooser to automation. Requested user takeover for selecting the three DOCX files from `validation-artifacts/consteng-kb-docs`.
- Added resized/redacted Lab 1 screenshots with `-consteng` suffix under `1-data-environment-setup/images` and updated markdown references for the screenshots captured so far.
- User completed the native upload picker by dragging the extracted DOCX files into the AIDP upload panel. Verified all three files in `ce_volume`: `CE_Compliance_Certification_Guidelines.docx`, `CE_Supplier_Evaluation_Playbook.docx`, and `CE_Technical_Addendum_Risk_Triage.docx`.
- Created Knowledge Base `ce_kb` in `ce_std_catalog.default` and confirmed it became Active.
- Added data source `/Volumes/ce_std_catalog/default/ce_volume` to `ce_kb`; the Workbench started an **Update Knowledge Base** operation.
- Confirmed the **Update Knowledge Base** operation completed with status **Succeeded** in the History tab.
- Added and/or refreshed Lab 1 Construction Engineering screenshots: upload staged, upload complete, create KB, add `ce_volume` data source, and KB history succeeded. Redacted user-specific table values before writing screenshots to the workshop repo.
- Updated `1-data-environment-setup/1-data-environment-setup-consteng.md` to reference the new `-consteng` screenshots and to explicitly wait for **Update Knowledge Base** to show **Succeeded**.
- Next action: begin Lab 2 Agent Flow setup using `ce_compute`, `ce_std_catalog.default.ce_kb`, and generated external catalog `vector_db_...` for SQL access to `CONSTRUCTION_ENGINEERING`.

## 2026-07-07 Lab 2 Validation Progress
- Created `ce_agent_flow`, attached `ce_compute`, and configured `Construction_Evaluation_Agent` with region `us-ashburn-1`, model `xai.grok-4.20-reasoning`, and construction-specific agent instructions.
- Created and configured RAG tool `construction_policy_rag` against `ce_std_catalog.default.ce_kb`; optional RAG test succeeded for denial-vs-request-info guidance with citations from the uploaded DOCX knowledge base.
- Observed that drag-from-palette did not reliably instantiate Agent/SQL nodes; right-clicking the canvas and selecting the node/tool from the add menu worked. Lab 2 should document this as the reliable alternate path.
- Created first SQL tool `get_project_requirements` and selected generated catalog/schema `vector_db_holcexsgda4wd.construction_engineering`.
- Initial `get_project_requirements` query failed in AIDP Test with `Failed to fetch results: Internal Server Error` after a long wait.
- Diagnostic `SELECT 1 AS test_value FROM dual` succeeded, proving SQL tool execution and catalog/schema selection were healthy.
- Diagnostic `SELECT project_id, project_name FROM ce_projects ORDER BY project_id` succeeded and returned project names including `Downtown Mixed-Use Tower`, `Bayfront Utility Upgrade`, `Harbor Seismic Retrofit`, and `North Campus Lab Expansion`.
- Root cause found: SQL tools fail when returning raw CLOB columns. Updated/tested `get_project_requirements` query with `DBMS_LOB.SUBSTR(r.technical_spec, 1000, 1) AS technical_spec`; test with `project_name = Downtown` succeeded and returned one row with the structural steel requirement.
- Required doc fix: wrap all CLOB-returning SQL tool columns in Lab 2 with `DBMS_LOB.SUBSTR(..., 1000, 1)` or similar aliases before finalizing/testing the remaining SQL tools.

## 2026-07-07 Agent Tool Connection Finding
- User identified the key Workbench behavior: the new Agent Flow canvas does not auto-attach tool nodes to the agent. Hover near the **Tools (#)** text below the agent, click the circular connector that appears, then drag the connector line to the desired tool.
- Updated `2-agent-flow-setup/2-agent-flow-setup-consteng.md` to document the manual tool-connection step and added animated GIF `2-agent-flow-setup/images/02-agent-flows-connect-tools-consteng.gif`.
- User clarified the construction engineering workshop should use five SQL tools, not the temporary three-tool simplification. Lab 2 now has five numbered SQL tool sections: `get_project_requirements`, `get_supplier_recommendations`, `get_supplier_profile`, `get_missing_supplier_information`, and `get_project_decision_context`.
- Lab 3 and the recap now expect one RAG tool plus five SQL tools.

## 2026-07-07 Live Tool Build Progress
- Live flow currently shows **Tools (3)** connected to `construction_policy_rag`, `get_project_requirements`, and `get_supplier_recommendations`.
- Configured SQL Tool 3 `get_supplier_profile` against `vector_db_holcexsgda4wd.construction_engineering`.
- `get_supplier_profile` test passed with `supplier_name = Atlas`, returning two `Atlas Structural Fabrication` rows with `AISC Certified Fabricator` and `AWS Certified Welding Program` certification data plus performance metrics.
- Attempted to connect `get_supplier_profile` from the agent **Tools (3)** label, but the hidden connector still cannot be reliably exposed through automation. The tool remains unconnected until the manual hover-and-drag gesture is completed.
- Created SQL Tool 4 and renamed it to `get_missing_supplier_information`; description was entered. Catalog/schema and SQL query still need to be finished because the schema picker did not latch during automation.
- Next validation action: finish Tool 4 (`get_missing_supplier_information`), create Tool 5 (`get_project_decision_context`), manually connect Tools 3-5 so the agent shows **Tools (6)**, then run Playground validation.
