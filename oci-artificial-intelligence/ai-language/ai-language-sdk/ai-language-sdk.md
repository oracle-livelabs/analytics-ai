# Lab 3: Access OCI Language with Language SDKs

## Introduction 

Oracle Cloud Infrastructure provides a number of Software Development Kits (SDKs) to facilitate development of custom solutions. SDKs allow you to build and deploy apps that integrate with Oracle Cloud Infrastructure services. Each SDK also includes tools and artifacts you need to develop an app, such as code samples and documentation. In addition, if you want to contribute to the development of the SDKs, they are all open source and available on GitHub.

 
You can invoke OCI Language capabilities through the OCI SDKs. In this lab session, we will show several code snippets to access OCI Language through the OCI SDKs. You do not need to execute the snippets, but review them to understand what information and steps are needed to implement your own integration. In addition, you can find OCI Language samples in different programming languages in this [github repository](https://github.com/oracle/oci-data-science-ai-samples/tree/master/ai_services/language).


#### 1. [SDK for Java](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/javasdk.htm#SDK_for_Java)
#### 2. [SDK for Python](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/pythonsdk.htm#SDK_for_Python)
#### 3. [SDK for TypeScript and JavaScript](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/typescriptsdk.htm#SDK_for_TypeScript_and_JavaScript)
#### 4. [SDK for .NET](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/dotnetsdk.htm#SDK_for_NET)
#### 5. [SDK for Go](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/gosdk.htm#SDK_for_Go)
#### 6. [SDK for Ruby](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/rubysdk.htm#SDK_for_Ruby)

*Estimated Lab Time*: 10 minutes

### Objectives:

* Learn how to use Language SDKs to communicate with our language service endpoints.

<!-- ### Prerequisites:
* Familiar with Python programming is required
* Have a Python environment ready in local
* Familiar with local editing tools, vi and nano
* Installed with Python libraries: `oci` and `requests` -->


## **TASK 1:** Setup API Signing Key and Config File
**Prerequisite: Before you generate a key pair, create the .oci directory in your home directory to store the credentials.**

Mac OS / Linux:

```
<copy>mkdir ~/.oci</copy>
```
Windows:
```
<copy>mkdir %HOMEDRIVE%%HOMEPATH%\.oci</copy>
```

Generate an API signing key pair

### 1. Open User Settings
Open the Profile menu (User menu icon) and click User Settings.
    ![](./images/userProfileIcon.png " ")

### 2. Open API Key
Navigate to API Key and then Click Add API Key.
    ![](./images/addAPIButton.png " ")

### 3. Generate API Key
In the dialog, select Generate API Key Pair. Click Download Private Key and save the key to your .oci directory and then click Add.
    ![](./images/genAPI.png " ")



### 4. Generate Config File
Copy the values shown on the console.
    ![](./images/conf.png " ")

Create a config file in the .oci folder and paste the values copied.
Replace the key_file value with the path of your generated API Key.
    ![](./images/conf2.png " ")



To Know more visit [Generating API KEY](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm) and [SDK and CLI Configuration File](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/sdkconfig.htm#SDK_and_CLI_Configuration_File)

## **TASK 2:** Prerequisites and Setup for Python

Please follow the steps in the order described.
Before you go any further, make sure you have Python 3.x version and that it’s available from your command line. You can check this by simply running:
```
<copy>python --version</copy>
```
If you do not have Python, please install the latest 3.x version from [python.org ](https://www.python.org)

Additionally, you’ll need to make sure you have pip available. You can check this by running:
```
<copy>pip --version</copy>
```
If you installed Python from source, with an installer from python.org, or via Homebrew you should already have pip. If you’re on Linux and installed using your OS package manager, you may have to install pip separately.


### 1. Create virtualenv
To create a virtual environment, run the venv module as a script as shown below
```
<copy>python3 -m venv <name of virtual environment></copy>
```
### 2. Activate virtualenv
Once you’ve created a virtual environment, you may activate it.

Mac OS / Linux:
```
<copy>source <name of virtual environment>/bin/activate</copy>
```
Windows:
```
<copy><name of virtual environment>\Scripts\activate</copy>
```
### 3. Install OCI
Now Install oci by running:
```
<copy>pip install oci</copy>
```




## **TASK 3:** OCI Language Service SDK Code Sample

#### Python Code
```Python
<copy>
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
</copy>
```
Follow below steps to run Python SDK:

### 1. Download Python Code.

Download [code](./files/language.py) file and save it your directory.

### 2. Execute the Code.
Navigate to the directory where you saved the above file (by default, it should be in the 'Downloads' folder) using your terminal and execute the file by running:
```
<copy>python language.py</copy>
```
### 3. Result
You will see the result as below
    ![](./images/result.png " ")



## Learn More
To know more about the Python SDK visit [Python OCI-Language](https://docs.oracle.com/en-us/iaas/tools/python/2.43.1/api/ai_language/client/oci.ai_language.AIServiceLanguageClient.html)

To know more about the Java SDK visit [Java OCI-Language](https://docs.oracle.com/en-us/iaas/tools/java/2.3.1/)

To know more about the Go SDK visit [Go OCI-Language](https://docs.oracle.com/en-us/iaas/tools/go/45.1.0/ailanguage/index.html)

To know more about the Ruby SDK visit [Ruby OCI-Language](https://docs.oracle.com/en-us/iaas/tools/ruby/2.14.0/OCI/AiLanguage.html)

To know more about the Java Script SDK visit [Java Script OCI-Language](https://docs.oracle.com/en-us/iaas/tools/typescript/2.0.1/modules/_ailanguage_index_.html)


To know more about the DOT NET SDK visit [DOT NET OCI-Langauge](https://docs.oracle.com/en-us/iaas/tools/dotnet/23.1.0/api/Oci.AilanguageService.html)

Congratulations on completing this lab!

[Proceed to the next section](#next).

## Acknowledgements
* **Authors**
    * Rajat Chawla  - Oracle AI Services
    * Ankit Tyagi -  Oracle AI Services
* **Last Updated By/Date**
    * Rajat Chawla  - Oracle AI Services, February 2021