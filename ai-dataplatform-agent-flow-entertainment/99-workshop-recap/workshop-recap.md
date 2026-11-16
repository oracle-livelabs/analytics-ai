# Workshop Recap

## Introduction

You built a Release & Performance Analyst Agent for entertainment teams. The agent combines database facts with internal release and measurement guidance to explain box office performance and streaming engagement.

**Estimated Time:** 5 Minutes

### Objectives

In this recap, you will:

* Review the components of the Entertainment Release & Performance Analyst Agent.
* Explain how SQL evidence and retrieved policy support the workshop scenarios.
* Identify extensions and production-readiness checks for this pattern.

## What You Built

| Component | Purpose |
| --- | --- |
| `ent_ext_catalog` / `ENTERTAINMENT` | Read-only tool queries against the seeded Entertainment database |
| `ent_std_catalog.default.ent_volume` | Three internal release, measurement, and distribution documents |
| `ent_std_catalog.default.ent_kb` | Semantic retrieval over those documents |
| `ent_compute` | Runtime for agent testing and deployment |
| Chat Trigger and `Analyst_Agent` | Conversation entry point and Executor Agent |
| One RAG tool and four SQL tools | Policy guidance, box office, streaming, title lookup, and market lookup |

## What You Accomplished

1. **Data environment:** Used the AI-enabled Workbench, created the Entertainment catalogs and volume, and confirmed successful Knowledge Base ingestion. The Terraform stack prepared the database and AI-feature attachment; the Knowledge Base remains a separately validated catalog asset.
2. **Agent flow:** Connected the Chat Trigger, configured the Executor Agent, and explicitly connected the RAG tool and all four SQL tools.
3. **Validation:** Resolved a misspelled movie title, retained context for a Canadian-market follow-up, compared matching streaming weeks, retrieved internal policy, and combined the policy with SQL evidence.
4. **Deployment:** Deployed the tested flow and retrieved its chat endpoint. External callers still need the supported authentication and request contract for that deployment.

## What the Scenarios Teach

- Gross and rank answer different questions. Skyline Heist ranks higher in the recorded Canadian weekends while Neon Knights has the higher two-week gross across its own release window. These are different dates, not a same-week comparison or lifetime totals.
- Reach and engagement can diverge. Cosmic Kitchen has more US starts, but its completion declines; Maple Street has fewer starts and improving completion.
- Policy determines the escalation condition. With the hybrid scenario's explicit top-three-region assumption, Cosmic Kitchen's 44% and 40% completion in two consecutive weeks meets the documented below-45% rule.
- An observed trend does not establish its cause. The agent should not claim that a campaign caused a change when no campaign tool or causal evidence supports that claim.
- Historical sample dates stay historical. Latest available sample weeks are not the current calendar weeks.

## Value for Entertainment Teams

Marketing teams can examine reach and engagement alongside release guidance. Finance and distribution teams can compare reported box office figures without inventing missing forecasts or lifetime totals. Content strategy teams can distinguish growing starts from healthy completion and identify when the internal playbook calls for escalation.

The shared interface brings policy interpretation and structured evidence into the same conversation. Its usefulness depends on clear tool boundaries, successful retrieval, and careful interpretation of the returned data.

## Extend the Pattern

Marketing campaign and spend tables are included in the sample database, but the core workshop does not create campaign, channel, or ROI SQL tools. A future exercise could add those tools and test the playbook's attribution and ROI definitions. Other extensions include document-version governance, additional territories, retrieval evaluation, and integration with internal applications.

Before using the pattern in production, evaluate access controls, retrieval quality, endpoint authentication, monitoring, cost, data freshness, and failure recovery. Completing this workshop demonstrates the pattern; it does not substitute for those production checks.

## Learn More

* [Oracle AI Data Platform documentation](https://docs.oracle.com/en/cloud/paas/ai-data-platform/)
* [Oracle AIDP sample agent flows](https://github.com/oracle-samples/oracle-aidp-samples/tree/main/ai/agent-flows)

## Acknowledgements

* **Author(s)** - Jean-Rene Gauthier [AIDP]
* **Contributors** - Eli Schilling, Cloud Architect; Gareth Nathan, SDE, GenAI
* **Last Updated By/Date** - Eli Schilling, October 2026
