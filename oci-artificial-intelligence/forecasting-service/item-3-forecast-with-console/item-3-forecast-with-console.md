# Lab 1: Learn how to access Forecast Service from OCI Console

## Introduction

In this section, we will learn how to create the forecast project, upload data into object storage, create the data assets, train the model, and get forecasts and predictions intervals for the desired forecast horizon from OCI Console

***Estimated Time***: 20 minutes

### Objectives
- Learn how to set up pre-requisites for using the OCI console
- Learn about data requirements and download data
- Learn how to create a forecast project from the console
- Learn how to upload data into the OCI object storage
- Learn how to create a data asset to refer to data in the OCI object storage
- Learn to train a forecasting model with created data asset
- Explore forecast results and prediction intervals

### Prerequisites
- A free tier or paid tenancy account in OCI
- If user is using <b>LiveLabs Sandbox  button </b>, then skip <b>Task-1</b> and proceed directly from <b>Task-2</b>(Understand Data Requirements)
- However, if user is using their own tenancy then tenancy must be whitelisted to use OCI Forecasting Service. Whitelisting request for your tenancy can be done by providing your details here: [Oracle Beta Programs](https://pdpm.oracle.com/pls/apex/f?p=108:501:108121904414715::::P501_SELF_NOMINATION:Self-Nomination " "). 
- Tenancy must be subscribed to US West (Phoenix)
- Completed ***Introduction and Getting Started*** sections

## Task 1: Set up pre-requisites for console (Need only if user is using their own tenancy)

1. If the user tenancy is not subscribed to US West (Phoenix) then we should look for the tenancy region drop-down for US West (Phoenix) and select it as shown below:
        ![Subscribe to Region US-West Phoenix](images/lab5-subscribe-us-west-phnx.png " ")

2. Create a Dynamic group in the user tenancy by below steps:

    - Go to Identity & Security from the Sidebar Menu of the OCI console and select Dynamic Groups
        ![Select Dynamic Group](images/lab5-select-dynamic-group.png " ")

    - Create Dynamic Group
        ![Create Dynamic Group](images/lab5-click-create-dynamic-group.png " ")

    - Fill in the below details in the relevant fields as shown in image:
        Name: DynamicGroupRPSTAccess (This name is an Eg. , you can keep your name)
        Rule: ANY {resource.type='aiforecastproject'}
        DynamicGroupRPSTAccess is to allow Forecasting service to manage (read & write) Customer’s Object Storage
        ![Fill Details for Dynamic Group](images/lab5-create-and-save-dynamic-group.png " ")
        
    - We can verify that the dynamic group DynamicGroupRPSTAccess is created:
        ![Verify Dynamic Group](images/lab5-dynamic-group-created.png " ")

3. Create a Policy in the user tenancy by following below steps:

    - Go to Identity & Security from Sidebar Menu of the OCI console and select Policies
        ![Select Policy](images/lab5-navigate-to-policy.png " ")

    - Create policy
        ![Click Create Policy](images/lab5-click-on-create-policy.png " ")

    - Fill in the below details in the relevant fields as shown in the image:

        Name: FC_POLICY

        Option 1: 
        If you want to add policy only at tenancy level then please add below policy statements. Adding policy  at tenancy level will let the user access to all resources in the tenancy
        
        ```
        <copy>
        Allow dynamic-group DynamicGroupRPSTAccess to manage objects in tenancy
        Allow dynamic-group DynamicGroupRPSTAccess to read buckets in tenancy
        </copy>
        ```

        ![Create Policy](images/lab5-create-policy.png " ")

        Option 2: 
        If you want to add policy ONLY at compartment level then please replace above policy statements as mentioned below. Adding policy ONLY at compartment level will limit the user to access resources only in their compartment:
        ```
        <copy>
        Allow dynamic-group DynamicGroupRPSTAccess to manage objects in compartment <compartment-name>
        Allow dynamic-group DynamicGroupRPSTAccess to read buckets in compartment <compartment-name>
        </copy>
        ```


    - We can verify that the FC_POLICY policy has been created:     
        ![Verify Policy](images/lab5-policy-created.png " ")

    - Now, we are ready to use Object Storage for the OCI Forecasting service   
    
    - Administrator user policies :
    In addition to the above, the **tenancy admin** should allow the group to manage the OCI forecasting service. Admin can do so by modifying the existing policy for the user group or new policy for the user group
        ```
        <copy>
        Allow group <group-name> to manage ai-service-forecasting-family in tenancy
        Allow group <group-name> to manage ai-service-forecasting-family in compartment <compartment-name>
        </copy>
        ```
        ``` <group-name> ``` is the name of the group to which user is added

        ``` <compartment-name> ``` is the name of the compartment to which user is added 
    

## Task 2: Understand Data Requirements
OCI forecasting service provides an AutoML solution with multiple univariate/multivariate algorithms that can run on single series or multiple series at once. There are some data validations and data format requirements that the input data must satisfy.

### **Data Validations**
For a successful forecast, the input data should pass the following data validations:

* Number of missing values <= 10% of series length
* If the series is non-seasonal, at least one non-seasonal method needs to be available for running.
* Number of missing values for 5 consecutive time steps is not allowed
* All the timestamps in the primary data source should exist in the secondary data source
* The number of rows in the additional data source should be equal to the number of rows in the primary data source + forecast horizon size (adjusted by input and output frequency).
* There should be no duplicate dates in the time-series in either the additional and primary data files.

### **Data format requirements**

- **Primary Data:**
The input data should contain Series id, timestamp, and target variable which you want to forecast

- **Additional Data:**
The data should contain Series id, timestamp, and additional influencer that help in forecasting the target variable, given primary data

- **Meta Data:**
The input data can also have meta data that help multivariate algorithms in forecasting by identify homogeneous series. The primary data should have three columns - timestamp, target column, and a column for the series id. The additional data should have a timestamp column, a series id column, and columns for additional influencers. The meta data should have a series id column, and any number of columns for meta data information for that particular series. Each series will have one observation in meta data 

- timestamp column should contain dates in standard [ISO 8601]('https://en.wikipedia.org/wiki/ISO_8601') format. Allowed formats: "yyyy-MM-dd","yyyy-MM-dd HH:mm:ss","yyyy-dd-MM HH:mm:ss","MM-dd-yyyy HH:mm:ss" ,"dd-MM-yyyy HH:mm:ss","dd-MM-yyyy","MM-dd-yyyy", "yyyy-dd-MM" 
- target_column should contain target values of time series. For example it be sales number of a sales data 
- series_id column should contain identifiers for different series e.g., if the data is having sales for different products, then series id can have product codes. 

**Note**: The column names used in the examples here are just for representation and actual data can have different custom names.  

Currently, our APIs support datasets that can be in one of the following formats:

1.  Ungrouped Data (Single time series) without any additional data:
    Such datasets have only two columns in them. The first column should be a timestamp column and the second column should be the target column.

    **Here is a sample CSV-formatted data:**
    ```csv
    timestamp,target_column
    2020-07-13T00:00:00Z,20
    2020-07-14T00:00:00Z,30
    2020-07-15T00:00:00Z,28
    ...
    ...
    ```
2.  Grouped Data(Multiple time series) without any additional data
    The input data can have multiple time series. Such datasets are called *grouped data* and there must be a column to identify different time series.

    **Here is a sample CSV-formatted data:**
    ```csv
    timestamp,target_column,series_id
    2020-07-13T00:00:00Z,20,A
    2020-07-14T00:00:00Z,30,A
    2020-07-15T00:00:00Z,28,A
    ....
    ....
    2020-07-13T00:00:00Z,40,B
    2020-07-14T00:00:00Z,50,B
    2020-07-15T00:00:00Z,28,B
    ....
    ....
    2020-07-13T00:00:00Z,10,C
    2020-07-14T00:00:00Z,20,C
    2020-07-15T00:00:00Z,30,C
    ....
    ....
    ``` 
3.  Grouped Data(Multiple time series) with additional data:
    The input data can have additional influencers that help in forecasting. We call the two datasets primary and additional. The primary data should have three columns - timestamp, target column, and a column for the series id. The additional data should have a timestamp column, a series id column, and columns for additional influencers.   

    **Here is a sample CSV-formatted data:**

    Primary data 
    ```csv
    timestamp,target_column,series_id
    2020-07-13T00:00:00Z,20,A
    2020-07-14T00:00:00Z,30,A
    2020-07-15T00:00:00Z,28,A
    ....
    ....
    2020-07-13T00:00:00Z,40,B
    2020-07-14T00:00:00Z,50,B
    2020-07-15T00:00:00Z,28,B
    ....
    ....
    2020-07-13T00:00:00Z,10,C
    2020-07-14T00:00:00Z,20,C
    2020-07-15T00:00:00Z,30,C
    ....
    ....
    ```
    Additional data 
    ```csv
    timestamp,feature_1,series_id
    2020-07-13T00:00:00Z,0,A
    2020-07-14T00:00:00Z,1,A
    2020-07-15T00:00:00Z,2,A
    ....
    ....
    2020-07-13T00:00:00Z,0,B
    2020-07-14T00:00:00Z,0,B
    2020-07-15T00:00:00Z,1,B
    ....
    ....
    2020-07-13T00:00:00Z,1,C
    2020-07-14T00:00:00Z,0,C
    2020-07-15T00:00:00Z,0,C
    ....
    ....
    ```

4.  Grouped Data(Multiple time series) with additional and meta data:
    The input data can also have meta data that help multivariate algorithms in forecasting by identify homogeneous series. The primary data should have three columns - timestamp, target column, and a column for the series id. The additional data should have a timestamp column, a series id column, and columns for additional influencers. The meta data should have a series id column, and any number of columns for meta data information for that particular series. Each series will have one observation in meta data 

    **Here is a sample CSV-formatted data:**

    Primary data 
    ```csv
    timestamp,target_column,series_id
    2020-07-13T00:00:00Z,20,A
    2020-07-14T00:00:00Z,30,A
    2020-07-15T00:00:00Z,28,A
    ....
    ....
    2020-07-13T00:00:00Z,40,B
    2020-07-14T00:00:00Z,50,B
    2020-07-15T00:00:00Z,28,B
    ....
    ....
    2020-07-13T00:00:00Z,10,C
    2020-07-14T00:00:00Z,20,C
    2020-07-15T00:00:00Z,30,C
    ....
    ....
    ```
    Additional data 
    ```csv
    timestamp,feature_1,series_id
    2020-07-13T00:00:00Z,0,A
    2020-07-14T00:00:00Z,1,A
    2020-07-15T00:00:00Z,2,A
    ....
    ....
    2020-07-13T00:00:00Z,0,B
    2020-07-14T00:00:00Z,0,B
    2020-07-15T00:00:00Z,1,B
    ....
    ....
    2020-07-13T00:00:00Z,1,C
    2020-07-14T00:00:00Z,0,C
    2020-07-15T00:00:00Z,0,C
    ....
    ....
    ```

    Meta data 
    ```csv
    meta_feature_1,meta_feature_2,series_id
    x,x1,A
    x,x1,B
    y,x2,C
    ....
    ....
    ```

    **Note:**
    * Missing values are permitted (with empty), and boolean flag values should be converted to numeric (0/1)

## Task 3: Download Sample Data

Here is a sample dataset to help us easily understand what the input data looks like, Download the files to our local machine.

Use Case 1 (With Primary and Additional Data):
* [Primary data](files/primary-15-automotive.csv)
* [Additional data](files/add-15-automotive.csv)
  
Use Case 2 (With Primary, Additional and Meta Data):
* [Primary data](files/favorita-20-primary.csv)
* [Additional data](files/favorita-20-additional.csv)
* [Meta data](files/favorita-20-metadata.csv)

## Task 4: Upload Data to Object Storage

After downloading the dataset, we need to upload the sample training data into the OCI object storage, to be used for Data Asset creation for model training in the next steps.


1.  Create an Object Storage Bucket (This step is optional in case the bucket is already created):

    - Navigate to the OCI Services menu, select Object Storage

    ![Storage Bucket](images/lab5-switch-to-cloudstoragebucket.png " ")

    - Select compartment from the left dropdown menu and choose the compartment and select create bucket 

    ![Create Bucket](images/lab5-compartment-create-bucket.png " ")

    - Fill out the dialog box, fill in bucket Name & select the STANDARD option for storage tier and create bucket
    ![Fill Bucket](images/lab5-fill-bucket-details.png " ")


2.  Upload the downloaded training CSV data file into Storage Bucket:

    - Switch to OCI window and select the bucket name that we created just now.
    ![Bucket Created](images/lab5-check-bucket-created.png " ")
    

    - Bucket detail window should be visible. Scroll down and click Upload
    ![Bucket Details](images/lab5-bucket-details-window.png " ")


    - Browse to the file to upload and click the Upload button 
    ![Upload Files](images/lab5-bucket-upload-files.png " ")

    More details on OCI Object storage can be found [here](https://oracle-livelabs.github.io/oci-core/object-storage/workshops/freetier/index.html?lab=object-storage) to see how to upload.

## Task 5: Create a project 

A project is a way to organize multiple data assets and forecasts in the same workspace.

1.  Log into the OCI Cloud Console. Using the Ham Burger Menu on the top left corner, navigate to Analytics and AI, then select the Forecasting  under AI services

    ![Select Forecasting Service](images/lab5-project-select-forecast-service.png " ")

2.  Selecting the Forecasting option will navigate us to the OCI Forecast Console.
    
    Under Projects, select compartment and click create Project

    ![Click Create Project](images/lab5-project-details.png " ")

3.  The Create Project button navigates us to a form where we can specify the compartment we want to create a Forecast Project. Once the details are entered click the create button.
    ![Create Project](images/lab5-create-new-project.png " ")

4.  If the project is successfully created it will show up in the projects pane. From here onwards, select livelabs_forecast_demo.
    ![Project Created](images/lab5-project-created.png " ")

5.  Select the project we just created and go to project page.
    ![Navigate to Project Page](images/lab5-project-page.png " ")

## Task 6: Create Forecast

Below Forecast example is with **Use Case with Primary and Additional Data**. 
If you wish to only try **Use Case with Primary, Additional and Meta Data** , skip this task and directly go to *Task 10*

1.  Clicking on the Create Forecast button will take us to Create Forecast Page:
    ![Create Forecast](images/lab5-create-forecast.png " ")

2.  Create Data Asset:
    We need to select a Data Asset needed to train a model and forecast. There are two types of Data Assets i.e. Primary and Additional. For each type of Data Asset, Either, we can select a previously existing Data Asset or create a new Data Asset. As we don't have any existing Data Asset, we will click on the Create New Data Asset 
    ![Create Data Asset](images/lab5-data-asset-create-directly.png " ")

    In the Create Data Asset window, we can specify the bucket name of Object storage and select the data file. Next, Click Create Button.
    ![Fill Primary Data Details](images/lab5-primary-data-details.png " ")

    After a few seconds, the data asset will be shown in the data asset main panel, select the
    data that we just created now

    ![Create Primary Data Asset](images/lab5-select-created-primary-data-asset.png " ")
    
    Similarly, we can create Data Asset for Additional Data. Additional Data is optional but for this demo, we recommend to use Additional Data if you are expecting same results as the below
    ![Create Additional Data](images/lab5-select-additional-data.png " ")
    ![Fill Additional Data Details](images/lab5-additional-data-details.png " ")

    Now, select the Addtional Data Asset created just now, and click Next
    ![Create Additional Data Asset](images/lab5-select-created-additional-data-asset.png " ")

3.  Configure Schema :

    We need to provide a schema for the primary and additional data in this window. In addition to schema, we also provide Timestamp format, Input data frequency, and Timestamp column

    ![Provide Scehma](images/lab5-data-schema.png " ")

    After filling in the details, click Next

4.  Configure Forecast :

    We need to provide
    - Forecast name and description
    - Target Variable which we want to forecast. Eg. Sales for the current dataset
    - Input Data Frequency: Currently, OCI Forecasting service allows data with  'MINUTE','HOUR', 'DAY', 'WEEK', 'MONTH' or 'YEAR' and custom frequency depending on frequency of input data
    - Forecast Frequency: Currently, OCI Forecasting service allows to forecast with 'HOUR', 'DAY', 'WEEK', 'MONTH' or 'YEAR' and custom frequency. For custom frequency: If the input data frequency multiplier is more than 1, then the forecast frequency should be also at the same base frequency as the input. 
    Eg. If Input Data Frequency: 2HOUR , then the forecast frequency: 24HOUR if we want Forecast Frequency to be a DAY level
    - Forecast Horizon
    - Prediction Interval: Select Prediction Interval from the list. Additionaly, there is an option to select custom prediction intervals by specifying the interval width. Example: If width 60 is specified, result will contain two symmetric lower and upper bounds around the median forecast (50th percentile), i.e. lower at 20 and upper at 80, which will correspond to 60% confidence of actual future value being lying within these bounds
    - Error Measure: Error metric used to evaluate the performance of the forecasting models.
      Best Practises for Error Metric selection:
        - When your data has multiple series with different units of measurement or scale (for e.g., one series has data in tens, another series has data in thousands), try to use percentage dependent metrics. Use scale dependent metrics only if all the series have the same scale.
        - Choose the metric based on your business objective. For example, you may want to penalize under-forecasting more than over-forecasting or vice versa or even weigh them equally. 
        -  MAPE can be an appropriate choice, when you want to weigh both under-forecasting and over-forecasting equally.
        - SMAPE can be more suitable, if under-forecasting needs to be penalized.
        - The error metric should be in line with what the model is predicting. For example, the forecasts are closer to mean if RMSE or MSE is chosen as error measure, and closer to median when MAE is chosen.
        - Sometime it is better to use many Error metrics and take an average or a weighted average to satisfy the need of a better understandable error technique. This also improves the model selection procedure. This technique has proven better than the simple method.
        
        - SCALE DEPENDENT MEASURES: These measures are dependent of scale hence can be used to evaluate the model only over series which are similar scale
            -   MSE: 
                It is known as Mean Square Error. 
            Here e(t) is the difference between actual and predicted outcome.
                It can be taken as an estimate for variance of model.
                Pay attention to the scale of different series while using this metric.
                It is very sensitive to outliers, therefore we remove the outliers while preprocessing the data in our forecasting service.
            -  RMSE: 
                It is known as Root mean square Error.
                It is on the same scale at the data due to presence of the square root.
                It is an estimate of standard deviation of model.
                It is very sensitive to outliers, therefore we remove the outliers while preprocessing the data in our forecasting service.
            -  MAE:
                It is known as Mean Absolute Error.It is sensitive to intermittency. 
        
        - PERCENTAGE DEPENDANT MEASURES: These measures are independent of scale hence can be used to evaluate the model over various series without worrying about their scales.

            -  MAE:
                It is known as Mean Absolute Percentage Error.
                Data with seasonality may also cause issue in MAPE.
                The error is not symmetric that is interchanging y(t) with y^(t) changes the error. 
                It is sensitive to both outliers and intermittency. 
            -  SMAPE: 
                It is known as Symmetric Mean Absolute Percentage Error.
                It solves the symmetricity problem of MAPE. 
                Notice that it penalizes underestimation more than over estimation.
                It is sensitive to intermittency.


    - Select whether data is grouped or ungrouped based on example explained above. Refer to data format requirements above in Task 2 for an example
    - Select explainability if you want explainabiity
    - Select algorithm you want to run. For this eg: We have selected *SMA, DMA, DES, PROPHET*

    ![Configure Forecast](images/lab5-configure-forecast.png " ")




5.  Review the Configuration for Forecast and click Submit :
    ![Review Configuration ](images/lab5-review-config.png " ")
     
    Once submitted, the model training and forecast is started and the status is **Creating**


## Task 7: Forecast Results
1. Forecast Status:
    After 3-4 minutes the status will change to **Active**. Now, click on the Forecast Link as we can see below
    ![Forecast Status](images/lab5-forecast-active-page.png " ")

2. Review Forecast Results:
    
    Now, let's review the forecast results
    1. We get general information like OCID (forecast ID), description, and Training Messages etc.
    2. We get the generation time of the forecast, the total number of series provided for the forecast, and the forecast horizon, we can also download the forecast results by generating the download.zip
    ![Review Forecast Results](images/lab5-forecast-result-page.png " ")

## Task 8: Explore the Forecast and Explainability  
1.  Forecast:
    The next step is to explore the forecast graph which has forecast and historical data along with prediction intervals
    - Highlighted box 1 highlights to select series from dropdown list 
    - Highlighted box 2 highlights the forecast for a particular time step
    - Highlighted box 3 highlights information on forecast metrics like lowest error metric measure, the number of methods ran, etc.

    ![Forecast Graph](images/lab5-forecast-graph-page.png " ")

2.  Explainability: 

    The forecast will also give explainability for each of the target time series in the dataset. The explainability report includes both global and local level explanations. Explanations provide insights into the features that are influencing the forecast. Global explanation represents the general model behavior - e.g., which features does the model consider important? A local explanation tells the impact of each feature at a single time step level. The forecast provides local explanations for all the forecasts that it generates. Here we get a global and local explanation for the best model chosen by the forecast, to understand the features that are influencing the forecast

    ![Explainability](images/lab5-explain-forecast-all.png " ")


    - Global Feature Importance:
    ![Global Feature Importance](images/lab5-global-explain.png " ")

    
    - Local Feature Importance:
       We can select the time step for which we want to see the local feature importance
    ![Local Feature Importance](images/lab5-local-explain.png " ")

## Task 9 (Optional): Download the results file 
1. Finally, we can download the results zip file **Download.zip**. 
 **Download.zip** option will be available by selecting **Generate zip**. It can be leveraged directly to plot graphs, deep dive results or load into the system for dashboard view etc.
    ![Generate zip](images/lab5-generate-zip.png " ")
2. **Download.zip** contains three files:
    - **forecast_results.csv**: Input and Forecast, Upper Bound and Lower Bound Prediction Intervals
    - **explanation\_results\_global.csv**: Global Explainability
    - **explanation\_results\_local.csv**: Local Explainability

3. You can also download the files from bucket where you have your uploaded your input csv files
       - The folder name in the bucket is of format as ***fs-{last_string_of_ocid}***

       - For eg: if your ocid is 
       ***ocid1.aiforecast.oc1.phx.amaaaaaaugxxxxxxxxxx4smflo6jrubfflwrcs4evkbxwkfiq***,
       then files will be in ***fs-amaaaaaaugxxxxxxxxxx4smflo6jrubfflwrcs4evkbxwkfiq*** folder

     ![Results Object Storage Location](images/lab5-task10-results-object-storage.png " ")

    - **explainability**:  Explainability files for each series    
    - **forecast**: nput and Forecast, Upper Bound and Lower Bound Prediction Intervals
    - **report**: Report files for each series havingtraining metrics report which has the best model selected using AutoML based on performance on selected error metric and other information

## Task 10 (Optional): Forecast with Meta Data 

**Creating Forecast for Use case with Primary, Additional and Meta Data**

This examples shows how to use OCI Forecasting Service for Use case with Primary, Additional and Meta Data.

We will use the data already uploaded in bucket in *Task 4* above

1.  Clicking on the Create Forecast button will take us to Create Forecast Page:
    ![Create Forecast](images/lab5-create-forecast.png " ")



2.  Create Data Asset:
    We need to select a Data Asset needed to train a model and forecast. There are two types of Data Assets i.e. Primary and Additional. For each type of Data Asset, Either, we can select a previously existing Data Asset or create a new Data Asset. As we don't have any existing Data Asset, we will click on the Create New Data Asset 
    ![Create Data Asset](images/lab5-data-asset-create-directly.png " ")


    In the Create Data Asset window, we can specify the bucket name of Object storage and select the data file. Next, Click Create Button.
    ![Create Primary Data Asset](images/lab5-task10-create-prima-data.png " ")

    After a few seconds, the data asset will be shown in the data asset main panel

    Similarly, we can create Data Asset for Additional and Meta data

    Now, select the Data Assets created just now, and click Next
    ![Select Primary and Meta Data Assets](images/lab5-data-asset-prim-add.png " ")
    ![Select Meta Data](images/lab5-data-meta.png " ")



3.  Configure Schema :

    We need to provide a schema for the primary , additional and meta data in this window. In addition to schema, we also provide Timestamp format, Input data frequency, and Timestamp column

    ![Configure Schema](images/lab5-task10-configure-schema.png " ")

    After filling in the details, click Next

4.  Configure Forecast :

    We need to provide
    - Forecast name and description
    - Target Variable which we want to forecast. Eg. Sales for the current dataset
    - Output Frequency for Forecast
    - Forecast Horizon
    - Prediction Interval: Select Prediction Interval from the list. Additionaly, there is an option to select custom prediction intervals by specifying the interval width. Example: If width 60 is specified, result will contain two symmetric lower and upper bounds around the median forecast (50th percentile), i.e. lower at 20 and upper at 80, which will correspond to 60% confidence of actual future value being lying within these bounds
    - Error Measure: Error metric used to evaluate the performance of the forecasting models.
    - Select whether data is grouped or ungrouped based on example explained above. Refer to data format requirements above in Task 2 for an example
    - Select explainability if you want explainabiity
    - Select algorithm you want to run. Meta Data will be used only by Multivariate algorithms :    PROBRNN,APOLLONET EFE

    ![Configure Forecast](images/lab5-task10-configure-forecast.png " ")


5.  Review the Configuration for Forecast and click Submit :
    ![Review Forecast Configuration ](images/lab5-task10-review-config.png " ")
     
    Once submitted, the model training and forecast is started and the status is **Creating**


6.  Forecast Results
    - Forecast Status:
        After 3-4 minutes the status will change to **Active**. Now, click on the Forecast Link as we can see below
        ![Forecast Active](images/lab5-task10-forecast-active-page.png " ")

    - Review Forecast Results:
        
        Now, let's review the forecast results
        1. We get general information like OCID (forecast ID), description, and Training Messages etc.
        2. We get the generation time of the forecast, the total number of series provided for the forecast, and the forecast horizon, we can also download the forecast results by generating the download.zip
        ![Review Forecast Results](images/lab5-task10-forecast-result-page.png " ")

7.  Explore the Forecast and Explainability  
    -  Forecast:
        The next step is to explore the forecast graph which has forecast and historical data along with prediction intervals
        - Highlighted box 1 highlights to select series from dropdown list 
        - Highlighted box 2 highlights the forecast for a particular time step
        - Highlighted box 3 highlights information on forecast metrics like lowest error metric measure, the number of methods ran, etc.

        ![Forecast Graph](images/lab5-task10-forecast-graph-page.png " ")

    -  Explainability : 
        The forecast will also give explainability for each of the target time series in the dataset. The explainability report includes both global and local level explanations. Explanations provide insights into the features that are influencing the forecast. Global explanation represents the general model behavior - e.g., which features does the model consider important? A local explanation tells the impact of each feature at a single time step level. The forecast provides local explanations for all the forecasts that it generates. Here we get a global and local explanation for the best model chosen by the forecast, to understand the features that are influencing the forecast

        ![Explainability](images/lab5-task10-explain-graph-all.png " ")


        - Global Feature Importance:
        ![Global Feature Importance](images/lab5-task10-global-explain-dl.png " ")
        

        - Local Feature Importance: We can select the time step for which we want to see the local feature importance
        ![Local Feature Importance](images/lab5-task10-local-explain-dl.png " ")

        
8. (Optional): Download the results file 
    - Finally, we can download the results zip file **Download.zip**. 
    **Download.zip** option will be available by selecting **Generate zip**. It can be leveraged directly to plot graphs, deep dive results or load into the system for dashboard view etc.
        ![Generate zip](images/lab5-task10-forecast-download.png " ")
    - **Download.zip** contains three files:
        - **forecast_results.csv**: Input and Forecast, Upper Bound and Lower Bound Prediction Intervals
        - **explanation\_results\_global.csv**: Global Explainability - But will be empty until explainabiltiy is made available for PROBRNN, Apollonet and EFE 
        - **explanation\_results\_local.csv**: Local Explainability - But will be empty until explainabiltiy is made available for PROBRNN, Apollonet and EFE 
    - You can also download the files from bucket where you have your uploaded your input csv files
       - The folder name in the bucket is of format as ***fs-{last_string_of_ocid}***

       - For eg: if your ocid is 
       ***ocid1.aiforecast.oc1.phx.amaaaaaaugxxxxxxxxxx4smflo6jrubfflwrcs4evkbxwkfiq***,
       then files will be in ***fs-amaaaaaaugxxxxxxxxxx4smflo6jrubfflwrcs4evkbxwkfiq*** folder

        ![Results Object Storage Location](images/lab5-task10-results-object-storage.png " ")

    - **explainability**:  Explainability files for each series    
    - **forecast**: nput and Forecast, Upper Bound and Lower Bound Prediction Intervals
    - **report**: Report files for each series havingtraining metrics report which has the best model selected using AutoML based on performance on selected error metric and other information

Congratulations on completing this lab! 

Additionally, We can also try out Lab 2 which is Optional if we want to use a data science notebook. 

Please feel free to contact us if any additional questions.

## Acknowledgements
* **Authors**
    * Ravijeet Kumar, Senior Applied Scientist - Oracle AI Services
    * Anku Pandey, Applied Scientist - Oracle AI Services
    * Sirisha Chodisetty, Senior Applied Scientist - Oracle AI Services
    * Sharmily Sidhartha, Principal Technical Program Manager - Oracle AI Services
    * Last Updated By/Date: Ravijeet Kumar, March'2022
