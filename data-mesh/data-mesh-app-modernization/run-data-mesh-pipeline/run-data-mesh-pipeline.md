# Run Data Mesh pipeline

## Introduction

This lab will allow you to explore the workload in action. You will start by running the feed script, then observe the events being published within GoldenGate Stream Analytics. Then you will explore the pipeline and see the transformations taking place until the data product is complete and deployed to two different targets. You will then see the data exposed by the microservice and in Oracle Analytics Server.

### Objectives

- Run MedRec insert script
- View medical records in GGSA
- Analyze data products using OAS
- View data product as JSON using microservices

### Prerequisites
<!-- Check host name -->
  This lab assumes you have:
  - Obtained and signed in to your `dmmodernbastion` compute instance

## Task 1: Run MedRec insert script

<!-- Check script name -->
1. To start the workload, run the `insert_medical.sh` script. This script will insert medical records into our database. The records will be inserted at a slower pace to mimick real-time inserts.
<!-- Check path-->
    ```
    $ <copy>sh ~/dmodernConfigscripts/insert_medical.sh</copy>
    ```

## Task 2: View medical records in GGSA

1. Now, go to **Firefox** and view the GoldenGate Stream Analytics dashboard.

2. Under events, you should see a stream of records being picked up by GGSA.

3. <!-- Go through pipeline -->
4. <!-- TODO: Jade, Hannah? -->


## Task 3: Analyze data products using OAS

<!-- View from OAS -->
<!-- TODO: Amit-->

## Task 4: View data product as JSON using microservices

<!-- Go through different endpoints-->
<!-- TODO: Matthew-->