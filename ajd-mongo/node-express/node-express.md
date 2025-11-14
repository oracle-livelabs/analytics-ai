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
npm install express mongodb
</copy>
```

*Note* To install node on your system, the instructions can be found on the [NodeJS Website](https://nodejs.org/en/download)

## Task 3: Create server.js

Create a file named `server.js` with the following content:

```javascript
<copy>
// server.js
//require('dotenv').config(); // only if using .env

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
  db = client.db(); // use default DB from connection string
  // Optional: Ping to test connection
  await db.command({ ping: 1 });
  console.log('Connected to Oracle AJD (Mongo API)');
}

app.get('/api/status', async (req, res) => {
  try {
    await db.command({ ping: 1 });
    res.json({ status: 'ok' });
  } catch (err) {
    res.status(500).json({ status: 'error', error: err.message });
  }
});

// Read todos
app.get('/api/todos', async (req, res) => {
    const todos = await db.collection('todos').find().toArray();
    res.json(todos);
  });
  
// Create todo
app.post('/api/todos', async (req, res) => {
    const todo = { text: req.body.text, completed: false };
    const result = await db.collection('todos').insertOne(todo);
    res.json(result.ops ? result.ops[0] : todo);
});
  
// Update todo (mark as completed)
app.put('/api/todos/:id', async (req, res) => {
const result = await db.collection('todos').updateOne(
    { _id: new ObjectId(req.params.id) },
    { $set: { completed: true } }
);
res.json({ modifiedCount: result.modifiedCount });
});
  
// Delete todo
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

**Note:** This code is from the sample app. Cline can help customize it, e.g., adding authentication. The 'todos' collection will auto-create in AJD on the first insert operation; no explicit creation step is needed.

## Task 4: Configure Environment

Set the env variable **MONGO\_API\_URL**:

```bash
<copy>
export MONGO_API_URL='your-connection-string'
</copy>
```

**Note** Make sure to only use single quotes ' ' around the connection string.

## Task 5: Run the Server

Start the server:

```bash
<copy>
node server.js
</copy>
```

If successful, the server should be listening on port 3000. 

You are now ready to proceed to the Frontend UI lab.

## Troubleshooting

- **Installation Errors:** If npm install fails with network errors (e.g., ENOTFOUND), ensure you're not on a VPN or behind a proxy interfering with the registry. For public users, it pulls from npmjs.org.

- **Server Startup Errors:** If you see syntax errors, confirm Node.js version (>=18). For connection issues, refer to the AJD Connect lab's troubleshooting.

---

## Acknowledgements

**Authors**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform S&E

**Last Updated By/Date:**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform S&E, November 2025
