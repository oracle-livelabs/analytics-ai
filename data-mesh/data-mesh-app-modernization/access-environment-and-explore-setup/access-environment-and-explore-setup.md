<!-- IMPORTANT -->
<!-- Comments indicate incomplete portions of the markdown, delete comments once a component is complete -->
<!-- IMPORTANT -->

# Access environment and explore setup

## Introduction

The environment you will be working in consists of 3 compute instances. The first compute instance is the bastion host which is be the environment hosting the noVNC server. From this instance you will access the other two, the first being the host of the Oracle Database and GoldenGate. The other instance will host the Helidon microservice. The following image shows what the environment looks like.

<!-- INSERT IMAGE HERE -->

Estimated Time: 5 minutes

### Objectives
- Prepare your environment
- Explore GGSA and OML
- Explore Oracle Analytics Server
- Explore Helidon Microservice

### Prerequisites
  This lab assumes you have:
  - Obtained and signed in to your `dmeventbastion` compute instance

## Task 1: Explore MedRec

<!-- Pradeep, Matthew -->

1. Once you are connected to the `dmeventbastion`. Open a terminal session.

    <!-- INSERT IMAGE HERE -->

<!-- Check hostname -->
2. In the terminal session, use `ssh` to connect to the `dmsafeevents` instance.

    ```
    $ <copy>ssh -i /keys/bastionkey opc@dmsafeevents</copy>
    ```

3. Once you have connected to the instance, switch to the `oracle` user.

    ```
    $ <copy>sudo su - oracle</copy>
    ```
<!-- Verify hostname, port, path, etc.-->
1. Click on **Applications** in the top left corner of the noVNC desktop. Then click **Firefox**. In the URL, navigate to the **MedRec** application.

    ```
    <copy>http://dmsafeemodern:8001/medrec</copy>
    ```

2. MedRec is a monolithic example Java EE application designed to showcase all the different aspects of the standard. The purpose of MedRec is to, as the name suggests, store medical records of patients. To see some patient data, click **Login** in the navigation bar.

    <!-- INSET IMAGE HERE-->

3. Under **Patients**, click **Login**.

    <!-- INSERT IMAGE HERE-->

4. When the login information appears, use the following credentials.

    ```
    Username: <copy>fred@golf.com</copy>
    ```

    ```
    Password: <copy>weblogic</copy>
    ```

5. You can see the fields that are being tracked per patient.

6. Logout of this user.

## Task 2: Explore GGSA and OML

<!-- Jade, Maybe Hannah -->
<!-- TBD: I'm not sure involvement the user will have with setting up the pipeline -->

## Task 3: Explore Oracle Analytics Server

<!-- TBD: I'm not sure of the involvement the user will have with setting up the analytics view-->

## Task 4: Explore Helidon microservice

<!-- Matthew, Pradeep -->

1. Open a new terminal session, in the top right, click **File** then click **New Tab**.

    <!-- INSERT IMAGE HERE -->

2. In this session, use `ssh` to connect to the `eventshelidon` instance. As a reminder, this instance 

    ```
    $ <copy>ssh -i /keys/bastionkey opc@eventshelidon</copy>
    ```

<!-- Review if necessary, will with microservice be launched at instance startup? Also, service name name is probably incorrect-->
3. Once connected, set up the environment for the microservice.

    ```
    $ <copy>. /u05/app/helidon-app/setHelidonEnv.sh</copy>
    ``

<!-- Change path -->
1. Launch the microservice.

    ```
    $ <copy>java -jar path-to-app/target/datamesh.jar</copy>
    ```
2. Return to the terminal window running the `ssh` connection to `dmsafeevents`.

## Acknowledgements
- **Authors**- Matthew McDaniel, Solution Engineer
