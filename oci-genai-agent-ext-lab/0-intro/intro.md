
# Introduction

## About This Workshop
In this workshop, you will create a OCI Enterprise AI Vector Store and enable document search capabilities.

The workshop covers:
- Manual installation and testing of Vector Store (Lab 1)
- Installation of supporting components using Terraform (Lab 2)
- Building user interfaces with:
    - APEX (Lab 3)
        ![Screenshot APEX](images/apex-jazz.png =500x500)
    - LangGraph (Lab 4)
        ![Screenshot LangGraph](images/langgraph-jazz.png =500x500)
    - ReactJS (Lab 5)
        ![Screenshot ReactJS](../5-reactjs/images/reactjs-headphones.png =500x500)
    - Oracle Digital Assistant (Lab 6)
        ![Screenshot Digital Assistant](../6-digital-assistant/images/oda-webchat.png =500x500)    

You will search documents such as:
- Video and audio files using OCI Speech
- Images using OCI Vision
- TIFF files (FAX) using OCI Document Understanding
- Word, Excel, PowerPoint, etc. using OCI Functions
- Websites using:
      - A crawler (for all pages of a website, based on sitemap or not)
      - Or Selenium (for a fixed number of URLs)

Lab 6 explains how to customize the demo to your needs.

Estimated Workshop Time: 90 minutes

## Vector Store

First, you will manually install a vector store, upload files to Object Storage, synchronize, and test it.

![Architecture](images/vector-store.png)

## Logical Architecture

Then, from Lab 2, you will install a Terraform stack that preprocesses files in different formats before inserting them into the Vector Store.

This diagram shows the processing flow.

![Architecture](images/logical-architecture.png)

It works like this:
1. A document is uploaded to the "UPLOAD" Object Storage bucket by the user.
2. An event is raised and queued. A Python program running on a VM processes the event. Based on the file type, it sends the file to one or more AI services to extract searchable text.
3. The searchable text is uploaded to the "CONVERTED" Object Storage bucket.
4. The Vector Store ingests the new files.
5. The user queries the Generative AI Agent.

Here's how various file types are processed:

- **.pdf**, **.txt**, **.csv**, **.md**: Copied directly to the CONVERTED Object Storage bucket.
- **.png**, **.jpg**, **.jpeg**, **.gif**: Processed by OCI Vision. Output stored in CONVERTED Object Storage.
- **.mp4**, **.avi**, **.mp3**, **.wav**, **.m4a**: Processed by OCI Speech.
- **.tif**: Processed by OCI Document Understanding.
- **.json**: Output from asynchronous AI services (e.g., OCI Speech, OCI Document Understanding).
- **.doc**, **.docx**, **.ppt**, **.pptx**: Converted to PDF first.
- All other types: Sent to an OCI Function with a generic document parser.

## Physical Architecture

The following architecture will be installed using Terraform.

![Integration](images/physical-architecture.png)

## Objectives

- Provision the services needed for the system:
  - Compartment
  - Object Storage buckets
  - Stream
  - Events
  - Vector Store
  - Enterprise AI
  - Virtual Machine
- Integrate the components into a working system
- Search for files through several types of user interfaces

**Please proceed to the [next lab](#next).**

## Acknowledgements

- **Author**
    - Marc Gueury, Generative AI Specialist
    - Maurits Dijkens, Generative AI Specialist
    - Ras Alungei, Generative AI Specialist