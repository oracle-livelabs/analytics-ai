import oci

ai_client = oci.ai_language.AIServiceLanguageClient(oci.config.from_file())

key1 = "doc1"
key2 = "doc2"
text1 = "Hello Support Team, I am reaching out to seek help with my credit card number 1234 5678 9873 2345 expiring on 11/23. There was a suspicious transaction on 12-Aug-2022 which I reported by calling from my mobile number +1 (423) 111-9999 also I emailed from my email id sarah.jones1234@hotmail.com. Would you please let me know the refund status? Regards, Sarah"
text2 = "Using high-performance GPU systems in the Oracle Cloud, OCI will be the cloud engine for the artificial intelligence models that drive the MIT Driverless cars competing in the Indy Autonomous Challenge."

compartment_id = "<COMPARTMENT_ID>" #TODO Specify your compartmentId here

#language Detection of Input Documents
doc1 = oci.ai_language.models.DominantLanguageDocument(key=key1, text=text1)
doc2 = oci.ai_language.models.DominantLanguageDocument(key=key2, text=text2)
documents = [doc1, doc2]
batch_detect_dominant_language_details = oci.ai_language.models.BatchDetectDominantLanguageDetails(documents=documents, compartment_id=compartment_id)
output = ai_client.batch_detect_dominant_language(batch_detect_dominant_language_details)
print(output.data)

doc1 = oci.ai_language.models.TextDocument(key=key1, text=text1, language_code="en")
doc2 = oci.ai_language.models.TextDocument(key=key2, text=text2, language_code="en")
documents = [doc1, doc2]

#Text Classification of Input Documents
batch_detect_language_text_classification_details = oci.ai_language.models.BatchDetectLanguageTextClassificationDetails(documents=documents, compartment_id=compartment_id)
output = ai_client.batch_detect_language_text_classification(batch_detect_language_text_classification_details)
print(output.data)

#Named Entity Recognition of Input Documents
batch_detect_language_entities_details = oci.ai_language.models.BatchDetectLanguageEntitiesDetails(documents=documents, compartment_id=compartment_id)
output = ai_client.batch_detect_language_entities(batch_detect_language_entities_details)
print(output.data)

#Key Phrase Detection of Input Documents
batch_detect_language_key_phrases_details = oci.ai_language.models.BatchDetectLanguageKeyPhrasesDetails(documents=documents, compartment_id=compartment_id)
output = ai_client.batch_detect_language_key_phrases(batch_detect_language_key_phrases_details)
print(output.data)

#Aspect based and Sentence level Sentiment Analysis of Input Documents
batch_detect_language_sentiment_details = oci.ai_language.models.BatchDetectLanguageSentimentsDetails(documents=documents, compartment_id=compartment_id)
output = ai_client.batch_detect_language_sentiments(batch_detect_language_sentiment_details,  level=["ASPECT","SENTENCE"])
print(output.data)

#Personal Identifiable Information Entities Recognition
piiEntityMasking = oci.ai_language.models.PiiEntityMask(mode="MASK", masking_character="*", leave_characters_unmasked=4,
                                                        is_unmasked_from_end=True)
masking = {"ALL": piiEntityMasking}

batch_detect_language_pii_entities_details = oci.ai_language.models.BatchDetectLanguagePiiEntitiesDetails(
    documents=documents, compartment_id=compartment_id, masking=masking)
output = ai_client.batch_detect_language_pii_entities(batch_detect_language_pii_entities_details)
print(output.data)
