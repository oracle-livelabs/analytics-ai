import streamlit as st
import requests
from bs4 import BeautifulSoup
import langchain
from langchain.text_splitter import CharacterTextSplitter
from langchain.chains.question_answering import load_qa_chain
from langchain_community.vectorstores import Qdrant
from langchain_community.embeddings import OCIGenAIEmbeddings  # Updated import
from typing import Optional, List, Mapping, Any
from langchain_community.chat_models.oci_generative_ai import ChatOCIGenAI
from langchain_community.tools import WikipediaQueryRun
from langchain_community.utilities import WikipediaAPIWrapper
from io import StringIO
import datetime
import functools
import oracledb  # Assuming OracleDB is properly imported and configured
import pages.utils.config as config  # Import the configuration
from langchain_community.vectorstores.oraclevs import OracleVS
from langchain_community.vectorstores.utils import DistanceStrategy
import oracledb
from pages.utils.style import set_page_config
set_page_config()
compartment_id = config.COMPARTMENT_ID  

# Turn off langchain verbosity
langchain.verbose = False

#-------------------------------------------------------------------
def timeit(func):
    @functools.wraps(func)
    def new_func(*args, **kwargs):
        start_time = datetime.datetime.now()
        result = func(*args, **kwargs)
        elapsed_time = datetime.datetime.now() - start_time
        print('function [{}] finished in {} ms'.format(
            func.__name__, str(elapsed_time)))
        return result
    return new_func

#-------------------------------------------------------------------
@timeit
@st.cache_data(show_spinner="Fetching data from Wikipedia...")
def fetching_article(wikipediatopic, chunk_size, chunk_overlap):
    # Use OCIGenAIEmbeddings for embeddings
    embeddings = OCIGenAIEmbeddings(
        model_id=config.EMBEDDING_MODEL,
        service_endpoint=config.ENDPOINT,
        compartment_id=compartment_id
    )

    # Fetch article from Wikipedia
    wikipage = WikipediaQueryRun(api_wrapper=WikipediaAPIWrapper())
    text = wikipage.run(wikipediatopic)

    # Split the text into chunks
    text_splitter = CharacterTextSplitter(
        separator="\n", chunk_size=chunk_size, chunk_overlap=chunk_overlap, length_function=len
    )
    chunks = text_splitter.split_text(text)

    # Create vector store using Qdrant
    if config.DB_TYPE == "oracle":
        try:
            connection = oracledb.connect(user=config.ORACLE_USERNAME, password=config.ORACLE_PASSWORD, dsn=config.ORACLE_DSN)
            print("Connection to OracleDB successful!")
        except Exception as e:
            print("Connection to OracleDB failed!")
            connection = None
        
        if connection:
            knowledge_base = OracleVS.from_texts(
                chunks,
                embeddings,
                client=connection,
                table_name=config.ORACLE_TABLE_NAME,
                distance_strategy=DistanceStrategy.DOT_PRODUCT,
            )
        else:
            raise Exception("Failed to connect to OracleDB.")
    else:
        knowledge_base = Qdrant.from_texts(
            chunks,
            embeddings,
            location=config.QDRANT_LOCATION,
            collection_name=config.QDRANT_COLLECTION_NAME,
            distance_func=config.QDRANT_DISTANCE_FUNC
        )
    return knowledge_base

#-------------------------------------------------------------------
@timeit
@st.cache_resource(show_spinner="Fetching data from URL...")
def fetching_url(userinputquery, chunk_size, chunk_overlap):
    # Use OCIGenAIEmbeddings for embeddings
    embeddings = OCIGenAIEmbeddings(
        model_id=config.EMBEDDING_MODEL,
        service_endpoint=config.ENDPOINT,
        compartment_id=compartment_id
    )

    # Fetch page content from URL
    page = requests.get(userinputquery)
    soup = BeautifulSoup(page.text, 'html.parser')
    text = soup.get_text()

    # Split the text into chunks
    text_splitter = CharacterTextSplitter(
        separator="\n", chunk_size=chunk_size, chunk_overlap=chunk_overlap, length_function=len
    )
    chunks = text_splitter.split_text(text)

    # Create vector store 
    if config.DB_TYPE == "oracle":
        try:
            connection = oracledb.connect(user=config.ORACLE_USERNAME, password=config.ORACLE_PASSWORD, dsn=config.ORACLE_DSN)
            print("Connection to OracleDB successful!")
        except Exception as e:
            print("Connection to OracleDB failed!")
            connection = None
        
        if connection:
            knowledge_base = OracleVS.from_texts(
                chunks,
                embeddings,
                client=connection,
                table_name=config.ORACLE_TABLE_NAME,
                distance_strategy=DistanceStrategy.DOT_PRODUCT,
            )
        else:
            raise Exception("Failed to connect to OracleDB.")
    else:
        knowledge_base = Qdrant.from_texts(
            chunks,
            embeddings,
            location=config.QDRANT_LOCATION,
            collection_name=config.QDRANT_COLLECTION_NAME,
            distance_func=config.QDRANT_DISTANCE_FUNC
        )
    return knowledge_base

#-------------------------------------------------------------------
@timeit
def prompting_llm(user_question, _knowledge_base, _chain, k_value):
    with st.spinner(text="Prompting LLM..."):
        doc_to_prompt = _knowledge_base.similarity_search(user_question, k=k_value)
        docs_stats = _knowledge_base.similarity_search_with_score(user_question, k=k_value)
        print('\n# '+datetime.datetime.now().astimezone().isoformat()+' =====================================================')
        print("Prompt: "+user_question+"\n")
        for x in range(len(docs_stats)):
            try:
                print('# '+str(x)+' -------------------')
                content, score = docs_stats[x]
                print("Content: "+content.page_content)
                print("\nScore: "+str(score)+"\n")
            except:
                pass

        # Calculating prompt length
        prompt_len = _chain.prompt_length(docs=doc_to_prompt, question=user_question)
        st.write(f"Prompt len: {prompt_len}")

        # Grab and print response
        response = _chain.invoke({"input_documents": doc_to_prompt, "question": user_question}, return_only_outputs=True).get("output_text")
        print("-------------------\nResponse:\n"+response+"\n")
        return response
    
#-------------------------------------------------------------------
@timeit
def chunk_search(user_question, _knowledge_base, k_value):
    with st.spinner(text="Prompting LLM..."):
        doc_to_prompt = _knowledge_base.similarity_search(user_question, k=k_value)
        docs_stats = _knowledge_base.similarity_search_with_score(user_question, k=k_value)
        result = '  \n '+datetime.datetime.now().astimezone().isoformat()
        result = result + "  \nPrompt: "+user_question+ "  \n"
        for x in range(len(docs_stats)):
            try:
                result = result + '  \n'+str(x)+' -------------------'
                content, score = docs_stats[x]
                result = result + "  \nContent: "+content.page_content
                result = result + "  \n  \nScore: "+str(score)+"  \n"
            except:
                pass    
        return result

#-------------------------------------------------------------------
def main():
    # Initialize OCIGenAI for language generation
    llm = ChatOCIGenAI(
        model_id=config.GENERATE_MODEL,
        service_endpoint=config.ENDPOINT,
        compartment_id=compartment_id,
        model_kwargs={"temperature": 0, "max_tokens": 400}
    )

    # Load question answering chain
    chain = load_qa_chain(llm, chain_type="stuff")

    # Adjusting prompt template for assistance
    if hasattr(chain.llm_chain.prompt, 'messages'):

        for message in chain.llm_chain.prompt.messages:

            if hasattr(message, 'template'):

                message.template = message.template.replace("Helpful Answer:", "\n### Assistant:")
            
#-------------------------------------------------------------------
    # Streamlit page setup
    # st.set_page_config(page_title="Ask Wikipedia or URL", layout="wide")
    st.header("Ask any website using Oracle Gen AI")
    userinputquery = st.text_input('Add the desired Wikipedia topic here, or a URL')

    with st.expander("Advanced options"):
        k_value = st.slider('Top K search | default = 6', 2, 10, 6)
        chunk_size = st.slider('Chunk size | default = 1000 [Rebuilds the Vector store]', 500, 1500, 1000, step=20)
        chunk_overlap = st.slider('Chunk overlap | default = 20 [Rebuilds the Vector store]', 0, 400, 200, step=20)
        chunk_display = st.checkbox("Display chunk results")

    if userinputquery:
        if userinputquery.startswith("http"):
            knowledge_base = fetching_url(userinputquery, chunk_size, chunk_overlap)
        else:
            knowledge_base = fetching_article(userinputquery, chunk_size, chunk_overlap)
       
        user_question = st.text_input("Ask a question about the loaded content:")
        
        promptoption = st.selectbox(
                        '...or select a prompt templates',
                        ("Summarize the page", "Summarize the page in bullet points"), index=None,
                        placeholder="Select a prompt template...")
        
        if promptoption:
            user_question = promptoption
            
        if user_question:
            response = prompting_llm("This is a web page, based on this text " + user_question.strip(), knowledge_base, chain, k_value)
            st.write("_"+user_question.strip()+"_")
            st.write(response)
            if chunk_display:
                chunk_display_result = chunk_search(user_question.strip(), knowledge_base, k_value)
                with st.expander("Chunk results"):
                    st.code(chunk_display_result)
#-------------------------------------------------------------------

if __name__ == "__main__":
    main() 
