# Creating the OCI stream service and build the synthetic data generator.
Here we will be creating the OCI stream service and will be deploying the Python Streaming Simulator code base to the Compute VM created in ***Lab2B***

Estimated Time: 30 minutes

### Objectives
In this lab, you will:
- Create OCI stream service
- Deploy the generator codebase to compute VM
- Perform script refactoring and execute the code

## Pre-Requisites

* An Oracle Cloud Account - please view this workshop's LiveLabs landing page to see which environments are supported.
* Completed Lab 2B

## Task 1: Create an OCI Stream

1. Open the navigation menu and click ***Analytics & AI***. Under ***Messaging***, click ***Streaming***. A list of existing streams is displayed.
![OCI Stream console](./images/stream-console.png)

2. Click ***Create Stream*** at the top of the screen.Make sure to create the stream in the same demo compartment.
![OCI Stream console](./images/strem-select.png)

3. ***Stream Name:*** Specify a friendly name for the stream and create the streaming app using default pool option "Auto-Create a default stream pool" .
Streaming application name example - "e2e-stream-mysqlhw".
![OCI Stream console](./images/streaming-pool.png)


4.Click ***Create***.

5. In a few seconds the streaming application gets created .
![OCI Stream console](./images/stream-create.png)



## Task 2: Deploy the Python generator script on Compute VM
- Login to the compute VM using user ***OPC*** (Using and SCP tool like WINSCP or Mobaextern).
   
- Download the Labfiles and navigate to the below folder location to collect the codepump.zip file.

   Download file [`MYSQLLakehouse_labfiles.zip`](https://objectstorage.us-ashburn-1.oraclecloud.com/p/RPka_orWclfWJmKN3gTHfEiv-uPckBJTZ3FV0sESZ3mm3PDCQcVDCT-uM2dsJNGf/n/orasenatdctocloudcorp01/b/MYSQLLakehouse_labfiles/o/MYSQLLakehouse_labfiles.zip)

  *** Python Framework Location in the Zip file - \_MYSQLLakehouse_labfiles\_Lab4b\_ProducerCodebase  
  ![Python Generator code loc](images/generator-zip.png" ")

- Upload the zip to the compute VM
  ![Python Generator code loc](images/upload-codebase.png " ")

- Ensure python 3.8 and OCI library is installed in the compute VM 


  Run the below commands to get the packages installed.

    ``` 
        <copy>    
        sudo yum install python38
        sudo yum install oci
        python3.8 --version
    ```
- unzip the zip file 

  ![Python Generator code loc](images/unzip-file.png " ")
  
- Naviagte to the below location 
  ![Python Generator code loc](images/navigate-gen.png " ")

- Navigate to Keys directory and paste your OCI keys in the below directory 
  *** Flollow the below link ,which shows the steps to configure your private and public keys.
 
  **[Click here for key generation ]( https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm)**
  
  ![Python Generator code loc](images/key-gen.png" ")

  ![Python Generator code loc](images/key-file-content.png" ")

- Navigate to the ***Code*** directory. 
  Change the contents of the code - ProducerCodeLoop_ETC.py (in VI editor)
  ![Python Generator code loc](images/code-script.png" ")
  
    ```
      <copy>
      device_file_path = '/home/opc/codepump/data/datapumper-input-file-2.csv' - Linux live lab
      ociMessageEndpoint = "https://cell-1.streaming.us-xyz" - stream OCID
      ociStreamOcid = "xyz" - get this from the streaming application
      ociConfigFilePath = "/home/opc/codepump/keys/config" - path to your config file
      ociProfileName = "DEFAULT"
    ```
![OCI streaming application connection details from Producer code](images/streaming-connection-check.png " ")

- Save and run the pythn code

    ```
        <copy>
        python3 ProducerCodeLoop_ETC.py
    ```

You may now **proceed to the next lab**

## Acknowledgements
* **Author** - Biswanath Nanda, Principal Cloud Architect, North America Cloud Infrastructure - Engineering
* **Contributors** -  Biswanath Nanda, Principal Cloud Architect,Bhushan Arora ,Principal Cloud Architect,Sharmistha das ,Master Principal Cloud Architect,North America Cloud Infrastructure - Engineering
* **Last Updated By/Date** - Biswanath Nanda, March 2024