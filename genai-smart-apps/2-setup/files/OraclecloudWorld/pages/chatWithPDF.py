import streamlit as st
from PyPDF2 import PdfReader
from langchain.text_splitter import CharacterTextSplitter
from langchain_community.embeddings import OCIGenAIEmbeddings
from langchain.vectorstores import Qdrant
from langchain_community.vectorstores.oraclevs import OracleVS
from langchain_community.vectorstores.utils import DistanceStrategy
import oracledb
import pages.utils.config as config
from langchain.memory import ConversationBufferMemory
from langchain.chains import ConversationalRetrievalChain
from pages.utils.htmlTemplates import bot_template, user_template, css
from langchain_community.chat_models.oci_generative_ai import ChatOCIGenAI
from langchain.docstore.document import Document
# from pages.utils.style import set_page_config
# set_page_config()
# Configuration settings
endpoint = config.ENDPOINT
embeddingModel = config.EMBEDDING_MODEL
generateModel = config.GENERATE_MODEL
compartment_id = config.COMPARTMENT_ID

# Function to extract text from PDF files
def get_pdf_text(pdf_files):
    text = ""
    for pdf_file in pdf_files:
        reader = PdfReader(pdf_file)
        for page in reader.pages:
            text += page.extract_text()
    return text

# Function to split text into chunks
def get_chunk_text(text):
    text_splitter = CharacterTextSplitter(
        separator="\n",
        chunk_size=1000,
        chunk_overlap=200,
        length_function=len
    )
    chunks = text_splitter.split_text(text)
    return chunks

# Function to create a vector store
def get_vector_store(text_chunks):
    embeddings = OCIGenAIEmbeddings(
        model_id=embeddingModel,
        service_endpoint=endpoint,
        compartment_id=compartment_id
    )

    documents = [Document(page_content=chunk) for chunk in text_chunks]

    if config.DB_TYPE == "oracle":
        try:
            connection = oracledb.connect(user=config.ORACLE_USERNAME, password=config.ORACLE_PASSWORD, dsn=config.ORACLE_DSN)
            print("Connection to OracleDB successful!")
        except Exception as e:
            print("Connection to OracleDB failed!")
            connection = None

        vectorstore = OracleVS.from_documents(
            documents=documents,
            embedding=embeddings,
            client=connection,
            table_name=config.ORACLE_TABLE_NAME,
            distance_strategy=DistanceStrategy.DOT_PRODUCT,
        )
    else:
        vectorstore = Qdrant.from_documents(
            documents=documents,
            embedding=embeddings,  # Changed from 'embedding' to 'embeddings'
            location=config.QDRANT_LOCATION,
            collection_name=config.QDRANT_COLLECTION_NAME,
            distance_func=config.QDRANT_DISTANCE_FUNC
        )
    
    return vectorstore

# Function to create a conversation chain
def get_conversation_chain(vector_store):
    llm = ChatOCIGenAI(
        model_id=generateModel,
        service_endpoint=endpoint,
        compartment_id=compartment_id,
        model_kwargs={"temperature": 0, "max_tokens": 400}
    )

    memory = ConversationBufferMemory(memory_key='chat_history', return_messages=True)

    conversation_chain = ConversationalRetrievalChain.from_llm(
        llm=llm,
        retriever=vector_store.as_retriever(),
        memory=memory
    )

    return conversation_chain

# Function to handle user input and display the chat history
def handle_user_input(question):
    response = st.session_state.conversation({'question': question})
    st.session_state.chat_history = response['chat_history']

    for i, message in enumerate(st.session_state.chat_history):
        if i % 2 == 0:
            st.write(user_template.replace("{{MSG}}", message.content), unsafe_allow_html=True)
        else:
            st.write(bot_template.replace("{{MSG}}", message.content), unsafe_allow_html=True)

# Main function to set up the Streamlit app
def main():
    st.set_page_config(page_title='Chat with Your own PDFs', page_icon=':books:')

    st.write(css, unsafe_allow_html=True)
    st.write("""
    <style>
        .stTextInput {
            position: fixed;
            bottom: 30px;
            opacity: 0.8;
        }
    </style>
    """, unsafe_allow_html=True)

    if "conversation" not in st.session_state:
        st.session_state.conversation = None

    if "chat_history" not in st.session_state:
        st.session_state.chat_history = None
    
    st.header('Chat with Your own PDFs :books:')
    question = st.text_input("Ask anything to your PDF: ")

    if question:
        handle_user_input(question)
    
    with st.sidebar:
        st.subheader("Upload your Documents Here: ")
        pdf_files = st.file_uploader("Choose your PDF Files and Press OK", type=['pdf'], accept_multiple_files=True)

        if st.button("OK"):
            with st.spinner("Processing your PDFs..."):
                # Get PDF Text
                raw_text = get_pdf_text(pdf_files)

                # Get Text Chunks
                text_chunks = get_chunk_text(raw_text)

                # Create Vector Store
                vector_store = get_vector_store(text_chunks)
                st.write("DONE")

                # Create conversation chain
                st.session_state.conversation = get_conversation_chain(vector_store)

if __name__ == '__main__':
    main()
