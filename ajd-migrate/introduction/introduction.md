# Introduction

## About this Workshop

Welcome to **MongoDB Migration – Lift & Shift to Oracle AI Database**!  
This hands-on workshop is designed for MongoDB developers looking to migrate their applications to Oracle Autonomous JSON Database (AJD) for improved performance, scalability, security, and ease of management. You'll start with a simple CRUD To-Do list application running on a MongoDB-compatible AJD instance, prepare and analyze your data, migrate it using a custom CLI tool you build, and validate the app on AJD via its MongoDB-compatible API. This demonstrates a straightforward "lift and shift" migration with minimal changes.

You'll learn how to:
- Set up and analyze a source MongoDB database (AJD)
- Build a simple CLI for data migration
- Provision source/target AJD and migrate data
- Repoint your app to target AJD and explore its benefits

> **Estimated Workshop Time:** 1-2 hours

**Note:** The source database used in this lab is an AJD instance; however a mongoDB instance can be used instead. 

**Note:** Throughout this workshop, Cline (an optional AI assistant) can help review code, suggest optimizations, or troubleshoot—simply ask!

---

### Objectives

By completing this workshop, you will:
- Understand how to prepare and migrate data from MongoDB-compatible source AJD to target AJD
- Build and use a custom CLI for migration
- Validate application functionality on AJD
- Explore AJD benefits like auto-scaling, security, and monitoring

**Architecture Overview:**  
The workshop starts with a "MongoDB" source database running a To-Do app. You'll build a CLI to migrate data to AJD, then repoint the app to AJD's MongoDB API endpoint.

---

### Prerequisites

This workshop assumes you have:
- An Oracle Cloud account
- Basic knowledge of Node.js and MongoDB
- Node.js (v18+) and NPM installed
- Access to a MongoDB instance (instructions provided for setup)
- Familiarity with command-line tools

**Note:** Ensure your Node.js version is at least v18 (ideally v24 for compatibility with dependencies). You can check with `node -v`. If lower, update or use a version manager like nvm to switch (e.g., `nvm install 24 && nvm use 24`). Run this before proceeding to npm init or install to avoid compatibility warnings.

---

## Labs Overview

- **Lab 1: Set Up Cline** (Optional) - Install and configure Cline AI assistant in VS Code.
- **Lab 2: Prepare Source and Discover Data** - Set up and verify your MongoDB source, review schema, and plan migration.
- **Lab 3: Migrate to Oracle Autonomous JSON Database** - Provision AJD, build and run a CLI to migrate data.
- **Lab 4: Validate and Run on Oracle AI Database** - Repoint the app, validate, and explore AJD benefits.

---

## Learn More

* [Oracle Autonomous JSON Database Documentation](https://docs.oracle.com/en/cloud/paas/autonomous-json-database/index.html)
* [MongoDB API in AJD](https://docs.oracle.com/en/database/oracle/mongodb-api/mgapi/overview-oracle-database-api-mongodb.html#GUID-D1F0C555-73AE-4263-B59C-448925B963A8)
* [Node.js MongoDB Driver](https://www.mongodb.com/docs/drivers/node/current/)

---

## Acknowledgements

**Authors**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform S&E

**Contributors**
* **Cline**, AI Assistant

**Last Updated By/Date:**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform S&E, November 2025
