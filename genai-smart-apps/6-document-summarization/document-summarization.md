# Documentation for Document Summarization App

## Overview

This Streamlit application enables users to upload PDF files and generate summaries using a variety of language models (LLMs) from Oracle Cloud AI services. It offers a customizable summarization process by allowing users to select different summarization strategies and adjust parameters such as chunk size, chunk overlap, temperature, and maximum token output.

## Features

- Upload PDF documents for summarization.
- Choose from different LLMs, including cohere.command-r-16k, cohere.command-r-plus, and meta.llama-3-70b-instruct.
- Customize summarization prompts and select from various summarization strategies (map_reduce, stuff, and refine).
- Interactive interface for viewing and summarizing document content.

## Installation

### Prerequisites

- Python 3.7 or later
- Streamlit
- pypdf
- langchain
- python-dotenv

### Install Dependencies

```
pip install streamlit pypdf langchain python-dotenv
```

### Running the Application

1. Copy the provided code from a file named `documentSummarization.py`.
2. Ensure your Oracle Cloud AI services credentials and other configurations are set in the `config.py` file.
3. Run the Streamlit app using the following command:

```
streamlit run documentSummarization.py
```

## User Interaction

- **Select LLM**: Choose an LLM from the sidebar options.
- **Select Chain Type**: Choose a summarization strategy.
- **Adjust Parameters**: Tune parameters like chunk size, chunk overlap, temperature, and maximum token output.
- **Enter Summary Prompt**: Provide a custom prompt for document summarization.
- **Upload PDF**: Upload a PDF document.
- **Generate Summary**: Click the "Summarize" button to generate the summary.

## Code Summary

### Environment Setup

The code begins by importing necessary libraries and setting up the Streamlit environment. It loads configuration details and configures the Oracle Cloud Generative AI model using the `ChatOCIGenAI` class.

```python
import streamlit as st
import os
from langchain.document_loaders import PyPDFLoader
from langchain.prompts import PromptTemplate
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.chains.summarize import load_summarize_chain
from pypdf import PdfReader
from io import BytesIO
from typing import Any, Dict, List
import re
from langchain.docstore.document import Document
from langchain_community.chat_models.oci_generative_ai import ChatOCIGenAI
import pages.utils.config as config
from pages.utils.style import set_page_config

set_page_config()
```

### PDF Parsing

The `parse_pdf` function reads and extracts text from uploaded PDF files using the `pypdf` library. It cleans and formats the extracted text for further processing.

```python
@st.cache_data
def parse_pdf(file: BytesIO) -> List[str]:
    pdf = PdfReader(file)
    output = []
    for page in pdf.pages:
        text = page.extract_text()
        text = re.sub(r"(\w+)-\n(\w+)", r"\1\2", text)
        text = re.sub(r"(?\<!\n\s)\n(?!\s\n)", " ", text.strip())
        text = re.sub(r"\n\s*\n", "\n\n", text)
        output.append(text)
    return output
```

### Text to Document Conversion

The `text_to_docs` function converts the extracted text into a list of `Document` objects, which include metadata like page and chunk numbers. It utilizes the `RecursiveCharacterTextSplitter` to split the text into manageable chunks.

```python
@st.cache_data
def text_to_docs(text: str, chunk_size, chunk_overlap) -> List[Document]:
    if isinstance(text, str):
        text = [text]
    page_docs = [Document(page_content=page) for page in text]
    for i, doc in enumerate(page_docs):
        doc.metadata["page"] = i + 1
    doc_chunks = []
    # Code snippet for doc_chunks generation
    return doc_chunks
```

### Custom Summary Function

The `custom_summary` function generates document summaries using the specified LLM and summarization strategy. It configures prompt templates and loads the appropriate summarization chain.

```python
def custom_summary(docs, llm, custom_prompt, chain_type, num_summaries):
    custom_prompt = custom_prompt + ":\n {text}"
    COMBINE_PROMPT = PromptTemplate(template=custom_prompt, input_variables=["text"])
    MAP_PROMPT = PromptTemplate(template="Summarize:\n{text}", input_variables=["text"])
    if chain_type == "map_reduce":
        chain = load_summarize_chain(...)
    else:
        chain = load_summarize_chain(llm, chain_type=chain_type)
    summaries = []
    for i in range(num_summaries):
        summary_output = chain({"input_documents": docs}, return_only_outputs=True)["output_text"]
        summaries.append(summary_output)
    return summaries
```

### Main Streamlit Application

The `main` function sets up the Streamlit interface, handles user inputs, and displays the results. Users can interact with the app to upload PDFs, select LLMs, adjust parameters, and generate summaries.

```python
def main():
    st.markdown(hide_streamlit_style, unsafe_allow_html=True)
    st.title("Document Summarization App")
    llm_name = st.sidebar.selectbox("LLM", ["cohere.command-r-16k", "cohere.command-r-plus", "meta.llama-3-70b-instruct"])
    chain_type = st.sidebar.selectbox("Chain Type", ["map_reduce", "stuff", "refine"])
    chunk_size = ...
    chunk_overlap = ...
    user_prompt = ...
    temperature = ...
    max_token = ...
    opt = "Upload-own-file"
    pages = None
    if opt == "Upload-own-file":
        uploaded_file = st.file_uploader("**Upload a Pdf file :**", type=["pdf"])...
        llm = ChatOCIGenAI(...)
    if st.button("Summarize"):
        with st.spinner('Summarizing....'):
            result = custom_summary(pages, llm, user_prompt, chain_type, 1)
        ...

if __name__ == "__main__":
    main()
```

## Summarization Models and Strategies

### Summarization Models

- `cohere.command-r-16k`: Suitable for large-scale summarization tasks.
- `cohere.command-r-plus`: Enhanced model with advanced capabilities.
- `meta.llama-3-70b-instruct`: State-of-the-art model for detailed and accurate summarization.

### Summarization Strategies

- `map_reduce`: Splits the document into chunks, summarizes each chunk, and then combines the summaries.
- `stuff`: Processes the entire document in a single step.
- `refine`: Iteratively refines the summary for improved accuracy.

By following the documentation and utilizing the provided code snippets, users can recreate and customize the Document Summarization App to suit their specific requirements.

## Acknowledgements

* **Author** - Anshuman Panda, Principal Generative AI Specialist, Alexandru Negrea , AI and App Integration Specialist Leader

**Last Updated By/Date** - Anshuman Panda, Principal Generative AI Specialist, Aug 2024