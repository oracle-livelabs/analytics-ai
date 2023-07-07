
# Introduction

Using low code cloud services in Oracle Cloud Infrastructure (OCI), this workshop will illustrate how to create a system to search the full text of document images using OpenSearch and a familiar search interface created with Visual Builder.

The focus of this workshop is making document images searchable. These document images are typically text documents that have been scanned to .tif or .jpg, or exported as .pdf. However the system you'll build will handle many different document types such as:
- Word, Excel, PDF 
- Images with text using AI text recognition
- Images without text using AI Vision
- Custom document: Belgian ID card images

![Introduction Usecase](images/opensearch-intro.png)

The procedures in this workshop are designed for users that have obtained an Oracle Cloud free trial account with active credits. 

Total estimated time: 90 minutes

### Architecture

![Architecture](images/opensearch-architecture.png)

It works like this:
1. A document is uploaded in the Object Storage
1. An event is raised and queued in Streaming (Kafka)
1. The events are processed by Oracle Integration Cloud (OIC)
1. Based on the file type, OIC will send them to AI services to enrich them and provide searchable data
1. The results are uploaded to an OpenSearch index
1. The user queries OpenSearch using a Visual Builder application

The enrichment processing is orchestrated with OIC, a low code integration service that supports many use cases. This picture shows the processing flow.

![Integration](images/opensearch-oic.png)



### Objectives

- Provision the services needed for the system
    - Compartment, Object Storage Bucket, Stream, Event, OpenSearch, OIC, AI services, Visual Builder
- Create an OCI Function to identify the documents
- Integrate the components into a working system
- Create a search user interface

### Prerequisites
- You need an Oracle Cloud account (i.e. access to an OCI tenancy) to complete this workshop. Participants can take advantage of Oracle's free trial account that come with free cloud credits that are good for 30 days or until used up. Many Oracle events, such as CloudWorld, offer trial accounts with extra free cloud credits. You should be able to complete this workshop in teh allotted time if your free trial cloud account is already created and ready to use. If you previously had a free trial account but the credits have expired, you won't be able to complete the lab. An option in this case is to obtain a new free trial account with fresh credits using a different email address. You can also use an existing paid Oracle Cloud account as long as you have administrator rights that will be needed to provision services.
- You need a computer (laptop or desktop) with web browser, a text editor, and internet access. (Attempting to accomplish this workshop using a tablet or phone might be possible but is not recommended and we haven't tested it on those types of devices.)

## Please proceed to the next lab.

## Acknowledgements 
- **Author**
    - Marc Gueury
    - Badr Aissaoui
    - Marek Krátký 
- **History** - 27 Mar 2023