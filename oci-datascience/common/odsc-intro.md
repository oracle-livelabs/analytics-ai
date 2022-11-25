# Introduction

## Data Science Service

Oracle Cloud Infrastructure Data Science is a fully managed and serverless platform for data science teams to build, train, and manage machine learning models using Oracle Cloud Infrastructure.

The Data Science Service:
* Provides data scientists with a collaborative, project-driven workspace.
* Enables self-service, serverless access to infrastructure for data science workloads.
* Includes Python-centric tools, libraries, and packages developed by the open source community and the [Oracle Accelerated Data Science SDK](https://docs.cloud.oracle.com/iaas/tools/ads-sdk/latest/index.html) which supports the end-to-end life cycle of predictive models:
    * Data acquisition, profiling, preparation, and visualization.
    * Feature engineering.
    * Model training. 
    * Model evaluation, explanation, and interpretation. 
    * Model deployment.
* Integrates with the rest of the Oracle Cloud Infrastructure stack, including Vault, Data Flow, Big Data Service, Autonomous Data Warehouse, Object Storage, and much more.
* Helps data scientists concentrate on methodology and domain expertise to deliver excellent models to production.

Estimated Workshop Time: 90 minutes

### Objectives

In this lab, you will:
* Become familiar with concepts and terminology used in the Data Science service.

## Data Science Service Concepts

Review the following concepts and terms to help you get started with the Data Science service.

* **Project**: Projects are collaborative workspaces for organizing and documenting Data Science assets, such as notebook sessions and models.
* **Notebook Session**: Data Science notebook sessions are interactive coding environments for building and training models. Notebook sessions come with many pre-installed open source and Oracle developed machine learning and data science packages.
* **Accelerated Data Science SDK**: The Oracle Accelerated Data Science (ADS) SDK is a Python library that is included as part of the Oracle Cloud Infrastructure Data Science service. ADS has many functions and objects that automate or simplify many of the steps in the Data Science workflow, including connecting to data, exploring and visualizing data, evaluating and explaining models. In addition, ADS provides a simple interface to access the Data Science service model catalog and other Oracle Cloud Infrastructure services including Object Storage. To familiarize yourself with ADS, see the [Oracle Accelerated Data Science Library documentation](https://docs.cloud.oracle.com/iaas/tools/ads-sdk/latest/index.html).
* **Model**: Models define a mathematical representation of your data and business processes. 
* **Model Catalog**: The model catalog is a place to store, track, share, and manage models.
* **Model Deployment**: This feature allows you to take a model stored in the model catalog and deployed it as an HTTPS REST endpoint for real-time inference use cases.
* **Jobs**: Jobs give the data scientist the ability to execute batch jobs in either an ad hoc way or via a scheduler. Jobs can be used to perform batch inference, model training, feature engineering, and so on. ADS also provides a rich interface to interact with Jobs.
* **Conda environment**: Condas are collections of specific libraries and other resources that simplify library management. They are used to run notebook sessions, jobs, and deployed models.


## Acknowledgements

* **Author**: [Wendy Yip](https://www.linkedin.com/in/wendy-yip-a3990610/), Data Scientist
* **Last Updated By/Date**:
    * [Wendy Yip](https://www.linkedin.com/in/wendy-yip-a3990610/), Data Scientist, Sept 2022