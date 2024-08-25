# Documentation for YouTube Video Transcript Analysis Application

## Overview

This documentation provides a comprehensive guide for setting up and running a Streamlit application that enables users to analyze YouTube video transcripts using Oracle Cloud AI services. The application fetches video transcripts, processes them into chunks, generates embeddings, and employs a conversational AI model to respond to user queries.

## Features

- Fetch and process YouTube video transcripts.
- Split transcripts into chunks for efficient processing.
- Generate embeddings and create a vector store using OracleDB or Qdrant for rapid retrieval.
- Utilize Oracle Cloud Generative AI for conversational analysis.
- Offer an interactive user interface for users to ask questions about the video content.

## Installation

### Prerequisites

- Python 3.7 or later
- Streamlit
- requests
- langchain
- youtube_transcript_api
- Oracle Cloud AI services credentials
- OracleDB or Qdrant for vector storage

### Install Dependencies

```bash
pip install streamlit requests langchain youtube-transcript-api oracledb
```

### Running the Application

1. Copy the provided code from a file named `youtubeChat.py`.
2. Ensure your Oracle Cloud AI services credentials and other configurations are set in the `config.py` file.
3. Run the Streamlit app using the following command:

```bash
streamlit run youtubeChat.py
```

## User Interaction

- **Enter YouTube Video ID/URL**: Users can input a YouTube video ID or URL in the provided text box.
- **Ask Questions**: Once the transcript is fetched and processed, users can type their questions about the video content.
- **Advanced Options**: Users can adjust settings such as chunk size, overlap, and the number of top results to display.

## Code Summary

### Fetching YouTube Video ID

The `fetching_youtubeid` function extracts the YouTube video ID from a URL.

```python
def fetching_youtubeid(youtubeid):
    if "youtu" in youtubeid:
        data = re.findall(r"(?:v=\|\\)(\[0-9A-Za-z\_-\]{11}).\*", youtubeid)
        youtubeid = data\[0\]
        return youtubeid
```

### Fetching and Splitting Transcript

The `fetching_transcript` function fetches and splits the YouTube video transcript into chunks using `YouTubeTranscriptApi` to retrieve the transcript and `CharacterTextSplitter` to create chunks.

```python
def fetching_transcript(youtubeid, chunk_size, chunk_overlap):
    youtubeid = fetching_youtubeid(youtubeid)
    transcript = YouTubeTranscriptApi.get_transcript(youtubeid, languages=\['pt', 'en'\])
    formatter = TextFormatter()
    text = formatter.format_transcript(transcript)
    text_splitter = CharacterTextSplitter...
    chunks = text_splitter.split_text(text)
    return chunks
```

### Creating Vector Store

The `get_vector_store` function generates embeddings and creates a vector store using OracleDB or Qdrant for efficient retrieval.

```python
def get_vector_store(chunks):
    embeddings = OCIGenAIEmbeddings(
        model_id=embeddingModel, ... )
    if config.DB_TYPE == "oracle":
        connection = oracledb.connect(user=config.ORACLE_USERNAME,
                                     password=config.ORACCoefficient,
                                     dsn=config.ORACLE_DSN)
        knowledge_base = OracleVS.from_texts(... )
    else:
        knowledge_base = Qdrant.from_texts(... )
    return knowledge_base
```

### Prompting the LLM

The `prompting_llm` function prompts the LLM with the user’s question and retrieves the response.

```python
def prompting_llm(user_question, knowledge_base, chain, k_value):
    with st.spinner(text="Prompting LLM..."):
        doc_to_prompt = knowledge_base.similarity_search(user_question, k=k_value)
        response = chain.invoke({"input_documents": doc_to_prompt, "question": user_question}, return_only_outputs=True).get("output_text")
        return response
```

### Chunk Search

The `chunk_search` function retrieves similar chunks based on the user's question and displays them.

```python
def chunk_search(user_question, knowledge_base, k_value):
    with st.spinner(text="Searching chunks..."):
        doc_to_prompt = knowledge_base.similarity_search(user_question, k=k_value)
        docs_stats = knowledge_base.similarity_search_with_score(user_question, k=k_value)
        result = ' \n '+datetime.datetime.now().astimezone().isoformat()
        result = result + " \nPrompt: "+user_question+ " \n"
        for x in range(len(docs_stats)):
            try:
                result = result + ' \n'+str(x)+' -------------------'
                content, score = docs_stats\[x\]
                result = result + " \nContent: "+content.page_content
                result = result + " \n \nScore: "+str(score)+" \n"
            except:
                pass
        return result
```

### Main Function

The main function sets up the Streamlit app, handles user inputs, and displays responses.

```python
def main():
    llm = ChatOCIGenAI(... )
    chain = load_qa_chain(llm, chain_type="stuff")
    if hasattr(chain.llm_chain.prompt, 'messages'):
        ...
    st.header("Ask Youtube using Oracle GEN AI")
    youtubeid = st.text_input('Enter the desired Youtube video ID or URL here.')
    with st.expander("Advanced options"):
        k_value = st.slider...
        chunk_size = st.slider(...
        chunk_overlap = st.slider('...
    chunk_display = st.checkbox("Display chunk results")
    if youtubeid:
        knowledge_base = fetching_transcript(youtubeid, chunk_size, chunk_overlap)
        user_question = st.text_input("Ask a question about the Youtube video:")
        promptoption = st.selectbox(
            '...
            ("Summarize the transcript", "Summarize the transcript in bullet points"), index=None,
            placeholder="Select a prompt template..."
        )
        ...
    st.write(response)
    if chunk_display:
        ...

if \_\_name\_\_ == "\_\_main\_\_":
    main()
```

## Explanation

This section provides a high-level overview of the key functions and their purposes within the application. Each function is designed to handle specific tasks, such as fetching YouTube video IDs, processing transcripts, generating embeddings, prompting the LLM, and performing chunk searches. This modular design ensures that each component is easily understandable and modifiable, allowing for further customization and enhancement.

## Conclusion

This application demonstrates the capabilities of Oracle Gen AI services by analyzing YouTube video transcripts and providing insightful responses to user queries. By following the provided setup instructions, users can effortlessly run the application and benefit from its interactive and informative features. The modular code structure encourages customization, making it a versatile tool for analyzing video content.


## Acknowledgements

* **Author** - Anshuman Panda, Principal Generative AI Specialist, Alexandru Negrea , AI and App Integration Specialist Leader

**Last Updated By/Date** - Anshuman Panda, Principal Generative AI Specialist, Aug 2024