# apply database operations

## Introduction

This lab will walk you thru staging and loading of autoclaims data into the Autonomous Database created in previous steps. You will stage data in an object storage bucket, use the api key to create a cloud store for the object storage bucket, load data from the bucket into the autonomous database and create an auto table using parquet files in object storage bucket.

Estimated Time: 30 minutes

### Objectives


In this lab, you will:
* Create an Object Storage Bucket
* Create Cloud Storage location for Object Storage Bucket
* Load data from Object Storage bucket into Autonomous database
* Create an auto table for telemetry in parquet files

### Prerequisites

 
This lab assumes you have:
* An Oracle Cloud account with privileges to access Generative AI services, provision Autonomous Database and add API keys
 

## Task 1: Create Autonomous Database