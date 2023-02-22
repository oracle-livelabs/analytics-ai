# Train Anomaly Detection Univariate Model And Detect

## Introduction

In this session, we will show you how to train an univariate anomaly detection model, and make predictions with new data.

[Step by step walkthrough of a univariate anomaly detection example](youtube:xTJBpAhaIcs)

***Estimated Time***: 30 minutes

### Objectives

In this lab, you will:
- Learn to train an anomaly detection model with created data asset
- Learn to verify the trained model performance
- Upload testing data to check detection result

### Prerequisites

- A Free tier or paid tenancy account in OCI
- Understand basic model terminology FAP - False Alarm Probability

## Task 1: Create a Model

Creating a model is requiring the 3 actions to kick off training the AD model.

* Select the proper compartment and data asset that we just created.
* Set training parameters
* Train a model

Select the proper compartment(e.g, the compartment matching your name or company name), and then the project you have created.
![select compartment](../images/selectCompartmentModelTrain.png " ")

Once the project ad_demo is selected, it will navigate the User to Created Anomaly Detection Project, then click "Create and Train Model".
![create model](../images/5_create_a_new_model.png " ")

The data asset created in previous lab session should be pop up in the drop down menu. Click "Next" button.
![choose an existing dataset](../images/choose_an_existing_dataset.png " ")

This takes us to "Train Model" form with parameter selections.

We can specify FAP(false alarm probability) and Train Fraction Ratio. The default values for these are 0.01 and 0.7 (implying 70%) respectively.

###FAP (False Alarm Probability)

FAP stands for False Alarm Probability, which is basically the likelihood (percentage) of a timestamp is flagged as anomaly in the clean (anomaly-free) training data. It is calculated at every signal level and then averaged across all signals as the final achieved FAP by our model.  

A model with high FAP means the likelihood of an anomaly flagged by AD service to be a false alarm is high. If this is not desired, depending on the sensitivity requirements of a user, user can specify it to be low.

Typically, FAP can be set to be around the same level of percentage of anomalies in real business scenarios, and a value 0.01 or 1% is relatively appropriate for many scenarios. Also, be aware that if specifying a lower target FAP, the model needs more time to train, and may not achieve to the target FAP.

###How to calculate FAP

![fap formula](../images/fap-formula.png " ")

**FAP = sum(number of anomalies in each signal) / (number of signals * number of timestamps)**

As can be inferred from the formula, the more the number of false alarms allowed for the model to learn, the higher FAP will be.

###Train Fraction Ratio

Train Fraction Ratio specifies the ratio of the whole training data used for our algorithm to learn the pattern and train the model. The rest (1-ratio) of training data will be used for our algorithm to evaluate and report model performance (e.g., FAP). The default value 0.7 or 70% specifies the model to use 70% of the data for training, and the rest 30% is used to produce model performance.

In this demo data set, the default value for FAP and Train Fraction Ratio are appropriate, we will leave them as is.
![create and train univariate model](../images/create_and_train_model.png " ")

![review model creation](../images/create_and_train_model_2.png " ")

Click Submit. For this demo dataset, it takes **10-15 minutes** to finish training a model.
![model creating](../images/model_creation.png " ")

Once the model is trained successfully, it is automatically ready for detecting anomalies from new data. User can either use the cloud Console (next step) or the endpoint to send new testing data.

## Task 2: Detect Anomaly synchronously with new Data

### Upload to UI

To start the  process of anomaly detection select "Detect Anomalies" on the Model listing page.
![click detect anomalies](../images/click-detect-anomalies.png " ")

Select a file from local filesystem or drag and drop the desired file.
![upload data to detect anomaly](../images/detect-anomaly-upload-data-form.png " ")

**Note: The detection data can have up to 30,000 data points (number of signals times number of timestamps).**

Once the test file is uploaded, now click Detect button.

The detection result will return immediately, and you have the option to select the column to see related anomalies.

Use the drop wizard to select a column to see anomalies.
![select column droplist for univariate detection results](../images/detect-result-select-column-droplist-univariate.png " ")

**Explanation of the Graph**

Each signal in your detection data can be selected to show a separate graph.

In the graph, horizontal axis represents the timestamp (or indexes if no timestamp was provied), and the vertical axis represents sensor values.

In each subgraph, orange line indicates the actual input value of a signal, purple line indicates the predicted value by the machine learning model, and red line indicates anomaly being detected at that timestamp. If more than one signals exist in the dataset, a dropdown for all the signal names will be available.

There are two additional subgraphs after sensor subgraphs:

* The Anomaly Score Per Signal shows the significance of anomaly at individual signal level for a given timestamp. Not all the signals flag anomalies at the same time.
* The Aggregated Anomaly Score is only available for a multivariate model. Only looking at the anomaly score per signal is sufficient.

You can move your mouse over the graph, the actual value & estimated value at a certain timestamp will show at the upper right corner of the graph.

Lets select value and anomaly score per signal to have a cleaner layout to see where the model has detected an anomaly.

![univariate anomaly result graph](../images/anomaly-result-graph-univaraite-sen0.5.png " ")

The part of the signal where the model has determined to be an anomaly is highlighted. There is also an option to download the anomaly detection result.

Click the "Download JSON" button, it will download a file named anomalies.json, with the following content after pretty formatting.
 ```json
 [
  {
    "timestamp": "2021-03-18T00:00:00.000+00:00",
    "anomalies": [
      {
        "signalName": "value",
        "actualValue": 3132364.34206113,
        "estimatedValue": 818404.8901145846,
        "anomalyScore": 0.91
      }
    ]
  },
  {
    "timestamp": "2021-03-18T01:00:00.000+00:00",
    "anomalies": [
      {
        "signalName": "value",
        "actualValue": 1980697.672616325,
        "estimatedValue": 951127.7037798172,
        "anomalyScore": 0.5438586438042919
      }
    ]
  }
]
 ```

The results return an array of anomalies grouped by timestamp. Each timestamp could have anomalies generated by single or multiple signals. Anomaly generated by one signal contains a tuple of signal name, actual value, estimate value, and an anomaly score with in the range of 0 to 1 that indicate the significance of anomaly. Meanwhile, each timestamp also have a normalized score that combines the significance scores across single or multiple alerted signals.

**Sensitivity Tuning**

Sensitivity is a parameter ranging from 0 and 1 that controls how sensitivity the algorithm is outputting the anomalies. The default value is 0.5. The higher the sensitivity parameter, the more anomalies our solution will flag. As an example, if we customize the sensitivity as 0.51 rather than the default value 0.5 for the same test data.

![upload data to detect anomaly with sensitivity 0.51](../images/detect-anomaly-upload-data-form-univariate-sensitivity.png " ")

![univariate anomaly result graph with sensitivity 0.51](../images/anomaly-result-graph-univaraite-sen0.51.png " ")

This is the results file downloaded:
 ```json
 [
   {
     "timestamp": "2021-03-17T14:00:00.000+00:00",
     "anomalies": [
       {
         "signalName": "value",
         "actualValue": 1133639.109484883,
         "estimatedValue": 1010844.540918226,
         "anomalyScore": 0.2572041523905171
       }
     ]
   },
   {
     "timestamp": "2021-03-18T00:00:00.000+00:00",
     "anomalies": [
       {
         "signalName": "value",
         "actualValue": 3132364.34206113,
         "estimatedValue": 818404.8901145846,
         "anomalyScore": 0.91
       }
     ]
   },
   {
     "timestamp": "2021-03-18T01:00:00.000+00:00",
     "anomalies": [
       {
         "signalName": "value",
         "actualValue": 1980697.672616325,
         "estimatedValue": 951127.7037798172,
         "anomalyScore": 0.5438586438042919
       }
     ]
   },
   {
     "timestamp": "2021-03-18T14:00:00.000+00:00",
     "anomalies": [
       {
         "signalName": "value",
         "actualValue": 1150601.718048229,
         "estimatedValue": 1034970.7609649705,
         "anomalyScore": 0.26274424377191463
       }
     ]
   },
   {
     "timestamp": "2021-03-19T17:00:00.000+00:00",
     "anomalies": [
       {
         "signalName": "value",
         "actualValue": 847211.507556418,
         "estimatedValue": 710136.3783229797,
         "anomalyScore": 0.7300000000000001
       }
     ]
   },
   {
     "timestamp": "2021-03-19T18:00:00.000+00:00",
     "anomalies": [
       {
         "signalName": "value",
         "actualValue": 694509.175506408,
         "estimatedValue": 606504.5548762243,
         "anomalyScore": 0.7400000000000001
       }
     ]
   },
   {
     "timestamp": "2021-03-19T19:00:00.000+00:00",
     "anomalies": [
       {
         "signalName": "value",
         "actualValue": 518569.690032113,
         "estimatedValue": 502872.73142946884,
         "anomalyScore": 0.7500000000000001
       }
     ]
   },
   {
     "timestamp": "2021-03-19T20:00:00.000+00:00",
     "anomalies": [
       {
         "signalName": "value",
         "actualValue": 378591.76660394,
         "estimatedValue": 399240.9079827134,
         "anomalyScore": 0.7600000000000001
       }
     ]
   },
   {
     "timestamp": "2021-03-23T14:00:00.000+00:00",
     "anomalies": [
       {
         "signalName": "value",
         "actualValue": 1192612.395582294,
         "estimatedValue": 1067845.9858714943,
         "anomalyScore": 0.27646518720251817
       }
     ]
   },
   {
     "timestamp": "2021-03-24T14:00:00.000+00:00",
     "anomalies": [
       {
         "signalName": "value",
         "actualValue": 1142870.44081043,
         "estimatedValue": 1024345.733837085,
         "anomalyScore": 0.2602191614868185
       }
     ]
   }
 ]
  ```

**Congratulations on completing this lab!**

You now have completed the full cycle of using the training data to create a model and deploy, and also making predictions with testing data.

The next 2 sessions are optional for advanced users, which cover the topic on using REST API to integrate our services and how to prepare the training and testing data from raw data in different scenarios.

## Acknowledgements

* **Authors**
    * Jason Ding - Principal Data Scientist - Oracle AI Services
    * Haad Khan - Senior Data Scientist - Oracle AI Services
    * Marianne Liu - Senior Data Scientist - Oracle AI Services
    * Longjiao Zhang - Senior Data Scientist - Oracle AI Services
* **Last Updated By/Date**
* Marianne Liu - Senior Data Scientist Feb 2023
* Longjiao Zhang - Senior Data Scientist Feb 2023
