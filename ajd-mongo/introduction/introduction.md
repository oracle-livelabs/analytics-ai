# Introduction

## About this Workshop

Welcome to **Migrating MongoDB Workloads to Oracle Autonomous JSON Database (AJD)**!  
This hands-on workshop is designed for MongoDB developers transitioning to Oracle Autonomous JSON Database. You'll deploy a simple CRUD To-Do list application using Node.js and Express, connecting to AJD via its MongoDB-compatible API. This demonstrates AJD as a drop-in replacement for MongoDB, requiring minimal changes.

You'll learn how to:
- Provision an AJD instance with MongoDB API enabled
- Set up a Node.js/Express backend
- Build a basic frontend UI
- Deploy and run the app

> **Estimated Workshop Time:** 1 hour

**Note:** Throughout this workshop, Cline can assist by reviewing your code, suggesting optimizations, or refactoring for better scalability—simply ask!

---

### Objectives

By completing this workshop, you will:
- Understand how AJD serves as a seamless backend for MongoDB applications
- Deploy a full-stack To-Do app with CRUD operations
- Gain hands-on experience with AJD's MongoDB API compatibility

**Architecture Overview:**  
The app uses Node.js/Express for the backend, connecting to AJD via the MongoDB driver. The frontend is a simple HTML/JS interface.

---

### Prerequisites

This workshop assumes you have:
- An Oracle Cloud account
- Basic knowledge of Node.js and MongoDB
- Node.js (v18+) and NPM installed
- Familiarity with command-line tools

**Note:** Ensure your Node.js version is at least v18 (ideally v24 for compatibility with dependencies). You can check with `node -v`. If lower, update or use a version manager like nvm to switch (e.g., `nvm install 24 && nvm use 24`). Run this before proceeding to npm init or install to avoid compatibility warnings.

---

## Learn More

* [Oracle Autonomous JSON Database Documentation](https://docs.oracle.com/en/database/oracle/autonomous-database-serverless/)
* [MongoDB API in AJD](https://docs.oracle.com/en/database/oracle/autonomous-database-serverless/adbsb/mongodb-api.html)
* [Node.js MongoDB Driver](https://www.mongodb.com/docs/drivers/node/current/)

---

## Acknowledgements

**Authors**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform

**Last Updated By/Date:**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform, November 2025
