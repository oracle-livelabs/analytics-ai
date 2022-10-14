# Create a custom model through the console

## Introduction
In this session, we will show you how to create a language project, select your training data, train a custom model, create an endpoint and analyze text through endpoint.

*Estimated Time*: 15 minutes

### Objectives

In this lab, you will:
- Learn how to create language project.
- Understand the schema for training data.
- Learn how to train a named entity recognition model or text classification model through the OCI console and Python SDK.

### Prerequisites
- A Free tier or paid tenancy account in OCI (Oracle Cloud Infrastructure)
- Familiar with OCI object storage to upload data.

## **Policy Setup**

Before you start using OCI Language, OCI policies should be setup for allowing you to access OCI Language Services. Follow these steps to configure required policies.

Please refer Lab 1 to setup Language policies and add this additional policy for accessing Custom Models.

### 1. Navigate to Dynamic Groups

Log into OCI Cloud Console. Using the Burger Menu on the top left corner, navigate to Identity & Security and click it, and then select Dynamic Groups item under Identity.
 ![OCI Hamburger menu](./images/dynamicgroup1.png " ")

### 2. Create Dynamic Group

Click Create Dynamic Group

![OCI Create policy](./images/dynamicgroup2.png " ")
```
<copy>all {resource.type='ailanguagemodel'}</copy>
```


### 3. Navigate to Policies

Log into OCI Cloud Console. Using the Burger Menu on the top left corner, navigate to Identity & Security and click it, and then select Policies item under Identity.
    ![OCI Hamburger menu](./images/policy1.png " ")


### 4. Create Policy

Click Create Policy
    ![OCI Create policy](./images/policy2.png " ")


### 5. Create a new policy with the following statements:

If you want to allow all the users in your tenancy to use language service, create a new policy with the below statement:
    ```

    <copy>Allow dynamic-group language-service-dyn-grp-for-custom-models to manage objects in tenancy</copy>
    ```

    ![OCI Create policy screen](./images/policy3.png " ")


## **Task 1:** Create a Project

A Project is a way to organize multiple models in the same workspace. It is the first step to start.

1. Log into OCI Cloud Console. Using the Burger Menu on the top left corner, navigate to Analytics and AI menu and click it, and then select Language Service item under AI services. Clicking the Language Service Option will navigate one to the Language Service Console. Once here, select Projects under "Custom models" header on the left hand side of the console.

    ![](./images/project-list.png " ")

2. The Create Project button navigates User to a form where they can specify the compartment in which to create a Language Project.

    ![](./images/create-project.png " ")

3. Once the details are entered click the Create Button. If the project is successfully created it will show up in projects pane.  

## **Task 2:** Create and Train Custom NER Model

1. **Navigate to Models**: Under models, click on create and train model.

2. **Choose model type**: Choose  Named entity recognition for model type.

    ![](./images/ner-model-type.png " ")

3. **Select training data**: Choose existing labeled data from Object Storate or Data Labeling service or you can choose to create new dataset by clicking Data science labeling link, which will drive you to OCI Data Labeling service, where you can easily add labels.

     ![](./images/ner-training-data.png " ")

4. **Model details**: In the "Model details" step, you will name your model, add a description of it and optionally add tags.

    ![](./images/add-model-details.png " ")

5. **Review and Submit**: In the "review" step, you can verify that all of your information is correct and go back if you want to make adjustments. When you want to start training, click "Create and train" and this will kick of the process. You can then check on the status of your model in the project where you created it.

    ![](./images/ner-review.png " ")

## **Task 3:** Create and Train Custom TXTC Model

1. **Navigate to Models**: Under models, click on create and train model.

2. **Choose model type**: Choose Text classification for model type. Select Single label or multi label as classification model type depending on your labeled data.

    ![](./images/txtc-model-type.png " ")

3. **Select training data**: Choose existing labeled data from Object Storate or Data Labeling service or you can choose to create new dataset by clicking Data science labeling link, which will drive you to OCI Data Labeling service, where you can easily add labels.

     ![](./images/txtc-training-data.png " ")

4. **Model details**: In the "Model details" step, you will name your model, add a description of it and optionally add tags.

    ![](./images/add-model-details.png " ")

5. **Review and Submit**: In the "review" step, you can verify that all of your information is correct and go back if you want to make adjustments. When you want to start training, click "Create and train" and this will kick of the process. You can then check on the status of your model in the project where you created it.

    ![](./images/txtc-review.png " ")

## **Task 4:** Create an Endpoint and Analyze through endpoint.

1. Under Model endpoints, click on create model endpoint
2. Specify the name of the endpoint (e.g., ticket_classification_endpoint1)
    
    ![](./images/create-model-endpoint.png " ")

3. Once endpoint is active, Under Resources, click on Analyze link.
4. Enter text, and click on Analyze to see the result

    ![](./images/analyze.png " ")

## **Task 5:** Create Custom Models and analyzing through endpoint with Python SDK.

For setup, please refer Lab 1

[Proceed to the next section](#next).
Follow below steps to run Python SDK:

#### 1. Download Python Code.

#### Custom NER Python Code

```Python
<copy>
import time
import oci
print(f'OCI Client SDK version: {oci.__version__}')
config = oci.config.from_file()

compartment_id = "ocid1.tenancy.oc1..aaaaaaaaih4krf4od5g2ym7pffbp6feof3rx64522aoxxvv3iuw3tam6fvea"  #TODO Provide your compartmentId here

project_name = None #"custom-NER-project"
model_name = None #"custom-NER-model"
endpoint_name = None #"custom_NER_endpoint"

#assuming ashburn endpoint.
# For other regions, use below end points
endpoint = "https://language.aiservice-preprod.us-ashburn-1.oci.oraclecloud.com"
#Ashburn: https://language.aiservice.us-ashburn-1.oci.oraclecloud.com
#Phoenix: https://language.aiservice.us-phoenix-1.oci.oraclecloud.com
#Frankfurt: https://language.aiservice.eu-frankfurt-1.oci.oraclecloud.com
#London: https://language.aiservice.uk-london-1.oci.oraclecloud.com
#Mumbai: https://language.aiservice.ap-mumbai-1.oci.oraclecloud.com
print(f"Instantiating AI Services client with end point: {endpoint}")

ai_client = oci.ai_language.AIServiceLanguageClient(config, service_endpoint=endpoint)

#create ailanguageproject
project_details = oci.ai_language.models.CreateProjectDetails(compartment_id=compartment_id,display_name=project_name)
print(f"Creating project with details:{project_details}")
project = ai_client.create_project(project_details)
print(f"create_project returned: {project.data}")

#wait till project state becomes ACTIVE
project_id = project.data.id
project_status = project.data.lifecycle_state
while (project.data.lifecycle_state == "CREATING"):
    print('Waiting for project creation to complete...')
    time.sleep(1*60) #sleep for 1 minute
    project = ai_client.get_project(project_id)

project = ai_client.get_project(project_id)
project_status = project.data.lifecycle_state
print(f"Project status changed from CREATING to {project_status}")

#creating ailanguagemodel
location_details = oci.ai_language.models.ObjectListDataset(
    location_type="OBJECT_LIST", 
    namespace_name="idngwwc5ajp5",  #TODO specify the namespace here
    bucket_name="canary-bucket", #TODO specify the name your training data bucket here
    object_names=["small_portableJosnl.jsonl"]  #TODO specify the name your train label file
)

model_details = oci.ai_language.models.CreateModelDetails(
    project_id = project.data.id,
    model_details = oci.ai_language.models.ModelDetails(model_type="NAMED_ENTITY_RECOGNITION", language_code="en"),
    display_name = model_name,
    compartment_id = compartment_id,
    training_dataset = oci.ai_language.models.ObjectStorageDataset(dataset_type="OBJECT_STORAGE", location_details=location_details)
)

print(f"creating model with details:{model_details}")
model_response = ai_client.create_model(model_details)
print(f"create_model returned: {model_response.data}")

model_details = ai_client.get_model(model_response.data.id)

#wait till model state becomes ACTIVE
while (model_details.data.lifecycle_state == "CREATING"):
    print('Waiting for model creation and training to complete...')
    time.sleep(1*60) #sleep for 1 minute
    model_details = ai_client.get_model(model_response.data.id)

print(f"Model status changed from CREATING to {model_details.data.lifecycle_state}")

print("Printing model evaluation results")
print(model_details.data.evaluation_results)

print("Creating an end point")
endpoint_details = oci.ai_language.models.CreateEndpointDetails(
    compartment_id = compartment_id,
    model_id = model_details.data.id,
    inference_units = 1,
    display_name = endpoint_name
)

endpoint_response = ai_client.create_endpoint(endpoint_details)
print(f"create_endpoint call returned{endpoint_response.data}")
end_point_details = ai_client.get_endpoint(endpoint_response.data.id)

#wait till endpoint state becomes ACTIVE
while (end_point_details.data.lifecycle_state == "CREATING"):
    print('Waiting for endpoint creation to complete...')
    time.sleep(1*60) #sleep for 5 minutes
    end_point_details = ai_client.get_endpoint(end_point_details.data.id)

print(f"End point status changed from CREATING to {end_point_details.data.lifecycle_state}")

text_to_analyze = "\n\nDear Bryan Hernandez,\n \nGilmore  Kennedy and Lloyd is delighted to offer you the position of Chief Strategy Officer with an anticipated start date of 06/16/17, contingent upon background check, drug screening and work permit verification. \n \nYou will report directly to Jeffrey Zamora at Unit 6709 Box 6713,DPO AP 11187. Working hours are decided based on your assigned business unit. \n \nThe starting salary for this position is $216053 per annum. Payment is on a monthly basis by direct deposit done on the last working day of the moth. \n \nGilmore  Kennedy and Lloyd offers a comprehensive benefits program, which includes medical insurance, 401(k), paid time off and gym facilities at work location. \n \nYour employment with Gilmore  Kennedy and Lloyd will be on an at-will basis, which means you and the company are free to terminate employment at any time, with or without cause or advance notice. This letter is not a contract indicating employment terms or duration.\n \nPlease confirm your acceptance of this offer by signing and returning this letter before 7 days from 06/16/17. \n \nSincerely,\n \nCarlos Banks\n(Country Leader, Human Resources)"

print(f"Analyzing the text: {text_to_analyze}")
ner_text_for_testing = oci.ai_language.models.BatchDetectLanguageEntitiesDetails(endpoint_id = end_point_details.data.id, documents = [oci.ai_language.models.TextDocument(key = "1", text = text_to_analyze)])
ner_inference_result = ai_client.batch_detect_language_entities(ner_text_for_testing)
print("inference result for custom NER:")
print(ner_inference_result.data)

</copy>
```

Download [code](./files/customNERPythonSDK.py) file and save it your directory.



#### Custom TXTC Python Code

```Python
<copy>
import time
import oci
print(f'OCI Client SDK version: {oci.__version__}')
config = oci.config.from_file()

compartment_id = "ocid1.tenancy.oc1..aaaaaaaaih4krf4od5g2ym7pffbp6feof3rx64522aoxxvv3iuw3tam6fvea"

project_name = None #"custom-TXTC-project"
model_name = None #"custom-TXTC-model"
endpoint_name = None #"custom_TXTC_endpoint"

#assuming ashburn endpoint.
# For other regions, use below end points
endpoint = "https://language.aiservice-preprod.us-ashburn-1.oci.oraclecloud.com"
#Ashburn: https://language.aiservice.us-ashburn-1.oci.oraclecloud.com
#Phoenix: https://language.aiservice.us-phoenix-1.oci.oraclecloud.com
#Frankfurt: https://language.aiservice.eu-frankfurt-1.oci.oraclecloud.com
#London: https://language.aiservice.uk-london-1.oci.oraclecloud.com
#Mumbai: https://language.aiservice.ap-mumbai-1.oci.oraclecloud.com
print(f"Instantiating AI Services client with end point: {endpoint}")

ai_client = oci.ai_language.AIServiceLanguageClient(config, service_endpoint=endpoint)

#create ailanguageproject
project_details = oci.ai_language.models.CreateProjectDetails(compartment_id=compartment_id,display_name=project_name)
print(f"Creating project with details:{project_details}")
project = ai_client.create_project(project_details)
print(f"create_project returned: {project.data}")

#wait till project state becomes ACTIVE
project_id = project.data.id
project_status = project.data.lifecycle_state
while (project.data.lifecycle_state == "CREATING"):
    print('Waiting for project creation to complete...')
    time.sleep(1*60) #sleep for 1 minute
    project = ai_client.get_project(project_id)

project = ai_client.get_project(project_id)
project_status = project.data.lifecycle_state
print(f"Project status changed from CREATING to {project_status}")

#creating ailanguagemodel
location_details = oci.ai_language.models.ObjectListDataset(location_type="OBJECT_LIST", namespace_name="idngwwc5ajp5", bucket_name="txtc_csv_datasets", object_names=["physics_chemistry_biology_train.csv"])
# For Text classification, multi-class and multi-labe classification types are supported
classification_mode = oci.ai_language.models.ClassificationType(classification_mode="MULTI_CLASS")
model_details = oci.ai_language.models.CreateModelDetails(
    project_id = project.data.id,
    model_details = oci.ai_language.models.TextClassificationModelDetails(classification_mode=classification_mode,model_type="TEXT_CLASSIFICATION", language_code="en"),
    display_name = model_name,
    compartment_id = compartment_id,
    training_dataset = oci.ai_language.models.ObjectStorageDataset(dataset_type="OBJECT_STORAGE", location_details=location_details)
)

print(f"creating model with details:{model_details}")
model_response = ai_client.create_model(model_details)
print(f"create_model returned: {model_response.data}")

model_details = ai_client.get_model(model_response.data.id)

#wait till model state becomes ACTIVE
while (model_details.data.lifecycle_state == "CREATING"):
    print('Waiting for model creation and training to complete...')
    time.sleep(1*60) #sleep for 1 minute
    model_details = ai_client.get_model(model_response.data.id)

print(f"Model status changed from CREATING to {model_details.data.lifecycle_state}")

print("Printing model evaluation results")
print(model_details.data.evaluation_results)

print("Creating an end point")
endpoint_details = oci.ai_language.models.CreateEndpointDetails(
    compartment_id = compartment_id,
    model_id = model_details.data.id,
    inference_units = 1,
    display_name = endpoint_name
)

endpoint_response = ai_client.create_endpoint(endpoint_details)
print(f"create_endpoint call returned{endpoint_response.data}")
end_point_details = ai_client.get_endpoint(endpoint_response.data.id)

#wait till endpoint state becomes ACTIVE
while (end_point_details.data.lifecycle_state == "CREATING"):
    print('Waiting for endpoint creation to complete...')
    time.sleep(1*60) #sleep for 5 minutes
    end_point_details = ai_client.get_endpoint(end_point_details.data.id)

print(f"End point status changed from CREATING to {end_point_details.data.lifecycle_state}")

text_to_analyze = "I like Physics over chemistry"

print(f"Analyzing the text: {text_to_analyze}")
txtc_text_for_testing = oci.ai_language.models.BatchDetectLanguageEntitiesDetails(endpoint_id = end_point_details.data.id, documents = [oci.ai_language.models.TextDocument(key = "1", text = text_to_analyze)])
txtc_inference_result = ai_client.batch_detect_language_entities(txtc_text_for_testing)
print("inference result for custom TXTC:")
print(txtc_inference_result.data)
</copy>
```

Download [code](./files/customTXTCPythonSDK.py) file and save it your directory.

#### 2. Provide TODO marked details
Provide your compartmentId and model training data details. These parameters are marked with TODO

#### 3. Execute the Code.
Navigate to the directory where you saved the above file (by default, it should be in the 'Downloads' folder) using your terminal and execute the file by running:

For Custom NER
```
<copy>python customNERPythonSDK.py</copy>
```

For Custom TXTC
```
<copy>python customTXTCPythonSDK.py</copy>
```

### Learn More
To know more about the Python SDK visit [Python OCI-Language](https://docs.oracle.com/en-us/iaas/tools/python/2.43.1/api/ai_language/client/oci.ai_language.AIServiceLanguageClient.html)

## **Summary**

Congratulations! </br>
In this lab you have learnt how to create and train custom NER and TXTC models and analyze text on trained models through language endpoing using OCI Console and Python SDK.

[Proceed to the next section](#next).