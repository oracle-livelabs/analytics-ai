import oci
 
ai_client = oci.ai_language.AIServiceLanguageClient(oci.config.from_file(), service_endpoint="https://language.aiservice.us-ashburn-1.oci.oraclecloud.com")
#Input Text
text1 = "The Indy Autonomous Challenge is the worlds first head-to-head, high speed autonomous race taking place at the Indianapolis Motor Speedway"
text2 = "Using high-performance GPU systems in the Oracle Cloud, OCI will be the cloud engine for the artificial intelligence models that drive the MIT Driverless cars competing in the Indy Autonomous Challenge."
 
#language Detection of Input Documents
doc1 = oci.ai_language.models.DominantLanguageDocument(key="doc1", text=text1)
doc2 = oci.ai_language.models.DominantLanguageDocument(key="doc2", text=text2)
documents = [doc1, doc2]
 
batch_detect_dominant_language_details = oci.ai_language.models.BatchDetectDominantLanguageDetails(documents=documents)
output = ai_client.batch_detect_dominant_language(batch_detect_dominant_language_details)
print(output.data)
 
 
#Text Classification of Input Documents
doc1 = oci.ai_language.models.TextClassificationDocument(key="doc1", text=text1)
doc2 = oci.ai_language.models.TextClassificationDocument(key="doc2", text=text2)
documents = [doc1, doc2]
 
batch_detect_language_text_classification_details = oci.ai_language.models.BatchDetectLanguageTextClassificationDetails(documents=documents)
output = ai_client.batch_detect_language_text_classification(batch_detect_language_text_classification_details)
print(output.data)
 
 
#Named Entity Recoginiton of Input Documents
doc1 = oci.ai_language.models.EntityDocument(key="doc1", text=text1)
doc2 = oci.ai_language.models.EntityDocument(key="doc2", text=text2)
documents = [doc1, doc2]
 
batch_detect_language_entities_details = oci.ai_language.models.BatchDetectLanguageEntitiesDetails(documents=documents)
output = ai_client.batch_detect_language_entities(batch_detect_language_entities_details)
print(output.data)
 
 
#Key Phrase Detection of Input Documents
doc1 = oci.ai_language.models.KeyPhraseDocument(key="doc1", text=text1)
doc2 = oci.ai_language.models.KeyPhraseDocument(key="doc2", text=text2)
documents = [doc1, doc2]
 
batch_detect_language_key_phrases_details = oci.ai_language.models.BatchDetectLanguageKeyPhrasesDetails(documents=documents)
output = ai_client.batch_detect_language_key_phrases(batch_detect_language_key_phrases_details)
print(output.data)
 
 
#Aspect based and Sentence level Sentiment Analysis of Input Documents
doc1 = oci.ai_language.models.SentimentsDocument(key="doc1", text=text1)
doc2 = oci.ai_language.models.SentimentsDocument(key="doc2", text=text2)
documents = [doc1, doc2]
 
batch_detect_language_sentiment_details = oci.ai_language.models.BatchDetectLanguageSentimentsDetails(documents=documents)
output = ai_client.batch_detect_language_sentiments(batch_detect_language_sentiment_details,  level=["ASPECT","SENTENCE"])
print(output.data)