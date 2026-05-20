# Lab 5: Build a Compute Wingmate Agent

## Introduction

This lab is a placeholder for the Compute Wingmate Agent. The final lab will guide learners through creating compute-focused APEX pages and agent prompts using Resource Analytics compute data, curated materialized views, and any supporting synthetic or REST API data approved by the workshop SMEs.

> **SME Review Gate:** This lab is intentionally not executable yet. Provide the exact APEX steps, SQL sources, materialized views, screenshots, assistant prompt, page items, validation queries, and expected outputs before publishing this lab as learner-ready content.

Estimated Time: TBD

### Objectives

In this lab, you will:

* Build a Compute Wingmate Agent page in APEX
* Use Resource Analytics compute data as the primary source
* Configure compute-focused dashboard regions and assistant context
* Validate the agent response against compute inventory and utilization data

### Prerequisites

* Completed Labs 1 through 4
* Access to the `WINGMATE` APEX application
* `OCI_GENAI` Generative AI service object created in APEX
* Resource Analytics compute materialized views reviewed and created
* SME-approved Compute Wingmate source SQL and APEX page design

## Task 1: Confirm Compute Wingmate Data Sources

> **SME TODO:** Provide the exact source objects and SQL queries for this task.

Candidate source areas for SME review:

* Resource Analytics compute instance views
* Resource Analytics compute facts or utilization views
* Instance volume relationship views
* Compartment and tenancy reference views
* Synthetic compute or host-insights tables, if needed
* Optional REST API or ShowOCI data, if approved

Sample review query:

```sql
<copy>
SELECT view_name
FROM all_views
WHERE owner = 'OCIRA'
AND (
       view_name LIKE 'COMPUTE\_%' ESCAPE '\'
    OR view_name = 'INSTANCE_VOLUME_DETAILS_V'
)
ORDER BY view_name;
</copy>
```

## Task 2: Build the Compute Wingmate APEX Page

> **SME TODO:** Provide the final APEX page layout, page name, screenshots, region types, SQL source queries, and component settings.

The final version of this task should explain how to:

1. Create or copy an APEX page for Compute Wingmate.
2. Add compute inventory and operational insight regions.
3. Configure report or chart regions using approved compute source objects.
4. Add hidden page items for assistant context if required.
5. Save and run the page.

## Task 3: Configure the Compute Wingmate Agent Prompt

> **SME TODO:** Provide the exact prompt, context item names, and expected assistant behavior.

The final version of this task should explain how to:

1. Select the `OCI_GENAI` service created in Lab 2.
2. Configure the **Show AI Assistant** action.
3. Attach compute context from approved APEX page items or SQL queries.
4. Set the welcome message and prompt examples.

Draft prompt pattern for SME review:

```text
<copy>
You are OCI Compute Wingmate, an assistant for OCI compute operations and capacity review. Answer questions using the application's loaded Resource Analytics compute data. Be concise, explain operational impact, and call out missing data instead of guessing.
</copy>
```

## Task 4: Validate Compute Wingmate

> **SME TODO:** Provide validation questions, expected data points, and screenshots.

The final version of this task should validate:

1. Compute inventory regions render with the expected data.
2. Charts or reports match approved SQL results.
3. The assistant answers compute questions from the configured context.
4. The assistant identifies missing data instead of guessing.

## Acknowledgements

* **Authors:**
	* Royce Fu - Master Principal Cloud Architect
* **Last Updated by/Date** - Royce Fu, May 2026
