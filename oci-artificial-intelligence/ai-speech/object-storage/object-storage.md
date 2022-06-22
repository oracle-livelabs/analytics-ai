# Lab 0: Create a bucket and upload audio files

## Introduction

In order to use the OCI (Oracle Cloud Infrastructure) speech service you must upload formatted audio files to an OCI
object storage bucket

***Estimated Lab Time***: 15 minutes

### Objectives

In this lab, you will:
- Understand the how to format audio files to be compatible with OCI speech service
- Be able to create a bucket on OCI object storage
- Upload the formatted files into OCI object storage

### Prerequisites
- A Free tier or paid tenancy account in OCI
- Familiar with OCI object storage to upload data

## Task 1: Format audio files with proper headers

OCI speech supports single-channel, 16-bit PCM WAV audio files with a 16kHz sample rate. We recommend Audacity (GUI) or ffmpeg (command line) for audio transcoding. 
If you have audio files that aren't in the supported encoding, you can [install ffmpeg](https://ffmpeg.org/download.html) and run the following command:
    <copy>
    ffmpeg -y -i <path to input file> -map 0:a -ac 1 -ar 16000 -b:a 16000 -acodec pcm_s16le <path to output wav file>
    </copy>

In some rare cases a WAV file can have correct encoding but have a different metadata header. To fix this:

    <copy>
    ffmpeg -i <path to input file> -c copy -fflags +bitexact -flags:v +bitexact -flags:a +bitexact <path to output wav file>
    </copy>

<strong>If your audio files are not in WAV format:</strong>
GUI users can use any audio editing software that can load your input file and save in .WAV format. For automated or command-line scenarios, we recommend using the ffmpeg utility with the following command:

    <copy>
    ffmpeg -i <input.ext> -fflags +bitexact -acodec pcm_s16le -ac 1 -ar 16000 <output.wav>
    </copy>

Alternatively, download these pre-formatted sample audio files to use in Task 2:

[sample1](./files/oracle-advertising.wav)

[sample2](./files/oracle-redbull-racing.wav)

[sample3](./files/ready-player-one.wav)

[sample4](./files/the-poet.wav)


## Task 2: Upload Files to Object Storage

You need to upload the audio files into Oracle object storage, to be used in the transcription job(s) in next steps.


1. Create an Object Storage Bucket (This step is optional in case the bucket is already created)

    First, From the OCI Services menu, click Object Storage.
    ![](../../anomaly-detection/images/cloudstoragebucket.png " ")

    Then, Select Compartment from the left dropdown menu. Choose the compartment matching your name or company name.
    ![](../../anomaly-detection/images/createCompartment.png " ")

    Next click Create Bucket.
    ![](../../anomaly-detection/images/createbucketbutton.png " ")

    Next, fill out the dialog box:
    * Bucket Name: Provide a name <br/>
    * Storage Tier: STANDARD

    Then click Create
    ![](../../anomaly-detection/images/pressbucketbutton.png " ")

2. Upload audio file into Storage Bucket

    Switch to OCI window and click the Bucket Name.

    Bucket detail window should be visible. Click Upload
    ![](../../anomaly-detection/images/bucketdetail.png " ")

    Click on Upload and then browse to file which you desire to upload.


More details on Object storage can be found on this page. [Object Storage Upload Page](https://oracle.github.io/learning-library/oci-library/oci-hol/object-storage/workshops/freetier/index.html?lab=object-storage) to see how to upload.


Congratulations on completing this lab!

You may now **proceed to the next lab**

## Acknowledgements
* **Authors**
    * Alex Ginella - Software Developer - Oracle AI Services
    * Jason Ding - Principal Data Scientist - Oracle AI Services
    * Haad Khan - Senior Data Scientist - Oracle AI Services
