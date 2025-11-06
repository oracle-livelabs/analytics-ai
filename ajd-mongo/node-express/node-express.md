# Set Up Node.js/Express Backend

## Introduction

In this lab, you'll set up the Node.js/Express backend for the To-Do app, connecting it to your AJD instance using the MongoDB driver. This demonstrates how existing MongoDB code works directly with AJD.

> **Estimated Time:** 20 minutes

**Note:** Cline can review your server code for improvements, such as adding error handling or optimizing queries—just provide the code!

---

### Objectives

In this lab, you will:
- Install dependencies
- Configure the connection to AJD
- Implement CRUD operations
- Run the server

---

### Prerequisites

This lab assumes you have:
- Completed the AJD Connect lab
- Node.js and NPM installed
- Your AJD connection string

---

## Task 1: Create Project Directory

1. Create a new directory for your app:

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

## Task 2: Install Dependencies

Install Express and MongoDB driver:

```bash
<copy>
npm install express mongodb dotenv
</copy>
```

## Task 3: Create server.js

Create a file named `server.js` with the following content:

```javascript
<copy>
// server.js
require('dotenv').config();

const express = require('express');
const { MongoClient, ObjectId } = require('mongodb');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use(express.static('public'));

let db;

async function connectDB() {
  const client = new MongoClient(process.env.MONGO_API_URL);
  await client.connect();
  db = client.db();
  console.log('Connected to AJD via MongoDB API');
}

app.get('/api/todos', async (req, res) => {
  const todos = await db.collection('todos').find().toArray();
  res.json(todos);
});

app.post('/api/todos', async (req, res) => {
  const todo = { text: req.body.text, completed: false };
  const result = await db.collection('todos').insertOne(todo);
  res.json(result.ops ? result.ops[0] : todo);
});

app.put('/api/todos/:id', async (req, res) => {
  const result = await db.collection('todos').updateOne(
    { _id: new ObjectId(req.params.id) },
    { $set: { completed: true } }
  );
  res.json({ modifiedCount: result.modifiedCount });
});

app.delete('/api/todos/:id', async (req, res) => {
  const result = await db.collection('todos').deleteOne({ _id: new ObjectId(req.params.id) });
  res.json({ deletedCount: result.deletedCount });
});

app.listen(PORT, async () => {
  await connectDB();
  console.log(`Server listening on port ${PORT}`);
});
</copy>
```

**Note:** This code is from the sample app. Cline can help customize it, e.g., adding authentication.

## Task 4: Configure Environment

Create a `.env` file:

```bash
<copy>
MONGO_API_URL=your-connection-string
</copy>
```

## Task 5: Run the Server

Start the server:

```bash
<copy>
node server.js
</copy>
```

Visit `http://localhost:3000` to test (frontend in next lab).

You are now ready to proceed to the Frontend UI lab.

---

## Acknowledgements

**Authors**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform

**Last Updated By/Date:**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform, November 2025
