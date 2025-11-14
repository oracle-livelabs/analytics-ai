# Lab 5: Build Migration CLI and Migrate

## Introduction

In this lab, you'll build a simple CLI tool to migrate data from your source collection in AJD to a target collection in the same instance, run the migration, and handle any basic transformations. This demonstrates a straightforward lift-and-shift approach within AJD.

> **Estimated Time:** 30 minutes

**Note:** If using Cline, it can help refine the CLI code or debug migration issues.

---

### Objectives

In this lab, you will:
- Use the existing AJD as both source and target
- Build a CLI tool to transfer collections and data
- Run the migration and monitor progress
- Handle any data transformation or mapping needs

---

### Prerequisites

This lab assumes you have:
- Completed Lab 4
- Your AJD URI from Lab 2
- The To-Do app data in 'todos' collection

---

## Task 1: Build the Migration CLI

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
     .requiredOption('--uri <uri>', 'AJD URI (used for both source and target)')
     .requiredOption('--source-collection <name>', 'Source collection name')
     .requiredOption('--target-collection <name>', 'Target collection name');

   program.parse(process.argv);

   const options = program.opts();

   async function migrateCollection() {
     const client = new MongoClient(options.uri);
     try {
       await client.connect();
       const db = client.db();

       const srcCol = db.collection(options.sourceCollection);
       const tgtCol = db.collection(options.targetCollection);

       const count = await srcCol.countDocuments();
       console.log(`Migrating ${count} documents from ${options.sourceCollection} to ${options.targetCollection}`);

       const bar = new cliProgress.SingleBar({}, cliProgress.Presets.shades_classic);
       bar.start(count, 0);

       const cursor = srcCol.find();
       let migrated = 0;

       while (await cursor.hasNext()) {
         const doc = await cursor.next();
         // Optional: Basic transformation (e.g., add a field)
         // doc.migrated = true;
         await tgtCol.insertOne(doc);
         migrated++;
         bar.update(migrated);
       }

       bar.stop();
       console.log('Migration completed successfully.');
     } catch (error) {
       console.error('Migration error:', error);
     } finally {
       await client.close();
     }
   }

   migrateCollection();
   </copy>
   ```

   This script uses the same URI for source and target, migrating between collections.

---

## Task 2: Run the Migration

1. Execute the CLI:
   ```bash
   <copy>
   node migrate.js --uri 'your-ajd-uri' --source-collection todos --target-collection todos_target
   </copy>
   ```

2. Monitor the progress bar and output.

---

## Task 3: Handle Transformations (Optional)

If needed, modify the script in Task 1 (e.g., in the while loop, adjust `doc` before inserting). For this workshop, assume a simple 1:1 migration. Cline can assist with custom transformations.

---

## Troubleshooting

- **URI Encoding:** Ensure special characters are encoded.
- **Large Datasets:** The cursor handles streaming for efficiency.
- **Errors:** Check connections; add logging if needed for debugging.

You are now ready for Lab 6 to validate and explore.

---

## Acknowledgements

**Authors**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform S&E

**Contributors**
* **Cline**, AI Assistant

**Last Updated By/Date:**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform S&E, November 2025
