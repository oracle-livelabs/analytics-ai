# Documentation for PDF Comparison Using Oracle Gen AI

## Overview

This Python application enables users to compare the content of multiple PDF files using Large Language Models (LLMs). Users can upload PDF files, ask specific questions, and receive comparative answers from each PDF. The app utilizes Streamlit for the user interface, LangChain for LLM orchestration, and Oracle Generative AI for the underlying AI services.

## Features and Capabilities

- **PDF Upload and Question Input**: Users can upload multiple PDF files and input up to four questions to query the content of these PDFs.
- **Embeddings Creation and Storage**: The application extracts text from the uploaded PDFs, creates embeddings using Oracle Generative AI, and stores these embeddings in a vector database (either OracleDB or Qdrant).
- **Query Analysis**: The application uses the stored embeddings to perform query analysis, retrieving relevant information from the PDFs based on the input questions.
- **Results Display**: The results of the queries are displayed in a structured table format, showing the responses from each PDF.

## How It Works

1. **User Interface**: The Streamlit-based user interface allows users to interact with the application by uploading PDFs and entering questions.
2. **Embeddings Creation**: Uploaded PDFs are processed to extract text, which is then converted into embeddings using Oracle Generative AI.
3. **Vector Database**: The embeddings are stored in a vector database for efficient retrieval. The application supports both OracleDB and Qdrant as storage options.
4. **LLM Integration**: The application integrates with Oracle's LLM to analyze the queries and retrieve relevant information from the PDFs.
5. **Data Display**: The application processes the query responses and displays them in a table format, highlighting the source document for each response.

## Installation

To install and run this application, follow these steps:

1. **Install dependencies**:
   ```
   pip install -r requirements.txt
   ```
2. **Set up configuration**: Ensure that the configuration settings for Oracle Generative AI and the embedding model are correctly set in the `config.py` file located in the `pages/utils` directory.
3. **Run the application**:
   ```
   streamlit run docCompare.py
   ```

## User Interaction

1. **Upload PDF Files**: Use the file uploader to select and upload multiple PDF files.
2. **Input Questions**: Enter up to four questions in the provided text input fields.
3. **Submit**: Click the "Start Processing" button to begin the analysis.
4. **View Results**: The app will display the responses from each PDF in a table format, showing how each document answers the questions.

## Code Summary

Let's break down the main file `docCompare.py` and explain its logic and functionality in detail.

### Main File: docCompare.py

This file contains the main logic for the Streamlit application that compares PDF files using Oracle Generative AI.

#### 1. Importing Libraries and Setting Up the Page

```python
import pandas as pd
import streamlit as st
import streamlit.components.v1 as components
from PIL import Image
from pages.utils.lang_utils import ask_to_all_pdfs_sources, create_qa_retrievals

st.set_page_config(...)
```

- **Libraries**: Imports necessary libraries such as pandas for data manipulation, streamlit for creating the web interface, components for embedding HTML/CSS, and PIL for handling images.
- **Configuration**: Sets up the Streamlit page configuration, including the page title, icon, layout, and initial sidebar state.

#### 2. Sidebar Contents

```python
with st.sidebar:
    st.markdown(
        """
     About

    This app is an pdf comparison (LLM-powered), built using:

    ...
    """
    )
    st.write("Made with Oracle Generative AI")
```

- **Title and Description**: Displays the title and description of the app in the sidebar.
- **Libraries and AI**: Lists the technologies used to build the app, including Streamlit, LangChain, and Oracle Generative AI.
- **Acknowledgment**: Credits Oracle Generative AI for its contribution.

#### 3. Main Title and Form for User Input

```
<copy>
Title_html = """
    <style>
        .title h1{
            user-select: none;
            font-Multiplier: 1.5;
            color: white;
            background: repeating-linear-gradient(-45deg, red 0%, yellow 7.14%,
            rgb(0,255,0) 14.28%, rgb(0,255,255) 21.4%, cyan 28.56%, blue 35.7%,
            magenta 42.84%, red 50%);
        }
    </style>
    """
components.html(Title_html)
<\copy>
```

- **HTML/CSS for Title**: Creates a styled title using HTML and CSS. The title has a rainbow gradient animation.

```python
with st.form("basic_form"):
    uploaded_files = st.file_uploader(
        "Upload files",
        type=["pdf"],
        key="file_upload_widget",
        accept_multiple_files=True,
    )
    question_1 = st.text_input("Question 1", key="1_question")
    question_2 = st.text_input("Question 2", key="2_question")
    question_3 = st.text_input("Question 3", key="3_question")
    question_4 = st.text_input("Question 4", key="4_question")
    submit_btn = st.form_submit_button("Start Processing")
```

- **File Uploader**: Allows users to upload multiple PDF files.
- **Text Inputs for Questions**: Provides input fields for up to four questions.
- **Submit Button**: A button to start processing the uploaded PDFs and input questions.

#### 4. Handling User Input and Processing

```python
if submit_btn:
    if question_1 == "":
        st.warning("Give at least one question")
        st.stop()
    if uploaded_files is None:
        st.warning("Upload at least 1 PDF file")
        st.stop()

    all_questions = [question_1, question_2, question_3, question_4]

    with st.spinner("Creating embeddings...."):
        try:
            ...
            st.exception(e)
            st.stop()
        st.success("Done!", icon="✅")

    with st.spinner("Doing Analysis...."):
        try:
            data = []
            for question in st.session_state.questions:
                if question == "":
                    ...
            with st.spinner("Doing Analysis.."):
                try:
                    df = pd.DataFrame(st.session_state.data)
                    ...
                except Exception as e:
                    st.exception(e)
                    st.stop()
            st.balloons()
```

- **Form Submission Handling**: When the submit button is clicked:
  - **Validation**: Checks if at least one question is provided and at least one PDF file is uploaded.
  - **Creating Embeddings**: Calls `create_qa_retrievals` to create embeddings for the uploaded PDFs.
  - **Analyzing Questions**: Iterates through the questions, uses `ask_to_all_pdfs_sources` to get answers from each PDF, and stores the results.
  - **Displaying Results**: Converts the results into a DataFrame, removes duplicates if any, and displays the responses in a table.

## Utility File: lang_utils.py

This file contains utility functions to handle PDF parsing, embeddings creation, and querying the LLM.

### 1. Importing Libraries and Configuration

```python
import streamlit as st
from pages.utils.pdf_parser import PDFParser
from langchain.chains import RetrievalQA
import os
from langchain_community.embeddings import OCIGenAIEmbeddings
import oracledb
import pages.utils.config as config 
from langchain_community.chat_models.oci_generative_ai import ChatOCIGenAI
from langchain_community.vectorstores.oraclevs import OracleVS
from langchain_community.vectorstores.utils import DistanceStrategy
from langchain.vectorstores import Qdrant
```

- **Libraries**: Imports necessary libraries for handling PDFs, embeddings, vector stores, and LLM interactions.
- **Configuration**: Imports configuration settings for Oracle Generative AI and database connections.

### 2. Parsing PDF Files

```python
def get_text_from_pdf(pdf_path):
    parser = PDFParser(config.COMPARTMENT_ID)
    docs = parser.parse_pdf(pdf_path)
    return docs
```

- **PDF Parsing**: Uses `PDFParser` to extract text content from a given PDF file.

```python
def get_text_splitter(pdf_file):
    with open("temp_pdf.pdf", "wb") as f:
        f.write(pdf_file.getbuffer())
    text = get_text_from_pdf("temp_pdf.pdf")
    os.remove("temp_pdf.pdf")
    return text
```

- **Temporary File Handling**: Saves the uploaded PDF file temporarily to extract text and then removes the temporary file.

### 3. Creating Embeddings and QA Retrievals

```python
def create_qa_retrievals(pdf_file_list: list):
    qa_retrievals = []
    for pdf in pdf_file_list:
        texts = get_text_splitter(pdf)
        text_strings = [doc.page_content for doc in texts]
        metadatas = [{"source": f"{i}-{pdf.name}", "topics": doc.metadata['topics'], "page": doc.metadata['page']} for i, doc in enumerate(texts)]
        embeddings = OCIGenAIEmbeddings(...)
        if config.DB_TYPE == "oracle":
            try:
                connection = oracledb.connect(user=...)
            except Exception as e:
                print("Connection to OracleDB failed!")
                return
        else:
            db = Qdrant.from_texts(... )
            st.info(f"Saving {pdf.name} to vector DB")
        llm = ChatOCIGenAI(... )
        qa_retrieval = RetrievalQA.from_chain_type(
            llm=llm, ... )
        qa_retrievals.append(qa_retrieval)
    return qa_retrievals
```

- **QA Retrievals Creation**:
  - **Text Splitting**: Extracts text from each PDF file.
  - **Embeddings**: Uses `OCIGenAIEmbeddings` to create embeddings for the extracted text.
  - **Vector Store**: Saves the embeddings to either OracleDB or Qdrant, based on the configuration.
  - **LLM**: Initializes the LLM with `ChatOCIGenAI`.
  - **QA Chain**: Creates a QA retrieval chain and appends it to the list.

### 4. Querying the PDFs

```python
def ask_to_all_pdfs_sources(query: str, qa_retrievals: list):
    data = []
    for i, qa in enumerate(qa_retrievals):
        response = qa.run(query)
        for doc in response['source_documents']:
            doc_name = doc.metadata['source']
            data.append(
                {
                    "query": query,
                    "response": response["result"],
                    "source_document": doc_name,
                }
            )
    return data
```

- **Querying PDFs**:
  - Iterates through the QA retrievals, runs the query on each, and collects the responses.
  - Stores the query, response, and source document information in a list.

## Conclusion

The PDF Comparison - LLM application showcases the power of combining Streamlit, LangChain, and Oracle Generative AI to create a robust tool for document analysis. By leveraging advanced embeddings and vector databases, the application provides accurate and efficient comparisons of PDF content, making it valuable for various use cases in research, legal, and business domains. The user-friendly interface ensures that even non-technical users can benefit from the capabilities of large language models and AI-driven document analysis.

## Acknowledgements

* **Author** - Anshuman Panda, Principal Generative AI Specialist, Alexandru Negrea, AI and App Integration Specialist Leader