# Workshop Recap

## Introduction

Over the course of this workshop, you went from a blank canvas to a production-deployed AI agent that serves entertainment marketing, finance, and content strategy teams. This recap summarizes what you built, connects each step to the broader Oracle AI Data Platform value proposition, and articulates how this approach accelerates ROI for entertainment companies managing title performance and marketing spend.

**Estimated Time:** 5 Minutes

### What You Built

In four labs, you designed, configured, tested, and deployed a **Release & Performance Analyst Agent** — an AI-powered assistant that answers natural language questions about movie and TV show performance by combining two capabilities:

- **RAG (Retrieval-Augmented Generation)** over internal release playbooks, marketing measurement guidelines, and distribution rules — for questions about definitions, policies, thresholds, and interpretation
- **SQL tools** that execute parameterized queries against an Oracle AI Database containing box office, streaming, and marketing campaign data — for questions about specific metrics, trends, and ROI

The agent serves cross-functional teams from a single, governed interface — eliminating the need for each team to pull data from separate systems with separate tools and separate definitions.

## What You Accomplished — Lab by Lab

### Workshop Introduction and Overview

You established the foundational context for the workshop:

- Identified the core challenge facing entertainment companies: fragmented data across dozens of systems, with marketing, finance, and distribution teams pulling from different sources with different definitions of success
- Learned how Oracle AI Data Platform unifies data lakehouse, AI/ML, analytics, and governance into a single environment on OCI
- Walked through the medallion architecture (bronze → silver → gold) using a movie release scenario — understanding how raw data flows from ingestion through transformation to business-ready analytics and AI-powered insights
- Oriented yourself in the AIDP Workbench environment, understanding the role of the Master Catalog, Workspaces, Compute, and Agent Flows

### Lab 1: Data Environment Setup

You prepared the data assets that power the agent:

- Explored the pre-configured standard catalog (`agent_assets`) and the managed volume (`entertainment_analyst`) containing release playbooks and strategy documents
- Created a **Knowledge Base** that converted those documents into vector embeddings — enabling the agent to search internal knowledge by semantic meaning, not just keywords
- Verified the **Oracle AI Database tables** containing box office, streaming, and marketing data — the structured data that powers the agent's SQL tools

### Lab 2: Agent Flow Setup

You built the agent itself on the visual canvas:

- Created an **AI Compute** to host and execute the agent flow
- Designed the **agent flow** and configured the agent node with a foundation model and detailed behavioral instructions
- Wired up a **RAG tool** connected to the Knowledge Base for policy and definition questions
- Wired up **seven SQL tools** covering box office performance, streaming health, campaign summaries, channel breakdowns, and reference lookups

### Lab 3: Validate the Agent Flow

You tested the agent across a comprehensive set of real-world scenarios:

- Multi-title box office queries with typo handling and automatic title resolution
- Market-specific follow-ups with conversational context retention
- Marketing ROI analysis with multi-tool chaining (campaign lookup → summary → channel breakdown)
- Cross-title comparative analysis and streaming performance reports
- Custom structured output formatting on demand

### Lab 4: Deploy the Agent Flow

You deployed the agent to production:

- Deployed the agent flow to an AI Compute, creating a live REST endpoint
- Retrieved the production endpoint URL for application and integration consumption
- Understood the REST API model for programmatic access, including authentication and conversational context

## The Value Proposition

### For Marketing Teams

Before this agent, answering "What was the CPA by channel for our opening weekend campaign?" required pulling data from ad platforms, cross-referencing with revenue data from a separate system, and manually computing metrics in a spreadsheet. The agent does this in seconds with a single natural language question — and grounds its interpretation in the same measurement guidelines the team is supposed to follow.

### For Finance Teams

Before this agent, building a title-level P&L with marketing ROI required reconciling data from multiple sources, waiting for reports from other teams, and debating metric definitions. The agent queries the same governed data that everyone trusts, applies the same attribution logic defined in the internal playbook, and returns answers in seconds.

### For Content Strategy and Distribution

Before this agent, understanding how a title is performing across markets required assembling data from box office trackers, streaming dashboards, and territory-specific reports. The agent provides a unified view — and can cross-reference performance data with the internal release playbook to flag green/yellow/red signals automatically.

### For the Organization

The agent doesn't just answer questions faster — it **answers them consistently**. When marketing and finance ask the same question, they get the same answer, because the agent queries the same governed data and applies the same policy-defined logic. This eliminates the "different numbers for the same title" problem that plagues cross-functional entertainment teams.

## How This Accelerates ROI

### 1. Time-to-Insight Compression

Traditional entertainment analytics workflows involve multiple handoffs: data engineering builds the pipeline, analysts build the report, and stakeholders wait days or weeks. The agent compresses this to seconds. For titles with narrow performance windows — where the difference between a strong opening weekend and a miss is measured in days, not months — this speed directly translates to faster decisions on marketing reallocation, territory expansion, and release strategy adjustments.

### 2. Reduced Tool Sprawl and Integration Cost

Entertainment companies typically stitch together 5–10 tools for data ingestion, transformation, governance, analytics, and AI. Each tool has its own licensing cost, integration overhead, and maintenance burden. Oracle AI Data Platform consolidates these into a single governed environment — reducing licensing costs, eliminating integration fragility, and freeing engineering resources for higher-value work.

### 3. Self-Service for Business Users

The agent abstracts the complexity of SQL, vector search, and data governance behind a natural language interface. Marketing managers don't need to know SQL to get campaign ROI by channel. Finance directors don't need to file a Jira ticket to get a title P&L. This shifts analytics capacity from "build me a report" to "ask the agent" — freeing data teams to focus on model development and pipeline optimization rather than ad-hoc reporting.

### 4. Governance Without Friction

Every answer the agent produces is traceable: the SQL queries it executed, the document passages it retrieved, the access controls it respected. This built-in governance meets the compliance requirements of entertainment companies managing sensitive financial data, talent contracts, and licensing terms — without adding manual audit steps or slowing down the workflow.

### 5. Incremental Expansion

The agent you built today has one RAG knowledge base and seven SQL tools. But the architecture is designed to scale. Additional tools can be added for new data sources (social sentiment, Nielsen ratings, merchandise sales). Additional knowledge bases can cover new document sets (talent contracts, competitive intelligence). Additional agents can be chained together via the A2A protocol. The initial investment in the platform and the medallion data architecture pays dividends every time a new use case is added — because the data foundation, governance, and compute are already in place.

## What's Next

- **Expand the agent's tools**: Add SQL tools for additional data sources — social engagement, audience demographics, merchandise performance, licensing revenue
- **Expand the knowledge base**: Add more internal documents — competitive landscape analyses, audience research reports, historical post-mortems
- **Build specialized agents**: Create separate agents for marketing attribution, financial forecasting, and distribution optimization — then chain them together using A2A
- **Integrate with existing workflows**: Connect the deployed endpoint to Slack, internal dashboards, Oracle Analytics Cloud, or Oracle Digital Assistant so teams can access the agent from the tools they already use
- **Automate with Workflows**: Use AIDP Workflows to automate the bronze → silver → gold data pipeline, ensuring the agent always has fresh data

## Learn More

* [Oracle AI Data Platform — Product Page](https://www.oracle.com/ai-data-platform/)
* [Oracle AI Data Platform Workbench — Product Page](https://www.oracle.com/ai-data-platform/workbench/)
* [Oracle AI Data Platform — Documentation](https://docs.oracle.com/en/cloud/paas/ai-data-platform/)
* [Oracle AI Data Platform — Sample Notebooks and Agent Flows on GitHub](https://github.com/oracle-samples/oracle-aidp-samples)
* [Getting Started on Your Oracle AI Data Platform Journey — Oracle Blog](https://blogs.oracle.com/ai-data-platform/getting-started-on-your-oracle-ai-data-platform-journey)
* [What Is the AI Data Platform? — Oracle Blog](https://blogs.oracle.com/ai-data-platform/what-is-the-ai-data-platform)
* [AIDP Workbench Essentials LiveLab — Oracle Community](https://community.oracle.com/products/oracleanalytics/discussion/27841/aidp-workbench-essentials-livelab-from-data-to-insights)

## Acknowledgements

* **Author(s)** - Jean-Rene Gauthier [AIDP]
* **Contributors** - Eli Schilling - Cloud Architect, Gareth Nathan - SDE, GenAI
* **Last Updated By/Date** - Published March 2026
