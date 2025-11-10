# Lab 2: Prepare Source and Discover Data

## Introduction

In this lab, you'll set up an Oracle Autonomous JSON Database (AJD) instance as your source database (simulating MongoDB), deploy a simple To-Do list application on it, insert sample data via the UI, review the schema and collections in Oracle SQL Web, and use tools to analyze and plan your migration to a target collection in the same AJD instance. This step ensures you understand your data before migrating.

> **Estimated Time:** 20-30 minutes

**Note:** If you're using Cline (from Lab 1), it can help generate code snippets or troubleshoot setup issues.

---

### Objectives

In this lab, you will:
- Set up and verify an AJD source database
- Deploy and run the To-Do app on AJD
- Review and understand the application schema and collections in Oracle SQL Web
- Use Oracle Code Assist and MongoVibeAssist_Migrator to analyze your source environment and plan the migration

---

### Prerequisites

This lab assumes you have:
- Completed Lab 1 (optional)
- Node.js and NPM installed
- An Oracle Cloud account with AJD provisioned (from Lab 1 or separately)
- Basic command-line familiarity

---

## Task 1: Set Up AJD Source Database

**Note:** This lab uses AJD as both source and target for demonstration purposes, but a real MongoDB instance can be swapped interchangeably for the source.

1. If you don't already have your own MongoDB instance, provision a new AJD instance in Oracle Cloud Console (see Lab 3 for details if needed). If using your own MongoDB, gather its connection details (URI) instead.

2. Enable MongoDB API in Tool Configuration (for AJD).

3. Get the connection URI from the console (for AJD) or your MongoDB setup.

4. Ensure your IP is in the ACL for access (for AJD).

---

## Task 2: Deploy the Sample To-Do App on AJD

1. Create a project directory:
   ```bash
   <copy>
   mkdir todo-app
   cd todo-app
   </copy>
   ```

2. Initialize NPM:
   ```bash
   <copy>
   npm init -y
   </copy>
   ```

3. Install dependencies:
   ```bash
   <copy>
   npm install express mongodb
   </copy>
   ```

4. Create `server.js`:
   ```javascript
   <copy>
   const express = require('express');
   const { MongoClient, ObjectId } = require('mongodb');

   const app = express();
   const PORT = process.env.PORT || 3000;
   const MONGO_URI = process.env.MONGO_URI || 'your-ajd-uri'; // Update with your AJD URI

   app.use(express.json());
   app.use(express.static('public'));

   let db;

   async function connectDB() {
     const client = new MongoClient(MONGO_URI);
     await client.connect();
     db = client.db();
     console.log('Connected to AJD');
   }

   // CRUD endpoints for 'todos_source' collection

   app.get('/api/todos', async (req, res) => {
     const todos = await db.collection('todos_source').find().toArray();
     res.json(todos);
   });

   app.post('/api/todos', async (req, res) => {
     const todo = { text: req.body.text, completed: false };
     const result = await db.collection('todos_source').insertOne(todo);
     res.json(result.ops ? result.ops[0] : todo);
   });

   app.put('/api/todos/:id', async (req, res) => {
     const result = await db.collection('todos_source').updateOne(
       { _id: new ObjectId(req.params.id) },
       { $set: { completed: true } }
     );
     res.json({ modifiedCount: result.modifiedCount });
   });

   app.delete('/api/todos/:id', async (req, res) => {
     const result = await db.collection('todos_source').deleteOne({ _id: new ObjectId(req.params.id) });
     res.json({ deletedCount: result.deletedCount });
   });

   app.listen(PORT, async () => {
     await connectDB();
     console.log(`Server listening on port ${PORT}`);
   });
   </copy>
   ```

5. Create `public/index.html` (simple frontend):
   ```html
   <copy>
   <!DOCTYPE html>
   <html lang="en">
   <head>
     <meta charset="UTF-8">
     <title>To-Do List</title>
     <style>
       body { font-family: sans-serif; max-width: 600px; margin: 2em auto; }
       h1 { color: #4267b2; }
       ul { padding-left: 0; }
       li { list-style: none; margin: 1em 0; display: flex; align-items: center; }
       .completed { text-decoration: line-through; color: #888; }
       button { margin-left: 1em; }
     </style>
   </head>
   <body>
     <h1>To-Do List</h1>
     <input id="todo-input" type="text" placeholder="Add a new to-do" />
     <button onclick="addTodo()">Add</button>
     <ul id="todo-list"></ul>

     <script>
       async function fetchTodos() {
         const res = await fetch('/api/todos');
         const todos = await res.json();
         const list = document.getElementById('todo-list');
         list.innerHTML = '';
         todos.forEach(todo => {
           const li = document.createElement('li');
           li.className = todo.completed ? 'completed' : '';
           li.textContent = todo.text;

           if (!todo.completed) {
             const completeBtn = document.createElement('button');
             completeBtn.textContent = 'Complete';
             completeBtn.onclick = () => completeTodo(todo._id);
             li.appendChild(completeBtn);
           }

           const deleteBtn = document.createElement('button');
           deleteBtn.textContent = 'Delete';
           deleteBtn.onclick = () => deleteTodo(todo._id);
           li.appendChild(deleteBtn);

           list.appendChild(li);
         });
       }

       async function addTodo() {
         const input = document.getElementById('todo-input');
         const text = input.value.trim();
         if (!text) return;
         await fetch('/api/todos', {
           method: 'POST',
           headers: { 'Content-Type': 'application/json' },
           body: JSON.stringify({ text })
         });
         input.value = '';
         fetchTodos();
       }

       async function completeTodo(id) {
         await fetch('/api/todos/' + id, { method: 'PUT' });
         fetchTodos();
       }

       async function deleteTodo(id) {
         await fetch('/api/todos/' + id, { method: 'DELETE' });
         fetchTodos();
       }

       // Fetch todos when page loads
       window.onload = fetchTodos;
     </script>
   </body>
   </html>
   </copy>

6. Run the server:
   ```bash
   <copy>
   node server.js
   </copy>
   ```
   Visit `http://localhost:3000` to test.

---

## Task 3: Insert Sample Data

1. Use the app UI to add a few to-do items (e.g., "Test Task 1", "Test Task 2"). Complete or delete one to test functionality.

---

## Task 4: Review Schema and Collections

1. In Oracle Database Actions (SQL Web from AJD console):
   - Log in as ADMIN.
   - Run: SELECT * FROM todos_source;
   - Note the schema (e.g., DATA column with JSON: _id, text, completed).

2. Explore other tables if needed.

---

## Task 5: Analyze and Plan Migration

1. Use Oracle Code Assist or MongoVibeAssist_Migrator (install via npm if needed; links to docs).
   - Example: Run analysis on 'todos_source' to suggest mappings.

2. Plan: For this simple app, assume 1:1 migration to 'todos_target'. Identify any transformations if needed.

With your source data prepared in AJD, you're ready to migrate to a target collection in the same instance in Lab 3.

---

## Troubleshooting

- **Connection Errors:** Verify URI, ACL (add IP), and network access.
- **Data Insertion:** Ensure write permissions; check console logs.
- **UI Issues:** Refresh browser or restart server.

You are now ready for Lab 3 to migrate within AJD.

---

## Acknowledgements

**Authors**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform S&E
* **Cline**, AI Assistant

**Last Updated By/Date:**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform S&E, November 2025
