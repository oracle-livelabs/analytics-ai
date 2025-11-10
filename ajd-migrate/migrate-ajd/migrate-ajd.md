# Lab 3: Migrate to Oracle Autonomous JSON Database

## Introduction

In this lab, you'll provision an Oracle Autonomous JSON Database (AJD) instance with MongoDB API enabled, build a simple CLI tool to migrate data from your source MongoDB to AJD, run the migration, and handle any basic transformations. This demonstrates a straightforward lift-and-shift approach.

> **Estimated Time:** 30 minutes

**Note:** If using Cline, it can help refine the CLI code or debug migration issues.

---

### Objectives

In this lab, you will:
- Configure your Oracle Autonomous JSON Database (AJD) MongoDB API endpoint as the target
- Build a CLI tool to transfer collections and data from "MongoDB" to Oracle AJD
- Run the migration and monitor progress
- Handle any data transformation or mapping needs

---

### Prerequisites

This lab assumes you have:
- Completed Lab 2
- Your source MongoDB URI
- An Oracle Cloud account

---

## Task 1: Provision AJD Instance

1. Log in to the Oracle Cloud Console.

2. Navigate to **Oracle Database > Autonomous AI Database**.

3. Click **Create Autonomous Database**.

4. Select **JSON Database** as the workload type.

5. Provide a display name (e.g., "ToDoAJD") and database name.

6. Set admin password and configure network access. Set access type to 'Secure access from allowed IPs and VCNs only' (add your IP to the ACL for security).

   **Note:** To get your public IP address, you can go to whatismyipaddress.com or run `curl -s ifconfig.me`.

7. Click **Create**.

Wait for the instance to provision (a few minutes).

## Task 2: Enable MongoDB API and Get Connection String

1. In the AJD details page, go to **Tool Configuration**.

2. Under **MongoDB API**, set the status to Enabled.

3. Note the connection string format:
   ```bash
   <copy>
   mongodb://<user>:<password>@<hostname>:27017/<user>?authMechanism=PLAIN&authSource=$external&ssl=true&retryWrites=false&loadBalanced=true
   </copy>
   ```

   Replace placeholders with your details. URL-encode special characters in the password (e.g., '@' as %40). Use single quotes when exporting as an environment variable.

---

## Task 3: Build the Migration CLI

1. In a new directory (e.g., `migration-cli`), initialize the project:
   ```bash
   <copy>
   mkdir migration-cli
   cd migration-cli
   npm init -y
   </copy>
   ```

2. Install dependencies:
   ```bash
   <copy>
   npm install mongodb commander cli-progress
   </copy>
   ```

3. Create `migrate.js` with the following code:
   ```javascript
   <copy>
   const { MongoClient } = require('mongodb');
   const { Command } = require('commander');
   const cliProgress = require('cli-progress');

   const program = new Command();

   program
     .requiredOption('--src <uri>', 'Source MongoDB URI')
     .requiredOption('--tgt <uri>', 'Target AJD URI')
     .requiredOption('--collection <name>', 'Source collection name')
     .option('--target-collection <name>', 'Target collection name (defaults to source name)');

   program.parse(process.argv);

   const options = program.opts();

   async function migrateCollection() {
     const srcClient = new MongoClient(options.src);
     const tgtClient = new MongoClient(options.tgt);

     try {
       await srcClient.connect();
       await tgtClient.connect();

       const srcCol = srcClient.db().collection(options.collection);
       const tgtCol = tgtClient.db().collection(options.targetCollection || options.collection);

       const count = await srcCol.countDocuments();
       console.log(`Migrating ${count} documents from ${options.collection} to ${options.targetCollection || options.collection}`);

       const bar = new cliProgress.SingleBar({}, cliProgress.Presets.shades_classic);
       bar.start(count, 0);

       const cursor = srcCol.find();
       let migrated = 0;

       while (await cursor.hasNext()) {
         const doc = await cursor.next();
         // Optional: Basic transformation (e.g., add a field if needed)
         // doc.newField = 'migrated';
         await tgtCol.insertOne(doc);
         migrated++;
         bar.update(migrated);
       }

       bar.stop();
       console.log('Migration completed successfully.');
     } catch (error) {
       console.error('Migration error:', error);
     } finally {
       await srcClient.close();
       await tgtClient.close();
     }
   }

   migrateCollection();
   </copy>
   ```

   This script uses commander for arguments, cli-progress for monitoring, and handles basic migration in batches (via cursor).

---

## Task 4: Run the Migration

**Note:** The source URI can be either a real MongoDB or AJD instance (interchangeable, as AJD mimics the MongoDB API).

1. Execute the CLI:
   ```bash
   <copy>
   node migrate.js --src 'your-mongo-uri' --tgt 'your-ajd-uri' --collection todos_source --target-collection todos_target
   </copy>
   ```

2. Monitor the progress bar and output.

---

## Task 5: Handle Transformations (Optional)

If schemas differ, modify the script in Task 3 (e.g., in the while loop, adjust `doc` before inserting). For this workshop, assume a simple 1:1 migration. Cline can be used to help with handling transformations.

---

## Troubleshooting

- **URI Encoding:** Ensure special characters are encoded.
- **Large Datasets:** Adjust batch sizes if needed (cursor handles streaming).
- **Errors:** Check connections; use `--verbose` if added to script for debugging.

You are now ready for Lab 4 to validate.

---

## Acknowledgements

**Authors**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform S&E
* **Cline**, AI Assistant

**Last Updated By/Date:**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform S&E, November 2025
