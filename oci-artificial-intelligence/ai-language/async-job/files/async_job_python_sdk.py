import oci

ai_client = oci.ai_language.AIServiceLanguageClient(oci.config.from_file())

compartment_id = <COMPARTMENT_ID> #TODO Specify your compartmentId here
job_id = <JOB_ID> #TODO Specify your jobId here
namespace_name = <NAMESPACE_NAME> #TODO Specify the namespace here
bucket_name = <BUCKET_NAME> #TODO Specify name of your training data bucket here

# Create async job for Pretrained Language Detection with TXT input data type

input_location_txt = oci.ai_language.models.ObjectStoragePrefixLocation(namespace_name=namespace_name, bucket_name=bucket_name, prefix="test/");
input_configuration_txt = oci.ai_language.models.InputConfiguration(document_types=['TXT'])
output_location = oci.ai_language.models.ObjectPrefixOutputLocation(namespace_name=namespace_name, bucket_name=bucket_name, prefix="output/")

model_metadata_details_languageDetection = oci.ai_language.models.ModelMetadataDetails(model_type="PRE_TRAINED_LANGUAGE_DETECTION", language_code='en')

create_job_details_language_detection = oci.ai_language.models.CreateJobDetails(description="Description", compartment_id=compartment_id, input_location=input_location_txt, input_configuration=input_configuration_txt, model_metadata_details=[model_metadata_details_languageDetection], output_location=output_location);

create_job_output_ld = ai_client.create_job(create_job_details=create_job_details_language_detection)
print("create_job_output ", create_job_output_ld.data)

# Create async job for Pretrained Language Detection with CSV input data type

input_config_csv = {"CSV": {
    "config": {"inputColumn": "Country", "rowId": "Country", "copyColumnsToOutput": "Region", "delimiter": ","}}};
input_configuration_csv = oci.ai_language.models.InputConfiguration(configuration=input_config_csv, document_types=['CSV']);
input_location_csv = oci.ai_language.models.ObjectStorageFileNameLocation(namespace_name=namespace_name, location_type='OBJECT_STORAGE_FILE_LIST',bucket_name=bucket_name,object_names=["Records.csv"]);
model_metadata_details_languageDetection = oci.ai_language.models.ModelMetadataDetails(model_type="PRE_TRAINED_LANGUAGE_DETECTION", language_code='en');

create_job_details_language_detection_ld_csv = oci.ai_language.models.CreateJobDetails(description="Description", compartment_id=compartment_id,input_location=input_location_csv,input_configuration=input_configuration_csv,model_metadata_details=[model_metadata_details_languageDetection],output_location=output_location);

create_job_output_csv = ai_client.create_job(create_job_details=create_job_details_language_detection_ld_csv);
print("create_job_output ", create_job_output_csv.data);


# Create async job for Pretrained sentiment analysis

configuration = {"sentimentAnalysisConfiguration": {"configurationMap": {"basis": "ASPECT"}}};
model_metadata_details_sentiment = oci.ai_language.models.ModelMetadataDetails(model_type="PRE_TRAINED_SENTIMENT_ANALYSIS", language_code='en', configuration=configuration)

create_job_details_sentiment_analysis = oci.ai_language.models.CreateJobDetails(description="Description", compartment_id=compartment_id, input_location=input_location_txt, input_configuration=input_configuration_txt, model_metadata_details=[model_metadata_details_sentiment], output_location=output_location);

create_job_output_sa = ai_client.create_job(create_job_details=create_job_details_sentiment_analysis)
print("create_job_output ", create_job_output_sa.data)

# Create async job for Pretrained language pii entities

configuration_pii = {"ALL": {"configurationMap": {"mode": "MASK", "maskingCharacter": "*", "isUnmaskedFromEnd": "true","leaveCharactersUnmasked": 4}}};
model_metadata_details_pii = oci.ai_language.models.ModelMetadataDetails(model_type="PRE_TRAINED_PII",language_code='en',configuration=configuration_pii)

create_job_details_pii = oci.ai_language.models.CreateJobDetails(description="pii detection",compartment_id=compartment_id,input_location=input_location_txt,input_configuration=input_configuration_txt,model_metadata_details=[model_metadata_details_pii],output_location=output_location);

create_job_output_pii = ai_client.create_job(create_job_details=create_job_details_pii)
print("create_job_output ", create_job_output_pii.data)

# Create async job for custom Text classification

endpoint_id = <ENDPOINT_ID> #TODO Specify your endpointId here (optional)
model_id = <MODEL_ID> #TODO Specify your modelId here
model_metadata_details_custom_txtc = oci.ai_language.models.ModelMetadataDetails(model_type="TEXT_CLASSIFICATION",language_code='en',model_id=model_id)

create_job_details_custom_txtc_1 = oci.ai_language.models.CreateJobDetails(description="Job description",compartment_id=compartment_id,input_location=input_location_txt,input_configuration=input_configuration_txt,model_metadata_details=[model_metadata_details_custom_txtc],output_location=output_location);

create_job_output_custom_txtc = ai_client.create_job(create_job_details=create_job_details_custom_txtc_1)
print("create_job_output ", create_job_output_custom_txtc.data)

# Create async job for custom Named entity recognition

endpoint_id = <ENDPOINT_ID> #TODO Specify your endpointId here (optional)
model_id = <MODEL_ID> #TODO Specify your modelId here
model_metadata_details_custom_ner = oci.ai_language.models.ModelMetadataDetails(model_type="NAMED_ENTITY_RECOGNITION",language_code='en',endpoint_id=endpoint_id,model_id=model_id)

create_job_details_custom_ner = oci.ai_language.models.CreateJobDetails(description="Description",compartment_id=compartment_id,input_location=input_location_txt,input_configuration=input_configuration_txt,model_metadata_details=[model_metadata_details_custom_ner],output_location=output_location);

create_job_output_custom_ner = ai_client.create_job(create_job_details=create_job_details_custom_ner)
print("create_job_output ", create_job_output_custom_ner.data)

# List Jobs
list_job_output = ai_client.list_jobs(compartment_id=compartment_id)
print("list job ", list_job_output.data)

# Get Job
get_job_output = ai_client.get_job(job_id=job_id)
print("get job ", get_job_output.data)

# Update Job
update_job_details = oci.ai_language.models.UpdateJobDetails(
    description="updated description")
updateJobOutput = ai_client.update_job(job_id=job_id, update_job_details=update_job_details)
print("updateJobOutput ", updateJobOutput.data)

# Cancel Job
cancel_job = ai_client.cancel_job(job_id=job_id)
print("cancelJob ", cancel_job.data)

# Delete Job

delete_job = ai_client.delete_job(job_id=job_id);
print("deleteJob ", delete_job.data)