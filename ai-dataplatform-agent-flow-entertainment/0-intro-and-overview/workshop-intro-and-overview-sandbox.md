# Workshop Introduction and Overview

## Why We Need an AI Data Platform

Entertainment is a data-rich, time-poor industry. A single movie or TV show release generates data across dozens of disconnected systems — box office receipts from distributors, streaming viewership from platform APIs, media spend from Google, Meta, and TikTok, social sentiment from listening tools, Nielsen audience demographics, and a trove of internal documents like marketing playbooks, campaign briefs, post-mortem reports, and distribution agreements.

The teams who need this data — marketing, finance, content strategy, distribution — are all pulling from different sources, at different cadences, with different definitions of "success." Marketing wants to know which campaigns drove viewership. Finance wants cost-per-acquisition and ROI by title. Distribution wants performance by platform and territory. When these teams meet after a release, they often arrive with different numbers for the same title — because the data was assembled from different tools with different logic.

The typical response is to stitch together 5–10 platforms for ingestion, transformation, governance, analytics, and AI. But this creates fragile pipelines, compliance risk, and slow time-to-insight on releases that have a narrow performance window. By the time the report is ready, the window to act on it — reallocating marketing spend, adjusting a release strategy, greenlighting a sequel — may have already closed.

**Oracle AI Data Platform** addresses this by unifying data lakehouse, AI/ML, analytics, generative AI, and governance into a single environment on Oracle Cloud Infrastructure. It organizes data using a **medallion architecture** — raw data (bronze) flows through transformation (silver) into business-ready, query-optimized tables (gold) — all governed by a centralized catalog that tracks lineage, enforces access control, and supports discovery.

But the real unlock isn't just clean data. It's what you can build on top of it: **AI agents** that combine structured data queries (SQL) with intelligent retrieval over internal documents (RAG) to answer natural language questions from any team — grounded in governed data and authoritative policy documents. That's what you'll build in this workshop.

### What You'll Build

Over the course of this workshop, you will design, configure, test, and deploy a **Release & Performance Analyst Agent** — an AI-powered assistant purpose-built for entertainment teams. The agent answers natural language questions about movie and TV show performance by combining two capabilities:

- **RAG (Retrieval-Augmented Generation)** over internal release playbooks, marketing measurement guidelines, and distribution rules — so the agent can answer questions about definitions, policies, thresholds, and interpretation grounded in your actual internal documents
- **SQL tools** that execute parameterized queries against an Oracle AI Database containing box office, streaming, and marketing campaign data — so the agent can return specific metrics, trends, and ROI numbers in real time

Here's how the pieces come together across the labs:

- **Data layer**: You'll explore a pre-configured standard catalog and managed volume in the AIDP Workbench, then create a Knowledge Base that converts your internal documents into vector embeddings for semantic search. You'll also verify the Oracle AI Database tables that contain your structured performance and marketing data.

- **Agent layer**: You'll build the agent flow on a visual canvas — configuring a foundation model with detailed behavioral instructions, wiring up a RAG tool connected to the Knowledge Base, and adding seven SQL tools that cover box office performance, streaming health, campaign summaries, channel breakdowns, and reference lookups.

- **Validation layer**: You'll test the agent in the Playground with real-world scenarios — multi-title box office comparisons, market-specific follow-ups, marketing ROI with channel breakdowns, streaming trend analysis, and custom tabular output — observing how the agent reasons, selects tools, and synthesizes answers.

- **Deployment layer**: You'll deploy the agent to a production REST endpoint that applications, dashboards, and integrations can consume.

### Workshop Flow

| Lab | Title | Focus | Est. Time |
|---|---|---|---|
| **Lab 1** | Data Environment Setup | Explore the pre-configured catalog and volume; create a Knowledge Base for RAG; verify Oracle AI Database tables for SQL | 15 min |
| **Lab 2** | Agent Flow Setup | Create AI Compute; build the agent flow on the visual canvas; configure the agent node with a model and instructions; add RAG tool and seven SQL tools | 25 min |
| **Lab 3** | Validate the Agent Flow | Test the agent in the Playground across box office, streaming, marketing ROI, and cross-title comparison scenarios | 15 min |
| **Lab 4** | Deploy the Agent Flow | Deploy to a production endpoint; retrieve the URL; understand REST API consumption | 5 min |
| **Workshop Recap** | Recap and Value Proposition | Review what you built; understand the value for marketing, finance, and content strategy; explore ROI acceleration and next steps | 5 min |

### Key Concepts

| Term | Definition |
|---|---|
| **Oracle AI Data Platform (AIDP)** | A unified, governed environment on Oracle Cloud Infrastructure that brings together data lakehouse, AI/ML, analytics, and generative AI services. Announced at Oracle AI World in October 2025 and generally available. |
| **AIDP Workbench** | The development interface within AIDP — integrating notebooks, catalog management, compute, workflows, and agent flows in a single collaborative workspace. |
| **Medallion Architecture** | A data organization pattern with three progressive layers: raw data (bronze), cleaned and transformed data (silver), and curated, business-ready data (gold). Each layer increases in quality, governance, and readiness for analytics and AI. |
| **Master Catalog** | AIDP's centralized metadata repository — a "catalog of catalogs" that registers all data and AI assets, tracks lineage, enforces role-based access control, and supports discovery across the platform. |
| **Standard Catalog** | A catalog that stores data directly within AIDP (backed by OCI Object Storage and Delta Lake), as opposed to an External Catalog which connects to data outside the platform. |
| **Volume** | A storage container for unstructured data (files, documents, images) within a catalog. In this workshop, the volume holds release playbooks and strategy documents. |
| **Knowledge Base** | An AIDP construct that creates vector embeddings of documents stored in a volume. Enables semantic search — finding relevant passages by meaning, not just keywords. Powers the RAG capability of the agent. |
| **Agent Flow** | Agent flows are end-to-end agentic applications. Agent flows are defined through a graph of steps represented by nodes of different types (agents or tools). Agent flows can be defined through a no-code visual flow builder and through code via third-party libraries, such as LangGraph. |
| **AI Compute** | A managed compute resource that hosts and executes agent flows. Required for testing in the Playground and for production deployment. |
| **RAG (Retrieval-Augmented Generation)** | A technique where the agent retrieves relevant passages from internal documents before generating an answer — grounding its response in real company knowledge rather than general training data. |
| **SQL Tool** | A pre-defined, parameterized, read-only query that the agent can execute against the Oracle AI Database. The agent selects which tool to call and populates the parameters based on the user's natural language question. |
| **MCP (Model Context Protocol)** | A standard that lets AI agents securely access database data while respecting role-based access controls at the database level. |
| **ROI (Return on Investment)** | In this workshop context, the ratio of attributed revenue to marketing spend for a campaign or title — a key metric the agent computes via SQL tools. |
| **Completion Rate** | A streaming metric measuring the percentage of viewers who finish watching a title — defined in the internal playbook and queried via the agent's streaming SQL tool. |

### Objectives

By the end of this workshop, you will be able to:

1. **Explain** how Oracle AI Data Platform unifies data lakehouse, AI/ML, analytics, and governance to solve the fragmented data problem in entertainment
2. **Describe** the medallion architecture and how raw entertainment data (box office, streaming, marketing, internal documents) flows from bronze through silver to gold
3. **Create** a Knowledge Base in AIDP that converts internal documents into vector embeddings for semantic retrieval
4. **Build** an agent flow on the AIDP visual canvas — configuring a foundation model, behavioral instructions, and multiple tools (RAG + SQL)
5. **Test** an AI agent that combines RAG and SQL to answer cross-functional business questions about title performance, marketing ROI, and release strategy
6. **Deploy** an agent flow to a production REST endpoint for consumption by applications and integrations
7. **Articulate** the value proposition of an AI-powered analytics agent for entertainment teams — including time-to-insight compression, governance without friction, and self-service analytics for business users

## Learn More

* [Oracle AI Data Platform — Product Page](https://www.oracle.com/ai-data-platform/)
* [Oracle AI Data Platform Workbench — Product Page](https://www.oracle.com/ai-data-platform/workbench/)
* [What Is the AI Data Platform? — Oracle Blog](https://blogs.oracle.com/ai-data-platform/what-is-the-ai-data-platform)
* [Getting Started on Your Oracle AI Data Platform Journey — Oracle Blog](https://blogs.oracle.com/ai-data-platform/getting-started-on-your-oracle-ai-data-platform-journey)
* [Oracle AI Data Platform — Documentation](https://docs.oracle.com/en/cloud/paas/ai-data-platform/)
* [Oracle AI Data Platform — Sample Notebooks and Agent Flows on GitHub](https://github.com/oracle-samples/oracle-aidp-samples)

## Acknowledgements

* **Author(s)** - Jean-Rene Gauthier [AIDP]
* **Contributors** - Eli Schilling - Cloud Architect, Gareth Nathan - SDE, GenAI
* **Last Updated By/Date** - Published March 2026
