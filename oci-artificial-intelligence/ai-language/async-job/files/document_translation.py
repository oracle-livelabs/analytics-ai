import oci

ai_client = oci.ai_language.AIServiceLanguageClient(oci.config.from_file())

compartment_id = <COMPARTMENT_ID> #TODO Specify your compartmentId here
job_id = <JOB_ID> #TODO Specify your jobId here
namespace_name = <NAMESPACE_NAME> #TODO Specify the namespace here
bucket_name = <BUCKET_NAME> #TODO Specify name of your training data bucket here

# Create async job for document translation
input_location_txt = oci.ai_language.models.ObjectStorageFileNameLocation(namespace_name=namespace_name, bucket_name=bucket_name);
output_location = oci.ai_language.models.ObjectPrefixOutputLocation(namespace_name=namespace_name, bucket_name=bucket_name, prefix="output/")
target_language_codes = {"configurationMap": {"languageCodes": "ar,pt-BR"}}
configuration = {"targetLanguageCodes": target_language_codes}

model_metadata_details = oci.ai_language.models.ModelMetadataDetails(model_type="PRE_TRAINED_TRANSLATION", language_code='en', configuration = configuration);

create_job_details = oci.ai_language.models.CreateJobDetails(description=None,
                                                            compartment_id=compartment_id,
                                                            input_location=input_location_txt,
                                                            model_metadata_details=[model_metadata_details],
                                                            output_location=output_location)

createJobOutput = ai_client.create_job(create_job_details=create_job_details)
print(f"created a job {createJobOutput.data.display_name}")
