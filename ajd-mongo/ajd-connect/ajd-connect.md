# Connect to Oracle Autonomous JSON Database (AJD)

## Introduction

In this lab, you'll provision an Oracle Autonomous JSON Database (AJD) instance and enable its MongoDB-compatible API. This allows your MongoDB applications to connect seamlessly, treating AJD as a drop-in replacement.

> **Estimated Time:** 15 minutes

**Note:** Cline can help automate provisioning scripts or troubleshoot connection issues—let me know if you need assistance!

---

### Objectives

In this lab, you will:
- Create an AJD instance in Oracle Cloud
- Enable the MongoDB API
- Obtain the connection string for your app

---

### Prerequisites

This lab assumes you have:
- Completed the Introduction lab
- An active Oracle Cloud account with permissions to create databases

---

## Task 1: Provision AJD Instance

1. Log in to the Oracle Cloud Console.

2. Navigate to **Oracle Database > Autonomous Database**.

3. Click **Create Autonomous Database**.

4. Select **JSON Database** as the workload type.

5. Provide a display name (e.g., "ToDoAJD") and database name.

6. Set admin password and configure network access (add your IP to the ACL for security).

7. Click **Create**.

Wait for the instance to provision (a few minutes).

## Task 2: Enable MongoDB API

1. In the AJD details page, go to **More Actions > Database Actions**.

2. Under **Development**, select **MongoDB API**.

3. Enable the API if not already active.

4. Download the connection string or note it down.

The connection string format is:
```bash
<copy>
mongodb://<user>:<password>@<hostname>:27017/<user>?authMechanism=PLAIN&authSource=$external&ssl=true&retryWrites=false&loadBalanced=true
</copy>
```

Replace placeholders with your details. URL-encode special characters in the password.

## Task 3: Test Connection (Optional)

You can test the connection using a MongoDB client like mongo shell:

```bash
<copy>
mongo "your-connection-string"
</copy>
```

**Note:** If you encounter connection issues, Cline can suggest debugging steps or code adjustments.

You are now ready to proceed to the next lab to set up the Node.js/Express backend.

---

## Acknowledgements

**Authors**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform

**Last Updated By/Date:**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform, November 2025
