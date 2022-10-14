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

project_id = "ocid1.ailanguageproject.oc1.iad.amaaaaaac4idruiagbwaof4pxwsji2oftlybzpxtztizxcnpqcuxudvsjiaa"
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

endpoint_id = "ocid1.ailanguageendpoint.oc1.iad.amaaaaaac4idruia4kaj5zszfsaqdbqjisdvtnzvl3445ljzjkuj3p3ltnaq"
text_to_analyze = "\n\nDear Bryan Hernandez,\n \nGilmore  Kennedy and Lloyd is delighted to offer you the position of Chief Strategy Officer with an anticipated start date of 06/16/17, contingent upon background check, drug screening and work permit verification. \n \nYou will report directly to Jeffrey Zamora at Unit 6709 Box 6713,DPO AP 11187. Working hours are decided based on your assigned business unit. \n \nThe starting salary for this position is $216053 per annum. Payment is on a monthly basis by direct deposit done on the last working day of the moth. \n \nGilmore  Kennedy and Lloyd offers a comprehensive benefits program, which includes medical insurance, 401(k), paid time off and gym facilities at work location. \n \nYour employment with Gilmore  Kennedy and Lloyd will be on an at-will basis, which means you and the company are free to terminate employment at any time, with or without cause or advance notice. This letter is not a contract indicating employment terms or duration.\n \nPlease confirm your acceptance of this offer by signing and returning this letter before 7 days from 06/16/17. \n \nSincerely,\n \nCarlos Banks\n(Country Leader, Human Resources)"

print(f"Analyzing the text: {text_to_analyze}")
txtc_text_for_testing = oci.ai_language.models.BatchDetectLanguageEntitiesDetails(endpoint_id = endpoint_id, documents = [oci.ai_language.models.TextDocument(key = "1", text = text_to_analyze)])
txtc_inference_result = ai_client.batch_detect_language_entities(txtc_text_for_testing)
print("inference result for custom TXTC:")
print(txtc_inference_result.data)