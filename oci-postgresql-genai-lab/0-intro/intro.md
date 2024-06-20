
# Introduction

## About This Workshop
Using Terraform, we will create a Generative AI / Neural Search to search documents using PostgreSQL and a Google like search interface. Documents like:
- Word, Excel, PDF, ...
- Images with text using AI Document Understanding
- Images without text using AI Vision
- Audio and Videos files 
- Custom document: Belgian ID card images

![Screenshot](images/when-was-jazz-created.png)

The website will have several ways to search:
- Search: Based on *Words* in the documents
- Semantic Search: Based on the *Meaning* (Vector Search)
- Hybrid: Based on the 2 above search
- RAG (Retrieval Augmented Generation): Answer questions based on documents
- and a "Generate" response button.

![Introduction use case](images/opensearch-intro.png)

The procedures in this workshop are designed for users that have obtained an Oracle Cloud free trial account with active credits. The procedures will also work for other Oracle Cloud accounts but may, in some cases, require minor adaptation.

Estimated Workshop Time: 90 minutes

### Architecture

![Architecture](images/postgres-logical-architecture.png)

It works like this:
1. A document is uploaded in the Object Storage by the user
1. An event is raised and queued in Streaming (Kafka)
1. The stream is received and processed by Oracle Integration Cloud (OIC)
1. Based on the file type, OIC will send them to one or more AI services to enrich them and provide searchable text
1. The results are uploaded to an OpenSearch index
1. The user queries OpenSearch using a Visual Builder application

The enrichment processing is orchestrated with OIC, a low code integration service that supports many use cases. This picture shows the processing flow.

![Integration](images/postgres-physical-architecture.png)
The file types supported by the OIC project are hard-coded into different routes in the ObjectStorage2OpenSearch integration using the Switch command. Here's how various file types are processed.
- If the name contains ***belgian***, it is processed by OCI Vision, then the extracted text is classified using OCI Language, and then it is indexed into OpenSearch

- If the file has the extension **.png**, **.jpg**, **.jpeg**, or **.gif**, it is processed by OCI Vision, then the extracted text is classified using OCI Language, and then it is indexed into OpenSearch

- If the file has the extension **.json**, this is an output of the asynchronous AI services such as OCI Speech or OCI Document Understanding. The text is indexed into OpenSearch.

- If the file has the extension **.mp4**, **.avi**, **.mp3**, **.wav**, or **.m4a**, it is processed by OCI Speech and the json output is processed as described above

- If the file has the extension **.tif** or **.pdf**, it is processed by OCI Document Understanding and the json output is processed as described above

- All other file types are sent to the OCI Function with a document parser and extracted text is classified using OCI Language and then indexed into OpenSearch

### Objectives

- Provision the services needed for the system
    - Compartment, Object Storage Bucket, Stream, Event, OpenSearch, OIC, AI services, Visual Builder
- Create an OCI Function to identify the documents
- Integrate the components into a working system
- Create a search user interface
- Process files through the system
- Search for files through the user interface

### Prerequisites
- You need an Oracle Cloud account (i.e. access to an OCI tenancy) to complete this workshop. Participants can take advantage of Oracle's free trial account that comes with free cloud credits that are good for 30 days or until used up. Many Oracle events, such as CloudWorld, offer trial accounts with extra free cloud credits. You should be able to complete this workshop in the allotted time if your free trial cloud account is already created and ready to use. If you previously had a free trial account but the credits have expired, you won't be able to complete the lab. An option in this case is to obtain a new free trial account with fresh credits using a different email address. You can also use an existing paid Oracle Cloud account as long as you have administrator rights that will be needed to provision services.
- You need a computer (laptop or desktop) with web browser, a text editor, and internet access. (Attempting to accomplish this workshop using a tablet or phone might be possible but is not recommended and it hasn't been tested on those types of devices.)
- *The Cloud Account should have access to the Chicago Region* where the Generative AI is available.
    - For Free Trial account, this means that the Free Trial should be created in the Chicago region
    - For Paid account, you will need to add the Chicago Region to your tenancy to access the Generative AI APIs. (See lab 1) 

**Please proceed to the [next lab.](#next)**

## Acknowledgements 
- **Author**
    - Marc Gueury, Master Principal Account Cloud Engineer
    - Badr Aissaoui, Principal Account Cloud Engineer
    - Marek Krátký, Cloud Storage Specialist 
