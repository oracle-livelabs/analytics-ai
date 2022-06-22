# Forecasting Service

## Introduction

Forecasting is a common data science problem across several industry domains. Companies try to forecast future key business metrics such as demand, sales, revenue, inventory, and others that aid in effective planning and goal setting. A few forecasting use cases are ATM cash flow forecasting, demand forecasting, sales forecasting in the presence of promotions in the retail industry

OCI Forecasting Service offers state-of-the-art machine learning & deep learning algorithms to deliver high-quality and reliable forecasts with AutoML capability such as automatic data preprocessing and developer-focused AI explainability. 

OCI Forecasting Service will create customized machine learning models trained on the data uploaded by users. Users will be able to submit historical data as inline data and data assets (created with data upload in the OCI object storage) via forecasting end-points and get the forecast for the desired horizon. In addition to providing forecasts, this service also provides predictions explanations from the model by leveraging state-of-the-art model explainability techniques.
 
The *OCI Forecasting Service* is a fully managed, serverless, and multi-tenant service and is accessible over public *REST APIs* by authenticated users via OCI Console or Data Science Notebooks. OCI CLI and SDK will be added in upcoming releases.

In this workshop, users will get familiar with data requirements and the full cycle of building the forecasting model and generate forecasts. We have two different options to generate forecast:
- *Option 1 (20 mins):* Lab-1 describes how to use Forecasting AI Service using OCI Console 
- *Option 2 (50 mins):* Lab-2 describes how to use Forecasting AI Service using Data Science Notebook

At the end of the workshop, users will understand how the data should be prepared and leverage the APIs via Data Science Notebook or the OCI Console for model training and getting forecasts with explainability.

*Estimated Workshop Time*: 70 minutes (20 mins if we only go through Lab-1, else 70 mins if we go through both)

### Objectives:

* Understand high level overview of the OCI Forecasting Service
* Understand the workflow of services provided in the OCI Forecasting Service
* Learn to use REST API to interact with OCI Forecasting Service
* Learn basic data analysis preprocessing techniques to prepare data for model training
* Hands-on activities to experience the whole pipeline of machine learning model development from training to forecasting

### Prerequisites:
* An OCI Free Tier, or Paid OCI Account
* Grant proper permission for user to use the OCI Forecasting Service
* Additional pre-requisites (cloud services) are mentioned per lab
* Familiar with services on Oracle Cloud Infrastructure (OCI), such as Data Science Notebooks, Object Storage
* Familiar with machine learning, data processing, statistics is desirable, but not required
* Familiar with Python/Java programming is strongly recommended (Optional for API integration)
* Familiar with editing tools (vim, nano) or shell environments (cmd, bash, etc) (Optional for API integration)

## Forecasting Service Concepts
* OCI Forecasting Service Console: Learn how to use the OCI Forecasting Service from the OCI Console 
* Data Science Notebook Session: Learn how to use the OCI Forecasting Service with [Data Science Notebook Session](https://docs.oracle.com/en-us/iaas/data-science/using/use-notebook-sessions.htm)
* Projects: Projects are collaborative workspaces for organizing data assets, models, and forecasting portals.
* Data Assets: An abstracted data format to contain primary, additional and meta information of the actual data source for model training.
* Models: The model that is trained by forecasting algorithms and can forecast using univariate/multivariate time-series data along with meta data. A few parameters with default values are exposed so that user can choose to select.
* Forecasts: Once a model is trained successfully, it is automatically deployed with an endpoint ready to generate forecast.

## Forecasting Service Process

At a high level, here is the process for completing full cycle of using the OCI Forecasting Service using the OCI Console or Data Science Notebook Session:

* Create a project: A project is used to include and organize different assets, models and private endpoints for data connection in the same workspace.
* Create a data asset: Data asset is an abstracted data representation for a data source. Currently it supports inline data generated from  csv files uploaded in the notebook session folder. 
* Train a model: After specifying a data asset and the training parameters, we can train a forecasting  model. It will take 3-5 minutes or longer depending on the data size and number of models to be trained as parameter. Once a model is trained successfully, it is deployed automatically with an endpoint ready to generate forecast.
* Forecasting - We call the GET Forecast API to get the forecast

Note that one project can have multiple data assets and multiple forecasts.

We can now proceed to the next section 

## Acknowledgements
* **Authors**
    * Ravijeet Kumar, Senior Data Scientist - Oracle AI Services
    * Anku Pandey, Data Scientist - Oracle AI Services
    * Sirisha Chodisetty, Senior Data Scientist - Oracle AI Services
    * Sharmily Sidhartha, Principal Technical Program Manager - Oracle AI Services
    * Last Updated By/Date: Ravijeet Kumar, May 2022
