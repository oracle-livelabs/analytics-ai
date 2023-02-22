"""
Author: OCI Anomaly Detection Team
Description: This python script showcases how to programmatically create
various OCI Anomaly Detection resources using the Python SDK.
Dated: 05-04-2022

Notes:
Capture updates made to the script below.

ID05042022: ganrad: (Bugfix) Script was throwing exception for 'date_today' - Unknown function (line # 164).
ID05052022: ganrad: Commented out print statement to reduce verbose output.
"""

import os
import oci
import time
import json
from datetime import datetime, date, timedelta

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

CONFIG_FILENAME = "~/.oci/config"  # TODO: Update USERNAME
SERVICE_ENDPOINT = "https://anomalydetection.aiservice.us-ashburn-1.oci.oraclecloud.com"  # Need to Update property if different
NAMESPACE = "idp0c2wo1mkb"  #TODO:  Need to Update property if different
BUCKET_NAME = "och-bucket"  #TODO:  Need to Update property if different
training_file_name = "small-demo-training-data.csv"  # Need to Update property if different

# compartment_id = os.getenv('OCI_COMPARTMENT') #Compartpip install python-cli-sdk/oci-2.90.5+0.2567.selfservice-py2.py3-none-any.whlment of the project, Need to Update propery if different
compartment_id = "ocid1.tenancy.oc1..aaaaaaaal5yjny27h2vxdh2fwsbxw32ctmyfyjqmmh5x2vyivjeq2p6mfo3q"  # TODO: Switch to preferable compartment
print("-*-*- Compartment ID=[" + compartment_id + "] -*-*-")

config = from_file(CONFIG_FILENAME)

ad_client = AnomalyDetectionClient(
    config,
    service_endpoint=SERVICE_ENDPOINT)  # /20210101

# PROJECT
print("-*-*-*-PROJECT-*-*-*-")

# CREATE CALL
proj_details = CreateProjectDetails(
    display_name="Test-Project",
    description="Project description",
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

# LIST CALL
list_proj = ad_client.list_projects(compartment_id=compartment_id)
print("----LISTING----")
print(list_proj.data)
time.sleep(5)

# DATA ASSET
print("-*-*-*-DATA ASSET-*-*-*-")
# CREATE CALL
dDetails = DataSourceDetails(data_source_type="ORACLE_OBJECT_STORAGE")

dObjDeatils = DataSourceDetailsObjectStorage(
    namespace=NAMESPACE,
    bucket_name=BUCKET_NAME,
    object_name=training_file_name,
)

da_details = CreateDataAssetDetails(
    display_name="Test-DataAsset",
    description="DataAsset Description",
    compartment_id=compartment_id,
    project_id=project_id,
    data_source_details=dObjDeatils,
)
create_res = ad_client.create_data_asset(create_data_asset_details=da_details)
print("----CREATING----")
print(create_res.data)
da_id = create_res.data.id

# READ CALL
get_da = ad_client.get_data_asset(data_asset_id=da_id)
print("----READING----")
print(get_da.data)

# LIST CALL
list_da = ad_client.list_data_assets(
    compartment_id=compartment_id, project_id=project_id
)
print("----LISTING----")
print(list_da.data)
time.sleep(5)

# MODEL
print("-*-*-*-MODEL-*-*-*-")
# CREATE CALL
dataAssetIds = [da_id]
mTrainDetails = ModelTrainingDetails(
    target_fap=0.02, training_fraction=0.7, window_size=1, algorithmHint="MSET", data_asset_ids=dataAssetIds
)
mDetails = CreateModelDetails(
    display_name="Test-Model",
    description="Model description",
    compartment_id=compartment_id,
    project_id=project_id,
    model_training_details=mTrainDetails,
)

create_res = ad_client.create_model(create_model_details=mDetails)
print("----CREATING----")
print(create_res.data)
model_id = create_res.data.id

# READ CALL
get_model = ad_client.get_model(model_id=model_id)
print("----READING----")
print(get_model.data)
time.sleep(10)
while get_model.data.lifecycle_state == Model.LIFECYCLE_STATE_CREATING:
    get_model = ad_client.get_model(model_id=model_id)
    time.sleep(60)
    print(get_model.data.lifecycle_state)
print(get_model.data)

# LIST CALL
list_model = ad_client.list_models(compartment_id=compartment_id, project_id=project_id)
print("----LISTING----")
print(list_model.data)
time.sleep(10)

# DETECT
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

dItem = DataItem(timestamp=timestamp, values=values)
payloadData = [dItem]

# ID05052022.so
print("*********** Detect Payload ************")
print(payloadData)
print("***************************************")
# ID05052022.eo

inline = InlineDetectAnomaliesRequest(model_id=model_id,
                                      request_type="INLINE",
                                      sensitivity=0.5,
                                      signal_names=signalNames,
                                      data=payloadData)

detect_res = ad_client.detect_anomalies(detect_anomalies_details=inline)
print("----DETECTING----")
print(detect_res.data)

# CREATE ASYNC JOB
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
                "timestamp": "2018-01-03T16:00-08:00",
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
                "timestamp": "2018-01-04T16:00-08:00",
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
            }]},
        "outputDetails": {
            "outputType": "OBJECT_STORAGE",
            "namespaceName": NAMESPACE,
            "bucketName": BUCKET_NAME,
            "prefix": "consoleJobOutput"
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


#UPDATE ASYNC JOB
update_data = {
  "displayName": "updated_display_name",
  "description": "updated description"
}

print("*********** Async Update Job Payload ************")
print(update_data)
print("***************************************")
updated_job = ad_client.update_detect_anomaly_job(detect_anomaly_job_id=job_id,
                                               update_detect_anomaly_job_details=update_data).data
print(f"Updated display name: {updated_job.display_name} and description: {updated_job.description}")
print(f"Update Async Job Successful")


#LIST ASYNC JOB
list_job_data = {
  "compartmentId": compartment_id
}
print("*********** Async List Job Payload ************")
print(list_job_data)
print("***************************************")
jobs = ad_client.list_detect_anomaly_jobs(compartment_id=list_job_data["compartmentId"])
job_ids = [job.id for job in jobs.data.items]
print(f"List response: {job_ids}")
print("List Async Jobs Successful")

#DELETE ASYNC JOB
ad_client.delete_detect_anomaly_job(detect_anomaly_job_id=job_id)
print(f"Deleted/Canceled job with id {job_id}")
print("Delete/Canceled Async Jobs Successful")
time.sleep(30)

# DELETE MODEL
delete_model = ad_client.delete_model(model_id=model_id)
print("----DELETING MODEL----")
print(delete_model.data)
time.sleep(60)

# DELETE DATA ASSET
delete_da = ad_client.delete_data_asset(data_asset_id=da_id)
print("----DELETING DATA ASSET----")
print(delete_da.data)
time.sleep(10)

# DELETE PROJECT
print("----DELETING PROJECT----")
delete_project = ad_client.delete_project(project_id=project_id)
print(delete_project.data)
