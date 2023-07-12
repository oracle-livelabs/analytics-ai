
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
Method 1
To download the files to your laptop from the Github website, please follow these steps.
````

1. In a new tab or window of your Intenet browser, go to https://github.com/mgueury/oci-searchlab/tree/main and click *Code* and then *Download ZIP*.
![GitHub_Download](images/opensearch-github-download-zip.png)

1. Extract the oci-searchlab-main.zip file to your computer. 
![GitHub_Download](images/opensearch-github-extract-zip.png) 

1. Note the directory contains the Oracle Integration Cloud (OIC) package in the ***oic*** folder, the Visual Builder (VB) application in the ***vb*** folder, and samples files in the ***sample_files*** folder.

````
Method 2
Since the Github repository was downloaded in the Cloud Console Code Editor during the previous lab using the "git clone" command, there is an option to download individual files using the OCI Console Code Editor. If you want to use this option, follow these alternative steps.
````
1. In the OCI Console, select the **Developer Tools icon** and then select *Cloud Shell*.

1. Click the **Cloud Shell Menu icon** and select *Download*.
![CloudShell_Download](images/opensearch-cloudshell-download.png)

1. To download the OIC integration file from the Cloud Shell, enter the file name: *oci-searchlab/oic/OPENSEARCH_OIC.par* and click **Download**.
    
    ![CloudShell_Download2](images/opensearch-cloudshell-download2.png)

## Task 2: Import the integration
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

## Task 3: Configure the OIC connections
We start with the public connections first because these don't depend on component provisioning that is being completed in the previous lab by the Terraform script.

### 1. RestObjectStorage

1. Click the **edit** icon on the same row as *RestObjectStorage*

    ![Package details](images/opensearch-oic-package-import1.png)

1. Copy the Object Storage rest API from [https://docs.oracle.com/en-us/iaas/api/#/en/objectstorage/20160918/](https://docs.oracle.com/en-us/iaas/api/#/en/objectstorage/20160918/). Select the endpoint for the home region of your tenancy. You will paste it in place of *##OS\_URL##* below.

1. Fill the Connection details:
    - Connection Type = *REST API Base URL*
    - Connection URL = *##OS\_URL##*
        - ex: https://objectstorage.eu-frankfurt-1.oraclecloud.com
    - Security policy = *OCI Service Invocation*
    - Access Type = *Public gateway*
1. **Test / Save / Save** until 100%
1. Go back to the list of connections. The remainder of the connections are configured in a similar manner.

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

1. In OCI Console Cloud Shell, run: 
    ```
    <copy>
    oci-searchlab/starter/src/search_env.sh
    </copy>
    ```
    1. In the output of this script look for the following values under the heading **-- STREAMING CONNECTION --------------------------**:
        - ##STREAM_BOOSTRAPSERVER##
        - ##STREAM_USERNAME##
        - ##AUTH_TOKEN##
    1. Copy and paste these values to your text file to use in configuring the connection

1. Click the **Cloud Shell Menu icon** and select *Download*.
![CloudShell_Download](images/opensearch-cloudshell-download.png)

1. Enter the file name: *oci-searchlab/starter/oss_store.jks* and click **Download**.
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
    - Access Type = *Connectivity agent*
    - Selected agent group: *OPENSEARCH\_AGENT\_GROUP*
    
    ![Connection StreamInputBucket](images/opensearch-connection-streaminputbucket.png)


1. **Test / Save / Save** until 100%

1. Go back to the list of connections

### 8. RestFunction
1. In OCI Console Cloud Shell, run: 
    ```
    <copy>
    oci-searchlab/starter/src/search_env.sh
    </copy>
    ```

    1. In the output of this script look for the following value:
        - *##FUNCTION_ENDPOINT##*
    1. Copy and paste the value to your text file to use in configuring the connection

1. Fill the Connection details:
    - Connection Type = *REST API Base URL*
    - Connection url = *##FUNCTION_ENDPOINT##* without /action/invoke at the end.
        - ex: https://xxxx.eu-frankfurt-1.functions.oci.oraclecloud.com/20181201/functions/ocid1.fnfunc.oc1.eu-frankfurt-1.aaaaaaabbbbb
    - Security policy = *OCI Service Invocation*
    - Access Type = *Public gateway*
    
    ![Connection RestFunction](images/opensearch-connection-restfunction.png)


1. **Test / Save / Save** until 100%

1. Go back to the list of connections

### 9. RestOpenSearch
1. In OCI Console Cloud Shell, run: 
    ```
    <copy>
    oci-searchlab/starter/src/search_env.sh
    <\copy>
    ```

    - In the output of this script look for the following value:
        - *##OPENSEARCH\_API\_ENDPOINT##*
    
1. Fill the Connection details:
    - Connection Type = *REST API Base URL*
    - Connection url = *##OPENSEARCH\_API\_ENDPOINT##*
        - ex: https://amamamamalllllaaac5vkwantypqqcs4bqrgqjrkvuxxghsmg7zzzzzxxxxx.opensearch.eu-frankfurt-1.oci.oraclecloud.com:9200
    - Security policy: *No Security Policy*
    - Access Type = *Connectivity agent*
    - Selected agent group: *OPENSEARCH\_AGENT\_GROUP*
    
    ![Connect RestOpenSearch](images/opensearch-connection-restopensearch.png)

1. **Test / Save / Save** until 100%

1. Go back to the list of connections

## Task 4. Activate the integration

1. All connections should be valid. To activate the integrations,
click on **Activation** 
![Checkup](images/opensearch-oic-checkup1.png)

1. Click on the **Activate** button for each integration and active them. 
![Activate](images/opensearch-oic-activation.png)

    ```
    Note: it is recommended to enable Debug tracing for this lab to check the integration payloads. 
    ```
    ![Activate2](images/opensearch-oic-activation2.png)


1. Confirm all integrations are up and running.
![Activate3](images/opensearch-oic-activation3.png)

## Task 5: Test OIC
You will load a file into object storage which will get ingested by OIC, processed with AI, and loaded into the OpenSearch index. (You'll query for this file in the next lab.)

1. In the OCI Console, select the 3-bar/hamburger menu and select
    - Storage
    - Buckets

    ![Test OIC](images/opensearch-oic-test-os-buckets.png)

1. In the *Buckets* list, select **opensearch-bucket**.
    ![Test OIC](images/opensearch-oic-test-opensearch-bucket.png)

1. On your local computer, go to the directory that you previously downloaded from GITHUB

    1. Alternatively, you can download the files form the Cloud Shell:
    1. Enter the file name: 
        ```
        <copy>
        oci-searchlab/sample_files/shakespeare_macbeth.tif
        <\copy>
        ```
        ![CloudShell_Download2](images/opensearch-cloudshell-download4.png)

    1. click Download button.


1. Upload the sample file to OCI Object Storage bucket: 

    ![Test OIC](images/opensearch-oic-test.png)

     
1. To check the result in OIC, Go to the OIC Console and select
    1. Menu *Observability* 
    2. Menu *Integrations*

    ![Monitor OIC](images/opensearch-oic-test2.png)

    The **Succeeded** count should match the **Received** count.

## Task 6: Optional - Process additional files
This is an optional test you can run with more sample files. If you do this test, you will have more content in the OpenSearch index to query in the next lab. If you're running short of time, then you can skip it.

1. Upload the remainder of the sample files to the Object Storage bucket *opensearch-bucket*, the same way you uploaded them in the previous task. In the Git clone, the files are located in the *sample_files* folder. (You might need to download them first using the Cloud Shell if you didn't clone the git repo to your local machine.)

1. To check the instances in OIC, go to OIC Console and select
    1. Menu *Observability* 
    1. Menu *Integrations*

1. Click on the "eye" icon to open the instance Activity Stream and view the message payloads.

    ![Monitor OIC](images/opensearch-oic-test-instances.png)

    ![Monitor OIC](images/opensearch-oic-test-instances-activity-stream.png)

**Please proceed to the [next lab.](#next)**


## Acknowledgements

- **Author**
    - Marc Gueury
    - Badr Aissaoui
    - Marek Krátký 
- **History** - Creation - 19 May 2023
