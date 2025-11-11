import asyncio
import pyaudio
from collections import deque
import oci
from oci.config import from_file
from oci.auth.signers.security_token_signer import SecurityTokenSigner

from oci_ai_speech_realtime import (
    RealtimeSpeechClient, 
    RealtimeSpeechClientListener
)

from oci.ai_speech.models import (
    RealtimeParameters,
)

import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
# Create a logger for this module
logger = logging.getLogger(__name__)

# This is needed for wss connections
# import truststore
# truststore.inject_into_ssl()

# Create a FIFO queue
queue = asyncio.Queue()

# Set audio parameters
SAMPLE_RATE = 16000
FORMAT = pyaudio.paInt16
CHANNELS = 1
BUFFER_DURATION_MS = 96

# Calculate the number of frames per buffer
FRAMES_PER_BUFFER = int(SAMPLE_RATE * BUFFER_DURATION_MS / 1000)


def authenticator():
    config =oci.config.from_file()
    with open(config["security_token_file"], "r") as f:
        token = f.readline()

    private_key = oci.signer.load_private_key_from_file(config["key_file"])

    return SecurityTokenSigner(token=token, private_key=private_key)


def audio_callback(in_data, frame_count, time_info, status):
    # This function will be called by PyAudio when there's new audio data
    queue.put_nowait(in_data)
    return (None, pyaudio.paContinue)


# Create a PyAudio object
p = pyaudio.PyAudio()

# Open the stream
stream = p.open(
    format=FORMAT,
    channels=CHANNELS,
    rate=SAMPLE_RATE,
    input=True,
    frames_per_buffer=FRAMES_PER_BUFFER,
    stream_callback=audio_callback,
)

stream.start_stream()
config = from_file()


async def send_audio(client):
    i = 0
    # loop = asyncio.get_running_loop()
    while True:
        data = await queue.get()

        # Send it over the websocket
        await client.send_data(data)
        i += 1

    # stream.close()
    # client.close()


class MyListener(RealtimeSpeechClientListener):
    def on_result(self, result):
        if result["transcriptions"][0]["isFinal"]:
            logger.info(
                f"Received final results: {result['transcriptions'][0]['transcription']}"
            )
        else:
            logger.info(
                f"Received partial results: {result['transcriptions'][0]['transcription']}"
            )

    def on_ack_message(self, ackmessage):
        return super().on_ack_message(ackmessage)

    def on_connect(self):
        return super().on_connect()

    def on_connect_message(self, connectmessage):
        return super().on_connect_message(connectmessage)

    def on_network_event(self, ackmessage):
        return super().on_network_event(ackmessage)

    def on_error(self):
        return super().on_error()
    
    def on_close(self, error_code, error_message):
        return super().on_close(error_code, error_message)


if __name__ == "__main__":
    # Run the event loop
    def message_callback(message):
        logger.info(f"Received message: {message}")

    realtime_speech_parameters: RealtimeParameters = RealtimeParameters()
    realtime_speech_parameters.language_code = "en-US"
    realtime_speech_parameters.model_domain = (
        realtime_speech_parameters.MODEL_DOMAIN_GENERIC
    )
    realtime_speech_parameters.model_type = "ORACLE"
    realtime_speech_parameters.partial_silence_threshold_in_ms = 0
    realtime_speech_parameters.final_silence_threshold_in_ms = 2000
    realtime_speech_parameters.encoding="audio/raw;rate=16000"
    realtime_speech_parameters.punctuation = (
        realtime_speech_parameters.PUNCTUATION_AUTO
    )
    realtime_speech_parameters.should_ignore_invalid_customizations = False
    realtime_speech_parameters.stabilize_partial_results = (
        realtime_speech_parameters.STABILIZE_PARTIAL_RESULTS_NONE
    )
    # realtime_speech_parameters.customizations = [
    #     {
    #         "compartmentId": "ocid1.compartment.....",
    #         "customizationId": "ocid1.aispeechcustomization....",
    #         "entities": [
    #             {
    #                 "entityType": "entityType",
    #                 "customizationAlias": "entityAlias",
    #                 "customizationId": "ocid1.aispeechcustomization.....",
    #             },
    #             ...,
    #         ],
    #     }
    # ]

    realtime_speech_url = "wss://realtime.aiservice.uk-london-1.oci.oraclecloud.com"
    client =  RealtimeSpeechClient(
            realtime_speech_parameters=realtime_speech_parameters,
            config=config,
            listener=MyListener(),
            service_endpoint=realtime_speech_url,
            signer=authenticator(),
            compartment_id="<compartmentID>",
        )

    loop = asyncio.get_event_loop()
    loop.create_task(send_audio(client))
    loop.run_until_complete(client.connect())

    """
    Optionally request the final result on demand.
    The below code snippet will request a final result.
    
    await client.request_final_result()
    
    """

    if stream.is_active():
        stream.close()

    logger.info("Closed now")