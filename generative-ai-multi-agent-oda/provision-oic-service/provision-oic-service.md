# To Integrate Weather API in Oracle Integration Cloud Service (OIC)

## Introduction

This lab will take you through the steps needed to provision Oracle Integration Cloud Service and integrate OIC with the Weather API

Estimated Time: 120 minutes

### About OCI Integration Cloud Service

Oracle Integration Cloud Service is a complete, secure, but lightweight integration solution that enables you to connect your applications in the cloud. It simplifies connectivity between your applications, and can connect both your applications that live in the cloud and your applications that still live on premises. Oracle Integration Cloud Service provides secure, enterprise-grade connectivity regardless of the applications you are connecting or where they reside.

### Objectives

In this lab, you will:

* SignUp for Weather API which is publicly available
* Provision Oracle Integration Cloud Service
* Integrate the Weather API using OIC by configuring connections and importing integration

### Prerequisites

This lab assumes you have:

* All previous labs successfully completed
* Must have an Administrator Account or Permissions to manage several OCI Services: Oracle Integration Cloud Service

## Task 1: Signup for Weather API

This task will help you ensure that the required access to the Weather API using the API Key is available. If the API Key access is not there, please get the API keys as follows.

The weather API provides Real-time or current weather access to near real-time weather information for millions of locations worldwide by global collaborations of weather stations and high resolution local weather models.

1. Goto the URL and sign up with details
   https://www.weatherapi.com/signup.aspx
   Please provide the Email,Password and Sign up.Click Sign up

    ![Signup WeatherAPI](images/signup1.png)

2. Do the account verification Please login into your email account and click on the verification link
   provided within this email to verify your email address.

    ![Account Verification](images/acctverification.png)

3. To complete your account verification, please click the link as provided in your email

    ![Account Activation](images/acctactivation.png)

    **Note** The name of your account can be different.

4. Once verified you will get a message for successful Email Verification.

    ![Successful Email Verification](images/successemailverification.png)


5. Now login to the WeatherAPI with the Email and Password provided in Step1.Click Login

    ![Login Weather API](images/loginweatherapi.png)

    **Note** The name of your account can be different.

6. In the Dasboard click the API and Copy the API key for completing your lab later

    ![Copy API Key](images/cpapikey.png)

## Task 2: Provision Oracle Integration Cloud

This task will help you to create Oracle Integration Cloud under your chosen compartment.

1. Locate Integration under Developer Services in Application Integration

    ![OIC Navigation](images/developerservicess.png)

    **Note** You can find Oracle Integration under the Deevloper Services

2. Click Create Instance

    ![OIC creation wizard](images/createinstoics.png)

3. Provide the information for Name , Edition Enterprise & License type as Subscribe to a new Oracle Integration License
   and Message packs as 1.Click Create

    ![OIC Details](images/oicdetailss.png)

4. In few minutes the status of recently created Oracle Integration will change from Creating to Active

    ![OIC Active](images/instancesactives.png)

## Task 3: Create User with admin roles to manage and run the integrations in Oracle Integration Cloud

This task will help you ensure that the required users are correctly defined. If the Users/Roles are not correctly defined, please define them as follows.A user with the ServiceAdministrator service roles is a super user who can manage and administer the features provisioned in an Oracle Integration instance

1. Locate Domains under Identity & Security

    ![Locate Domain](images/locatedomainss.png)

2. Click on your current domain name

    ![Default Domain](images/defaultsdomain.png)

3. In the Users Menu Click Users to create a  new user devuser3.
   Provide the Last name and Username and your email and Uncheck the checkbox Use the email address as the username

    ![Create User](images/createuser.png)

4. You will get an email notification to activate your account.Please Activate Your Account using the link given in the email

    ![Activate Account](images/activateacct.png)

5. Please reset the password of your choice matching the Rules and Click Reset Password

    ![Reset Password](images/resetpassword.png)

6. The password has been reset for the user devuser3.Keep this password handy as it will be required later in the Livelab

    ![Password Resetted](images/passwordresetted.png)

7. Goto Identity>>Domains>>Default domain>>Oracle Cloud Services and search with the name of  the OIC Instance  that was created in
   Task2 in Lab3

    ![Oracle Cloud Services](images/oracloudservicess.png)
    ![Oracle Cloud Services Instance](images/oracloudservicesinstancess.png)

8. Click on the required Oracle Cloud Services

    ![Click Oracle Cloud Services](images/clickoracloudservices.png)

9. Goto Application Roles and Expand ServiceAdministrator role

    ![Application Role SvcAdmin](images/approlessvcadminss.png)

10. Click Manage and then Click the Show available users and search based on the user devuser3

    ![Search Available User](images/searchavailableuser.png)

11. Select the User and Click Assign to assign the user

12. The User has now been assigned to Service Administrator role

    ![Assign User To AdminRole](images/userassigned2admin.png)

13. Click Close

## Task 4: Import the integration service in Oracle Integration Cloud

This task will help you to import the required integrations along with the related artifacts like Integrations,Connections,Lookups and Libraries in the Oracle Integration instance.

1. Goto Developer Services>>Application Integration >>Integration in your compartment to open the OIC Console

    ![Developer Services OIC](images/developerservicesinoicss.png)

2. Click on the OIC Instance Name

    ![Click OIC Instance](images/clickoicinstancess.png)

3. Click Open Console to launch the Homepage of OIC

    ![Open OIC Console](images/openoicconsoless.png)

4. The OIC Homepage is now opened

    ![OIC Home Page](images/oichomepage.png)

5. Click on Design

    ![OIC Design](images/oicdesign.png)

6. Then Click on Integrations and Click Import to import the integration into this OIC instance

    ![Click on Integration](images/integrations.png)

7. Click on Drag and Drop to Import the OIC Integration by importing the .iar files.Click Import

    ![Import Integration DragnDrop](images/importintdnd.png)

8. Goto the path where the .iar file is located and Click Open

    ![Upload Integration Archive](images/uploadintarchive.png)

9. Click Import

    ![Import Integration](images/importintegration.png)

10. In the Configuration Editor Click on the Edit Icon to modify the connection parameters for the NARestWeatherTrigger Connection

    ![Config Editor Connection1](images/ceconfigconnection1.png)

11. Modify the Properties like Connection URL and Security as Basic Authentication and provide the Username and password with Access
    Type as Public Gateway

    ![Config Connection1](images/configconn1.png)

12. Click On Test to test the connection that has been configured just now.
    Ensure you get a successful Message after clicking on Test.

13. Click on Save to save the connection and also on Save changes click save?

    ![Save Connection1](images/saveconn1.png)

14. Ensure you get a successful Message after clicking on Save. Now Click on the Back Icon to configure the other connection

    ![Goback From Connection1](images/gobackfromconn1.png)

15. Once the first connection is configured Click on the Edit Icon to modify the other connection

    ![Config Editor Connection2](images/ceconfigconnection2.png)

16. Modify the Properties like Connection URL and Security as API Key Based  Authentication and provide the API Key (Lab3 Task1 Step6)
    with Access Type as Public Gateway

    ![Config Connection2](images/configconn2.png)

17. Click On Test to test the connection that has been configured just now.
    Ensure you get a successful Message after clicking on Test.

18. Click on Save to save the connection and also on Save changes? Click Save

    ![Save Connection2](images/saveconn2.png)

19. Ensure you get a successful Message after clicking on Save. Now Click on the Back Icon to to review the Integration

    ![Goback From Connection2](images/gobackfromintegration.png)

20. Now both the required connections are Configured as shown below

    ![Both connections configured](images/bothconnconfigured.png)

21. Click back on the Configuration Editor to Activate the Integration

    ![Goback to Activate Integration](images/gobacktoactivateint.png)

22. Hover over the Integration and Click Activate to activate the integration

    ![Click to Activate Integration](images/clickactivate.png)

23. Select Tracing Level as Debug and click Activate

    ![Activate Integration with Debug Trace](images/activatetracetrue.png)

24. Once the Integration is in Active state Click on actions and then click Run to run the integration

    ![Run Integration once Active](images/runintegration.png)

25. The Integration test looks like

    ![Configure and Run Integration](images/integrationtestinput.png)

26. Provide the City Name as London and Click Run to see the response from the integration service

    ![Run integration with city input](images/inttestwithcityinput.png)

27. Once the integration runs successfully it will give a Response Code as 200 OK  and the desired outputs in the Body in JSON format

    ![View OIC Response](images/oicresponse.png)

28. Copy the endpoint URL and provide it along with the Username/Password to the external applications like Oracle Digital Assistant
    https://******-**************************************************** /ic/api/integration/v1/flows/rest/GETWEATHERUPDBYCITY2ERR/1.0/getTemperature1?city=[city-value]

    ![Copy Endpoint URL for ODA](images/cpendpointurl.png)

    Click Cancel once you have copied the Endpoint URL
    This concludes the OIC Lab !

You may now proceed to the next lab.

## Acknowledgements

* **Author**
    * **Nisith Apurb**, Principal Cloud Architect, NACIE
* **Last Updated By/Date**
    * **Nisith Apurb**, Principal Cloud Architect, January 2025
