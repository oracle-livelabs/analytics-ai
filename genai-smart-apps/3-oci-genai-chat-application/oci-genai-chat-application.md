# **Oracle Gen AI Chat Application**

## Introduction

This lab will guide you through the process of setting up and running the Oracle Gen AI Chat Application. We will cover the requirements, installation, and basic usage of the application. By the end of this lab, you should be able to interact with the chat interface and explore its features.

Estimated Time: 20 minutes

## Objectives

In this lab, you will:

- Understand the requirements for running the Oracle Gen AI Chat Application.
- Install the necessary Python packages and create the required configuration file.
- Run the Streamlit app and interact with the chat interface.
- Explore the available commands and functionality of the application.

## Prerequisites

Before beginning this lab, ensure you have the following:

- Python 3.7 or higher installed on your system.
- Access to an Oracle Cloud Infrastructure (OCI) account with permissions to use the Generative AI service.
- Basic knowledge of Python programming and Streamlit framework.

## Task 1: Understanding the Application

The Oracle Gen AI Chat Application is a Streamlit-based chat interface that leverages Oracle's Generative AI technology. It provides a user-friendly way to interact with a pre-trained language model and perform various tasks. The application supports basic commands for managing conversation history and continuing prompts.

## Task 2: Installation and Setup

### Requirements

To run the Oracle Gen AI Chat Application, you need the following:

- Python 3.7 or higher
- Streamlit: A popular framework for building data apps
- LangChain: A library for building applications with Large Language Models (LLMs)
- Access to OCI and Generative AI models

### Installation

1. **Install Python packages:**

   ```
   <copy>
   pip install streamlit langchain langchain_community
   <\copy>
   ```

2. **Create a configuration file:** Create a `config.py` file in the `pages/utils` directory with the following content:

   ```
   <copy>
   ENDPOINT = "https://inference.generativeai.eu-frankfurt-1.oci.oraclecloud.com" # Replace with your service endpoint
   EMBEDDING_MODEL = "cohere.command" # Replace with your embedding model ID
   GENERATE_MODEL = "cohere.command-r-plus" # Replace with your generative model ID
   COMPARTMENT_ID = "ocid1.compartment.oc1..example" # Replace with your compartment OCID
   <\copy>
   ```

## Task 3: Running the Application

### Step 1: Running the Streamlit App

To run the application, use the following command:

```
<copy>
streamlit run app.py
<\copy>
```

### Step 2: Accessing the Application

Open your web browser and navigate to `http://localhost:8501` to access the Oracle Gen AI Chat Application.

## Task 4: Exploring the Application

### Main Page Setup

The application sets up a simple interface with a header, sidebar, and a chat input box. The sidebar contains a success message and a style configuration.

### Language Model Initialization

The application initializes a `ChatOCIGenAI` language model from the `langchain_community` package using the provided configuration settings. This model is responsible for generating responses based on user input.

### Conversation Chain

A `ConversationChain` is created to manage the interaction with the LLM. This chain utilizes `ConversationSummaryMemory` to store and summarize the conversation history.

### Utility Functions

#### `timeit(func)`

This is a decorator function used to measure the execution time of other functions.

#### `prompting_llm(prompt, _chain)`

This function sends a prompt to the LLM and retrieves the response. It also prints the prompt and response for debugging purposes and displays a spinner while waiting for the LLM to respond.

#### `commands(prompt, last_prompt, last_response)`

This function handles specific commands such as `/continue`, `/history`, `/repeat`, and `/help`. It processes the prompt and generates an appropriate response based on the command.

### Chat History Management

The application manages chat history using `st.session_state` to store messages, conversation history, last response, and last prompt. This ensures that the chat history persists across different sessions.

### User Interaction

The application reacts to user input from the chat interface. If the input starts with a slash `/`, it is treated as a command and processed using the `commands` function. Otherwise, the prompt is sent to the LLM using the `prompting_llm` function. The user's input and the assistant's response are displayed in the chat interface and added to the chat history.

### Available Commands

- **/continue**: Continues the last response based on the previous prompt and response.
- **/history**: Displays the current conversation history summary.
- **/repeat**: Repeats the last response from the assistant.
- **/help**: Provides a list of available commands.

## Task 5: Code Explanation

### Imports and Configuration

The application begins by importing the necessary libraries and setting up configuration parameters.

``` python
import streamlit as st
import langchain
from langchain.chains import ConversationChain
from langchain.chains.conversation.memory import ConversationSummaryMemory
from typing import Optional, List, Mapping, Any
from io import StringIO
import datetime
import functools
from langchain_community.chat_models.oci_generative_ai import ChatOCIGenAI
import pages.utils.config as config
from pages.utils.style import set_page_config

set_page_config()

endpoint = config.ENDPOINT
embeddingModel = config.EMBEDDING_MODEL
generateModel = config.GENERATE_MODEL
compartment_id = config.COMPARTMENT_ID
```

### Timer Decorator

A decorator function, `timeit`, is defined to measure the execution time of other functions.

```python
def timeit(func):
    @functools.wraps(func)
    def new_func(*args, **kwargs):
        start_time = datetime.datetime.now()
        result = func(*args, **kwargs)
        elapsed_time = datetime.datetime->now() - start_time
        print('function [{}] finished in {} ms'.format(func.__name__, str(elapsed_time)))
        return result
    return new_func
```

### Streamlit Page Setup

The main page is configured with a header, sidebar, and chat input interface.

```python
st.header("How can I help you today? ")
st.info('Select a page on the side menu or use the chat below.', icon="📄")
with st.sidebar.success("Choose a page above"):
    st.sidebar.markdown(
        """
        <style>
        [data-testid='stSidebarNav'] > ul {
            min-height: 40vh;
        }
        </style>
        """,
        unsafe_allow_html=True,
    )
```

### Instantiate Chat LLM and Conversation Chain

The language model (LLM) is instantiated using Oracle Gen AI, and a conversation chain is set up to handle user interactions.

```python
llm = ChatOCIGenAI(
    model_id=generateModel,
    service_endpoint=endpoint,
    compartment_id=compartment_id,
    model_kwargs={"temperature": 0.0, "max_tokens": 500},
)
chain = ConversationChain(llm=llm, memory=ConversationSummaryMemory(llm=llm, max_token_limit=500), verbose=False)
```

### Prompting Function

The `prompting_llm` function handles LLM prompting and utilizes the `timeit` decorator to measure execution time.

```python
@timeit
def prompting_llm(prompt, _chain):
    with st.spinner(text="Prompting LLM..."):
        print('\n# ' + datetime.datetime.now().astimezone().isoformat() + ' =====================================================')
        print("Prompt: " + prompt + "\n")
        response = _chain.invoke(prompt).get("response")
        print("-------------------\nResponse: " + response + "\n")
        return response
```

### Command Handling

The `commands` function processes special commands to extend the chat functionality.

```python
@timeit
def commands(prompt, last_prompt, last_response):
    command = prompt.split(" ")[0]
    if command == "/continue":
        prompt = "Given this question: " + last_prompt + ", continue the following text you already started: " + last_response.rsplit("\n\n", 3)[0]
        response = prompting_llm(prompt, chain)
        return response
    elif command == "/history":
        try:
            history = chain.memory.load_memory_variables({"history"}).get("history")
            if history == "":
                return "No history to display"
            else:
                return "Current History Summary: \n" + history
        except:
            return "The history was cleared"
    elif command == "/repeat":
        return last_response
    elif command == "/help":
        return "Command list available: /continue, /history, /repeat, /help"
```

### Chat History Initialization

The application initializes chat history to manage context across sessions.

```python
if "messages" not in st.session_state:
    st.session_state.messages = []
if "history" not in st.session_state:
    st.session_state.history = []
else:
    chain.memory = st.session_state.history
if "last_response" not in st.session_state:
    st.session_state.last_response = ""
last_response = ""
else:
    last_response = st.session_state.last_response
if "last_prompt" not in st.session_state:
    st.session_state.last_prompt = ""
last_prompt = ""
else:
    last_prompt = st.session_state.last_prompt
for message in st.session_state.messages:
    with st.chat_message(message["role"]):
        st.markdown(message["content"])
    st.divider()
```

### User Input and Response Handling

The application reacts to user input, either processing commands or interacting with the LLM.

```python
if prompt := st.chat_input("What is up?"):
    st.chat_message("user").markdown(prompt)
    st.session_state.messages.append({"role": "user", "content": prompt})
    if prompt.startswith("/"):
        response = commands(prompt, last_prompt, last_response)
        with st.chat_message("assistant", avatar="🔮"):
            st.markdown(response)
    else:
        response = prompting_llm(prompt, chain)
        with st.chat_message("assistant"):
            st.markdown(response)
    st.session_state.messages.append({"role": "assistant", "content": response})
    try:
        st.session_state.history = chain.memory
        st.session_state.last_prompt = prompt
        st.session_state.last_response = response
    except:
        pass
```

## Learn More

To learn more about the Oracle Gen AI Chat Application and its capabilities, you can explore the following resources:

- [Oracle Cloud Infrastructure Documentation](https://docs.oracle.com/en-us/iaas/Content/Home.htm)
- [Streamlit Documentation](https://docs.streamlit.io/)
- [LangChain Documentation](https://langchain.readthedocs.io/)

## Acknowledgements

* **Author** - Anshuman Panda, Principal Generative AI Specialist, Alexandru Negrea , AI and App Integration Specialist Leader