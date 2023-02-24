#  (Advanced Session) Access Anomaly Detection Service with REST API

## Introduction

Our anomaly detection services also support to use CLI (Command Line Interface) tool `oci` and SDKs with different programming languages to make REST API calls to perform model and data operations.

In this lab session, we will show you how to set up authentication method in order to use the Python SDK to integrate with our service endpoints;

You can set up those configuration and execute those codes in the Oracle Cloud Shell.

*Estimated Time*: 45 minutes

### Objectives

* Learn how to set up API Signing Key and Configure file
* Lear to use Python SDK to communicate with our anomaly detection service endpoints

### Prerequisites

* Familiar with Python programming is required
* Have a Python environment ready in local machine or use our Cloud Shell, or Oracle [Data Science Platform](https://www.oracle.com/data-science/)
* Familiar with local editing tools, such as vi and nano, or editing IDEs, such as VS Code or Sublime
* If using cloud shell, be familiar with Oracle Cloud Shell. Refer [docs here](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellintro.htm)
* You have permission to use cloud shell; ask tenancy administrator to add policy if not.
* If using your local machine, be sure to install/Update to the most updated version of Python library `oci` (version 2.42.0 or higher)

> **Note:** The complete Python code file can be [downloaded here](../files/anomaly_detection_rest_api_example.py).

## TASK 1: Setup API Signing Key

We need to generate proper authentication configuration (API Signing Key pair) in order to use OCI CLI to communicate properly to the services on your behalf.

### 1. Open User Settings
Open the Profile menu (User menu icon) on the top right corner and click User Settings.
![user profile icon](../images/user-profile-icon.png " ")

### 2. Open API Key
Navigate to API Key and then Click Add API Key.
![add api key button](../images/add-api-button.png " ")

### 3. Generate API Key
In the dialog, select Generate API Key Pair. Click Download Private Key and save the key to your local computer, and we will upload it later to the Cloud Shell.

**You can rename this `pem` file as `oci-api-key.pem` .**

Then click the Add button.
![generate api key](../images/generate-api.png " ")

### 4. Generate Config File
After click the Add button, a configuration file window pop up.
Copy the values shown on the console, and save in your local computer, again later it will be used in the Cloud Shell.

![oci config sample](../images/oci-config-sample.png " ")

The configuration content will be like the following:
```
<copy>[DEFAULT]
user=ocid1.user.oc1..aaaaaaaa.....
fingerprint=11:11:11:11:11:11:11:11
tenancy=ocid1.tenancy.oc1..aaaaaaaa.....
region=us-ashburn-1
key_file=<path to your private keyfile> # TODO </copy>
```

To know more about API key and config file, please visit [Generating API KEY](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm) and [SDK and CLI Configuration File](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/sdkconfig.htm#SDK_and_CLI_Configuration_File)

## TASK 2: Activate Cloud Shell with Configuration

### 1. Get permission to Use Cloud shell

If you do not have permission to use cloud shell, ask your tenancy administrators to add the following policy:
```
<copy>allow any-user to use cloud-shell in tenancy</copy>
```
For details, you can refer to the [Cloud Shell Doc](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellintro.htm) .

### 2. Navigate to Cloud Shell

Log into OCI Cloud Console. Navigate to Cloud Shell Icon on the top right and click it.
![cloud shell position](../images/cloud-shell-position.png " ")

It may take up to 30 seconds for the Cloud Shell to be ready, like the following screenshot.
![cloud shell activated](../images/cloud-shell-activated.png " ")

### 3. Set up API Key and Configuration File

On the Cloud Shell, type the following command to create `.oci` folder and Enter:
```
<copy>mkdir .oci</copy>
```

Now, upload the `oci-api-key.pem` file you generated and downloaded earlier to the Cloud Shell host.
![cloud shell upload pem](../images/cloud-shell-upload-pem.png " ")

Once it is uploaded, it may landed in the home folder, you can move it to the `.oci` folder with the following command and change it permission to be accessible by owner ONLY:
```
<copy>mv oci-api-key.pem .oci/ ;
chmod 600 .oci/oci-api-key.pem </copy>
```

Next, let setup the configuration file using `nano` tool, paste the content copied from earlier step, and only update the last TODO line.
```
<copy>nano .oci/config </copy>
```
Now paste the configuration content, and update the last line as:
```
<copy>key_file=~/.oci/oci-api-key.pem</copy>
```
Then save the file (CTRL+X), and update the file permission to be accessible by owner only:
```
<copy>chmod 600 .oci/config </copy>
```

The final structure of `.oci` folder will be like this:
![cloud shell oci folder](../images/cloud-shell-oci-folder.png " ")

## **TASK 3:** Python SDK Code Snippets

The complete Python code file can be [downloaded here](../files/anomaly_detection_rest_api_example.py).

You need to update one place (marked with TODO) with your username in Cloud Shell, and then upload the to the Cloud Shell to run it.
```
<copy>CONFIG_FILENAME = "/home/<USERNAME>/.oci/config" # TODO: Update USERNAME </copy>
```

In Cloud Shell, run the following to get your username:
```
<copy>whoami</copy>
```

Then upload this script `anomaly_detection_rest_api_example.py` to the Cloud Shell, execute the following command to run all the actions of building a model and run detection.
```
<copy>python3 anomaly_detection_rest_api_example.py</copy>
```

More detailed information of the code are explained as follows.

### 1. Configuration and Connection

This code snippet showed you how to perform configuration and set up connection before other operations.

```Python
import oci
import time
import json
from datetime import datetime, date

from oci.config import from_file
from oci.ai_anomaly_detection.models import *
from oci.ai_anomaly_detection.anomaly_detection_client import AnomalyDetectionClient

from oci.ai_anomaly_detection.models.create_project_details import CreateProjectDetails
from oci.ai_anomaly_detection.models.create_data_asset_details import CreateDataAssetDetails
from oci.ai_anomaly_detection.models.data_source_details import DataSourceDetails
from oci.ai_anomaly_detection.models.data_source_details_object_storage import DataSourceDetailsObjectStorage

from oci.ai_anomaly_detection.models.create_model_details import CreateModelDetails
from oci.ai_anomaly_detection.models.model_training_details import ModelTrainingDetails

from oci.ai_anomaly_detection.models.data_item import DataItem
from oci.ai_anomaly_detection.models.inline_detect_anomalies_request import InlineDetectAnomaliesRequest

# change the following constants accordingly
# ## If using the instance in data science platform, please refer this page https://dzone.com/articles/quick-and-easy-configuration-of-oracle-data-scienc to setup the content of config file
CONFIG_FILENAME = "/home/USERNAME/.oci/config" # TODO: Update USERNAME
SERVICE_ENDPOINT="https://anomalydetection.aiservice.us-ashburn-1.oci.oraclecloud.com" # Need to Update properly if different
NAMESPACE = "abcd....." # Need to Update properly if different
BUCKET_NAME = "anomaly-detection-bucket" # Need to Update properly if different
training_file_name="demo-training-data.csv" # Need to Update properly if different

compartment_id = "ocid1.tenancy.oc1..aaaa........" #Compartment of the project, Need to Update properly if different
config = from_file(CONFIG_FILENAME)

ad_client = AnomalyDetectionClient(
    config,
    service_endpoint=SERVICE_ENDPOINT)  # /20210101
```

### 2. Creating a Project

```Python
print("-*-*-*-PROJECT-*-*-*-")

# CREATE CALL
proj_details = CreateProjectDetails(
    display_name="Test Project",
    description="Test Project description",
    compartment_id=compartment_id,
)
create_res = ad_client.create_project(create_project_details=proj_details)
print("----CREATING----")
print(create_res.data)
time.sleep(5)
project_id = create_res.data.id

# GET CALL
get_proj = ad_client.get_project(project_id=project_id)
print("----READING---")
print(get_proj.data)
time.sleep(5)

```

### 3. Creating the DataAsset

```Python
print("-*-*-*-DATA ASSET-*-*-*-")
# CREATE CALL
dDetails = DataSourceDetails(data_source_type="ORACLE_OBJECT_STORAGE")

dObjDeatils = DataSourceDetailsObjectStorage(
    namespace=NAMESPACE,
    bucket_name=BUCKET_NAME,
    object_name=training_file_name,
)

da_details = CreateDataAssetDetails(
    display_name="Test DataAsset",
    description="description DataAsset",
    compartment_id=compartment_id,
    project_id=project_id,
    data_source_details=dObjDeatils,
)
create_res = ad_client.create_data_asset(create_data_asset_details=da_details)
print("----CREATING----")
print(create_res.data)
time.sleep(5)
da_id = create_res.data.id

# READ CALL
get_da = ad_client.get_data_asset(data_asset_id=da_id)
print("----READING----")
print(get_da.data)
time.sleep(5)
```

### 4. Creating the Train Model
```Python
print("-*-*-*-MODEL-*-*-*-")
# CREATE CALL
dataAssetIds = [da_id]
mTrainDetails = ModelTrainingDetails(
    target_fap=0.02, training_fraction=0.7, window_size=1, algorithmHint="MSET",
  data_asset_ids=dataAssetIds
)
mDetails = CreateModelDetails(
    display_name="DisplayNameModel",
    description="description Model",
    compartment_id=compartment_id,
    project_id=project_id,
    model_training_details=mTrainDetails,
)

create_res = ad_client.create_model(create_model_details=mDetails)
print("----CREATING----")
print(create_res.data)
time.sleep(60)
model_id = create_res.data.id

# READ CALL
get_model = ad_client.get_model(model_id=model_id)
print("----READING----")
print(get_model.data)
time.sleep(60)
while get_model.data.lifecycle_state == Model.LIFECYCLE_STATE_CREATING:
    get_model = ad_client.get_model(model_id=model_id)
    time.sleep(60)
    print(get_model.data.lifecycle_state)

```

### 5. Sync Detection with the Model
```Python
print("-*-*-*-DETECT-*-*-*-")

signalNames = ["temperature_1", "temperature_2", "temperature_3", "temperature_4", "temperature_5", "pressure_1",
               "pressure_2", "pressure_3", "pressure_4", "pressure_5"]
timestamp = datetime.strptime("2020-07-13T20:44:46Z", "%Y-%m-%dT%H:%M:%SZ")
values = [
  1.0,
  0.4713,
  1.0,
  0.5479,
  1.291,
  0.8059,
  1.393,
  0.0293,
  0.1541,
  0.2611,
]

# creating detect payload
dItem = DataItem(timestamp=timestamp, values=values)
payloadData = [dItem]

print("*********** Detect Payload ************")
print(payloadData)
print("***************************************")

#creating detect request
inline = InlineDetectAnomaliesRequest(model_id=model_id,
                                      request_type="INLINE",
                                      signal_names=signalNames,
                                      sensitivity=0.5,
                                      data=payloadData)
#detecting anomalies
detect_res = ad_client.detect_anomalies(detect_anomalies_details=inline)
print("----DETECTING----")
print(detect_res.data)
```

### 5. Async Detection with the Model
```Python
create_job_data = {
    "compartmentId": compartment_id,
    "displayName": "Python SDK for Livelabs",
    "description": "This is for Livelabs",
    "modelId": model_id,
    "sensitivity": 0.5,
    "inputDetails": {
        "inputType": "INLINE",
        "data": [
            {
                "timestamp": "2019-01-07T21:00:08Z",
                "values": [
                    1,
                    0.8885,
                    0.6459,
                    -0.0016,
                    -0.9061,
                    0.1349,
                    -0.4967,
                    0.4335,
                    0.4813,
                    -1.0798,
                    0.2734
                ]
            },
            {
                "timestamp": "2019-01-07T21:01:03Z",
                "values": [
                    1,
                    0.1756,
                    1,
                    -0.1524,
                    -0.0804,
                    -0.2209,
                    0.4321,
                    -0.6206,
                    0.3386,
                    0.0082,
                    -0.3083
                ]
            }],
        "outputDetails": {
            "outputType": "OBJECT_STORAGE",
            "namespaceName": NAMESPACE,
            "bucketName": BUCKET_NAME,
            "prefix": "liveLabJobOutput"
        }
    }
}
print("*********** Async Detect Payload ************")
print(create_job_data)
print("***************************************")

job = ad_client.create_detect_anomaly_job(create_detect_anomaly_job_details=create_job_data).data
job_id = job.id
print(f"Created job: {job.id}")
lifecycle = job.lifecycle_state
print(f"lifecycle: {lifecycle}. Please wait...")
while lifecycle not in ['SUCCEEDED', 'PARTIALLY_SUCCEEDED', 'FAILED', 'CANCELED']:
    time.sleep(120)
    job = ad_client.get_detect_anomaly_job(detect_anomaly_job_id=job_id).data
    lifecycle = job.lifecycle_state
    print(f"lifecycle: {lifecyle}.")
print(f"Create Async Job Completed")
```
The result of the async detection can be found in the object storage
namespace and bucketname specified. This output should start with the prefix
liveLabJobOutput.



Congratulations on completing this lab!

## Acknowledgements

* **Authors**
    * Jason Ding - Principal Data Scientist - Oracle AI Services
    * Haad Khan - Senior Data Scientist - Oracle AI Services
    * Ganesh Radhakrishnan - Product Manager - Oracle AI Services
* **Last Updated By/Date**
    * Ochuko Adiotomre - Software Engineer, Feb 2023
    * Ganesh Radhakrishnan - Product Manager, May 2022
    * Jason Ding - Principal Data Scientist, Jan 2022
