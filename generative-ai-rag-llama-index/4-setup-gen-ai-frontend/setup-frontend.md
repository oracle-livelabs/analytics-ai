# Lab 4: Setting up Streamlit Frontend

The final lab will cover setting up our front end, which is built on the open source Python package **streamlit**. To orchastrate our RAG pipeline(refer to detailed explanation in Lab 3 for detailed overview) we will use **Llama-Index** to setup our LLM Chain and experiment with hyperparameters.

### Prerequisites
* Labs 1 and 2 of this Livelab.
## Task 1: Update Config File(Database)

Assuming that you have gone through all the previous steps, you should now have all the parameters you need to run our application. One final thing we need to do before running the app is collect the paramaters that we need to run it:


1. Navigate to the **Autonomous Database** that we created on [Lab 1](../1-create-vector-db/create-vector-db.md).
    ![ADB Navigation Menu](images/adb_navigation_menu.png)
2. Once you are in Autonomous Database details page, click **Database Connections**.
    ![Database Connections](images/database-connections.png)
3. Scroll down to the bottom and copy one of the **service names**.
    ![ODB Service Names](images/adb-service-names.png)
4. Navigate to your favorite code editor in the remote compute instance and fill out the DB details.
    ![Config File](images/config_file.png)

## Task 2: Update Config File(OCI Generative AI)

1. Click the hamburger menu, navigate to **Identity&Security** then **Compartments**.
    ![Compartments](images/compartments.png)
2. Choose a compartment, Copy OCID of the Compartment. 
3. Navigate back to config file and paste.

## Task 3: (Optional): Cohere Reranker

Reranker is an optional step on our pipeline, but one that can improve relevancy of results by putting it through another processing layer.(what?) OCI does not have the Reranker as a service, but for testing purposes Cohere offers a reranker api that we can use. To get a Cohere API key, please navigate to [Cohere Website](https://cohere.com).

## Task 4: Running Front End code

The following steps will

## Task 5: Experimenting with RAG Frontend
