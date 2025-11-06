# Build Frontend UI

## Introduction

In this lab, you'll create a simple HTML/JavaScript frontend for the To-Do app, interacting with the backend via API calls. This minimal UI uses fetch() for CRUD operations.

> **Estimated Time:** 15 minutes

**Note:** Cline can enhance the UI, such as adding CSS frameworks or React components—share your ideas!

---

### Objectives

In this lab, you will:
- Create the index.html file
- Implement JavaScript for todo interactions
- Test the full application

---

### Prerequisites

This lab assumes you have:
- Completed the Node/Express lab
- The backend server running

---

## Task 1: Create public Directory

In your project directory, create a `public` folder:

```bash
<copy>
mkdir public
</copy>
```

## Task 2: Create index.html

Inside `public`, create `index.html` with the following content:

```html
<copy>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>AJD-Powered Mongo To-Do List</title>
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
```

**Note:** This JS handles API calls. Cline can help add features like sorting or filtering.

## Task 3: Test the Application

1. Ensure the server is running (`node server.js`).

2. Open `http://localhost:3000` in your browser.

3. Add, complete, and delete todos to verify CRUD operations with AJD.

**Congratulations!** You've deployed a MongoDB-compatible app on AJD.

## Troubleshooting and Testing

- **UI Not Loading:** Ensure the server is running and the public directory is correctly placed.

- **Testing CRUD:** Besides the UI, you can test APIs with curl, e.g.:
  - GET todos: `curl http://localhost:3000/api/todos`
  - POST todo: `curl -X POST http://localhost:3000/api/todos -H "Content-Type: application/json" -d '{"text": "Test"}'`
  - PUT complete: `curl -X PUT http://localhost:3000/api/todos/<id>`
  - DELETE: `curl -X DELETE http://localhost:3000/api/todos/<id>`

This helps verify backend before UI.

---

## Acknowledgements

**Authors**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform

**Last Updated By/Date:**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform, November 2025
