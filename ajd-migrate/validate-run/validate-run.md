# Lab 4: Validate and Run on Oracle AI Database

## Introduction

In this lab, you'll repoint your To-Do application's connection string to the new Oracle Autonomous JSON Database (AJD) endpoint, validate the application's functionality and data integrity, and explore some of AJD's benefits like security, scaling, and monitoring. This confirms a successful migration with improved performance and management.

> **Estimated Time:** 15 minutes

**Note:** If using Cline, it can help verify code changes or analyze performance differences.

---

### Objectives

In this lab, you will:
- Repoint the connection string in your MongoDB application to the new Oracle AJD endpoint
- Validate application functionality and data integrity on Oracle’s MongoDB API
- Explore Oracle AI Database benefits: security, scaling, and monitoring in Oracle Cloud

---

### Prerequisites

This lab assumes you have:
- Completed Lab 3
- Your AJD connection string
- The To-Do app from Lab 2 running

---

## Task 1: Repoint the Application to AJD

1. In your `todo-app` directory from Lab 2, update the environment variable to point to the target AJD instance:
   
   ```bash
   <copy>
   export SOURCE_MONGO_API_URL="$TARGET_MONGO_API_URL"
   export COLLECTION_NAME='todos_target'
   </copy>
   ```

   **Note:** This changes the connection from the source to the target AJD instance. For real MongoDB to AJD migrations, typically only the URI changes—no code edits needed, as AJD is compatible. Collections can remain the same or be specified via env for flexibility. If needed, update server.js to use process.env.SOURCE\_MONGO\_API\_URL accordingly.

2. Restart the server (with the new env set):
   ```bash
   <copy>
   node server.js
   </copy>
   ```

---

## Task 2: Validate Application Functionality

1. Open `http://localhost:3000` in your browser. You should see the previous tasks from your source Mongo instance. 

![Migrated Tasks](./images/migrated-tasks.png)

2. Test CRUD operations:
   - Add new to-do items.
   - Complete and delete items.
   - Ensure the migrated data from Lab 3 appears correctly.

3. Verify data integrity:
   - Main check: In Oracle Database Actions, run 

   ```sql 
   SELECT * FROM todos_target;
   ```
   
   compare with source data.

   - Optional: Use mongo shell or compatible client for AJD to verify documents.

---

## Task 3: Explore AJD Benefits

1. **Security:** In the Oracle Cloud Console, review AJD's security features like automatic encryption and ACLs.

2. **Scaling:** Check the database details page for auto-scaling options—AJD handles workload spikes without manual intervention.

3. **Monitoring:** View performance metrics in the console (e.g., CPU usage, storage). Note improved performance over source MongoDB for queries.

4. **Other Benefits:** AJD offers high availability, backups, and integration with Oracle AI tools for enhanced analytics.

---

## Troubleshooting

- **Connection Issues:** Double-check URI encoding and ACL (add your IP if needed).
- **Data Discrepancies:** Re-run migration if issues; verify with queries.
- **Performance:** If slower, ensure optimal indexing (AJD auto-manages many aspects).

**Congratulations!** You've successfully migrated and validated your app on AJD, benefiting from Oracle's performance and scalability.

---

## Acknowledgements

**Authors**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform S&E

**Contributors**
* **Cline**, AI Assistant
* **Kaushik Kundu**, Master Principal Cloud Architect, ONA Data Platform S&E

**Last Updated By/Date:**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform S&E, November 2025
