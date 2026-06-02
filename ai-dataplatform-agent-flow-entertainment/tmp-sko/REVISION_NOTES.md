# SKO27 AIDP Workbench Essentials Revision Notes

### Objectives

In this lab, you will:
* TODO: Add objectives


Estimated Time: TODO - x minutes


Generated during validation on 2026-06-01 and updated after live Labs 1-3 validation on 2026-06-02.

## Preview

- Revised local preview: `http://127.0.0.1:4174/workshops/sko27-essentials/index.html`
- Revision bundle root: `C:\Users\Eli\Documents\Codex\automated-workshop-validation\outputs\sko27-essentials-revisions`

## How to Move These Changes

Copy the contents of this bundle into the `ai-dataplatform-agent-flow-entertainment` repo root. The revised manifest points at new `tmp-sko/*-sko27.md` files so the original published/common Markdown sources do not need to be edited directly.

## Files

- `workshops\sko27-essentials\manifest.json`
- `workshops\sko27-essentials\index.html`
- `tmp-sko\cloud-login-livelabs2-sko27.md`
- `tmp-sko\6-green-button-alternate-lab1-sko27.md`
- `tmp-sko\2-create-medallion-architecture-sko27.md`
- `tmp-sko\3-create-workflows-sko27.md`
- `tmp-sko\7-create-connector-to-oac-green-button-sko27.md`
- `tmp-sko\5-create-connector-to-fdi-sko27.md`
- `tmp-sko\images\...`
- `tmp-sko\screenshots\...`
- `notebooks\3_silver_transformation_continent.ipynb`
- `notebooks\4_silver_transformation_summary.ipynb`
- `notebooks\5_Gold_join.ipynb`
- `notebooks\6_gold_job_into_DB.ipynb`

## Changes Made

- Updated the manifest to use local revised Markdown copies for Get Started and Labs 1-5.
- Removed the duplicate trailing `Need Help?` manifest entry.
- Fixed the Get Started typo `Clink this link` to `Click this link`.
- Fixed Lab 1 role names so `AI_DATA_PLATFORM_ADMIN` renders with underscores.
- Fixed Lab 1 standard catalog name to lowercase `supplier`, matching the notebook references.
- Added Lab 1 guidance to press **Enter** when renaming the external catalog to `supplier_external_26ai`.
- Added Lab 1 model availability guidance after checking `default.oci_ai_models` in the live Workbench.
- Verified the downloadable lab zip and corrected notebook filenames in Labs 2 and 3:
  - `1_Create_Bronze_Tier.ipynb`
  - `2_silver_transformation.ipynb`
  - `3_silver_transformation_continent.ipynb`
  - `4_silver_transformation_summary.ipynb`
  - `5_Gold_join.ipynb`
  - `6_gold_job_into_DB.ipynb`
- Fixed Lab 2 numbering, `noteboooks`, and `fine grain`.
- Added Lab 2 prerequisites for the lowercase `supplier` source tables and the `supplier_external_26ai` external catalog.
- Added Lab 2 guidance to attach `Medallion_Compute` to each notebook when the notebook opens with no cluster attached.
- Revised the Silver AI notebooks to use `cohere.command-r-08-2024`; `xai.grok-3` was not available in the validated reservation.
- Added a revised `5_Gold_join.ipynb` with empty trailing code cells removed; the original notebook can cause Workflows to remain running after visible notebook output completes.
- Fixed Lab 3 heading grammar, task numbering, `Summery`, missing Gold nested-task instruction, **Nested job task** UI label, Daily schedule default, and `Medallion_Job` breadcrumb mismatch.
- Fixed Lab 4 task order from `1, 3, 2` to `1, 2, 3`, OAC prerequisite wording, and catalog casing to `supplier_external_26ai`.
- Fixed Lab 5 wording issues: `a the admin console`, `In theEdit Connection`, and a redundant wait-time sentence.
- Converted published-lab image links in local copies to absolute Oracle LiveLabs URLs so the local copies render without copying those published image folders.
- Cleaned screenshot callouts so no local image uses more than four red boxes; simplified `tmp-sko\images\configure-catalog-db-access.png`.

## Validation Notes

- Original manifest rendered locally at `http://127.0.0.1:4173/workshops/sko27-essentials/index.html`.
- Revised manifest rendered locally at `http://127.0.0.1:4174/workshops/sko27-essentials/index.html`.
- Browser checks confirmed the duplicate `Need Help?` entry is gone, Lab 3 task heading and notebook filename fixes render, Lab 4 task order renders as `1, 2, 3`, and Lab 5 copy fixes render.
- Live Workbench execution resumed in `LL207487-AIDP` after user login.
- Lab 2 Task 2 completed end to end in workspace `Medallion_Arch` using compute cluster `Medallion_Arch (Active)`.
- Verified Master Catalog outputs:
  - `bronze_supplier.supplier_schema`: `bronze_supplier_basic_csv`, `bronze_supplier_feedback_csv`.
  - `silver_supplier.supplier_schema`: `silver_supplier_basic_csv`, `silver_supplier_basic_cont_csv`, `silver_supplier_basic_ai_csv`, `silver_supplier_feedback_ai_csv`, `silver_supplier_feedback_ai_join_csv`.
  - `gold_supplier.supplier_schema`: `gold_supplier_feedback_ai_join_csv`.
  - `supplier_external_26ai.admin`: `gold_supplier_feedback`.
- The final external table query returned 6 rows in `Gold/6_gold_job_into_DB.ipynb`.
- 2026-06-02 live validation in reservation `207612` completed Labs 1-3 using the revised local bundle as the source of truth.
- Workbench `LL207612-AIDP`, workspace `Medallion_Arch`, and compute cluster `Medallion_Compute` were used for the full pass.
- Standalone workflows passed:
  - `Bronze_Workflow`: success.
  - `Silver_Workflow`: success with revised Cohere model notebooks.
  - `Gold_Workflow`: first run hung with the original `5_Gold_join.ipynb`; after uploading the revised notebook with overwrite enabled, run `7d2084e6-cd70-445d-aa01-5635d04029a9` succeeded.
- Unified `Medallion_Workflow` passed on Tuesday, June 2, 2026:
  - `Bronze_Tier` succeeded.
  - `Weekday_Condition` evaluated true and succeeded.
  - `Silver_Tier` succeeded.
  - `Gold_Tier` succeeded.
  - Parent run key: `0fb40d67-4501-40d6-805a-60d08f56da4c`.
- Graph and Timeline views rendered for the successful unified run.
- A daily schedule was created. The saved schedule uses UTC and was verified through the Workbench API as `50 30 9 * * ?`, `UNPAUSED`.
- The schedule form defaulted to **Weekly** during validation, so the instructions now explicitly tell attendees to change **Frequency** to **Daily**.
- The optional OAC lab was not tested per Eli's instruction.
- Screenshot QA pass: no copied output image currently exceeds the 3-4 red callout guideline.

## Acknowledgements

* **Author** - TODO: Your Name, Your Title, Your Organization
* **Last Updated By/Date** - TODO: Your Name, Month Year
