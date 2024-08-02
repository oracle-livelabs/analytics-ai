# Documentation for Web Content Analysis Application

## Overview

This documentation provides a comprehensive guide for setting up and running a Streamlit application that enables users to analyze content from Wikipedia articles or web pages using Oracle Cloud AI services. The application retrieves content, processes it into chunks, generates a vector store for efficient access, and employs a conversational AI model to respond to user queries.

## Features

- Fetch and process content from Wikipedia articles or web pages.
- Divide the extracted content into chunks for efficient processing.
- Create a vector store using either OracleDB or Qdrant.
- Leverage Oracle Cloud Generative AI for conversational analysis.
- Provide an interactive user interface for users to ask questions about the content.

## Installation

### Prerequisites

- Python 3.7 or higher
- Streamlit
- requests
- BeautifulSoup
- langchain
- oracledb
- Oracle Cloud AI services credentials
- OracleDB or Qdrant for vector storage

### Install Dependencies

To install the required dependencies, run the following command:

```bash
pip install streamlit requests beautifulsoup4 langchain oracledb
```

## Running the Application

1. Copy the provided code from a file named `webPageChat.py`.
2. Ensure that your Oracle Cloud AI services credentials and other configurations are set in the `config.py` file.
3. Start the Streamlit app by executing the following command:

```bash
streamlit run webPageChat.py
```

## User Interaction

- **Enter Wikipedia Topic or URL**: Users can input a Wikipedia topic or a URL in the provided text box.
- **Ask Questions**: Once the content is fetched and processed, users can pose questions about the content.
- **Advanced Options**: Users can fine-tune settings such as chunk size, overlap, and the number of top results to retrieve.

## Code Summary

### Timer Decorator

The `timeit` decorator measures the execution time of functions. It wraps a function, records its start time, executes it, and then displays the elapsed time.

```python
def timeit(func):
    ...
    return new_func
```

### Fetching Article from Wikipedia

The `fetching_article` function retrieves content from Wikipedia and processes it into chunks. It utilizes `OCIGenAIEmbeddings` to create vector embeddings and stores them in either OracleDB or Qdrant based on the configuration.

```python
def fetching_article(wikipediatopic, chunk_size, chunk_overlap):
    embeddings = OCIGenAIEmbeddings(...)
    wikipage = WikipediaQueryRun(...)
    text = wikipage.run(wikipediatopic)
    text_splitter = CharacterTextSplitter(...)
    chunks = text_splitter.split_text(text)
    ...
    if config.DB_TYPE == "oracle":
        ...
        knowledge_base = OracleVS.from_texts(...)
    else:
        knowledge_base = Qdrant.from_texts(...)
    return knowledge_base
```

This function manages the connection to the database and divides the Wikipedia article text into manageable chunks for analysis.

### Fetching Content from URL

The `fetching_url` function fetches and processes content from a URL. It uses BeautifulSoup to extract text from the page, splits the text into chunks, and creates a vector store.

```python
def fetching_url(userinputquery, chunk_size, chunk_overlap):
    embeddings = OCIGenAIEmbeddings(...)
    page = requests.get(userinputquery)
    soup = BeautifulSoup(page.text, 'html.parser')
    text = soup.get_text()
    text_splitter = CharacterTextSplitter(...)
    chunks = text_splitter.split_text(text)
    ...
    if config.DB_TYPE == "oracle":
        ...
        knowledge_base = OracleVS.from_texts(...)
    else:
        knowledge_base = Qdrant.from_texts(...)
    return knowledge_base
```

This function ensures that the text from the URL is correctly parsed and stored for subsequent retrieval and analysis.

### Prompting the LLM

The `prompting_llm` function prompts the LLM with the user's question and obtains a response. It performs a similarity search to identify relevant chunks, displays the prompt and results, and calculates the prompt length.

```python
def prompting_llm(user_question, _knowledge_base, _chain, k_value):
    with st.spinner(text="Prompting LLM..."):
        doc_to_prompt = _knowledge_base.similarity_search(user_question, k=k_value)
        docs_stats = _knowledge_base.similarity_search_with_score(user_question, k=k_value)
        ...
        prompt_len = _chain.prompt_length(docs=doc_to_prompt, question=user_question)
        response = _chain.invoke({"input_documents": doc_to_prompt, "question": user_question}, return_only_outputs=True).get("output_text")
        return response
```

This function ensures that user queries are effectively handled, and relevant answers are provided using the pre-processed text chunks.

### Chunk Search

The `chunk_search` function retrieves similar chunks based on the user's question and presents them. It performs a similarity search and formats the results for display.

```python
def chunk_search(user_question, _knowledge_base, k_value):
    with st.spinner(text="Prompting LLM..."):
        doc_to_prompt = _knowledge_base.similarity_search(user_question, k=k_value)
        docs_stats = _knowledge_base.similarity_search_with_score(user_question, k=k_value)
        ...
        return result
```

This function enables users to view the individual text chunks that are most pertinent to their query.

### Main Function

The `main` function sets up the Streamlit app, manages user inputs, and displays responses. It initializes the OCIGenAI model, loads the question-answering chain, and configures the user interface.

```python
def main():
    llm = ChatOCIGenAI(...)
    chain = load_qa_chain(llm, chain_type="stuff")
    ...
    st.header("Ask any website using Oracle Gen AI")
    with st.expander("Advanced options"):
        k_value = st.slider(...)
        chunk_size = st.slider(...)
        chunk_overlap = st.slider(...)
        chunk_display = st.checkbox("Display chunk results")...
    if userinputquery:
        if userinputquery.startswith("http"):
            knowledge_base = fetching_url(userinputquery, chunk_size, chunk_overlap)
        else:
            knowledge_base = fetching_article(userinputquery, chunk_size, chunk_overlap)
        ...
    user_question = st.text_input("Ask a question about the loaded content:")
    promptoption = st.selectbox(...)
    ...
    if user_question:
        response = prompting_llm("This is a web page, based on this text " + user_question.strip(), knowledge_base, chain, k_value)
        st.write("_"+user_question.strip()+"_")
        st.write(response)
    if chunk_display:
        chunk_display_result = chunk_search(user_question.strip(), knowledge_base, k_value)
        with st.expander("Chunk results"):
            st.code(chunk_display_result)
```

This function orchestrates the entire process, from content retrieval to processing user queries and presenting results interactively.

## Conclusion

This application empowers users to analyze web content using advanced AI capabilities offered by Oracle Cloud. By following the setup instructions and understanding the code structure, you can customize and extend the functionality to suit your specific requirements.


## Acknowledgements

* **Author** - Anshuman Panda, Principal Generative AI Specialist, Alexandru Negrea , AI and App Integration Specialist Leader