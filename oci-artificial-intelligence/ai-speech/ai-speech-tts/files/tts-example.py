import oci
import json
from oci.ai_speech import AIServiceSpeechClient
from oci.ai_speech.models import *
from oci.config import from_file
from oci.signer import load_private_key_from_file
from oci.auth.signers import SecurityTokenSigner

   
"""
configure these constant variables as per your use case
configurable values begin
"""
  
endpoint = "https://speech.aiservice-preprod.us-phoenix-1.oci.oraclecloud.com"
  
# Replace compartment with your tenancy compartmentId
compartmentId = "<compartment_ID>"
   
# the text for which you want to generate speech
text = "A paragraph is a series of sentences that are organized and coherent, and are all related to a single topic. Almost every piece of writing you do that is longer than a few sentences should be organized into paragraphs."
   
# Supported voices for ModelType TTS_2_Natural are: "Brian", "Annabelle", "Bob", "Phil", "Cindy" and "Stacy"
# Supported voices for ModelType TTS_1_Standard are: "Bob", "Phil", "Cindy" and "Stacy"
# the voiceId that you want to use for generated speech. Only "Brian" and "Annabelle" are supported as of now.
voiceId = "Annabelle"
   
# If you want to enable streaming, set this value to true.
# With streaming, response is sent back in chunks.
# This means that you don't have to wait for entire speech to be generated before you can start using it.
isStreamEnabled = False
 
# Supported output formats
# - TtsOracleSpeechSettings.OUTPUT_FORMAT_PCM
# - TtsOracleSpeechSettings.OUTPUT_FORMAT_MP3
# - TtsOracleSpeechSettings.OUTPUT_FORMAT_JSON
# - TtsOracleSpeechSettings.OUTPUT_FORMAT_OGG
outputFormat = TtsOracleSpeechSettings.OUTPUT_FORMAT_MP3
  
# Replace filename with the file name to save the response
filename = "tts.mp3"
   
# This is the sample rate of the generated speech.
sampleRateInHz = 24000
   
# Only TEXT_TYPE_TEXT is supported as of now.
textType = TtsOracleSpeechSettings.TEXT_TYPE_TEXT
   
# Specify speech mark types to obtain in case of Json output
# This field will be ignored if the output format is not Json
# The output json will contain all the speech mark types mentioned in the below list
speechMarkTypes = [TtsOracleSpeechSettings.SPEECH_MARK_TYPES_WORD, TtsOracleSpeechSettings.SPEECH_MARK_TYPES_SENTENCE]
   
"""
configurable values end
"""
   
def main():
    # get client for authentication and authorization
    client = get_client()
       
    # create payload object
    payload = get_payload()

    # voices = get_voices(client)

    # This will list voices available for model
    # print(f'List of voices available {json.dumps(voices)}')

    # print(json.dumps(payload))
    print(json.dumps(
            payload,
            default=lambda o: o.__dict__, 
            sort_keys=True,
            indent=4))
   
    # handle response
    response = client.synthesize_speech(payload)
    if (response.status != 200):
        print(f'Request failed with {response.status}')
    else:
        save_response(response.data)
          
def get_voices(client):
    return client.list_voices(compartment_id = compartmentId) # model_name

def getSigner(profile_name):
    config = oci.config.from_file(profile_name=profile_name)
    token_file = config['security_token_file']
    token = None
    with open(token_file, 'r') as f:
        token = f.read()
    private_key = oci.signer.load_private_key_from_file(config['key_file'])
    signer = oci.auth.signers.SecurityTokenSigner(token, private_key)
    return config, signer
 
def get_client():
    config, signer = getSigner("DEFAULT") # Change the profile name from DEFAULT, if you are using some other profile
    ai_client = oci.ai_speech.AIServiceSpeechClient(config, signer=signer, service_endpoint=endpoint)
    return ai_client

        
def get_payload():
    return SynthesizeSpeechDetails(
        text = text,
        is_stream_enabled=isStreamEnabled,
        compartment_id = compartmentId,
        configuration = TtsOracleConfiguration(
            model_details = TtsOracleTts2NaturalModelDetails (
                voice_id=voiceId
            ),
            speech_settings = TtsOracleSpeechSettings(
                text_type = textType,
                sample_rate_in_hz = sampleRateInHz,
                output_format = outputFormat,
                speech_mark_types = speechMarkTypes
            )
        )
    )
   
def save_response(data):
    if (isStreamEnabled and outputFormat == TtsOracleSpeechSettings.OUTPUT_FORMAT_PCM):
        streaming_save_as_wav(data)
    else:
        with open(filename, 'wb') as f:
            for b in data.iter_content():
                f.write(b)
   
def streaming_save_as_wav(data: bytes, filename: str = filename, buffer_size: int = 2048):
    HEADER_SIZE = 94
    assert buffer_size > HEADER_SIZE
    buffer, bytes_written = b'', 0
   
    f1 = open(filename, 'wb')
    f2 = open(filename, 'wb')
  
    with open(filename, 'wb') as f1, open(filename, 'wb') as f2:
  
        def update_wav_header():
            nonlocal buffer, f1, f2, bytes_written
              
            if len(buffer) >= buffer_size:
  
                f1.write(buffer)
                bytes_written += len(buffer)
                buffer = b''
  
                f2.seek(4, 0)
                f2.write((bytes_written - 8).to_bytes(4, 'little'))
                f2.seek(40, 0)
                f2.write((bytes_written - HEADER_SIZE).to_bytes(4, 'little'))
  
                f1.flush()
                f2.flush()
   
        for b in data.iter_content():
            buffer += b
            update_wav_header()
        update_wav_header()
   
   
if __name__ == '__main__':
    main()