# Configurations io trigger integration

## Introduction

Learn how to trigger integrations


*Estimated Lab Time*: 2 hour

### Objectives:

* To create a setup to trigger sppech and language integration setup in the lab 2

### Prerequisites:

* Lab 2


## **Task 1**: Setup Merge Transcription Function

## **Task 2**: Setup Key Phrase Function

## **Task 3**: Setup and Integrate Notification with the Integration Service

1. Click on the hamburger menu, then click on **Developer Services**, under **Application Integration** Click on **Notification**.
    ![Navigate to Notification Page](./images/navigate-to-notifications.png " ")

2. Select the compartment you are working on and then click **Create Topic**
    ![Create Topic button](./images/create-topic-button.png " ")

3. Fill the Name field with "NewAudioFileForTranscription" and click create.
    ![Create Topic details](./images/create-topic.png " ")

4. After the Topic is created, open the Topic details page, and click Create Subscription.

5. Under the Protocol choose "HTTPS (Custom URL)" from the dropdown. Fill the URL field with "https://*userName*:*Password*@*Integration-URL*/ic/api/integration/v1/flows/rest/TRANSCRIBE_AUDIO_FILES/1.0/NewAudioFileForTranscription".
where the "userName" and "Password" are the login username and password in encoded text format(for example user@gmail.com should be given as user%40gmail.com). The "Integration-URL" is the URL of the integration that we have created in the Lab 2.

6. Click create button.
    ![Create subscription](./images/create-subscription.png " ")

7. After the subscrption is created, it will be in pending state. To make it active first click on the three dots to the right and click "resend confirmation".
    ![Resend subscription confirmation](./images/subscription-confirmation-resend.png " ")

8. To activate the subscription, open the integrations URL. open hamburger menu, click on **Monitoring** then **Integrations** and then **Errors**.
    ![Navigate to Errors Page](./images/navigate-to-errors-1.png " ")
    ![Navigate to Errors Page](./images/navigate-to-errors-2.png " ")

9. In the Errors page click on view details for the latest error.
    ![Error details](./images/error-page.png " ")

10. Now in the error click on Message URL link and store the confirmationURL that is shown.
    ![Error Message](./images/error-message.png " ")

11. Modify the confirmation URL to remove "amp;" from the URL. For example modify
<copy>
https://cell1.notification.us-phoenix-1.oci.oraclecloud.com/20181201/subscriptions/ocid1.onssubscription.oc1.phx.aaaaaaaaxzkyua23ujvlynaadfqspam7wrwt7eev6lmjyxo5h4dimhri5wza/confirmation?token=MDAwMHRCUzFpVnVYb2FqM1YxMXVTKzJQUDJFb2NFcWp5SEpuQzlqWDNvS0JMN25xaVFrSFhvPQ==&amp;protocol=CUSTOM_HTTPS
</copy>
to 
<copy>
https://cell1.notification.us-phoenix-1.oci.oraclecloud.com/20181201/subscriptions/ocid1.onssubscription.oc1.phx.aaaaaaaaxzkyua23ujvlynaadfqspam7wrwt7eev6lmjyxo5h4dimhri5wza/confirmation?token=MDAwMHRCUzFpVnVYb2FqM1YxMXVTKzJQUDJFb2NFcWp5SEpuQzlqWDNvS0JMN25xaVFrSFhvPQ==&protocol=CUSTOM_HTTPS
</copy>

12. Open the modified URL in the browser. You should see a page stating that you have been subscribed to the topic "NewAudioFileForTranscription".
    ![Confirmation URL](./images/confirmation-url.png " ")

13. Create a new topic with Name "NewTranscriptionForAnalysis" following steps 2 and 3.

14. Repeat the steps 4 to 12 to create a subscription for the new topic "NewTranscriptionForAnalysis".


## **Task 4**: Event Setup for New Audio File for Transcription##

1. Open hanburger menu, click on **Observability & Management**, under **Events Service** Click on **Rules**.
    ![Navigate to Rules](./images/navigate-to-rules.png " ")

2. Select the compartment you are working on and then click **Create Rule**
    ![Create Rule button](./images/create-rule-button.png " ")

3. Fill Display Name with "NewAudioFileForTranscription"

4. Under Rule Conditions, Choose Condition as **Event Type**, Service Name as **Object Storage** and Event Type as **Object - Create**.

5. Click on **Another Condition**, Choose Condition as **Attribute**, Service Name as **bucketName** and fill Event Type with **FilesForTranscription** which is a bucket we created while preparing data sources in Lab 1.

6. Under Actions, Choose Action Type as **Notifications**, Notifications Compartment as *your-working-compartment* and Topic as **NewAudioFileForTranscription**.

7. Click Create Rule.
    ![Create New Audio File For Transcription Rule details](./images/create-rule-1.png " ")

## **Task 5**: Event Setup for New Transcription for Merge Transcription##

1. Navigate back to the Rules listing page.

2. Click on **Create Rule**
    ![Create Rule button](./images/create-rule-button.png " ")

3. Fill Display Name with "NewTranscriptionForMerge"

4. Under Rule Conditions, Choose Condition as **Event Type**, Service Name as **Object Storage** and Event Type as **Object - Create**.

5. Click on **Another Condition**, Choose Condition as **Attribute**, Service Name as **bucketName** and fill Event Type with **TranscribedFiles** which is a bucket we created while preparing data sources in Lab 1.

6. Under Actions, Choose Action Type as **Functions**, Function Compartment as *your-working-compartment*, Function Application as *Your-Appliction-Name* and Function as **merge-transcripts**.

7. Click Create Rule.
    ![Create New Transcription For Merge Rule details](./images/create-rule-2.png " ")

## **Task 6**: Event Setup for New Transcription for Analysis##

1. Navigate back to the Rules listing page.

2. Click on **Create Rule**
    ![Create Rule button](./images/create-rule-button.png " ")

3. Fill Display Name with "NewTranscriptionForAnalysis"

4. Under Rule Conditions, Choose Condition as **Event Type**, Service Name as **Object Storage** and Event Type as **Object - Create**.

5. Click on **Another Condition**, Choose Condition as **Attribute**, Service Name as **bucketName** and fill Event Type with **MergedTranscriptions** which is a bucket we created while preparing data sources in Lab 1.

6. Under Actions, Choose Action Type as **Notifications**, Notifications Compartment as *your-working-compartment* and Topic as **NewTranscriptionForAnalvsis**.

7. Click Create Rule.
    ![Create New Transcription For Analysis details](./images/create-rule-3.png " ")

## Acknowledgements

**Authors**
  * Rajat Chawla  - Oracle AI OCI Language Services
  * Sahil Kalra - Oracle AI OCI Language Services
  * Ankit Tyagi -  Oracle AI OCI Language Services
  * Veluvarthi Narasimha Reddy - racle AI OCI Language Services

**Last Updated By/Date**
* Veluvarthi Narasimha Reddy  - Oracle AI OCI Language Services, April 2023
