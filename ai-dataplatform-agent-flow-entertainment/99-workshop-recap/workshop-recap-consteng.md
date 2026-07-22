# Workshop Recap

## Introduction

Over the course of this workshop, you went from a blank canvas to a production-deployed AI agent that serves construction engineering procurement, project management, and quality teams. This recap summarizes what you built and how the pattern helps teams make faster, more consistent supplier decisions.

**Estimated Time:** 5 Minutes

### Objectives - What You Built

In four labs, you designed, configured, tested, and deployed a **Construction Procurement Evaluation Agent**. The agent answers natural language questions about supplier fit, project requirements, missing documentation, compliance blockers, and recommended next actions by combining:

- **RAG** over construction supplier evaluation, compliance, certification, and technical addendum guidance.
- **SQL tools** over governed Oracle AI Database tables containing projects, requirements, suppliers, certifications, performance history, recommendations, supporting documents, and decision records.

## What You Accomplished - Lab by Lab

### Workshop Introduction and Overview

You established the construction engineering context: supplier decisions depend on structured data and unstructured documents, and teams need consistent evaluation across project, procurement, quality, and executive stakeholders.

### Lab 1: Data Environment Setup

You prepared the data assets that power the agent:

- Created an AI Compute.
- Created external and standard catalogs.
- Uploaded construction guidance documents to a managed volume.
- Created and populated a Knowledge Base.
- Verified construction engineering database tables.

### Lab 2: Agent Flow Setup

You built the agent on the visual canvas:

- Created the agent flow and configured the Executor Agent node.
- Added a RAG tool connected to the Knowledge Base.
- Added three SQL tools for project context, supplier recommendations, and supplier profile.

### Lab 3: Validate the Agent Flow

You tested the agent across realistic scenarios:

- Project recommendation evidence for Downtown Mixed-Use Tower.
- Supplier profile evidence for Atlas Structural Fabrication.
- Procurement and compliance guidance from the construction knowledge base.
- SQL-backed project and supplier facts combined with RAG-based policy context.

### Lab 4: Deploy the Agent Flow

You deployed the agent to production:

- Deployed the flow to AI Compute.
- Retrieved the Chat endpoint URL.
- Reviewed the REST API consumption model.

## The Value Proposition

### For Project Managers

The agent brings supplier fit, schedule risk, and documentation status into one conversation. A project manager can ask which supplier is ready for approval and receive evidence tied to the project requirement.

### For Procurement Teams

The agent turns fragmented qualification data into clear next actions: approve, request information, deny, or issue a new RFP. It helps procurement teams avoid awarding work when critical evidence is missing.

### For Quality and Compliance Teams

The agent applies consistent rules for certifications, unresolved NCRs, safety score, delivery history, and technical addenda. It can explain why a supplier is blocked and what evidence is required to continue.

### For the Organization

The agent improves consistency. Different reviewers can ask the same question and receive answers grounded in the same database records and the same internal policy documents.

## How This Accelerates ROI

### 1. Faster Supplier Decisions

Supplier evaluation can move from manual reconciliation to a natural language workflow that retrieves project facts, supplier evidence, and policy guidance in seconds.

### 2. Reduced Risk Exposure

The agent makes missing certifications, unresolved NCRs, overloaded capacity, and incomplete technical addenda visible before they become project delivery issues.

### 3. Self-Service Decision Support

Business users do not need to know SQL or search multiple document repositories. They can ask the agent and receive a grounded answer with evidence and next action.

### 4. Governance Without Friction

The agent uses governed database access and authoritative knowledge base documents. Answers remain traceable to tool calls and retrieved passages.

### 5. Expandable Pattern

The same approach can expand to subcontractor prequalification, change-order risk, safety incident review, RFI triage, project controls, and claims support.

## What's Next

- Add SQL tools for cost variance, schedule slippage, RFIs, change orders, and safety incidents.
- Expand the knowledge base with project specifications, contract clauses, inspection procedures, and supplier manuals.
- Build specialized agents for procurement, quality, safety, and project controls.
- Integrate the deployed endpoint with dashboards, Slack, Oracle Analytics Cloud, or Oracle Digital Assistant.

## Learn More

* [Oracle AI Data Platform - Product Page](https://www.oracle.com/ai-data-platform/)
* [Oracle AI Data Platform Workbench - Product Page](https://www.oracle.com/ai-data-platform/workbench/)
* [Oracle AI Data Platform - Documentation](https://docs.oracle.com/en/cloud/paas/ai-data-platform/)
* [Oracle AI Data Platform - Sample Notebooks and Agent Flows on GitHub](https://github.com/oracle-samples/oracle-aidp-samples)

## Acknowledgements

* **Author** - Eli Schilling, Cloud Architect || Evangelist
* **Contributors** - ONA Lab Engineering team
* **Last Updated By/Date** - Eli Schilling, July 2026
