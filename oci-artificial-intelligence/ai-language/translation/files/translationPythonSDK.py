import oci

ai_client = oci.ai_language.AIServiceLanguageClient(oci.config.from_file(),
                                                    service_endpoint="https://language.aiservice-preprod.us-ashburn-1.oci.oraclecloud.com")

key1 = "doc1"
key2 = "doc2"
text1 = "The Indy Autonomous Challenge is the worlds first head-to-head, high speed autonomous race taking place at the Indianapolis Motor Speedway"
text2 = "OCI will be the cloud engine for the artificial intelligence models that drive the MIT Driverless cars competing in the Indy Autonomous Challenge."

doc1 = oci.ai_language.models.TextDocument(key=key1, text=text1, language_code="en")
doc2 = oci.ai_language.models.TextDocument(key=key2, text=text2, language_code="en")
documents = [doc1, doc2]

compartment_id = "ocid1.tenancy.oc1..aaaaaaaaih4krf4od5g2ym7pffbp6feof3rx64522aoxxvv3iuw3tam6fvea" #TODO Provide your compartmentId here

batch_language_translation_details = oci.ai_language.models.BatchLanguageTranslationDetails(documents=documents, compartment_id=compartment_id, target_language_code="de")
output = ai_client.batch_language_translation(batch_language_translation_details)
print(output.data)