# Entertainment Event: Facilitator Checks

Use these checks with the updated Entertainment Terraform package and sandbox guide. These are deterministic fixture expectations, not a record of a completed live agent test. Response wording and tool-call order can vary, but returned values and policy interpretation should agree.

## Environment Gates

- Fresh Entertainment stack; database display name begins `hol-entertainment-`.
- AI enablement work request succeeded against that database.
- `ENTERTAINMENT` schema login uses `schema_user_password`; ADMIN uses `adb_admin_password`.
- Six seeded tables: 5 titles, 5 markets, 30 box-office rows, 105 streaming rows, 3 campaigns, and 600 spend rows.
- Three Knowledge Base documents ingested successfully, followed by a successful retrieval test.
- Chat Trigger connected to `Analyst_Agent`; one RAG and four SQL tools connected; AI Compute Active.

## Box Office and Follow-Up

| Title | ID | US two-week gross | Canada two-week gross | Recorded weekends |
| --- | --- | --- | --- | --- |
| Skyline Heist | T1001 | $60.7M | $7.5M | September 14 and 21, 2025 |
| Neon Knights | T1005 | $70.2M | $8.8M | December 7 and 14, 2025 |

The typo `skyline hiest` should resolve through `get_title_id`, not an invented title. On the follow-up, preserve the titles and switch to `CA`. Skyline ranks 1 on both Canada rows; Neon ranks 3 on both. These are each title's first two recorded weekends, across different release windows. They are not lifetime grosses or simultaneous market rankings.

## Latest Four Available US Streaming Weeks

| Week start | Cosmic starts | Cosmic completion | Maple starts | Maple completion |
| --- | ---: | ---: | ---: | ---: |
| 2025-10-27 | 140,000 | 55% | 36,000 | 60% |
| 2025-11-03 | 160,000 | 50% | 38,000 | 64% |
| 2025-11-10 | 180,000 | 44% | 40,000 | 68% |
| 2025-11-17 | 200,000 | 40% | 42,000 | 72% |

Cosmic has stronger reach and declining completion; Maple has fewer starts and improving completion. Neither comparison establishes why the trends occurred. A value of `0.44` is 44%, not 0.44% or 44 starts.

## RAG and Hybrid Checks

The Content Strategy & Release Operations Playbook defines completion as completed starts / total starts for the week and region. Escalation requires completion below 45% for two consecutive weeks in a top-three region. There are no numerical green/yellow/red bands or numerical genre benchmarks in these documents; a response should say so rather than inventing them.

The hybrid prompt explicitly treats US as a top-three region. Cosmic's November 10 and 17 completion rates meet the threshold on consecutive weeks, so escalation to the Release Council is supported under that assumption. Without the assumption, top-three status must be confirmed.

The structured-output test should return four date rows and two show columns with percentages, matching the table above.

## Failure Triage

- Accepted ingestion request plus failed background job: collect run key, timestamps, failure details, and any service Request ID. Do not assume AI Compute is the ingestion dependency.
- Empty SQL result: check catalog/schema, title/market parameters, schema password, and sample dates.
- Unsupported marketing query: agent should disclose the absent tool; seeded campaign tables alone do not expose them to the agent.
- Missing Playground tool call: verify the connector and the tool's standalone query or retrieval result.
- Endpoint copied successfully: this validates endpoint discovery only. Authentication and request/response behavior require a separate live API check.

## Pending Live Validation

Run the complete attendee journey, select the event's available model, capture accurate Entertainment screenshots, validate ingestion and all prompts, and verify deployment. Record actual timing and facilitator interventions before marking the package event-ready.
