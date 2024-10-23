import oci
 
def getSigner(profile_name):
    config = oci.config.from_file(profile_name=profile_name)
    token_file = config['security_token_file']
    token = None
    with open(token_file, 'r') as f:
        token = f.read()
    private_key = oci.signer.load_private_key_from_file(config['key_file'])
    signer = oci.auth.signers.SecurityTokenSigner(token, private_key)
    return config, signer
 
def getSpeechClient():
    config, signer = getSigner("DEFAULT") # Change the profile name from DEFAULT, if you are using some other profile
    ai_client = oci.ai_speech.AIServiceSpeechClient(config, signer=signer)
    return ai_client

ai_client = getSpeechClient()

# Give your job related details in these fields
SAMPLE_DISPLAY_NAME = "<job_name>" # Name of the job
SAMPLE_COMPARTMENT_OCID = "<compartment_ocid>" # Compartment OCID containing the bucket with audio files
SAMPLE_DESCRIPTION = "<job_description>" # Optional can be left blank
SAMPLE_NAMESPACE = "<sample_namespace>" # Namespace of the bucket
SAMPLE_BUCKET = "<bucket_name>" # Bucket name containing audio files
JOB_PREFIX = "Python_SDK_DEMO"
LANGUAGE_CODE = "en-US"
FILE_NAMES = ["<file1>", "<file2>"] # List of audio files present in the bucket
NEW_COMPARTMENT_OCID = "<new_compartment>" # Destination Compartmnet OCID
NEW_DISPLAY_NAME = "<new_name>" # New Job Name in the Destination compartment
NEW_DESCRIPTION = "<new_description>" # Optional can be left blank
<<<<<<< HEAD
MODEL_TYPE = "ORACLE" # Supported MODEL_TYPE values: ORACLE, WHISPER_MEDIUM
IS_DIARIZATION_ENABLED = True  # Boolean value to enable or disable diarization
# Supported language codes for ORACLE MODEL: en-US, en-AU, en-IN, en-GB, it-IT, pt-BR, hi-IN, fr-FR, de-DE, es-ES
# Supported language codes for WHISPER_MEDIUM MODEL: af, ar, az, be, bg, bs, ca, cs, cy, da, de, el, en, es, et, fa, fi, fr, gl, he, hi, hr, hu, hy, id, is, it, ja, kk,  kn, ko, lt, lv, # mi, mk, mr, ms, ne, nl, no, pl, pt, ro, ru, sk, sl, sr, sv, sw, ta, th, tl, tr, uk, ur, vi, zh
SAMPLE_MODEL_DETAILS = oci.ai_speech.models.TranscriptionModelDetails(model_type=MODEL_TYPE, domain="GENERIC",  language_code=LANGUAGE_CODE,
transcription_settings=oci.ai_speech.models.TranscriptionSettings(
    diarization=oci.ai_speech.models.Diarization(
        is_diarization_enabled=IS_DIARIZATION_ENABLED               
    )
)
)
=======
SAMPLE_MODE_DETAILS = oci.ai_speech.models.TranscriptionModelDetails(domain="GENERIC", language_code=LANGUAGE_CODE)
>>>>>>> upstream/main
SAMPLE_OBJECT_LOCATION = oci.ai_speech.models.ObjectLocation(namespace_name=SAMPLE_NAMESPACE, bucket_name=SAMPLE_BUCKET,
object_names=FILE_NAMES)
SAMPLE_INPUT_LOCATION = oci.ai_speech.models.ObjectListInlineInputLocation(
    location_type="OBJECT_LIST_INLINE_INPUT_LOCATION", object_locations=[SAMPLE_OBJECT_LOCATION])
SAMPLE_OUTPUT_LOCATION = oci.ai_speech.models.OutputLocation(namespace_name=SAMPLE_NAMESPACE, bucket_name=SAMPLE_BUCKET,
                                                             prefix=JOB_PREFIX)
COMPARTMENT_DETAILS = oci.ai_speech.models.ChangeTranscriptionJobCompartmentDetails(compartment_id=NEW_COMPARTMENT_OCID)
UPDATE_JOB_DETAILS = oci.ai_speech.models.UpdateTranscriptionJobDetails(display_name=NEW_DISPLAY_NAME, description=NEW_DESCRIPTION)

# Create Transcription Job with details provided
transcription_job_details = oci.ai_speech.models.CreateTranscriptionJobDetails(display_name=SAMPLE_DISPLAY_NAME,
                                                                               compartment_id=SAMPLE_COMPARTMENT_OCID,
                                                                               description=SAMPLE_DESCRIPTION,
                                                                               model_details=SAMPLE_MODEL_DETAILS,
                                                                               input_location=SAMPLE_INPUT_LOCATION,
                                                                               output_location=SAMPLE_OUTPUT_LOCATION)
 
transcription_job = None
print("***CREATING TRANSCRIPTION JOB***")
try:
    transcription_job = ai_client.create_transcription_job(create_transcription_job_details=transcription_job_details)
except Exception as e:
    print(e)
else:
    print(transcription_job.data)


print("***CANCELLING TRANSCRIPTION JOB***")
# Cancel transcription job and all tasks under it
try:
    ai_client.cancel_transcription_job(transcription_job.data.id)
except Exception as e:
    print(e)


print("***UPDATING TRANSCRIPTION JOB DETAILS")
try:
    ai_client.update_transcription_job(transcription_job.data.id, UPDATE_JOB_DETAILS)
except Exception as e:
    print(e)

print("***MOVE TRANSCRIPTION JOB TO NEW COMPARTMENT***")
try:
    ai_client.change_transcription_job_compartment(transcription_job.data.id, COMPARTMENT_DETAILS)
except Exception as e:
    print(e)


print("***GET TRANSCRIPTION JOB WITH ID***")
# Gets Transcription Job with given Transcription job id
try:
    if transcription_job.data:
        transcription_job = ai_client.get_transcription_job(transcription_job.data.id)
except Exception as e:
    print(e)
else:
    print(transcription_job.data)


print("***GET ALL TRANSCRIPTION JOBS IN COMPARTMENT***")
# Gets All Transcription Jobs from a particular compartment
try:
    transcription_jobs = ai_client.list_transcription_jobs(compartment_id=SAMPLE_COMPARTMENT_OCID)
except Exception as e:
    print(e)
else:
    print(transcription_jobs.data)



print("***GET ALL TASKS FROM TRANSCIRPTION JOB ID***")
#Gets Transcription tasks under given transcription Job Id
transcription_tasks = None
try:
    transcription_tasks = ai_client.list_transcription_tasks(transcription_job.data.id)
except Exception as e:
    print(e)
else:
    print(transcription_tasks.data)


print("***GET PRATICULAR TRANSCRIPTION TASK USING JOB AND TASK ID***") 
# Gets a Transcription Task with given Transcription task id under Transcription Job id
transcription_task = None
try:
    if transcription_tasks.data:

        transcription_task = ai_client.get_transcription_task(transcription_job.data.id, transcription_tasks.data.items[0].id)
except Exception as e:
    print(e)
else:
    print(transcription_task.data)


print("***CANCEL PARTICULAR TRANSCRIPTION TASK***")
try:
    if transcription_task:
        ai_client.cancel_transcription_task(transcription_job.data.id, transcription_task.data.id)
except Exception as e:
    print(e)

