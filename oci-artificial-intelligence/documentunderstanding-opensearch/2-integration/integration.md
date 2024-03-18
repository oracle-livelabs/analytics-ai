
# Integrate the Components

## Introduction
In this lab, all of the components will be integrated together by configuring Oracle Integration Cloud to create an end-to-end solution.

Estimated time: 20 min

### Objectives

- Integrate all the components together

### Prerequisites
- The previous lab must have been completed, however this lab can be started while the Terraform script in the previous lab is running. A warning is shown in these lab procedures when you must ensure the Terraform script has completed.
- Know the home region of your tenancy. If you need to determine this, click the region name shown in the top right of the OCI Cloud console. Note the home region that is listed.
    
    ![Console Region](images/opensearch-console-region.png)

- There is an option to download a file to your local computer using the OCI Console cloud shell. Some users have experienced a bug attempting to do this with the Firefox Browser Extended Support Release (ESR). The Chrome browser is an alternative in this case.

## Task 1: Download required files
You will need the Oracle integration Cloud (OIC) package, the Visual Builder (VB) application, and samples files on your laptop/desktop. These procedures provide two methods to download a zip file from Github. Decide which method to use.

````
To download the files to your laptop from the Github website, please follow these steps.
````

1. In a new tab or window of your Intenet browser, go to https://github.com/mgueury/oci-genai-searchlab/tree/main and click *Code* and then *Download ZIP*.
![GitHub_Download](images/opensearch-github-download-zip.png)

1. Extract the oci-genai-searchlab-main.zip file to your computer. 
![GitHub_Download](images/opensearch-github-extract-zip.png) 

1. Note the directory contains the Oracle Integration Cloud (OIC) package in the ***oic*** folder, the Visual Builder (VB) application in the ***vb*** folder, and samples files in the ***sample_files*** folder.

## Task 2: User and Tenancy details

First, we need data about your tenancy and user.
- On the top, right, click *Tenancy: name*
- Copy the tenancy OCID *##TENANCY\_OCID##*

![Tenancy](images/opensearch-tenancy.png)

Then, we need data about the user
- On the top, right, click *Your username*
- Copy the username *##USERNAME##* (without oracleidentitycloudservice )
- Copy the user OCID *##USER\_OCID##*
- Click on *API Keys*

![User](images/opensearch-user.png)

- Click *Add API Key*
- Generate one
- Download it *##PRIVATE_KEY##*
- Copy the *##FINGERPRINT##*

![User API Keys](images/opensearch-user2.png)

In your computer (NOT in cloud shell), you need to convert the PEM key to RSA format:
- Run the below command 
- And keep the ##PRIVATE\_KEY\_RSA\_FORMAT##

```
openssl rsa -in ##PRIVATE_KEY## -out ##PRIVATE_KEY_RSA_FORMAT##
ex: openssl rsa -in private_key.pem -out private_key_rsa_format.pem
````

Double-check that the private\_key\_rsa_format.pem is really in RSA format like this:

```
-----BEGIN RSA PRIVATE KEY-----
...
-----END RSA PRIVATE KEY-----
```

## Task 3: Import the integration
Upload the integration configuration into OIC.

1. Open the OIC Service console. If you were logged out, use the following steps to re-open it. 
    1. Go to the OCI Console menu, select *Developer Services*, then *Integration*. 
    1. In the *Integration Instances* list, click **oic**. 
    1. On the *oic* integration instance details page, click the **Service console** button.
1. In the OIC service console, on the left menu, choose *Design*, then *Packages*
1. Click the *Import* button
    - Browse to choose *OPENSEARCH_OIC.par*
        - Go to the directory on your local computer where you downloaded files from GITHUB
        - In the directory **oic**, you will find *OPENSEARCH_OIC.par*
1. Click: *Import and Configure*
    ![Import Package](images/opensearch-oic-package-import.png)

## Task 4: Configure the OIC connections
We start with the public connections first because these don't depend on component provisioning that is being completed in the previous lab by the Terraform script.

### 1. RestObjectStorage

1. Click the **edit** icon on the same row as *RestObjectStorage*

    ![Package details](images/opensearch-oic-package-import1.png)

1. Copy the Object Storage rest API from [https://docs.oracle.com/en-us/iaas/api/#/en/objectstorage/20160918/](https://docs.oracle.com/en-us/iaas/api/#/en/objectstorage/20160918/). Select the endpoint for the home region of your tenancy. You will paste it in place of *##OS\_URL##* below.

1. Fill the Connection details:
    - Connection Type = *REST API Base URL*
    - Connection URL = *##OS\_URL##*
        - ex: https://objectstorage.eu-frankfurt-1.oraclecloud.com
    - Security policy = *No Security*
    - Access Type = *Public gateway*
1. **Test / Save / Save** until 100%
1. Go back to the list of connections. The remainder of the connections are configured in a similar manner.

### 2. RestGenerativeAI 

1. Click the **edit** icon on the same row as *RestGenerativeAI*

1. Copy the Generative AI endpoint from [https://docs.oracle.com/en-us/iaas/api/#/en/generative-ai/20231130/](https://docs.oracle.com/en-us/iaas/api/#/en/generative-ai/20231130/) . Select the endpoint for the home region of your tenancy. You will paste it in place of *##AI\_GENAI\_URL##* below.
1. Fill the Connection details:
    - Connection Type = *REST API Base URL*
    - Connection URL = *##AI\_GENAI\_URL##*
        - ex: https://inference.generativeai.us-chicago-1.oci.oraclecloud.com
    - Security policy = * OCI Signature Version 1*
    - Tenancy OCID = ##TENANCY_OCID##
    - User OCID = ##USER_OCID##
    - Private KEY = ##PRIVATE_KEY_RSA_FORMAT##
    - FingerPrint = ##FINGERPRINT##
    - Access Type = *Public gateway*
1. *Save / Test / Save* until 100%

### 2. RestLanguageAI

1. Click the **edit** icon on the same row as *RestLanguageAI*

1. Copy the OCI Language REST API endpoint from [https://docs.oracle.com/en-us/iaas/api/#/en/language/20221001/](https://docs.oracle.com/en-us/iaas/api/#/en/language/20221001/). Select the endpoint for the home region of your tenancy. You will paste it in place of *##AI\_LANG\_URL##* below.

1. Fill the Connection details:
    - Connection Type = *REST API Base URL*
    - Connection URL = *##AI\_LANG\_URL##*
        - ex: https://language.aiservice.eu-frankfurt-1.oci.oraclecloud.com
    - Security policy = *OCI Service Invocation*
    - Access Type = *Public gateway*

1. **Test / Save / Save** until 100%

1. Go back to the list of connections
  
### 3. Resttrigger

    There is no change needed here. The connection is already configured. 

### 4. RestDocumentUnderstandingAI

1. Click the **edit** icon on the same row as *RestDocumentUnderstandingAI*

1. Copy the OCI Document Understanding REST API endpoint from [https://docs.oracle.com/en-us/iaas/api/#/en/document-understanding/20221109/](https://docs.oracle.com/en-us/iaas/api/#/en/document-understanding/20221109/). Select the endpoint for the home region of your tenancy. You will paste it in place of *##AI\_DOC\_URL##* below.

1. Fill the Connection details:
    - Connection Type = *REST API Base URL*
    - Connection URL = *##AI\_DOC\_URL##*
        - ex: https://document.aiservice.eu-frankfurt-1.oci.oraclecloud.com
    - Security policy = *OCI Service Invocation*
    - Access Type = *Public gateway*
1. **Test / Save / Save** until 100%
1.  Go back to the list of connections

### 5. RestSpeechAI

1. Click the **edit** icon on the same row as *RestSpeechAI*.

1. Copy the AI Speech REST API endpoint from [https://docs.oracle.com/en-us/iaas/api/#/en/speech/20220101/](https://docs.oracle.com/en-us/iaas/api/#/en/speech/20220101/). Select the endpoint for the home region of your tenancy. You will paste it in place of *##AI\_SPEECH\_URL##* below.

1. Fill the Connection details:
    - Connection Type = *REST API Base URL*
    - Connection URL = *##AI\_SPEECH\_URL##*
        - ex: https://speech.aiservice.eu-frankfurt-1.oci.oraclecloud.com
    - Security policy = *OCI Service Invocation*
    - Access Type = *Public gateway*

1.  **Test / Save / Save** until 100%

1. Go back to the list of connections

### 6. RestVisionAI

1. Click the **edit** icon on the same row as *RestVisionAI*.

1. Copy the AI Vision REST API endpoint from [https://docs.oracle.com/en-us/iaas/api/#/en/vision/20220125/](https://docs.oracle.com/en-us/iaas/api/#/en/vision/20220125/). Select the endpoint for the home region of your tenancy. You will paste it in place of *##AI\_VISION\_URL##* below.

1. Fill the Connection details:
    - Connection Type = *REST API Base URL*
    - Connection URL = *##AI\_VISION\_URL##*
        - ex: https://vision.aiservice.eu-frankfurt-1.oci.oraclecloud.com
    - Security policy = *OCI Service Invocation*
    - Access Type = *Public gateway*

1. **Test / Save / Save** until 100%

1. Go back to the list of connections

    ```
    IMPORTANT: Before proceeding with configuring the remaining three connections, the Terraform script from the previous lab (build.sh) must finish. It takes about 34 minutes to complete. Return to the code editor in the cloud console and verify the script has finished then complete the remaining instruction in that previous lab before returning to continue here.
    ```
    [Go to previous lab.](#prev)

### 7. StreamInputBucket
1. In the OCI Console, select the **Developer Tools icon** and then select *Cloud Shell*.

1. In OCI Console Cloud Shell, if the terraform output is not there anymore, you can get it back like this: 
    ```
    <copy>
    oci-genai-searchlab/starter/src/after_done.sh
    </copy>
    ```
    1. In the output of this script look for the following values under the heading **-- STREAMING CONNECTION --------------------------**:
        - ##STREAM_BOOSTRAPSERVER##
        - ##STREAM_USERNAME##
        - ##AUTH_TOKEN##
    1. Copy and paste **all** the output from this script to your text file to use in configuring the connection and for later tasks.

1. Click the **Cloud Shell Menu icon** and select *Download*.
![CloudShell_Download](images/opensearch-cloudshell-download.png)

1. Enter the file name: *oci-genai-searchlab/starter/oss_store.jks* and click **Download**.
![CloudShell_Download2](images/opensearch-cloudshell-download3.png)

1. Go to the OIC console and click the **edit** icon on the same row as *StreamInputBucket*.
    ![Package details](images/opensearch-oic-package-import2.png)

1. Fill the Connection details:
    - Bootstrap servers = *##STREAM_BOOSTRAPSERVER##*
    - SASL Username = *##STREAM_USERNAME##*
    - SASL Password = *##AUTH_TOKEN##*
    - Expand *Optional security*
        - Truststore = upload *oss_store.jks*
        - TrustStore password = *changeit* 
    - Access Type = *Private Gateway*
    
    ![Connection StreamInputBucket](images/opensearch-connection-streaminputbucket.png)


1. **Test / Save / Save** until 100%

1. Go back to the list of connections

### 8. RestFunction
1. Use the **##FUNCTION_ENDPOINT##** value you saved to your text file to fill in the Connection details:
    - (If you need to get the value, run this command in OCI Console Cloud Shell: oci-genai-searchlab/starter/src/search_env.sh)
    - Connection Type = *REST API Base URL*
    - Connection url = **##FUNCTION_ENDPOINT##** (without /action/invoke at the end)
        - ex: https://xxxx.eu-frankfurt-1.functions.oci.oraclecloud.com/20181201/functions/ocid1.fnfunc.oc1.eu-frankfurt-1.aaaaaaabbbbb
    - Security policy = *OCI Service Invocation*
    - Access Type = *Public gateway*
    
    ![Connection RestFunction](images/opensearch-connection-restfunction.png)


1. **Test / Save / Save** until 100%

1. Go back to the list of connections

### 9. RestOpenSearch
1. Use the **##OPENSEARCH\_API\_ENDPOINT##** value you saved to your text file to fill in the Connection details:
    - (If you need to get the value, run this command in OCI Console Cloud Shell: oci-genai-searchlab/starter/src/search_env.sh)
    - Connection Type = *REST API Base URL*
    - Connection url = *##OPENSEARCH\_API\_ENDPOINT##*
        - ex: https://amamamamalllllaaac5vkwantypqqcs4bqrgqjrkvuxxghsmg7zzzzzxxxxx.opensearch.eu-frankfurt-1.oci.oraclecloud.com:9200
    - Security policy: *No Security Policy*
    - Access Type = *Private Gateway*
    
    ![Connect RestOpenSearch](images/opensearch-connection-restopensearch.png)

1. **Test / Save / Save** until 100%

1. Go back to the list of connections

## Task 5. Activate the integration

1. All connections should be valid. To activate the integrations,
click on **Activation** 
![Checkup](images/opensearch-oic-checkup1.png)

1. Click on the **Activate** button for each integration and active them. 
    
    Note: it is recommended to enable Debug tracing for this lab to check the integration payloads. 

    ![Activate](images/opensearch-oic-activation.png)

    ![Activate2](images/opensearch-oic-activation2.png)


1. Confirm all integrations are *Active*.
![Activate3](images/opensearch-oic-activation3.png)

## Task 6: Test OIC
You will load a file into object storage which will be ingested by OIC, processed with AI, and loaded into the OpenSearch index. (You'll query for this file in the next lab.)

1. In the OCI Console, select the 3-bar/hamburger menu and select
    - Storage
    - Buckets

    ![Test OIC](images/opensearch-oic-test-os-buckets.png)

1. In the *Buckets* list, select **search-public-bucket**.
    ![Test OIC](images/opensearch-oic-test-opensearch-bucket.png)

1. On your local computer, go to the directory that you previously downloaded from GITHUB

    - Alternatively, you can download the file below from the Cloud Shell:
        1. Enter the file name: 
        ```
        <copy>
        oci-genai-searchlab/sample_files/shakespeare_macbeth.tif
        <\copy>
        ```
        ![CloudShell_Download2](images/opensearch-cloudshell-download4.png)

        1. Click the **Download** button.


1. Under *Objects* click the **Upload* button. 

1. In the *Upload Objects* dialog, drag and drop *shakespeare_macbeth.tif* to the drop zone or use **select files** to browse to it on your local computer. Then click the **Upload** button.

    ![Test OIC](images/opensearch-oic-test.png)

1. Click the **Close** button on the *Upload Objects* dialog. The file will be detected automatically and processed by the OIC integration.
     
1. To check the result in OIC, go to the OIC Console and select
    1. Menu *Observability* 
    2. Menu *Integrations*

    ![Monitor OIC](images/opensearch-oic-test2.png)

    The **Succeeded** count should match the **Received** count.

## Task 7: Optional - Process additional files
This is an optional test you can run with more sample files. If you do this test, you will have more content in the OpenSearch index to query in the next lab. If you're running short of time, then you can skip it or come back to it later.

1. Upload the remainder of the sample files to the Object Storage bucket *search-public-bucket*, the same way you uploaded them in the previous task. In the Git clone, the files are located in the *sample_files* folder. (You might need to download them first using the Cloud Shell if you didn't clone the git repo to your local machine.)

1. To check the instances in OIC, go to OIC Console and select
    1. Menu *Observability* 
    1. Menu *Integrations*

1. Click the *Refresh** icon - next to the time in the upper right quadrant of the window - to refresh the processing status. Repeat as needed.
    
    ![Refresh OIC](images/opensearch-oic-test-refresh.png)

1. In the OIC console, go the *Observability* > *Instances* menu.

1. Click on the "eye" icon for any instance to open the instance Activity Stream.

    ![Monitor OIC](images/opensearch-oic-test-instances.png)

1. In the *Activity stream* dialog, click on the **eye** icon on any row that has one to view the message payload.

    ![Monitor OIC](images/opensearch-oic-test-instances-activity-stream.png)

**You may now proceed to the [next lab.](#next)**


## Acknowledgements

- **Author**
    - Marc Gueury, Master Principal Account Cloud Engineer
    - Badr Aissaoui, Principal Account Cloud Engineer
    - Marek Krátký, Cloud Storage Specialist 
