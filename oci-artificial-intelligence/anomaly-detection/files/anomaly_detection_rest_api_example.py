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
import pandas as pd
import numpy as np
#from datetime import datetime, timedelta # ID05042022.o
from datetime import datetime, date, timedelta # ID05042022.n

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

CONFIG_FILENAME = "/Users/USERNAME/.oci/config" # TODO: Update USERNAME
SERVICE_ENDPOINT="https://anomalydetection.aiservice.us-ashburn-1.oci.oraclecloud.com" # Need to Update propery if different
NAMESPACE = "UPDATE_NS" # Need to Update propery if different
BUCKET_NAME = "UPDATE_BUCKET_NAME" # Need to Update propery if different
training_file_name="demo-training-data.csv" # Need to Update propery if different

#compartment_id = os.getenv('OCI_COMPARTMENT') #Compartment of the project, Need to Update propery if different
compartment_id = "ocid1.tenancy.oc1..aaaa........" #Compartment of the project, Need to Update propery if different
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
    target_fap=0.02, training_fraction=0.7, data_asset_ids=dataAssetIds
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
## Method 1: Load the data from a csv file with first column as timestamp
# df = pd.read_csv(filename)
# signalNames = [e for e in df.columns if e != 'timestamp']

## Method 2: create a random dataframe with the appropriate header
num_rows = 200
signalNames = ["temperature_1", "temperature_2", "temperature_3", "temperature_4", "temperature_5", "pressure_1", "pressure_2", "pressure_3", "pressure_4", "pressure_5"]
df = pd.DataFrame(np.random.rand(num_rows, len(signalNames)), columns=signalNames)
#df.insert(0, 'timestamp', pd.date_range(start=date_today, periods=num_rows, freq='min')) # ID05042022.o
df.insert(0, 'timestamp', pd.date_range(start=date.today(), periods=num_rows, freq='min')) # ID05042022.n
df['timestamp'] = df['timestamp'].apply(lambda x: x.strftime('%Y-%m-%dT%H:%M:%SZ'))

# Now create the Payload from the dataframe
payloadData = []
for index, row in df.iterrows():
    timestamp = datetime.strptime(row['timestamp'], "%Y-%m-%dT%H:%M:%SZ")
    values = list(row[signalNames])
    dItem = DataItem(timestamp=timestamp, values=values)
    payloadData.append(dItem)

# ID05052022.so
#print("*********** Detect Payload ************");
#print(payloadData)
#print("***************************************");
# ID05052022.eo

inline = InlineDetectAnomaliesRequest(model_id=model_id, request_type="INLINE", signal_names=signalNames, data=payloadData)

detect_res = ad_client.detect_anomalies(detect_anomalies_details=inline)
print("----DETECTING----")
print(detect_res.data)


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
