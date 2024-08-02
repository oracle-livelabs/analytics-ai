# Documentation for OCI Gen Ai PDF Chat Application

## Overview

This documentation offers a comprehensive explanation of the Streamlit application, which empowers users to engage with their PDF files via a chat interface. This functionality is facilitated by LangChain and Oracle Cloud AI services. The application extracts text from PDFs, processes it into manageable chunks, generates a vector store for efficient retrieval, and establishes a conversational chain to address user queries.

## Features

- Upload and process multiple PDF files
- Extract text from uploaded PDFs
- Chunk extracted text for streamlined processing
- Create a vector store using either OracleDB or Qdrant
- Set up a conversational retrieval chain leveraging Oracle Cloud Generative AI
- Interactive chat interface for querying PDF content

## Installation

### Prerequisites

- Python 3.7 or higher
- Streamlit
- PyPDF2
- LangChain
- Oracle Cloud AI services credentials
- OracleDB or Qdrant for vector storage

### Install Dependencies

```
pip install streamlit PyPDF2 langchain langchain_community oracledb
```

### Running the Application

1. Copy the provided code from a file named `chatWithPDF.py`.
2. Ensure your Oracle Cloud AI services credentials and configurations are set in the `config.py` file.
3. Execute the Streamlit app using the command:

```
streamlit run chatWithPDF.py
```

## User Interaction

- **Upload PDFs**: Users can upload one or multiple PDF files via the sidebar.
- **Ask Questions**: Once PDFs are processed, users can input their questions into the text box at the bottom of the main page.

## Code Summary

### Configuration

The application relies on a `config.py` file for various settings, including database connection details and model identifiers.

### Extract Text from PDFs

The `get_pdf_text` function utilizes PyPDF2 to extract text from uploaded PDF files:

```python
def get_pdf_text(pdf_files):
    ...
    for pdf_file in pdf_files:
        reader = PdfReader(pdf_file)
        for page in reader.pages:
            text += page.extract_text()
    ...
```

### Text Chunking

The `get_chunk_text` function employs LangChain's `CharacterTextSplitter` to split extracted text into smaller chunks:

```python
def get_chunk_text(text):
    text_splitter = CharacterTextSplitter(
        ...
        chunk_size=1000,
        chunk_overlap=200,
        ...
    )
    chunks = text_splitter.split_text(text)
    return chunks
```

### Create Vector Store

The `get_vector_store` function establishes a vector store from text chunks using either OracleDB or Qdrant, based on the configuration:

```python
def get_vector_store(text_chunks):
    embeddings = OCIGenAIEmbeddings(...)
    documents = [Document(page_content=chunk) for chunk in text_chunks]

    if config.DB_TYPE == "oracle":
        connection = oracledb.connect(...)
        vectorstore = OracleVS.from_documents(
            documents=documents,
            embedding=embeddings,
            ...
        )
    else:
        vectorstore = Qdrant.from_documents(
            documents=documents,
            embedding=embeddings,
            ...
        )
    return vectorstore
```

### Conversational Chain

The `get_conversation_chain` function sets up a conversational retrieval chain using the Oracle Cloud Generative AI model:

```python
def get_conversation_chain(vector_store):
    llm = ChatOCIGenAI(...)
    memory = ConversationBufferMemory(memory_key='chat_history', return_messages=True)
    conversation_chain = ConversationalRetrievalChain.from_llm(
        llm=llm,
        retriever=vector_store.as_retriever(),
        memory=memory
    )
    return conversation_chain
```

### Handle User Input

The `handle_user_input` function processes user questions and displays the chat history in the Streamlit app:

```python
def handle_user_input(question):
    response = st.session_state.conversation({'question': question})
    st.session_state.chat_history = response['chat_history']
    ...
```

### Main Function

The main function configures the Streamlit interface, handles file uploads, and initializes the conversation chain:

```python
def main():
    ...
    st.set_page_config(page_title='Chat with Your own PDFs', page_icon=':books:')
    ...
    st.header('Chat with Your own PDFs :books:')

    question = st.text_input("Ask anything to your PDF: ")
    if question:
        handle_user_input(question)

    with st.sidebar:
        st.subheader("Upload your Documents Here: ")
        pdf_files = st.file_uploader("Choose your PDF Files and Press OK", type=['pdf'], accept_multiple_files=True)
    ...

if __name__ == '__main__':
    main()
```

## Explanation:

1. **Embeddings Setup**: Initialize embeddings using the Oracle Cloud Generative AI model.
2. **Document Creation**: Convert each text chunk into a `Document` object.
3. **Database Connection**: Establish a connection to either OracleDB or Qdrant, depending on the configured database type.
4. **Vector Store Creation**: Create the vector store from the documents, utilizing the selected database, embedding model, and distance strategy.

## Conclusion

This documentation offers a thorough guide to understanding, setting up, and utilizing the Streamlit PDF chat application. By adhering to these instructions, users can recreate and customize the application to align with their specific requirements.


## Acknowledgements

* **Author** - Anshuman Panda, Principal Generative AI Specialist, Alexandru Negrea , AI and App Integration Specialist Leader