# ODI High Availability Configuration

## Introduction
This lab will show you high-availability configuration steps for existing ODI installation.

*Estimated Lab Time*: 1 hour

### Objectives
In this lab, you will learn
* Configure ODI for High Availability
* Pack the New Configuration 
* Unpack the New Configuration in the secondary node
* Start the Node Manager, Admin Server
* Start the ODI Services

### Prerequisites
This lab assumes you have completed:
    - Lab: Prepare Setup
    - Lab: Environment Setup
    - Lab: Initialize Environment


## Task 1: Configure ODI for High Availability

1. Open the terminal in Node1 and provide the below command to launch the ODI configuration wizard.

    ```
     <copy>
      cd /u02/app/Oracle/Middleware/Oracle_Home/oracle_common/common/bin
      ./config.sh
     </copy>
    ```

      ![Config command](./images/config-1.png " ")

2. Select update an existing domain and verify if the odi_domain is selected. Click "Next".

  ![Update Domain in ODI configuration](./images/config-2.png " ")

3. Available Templates will be displayed on the screen. ODI agent is already selected. Click Next.

  ![Keep default template](./images/config-3.png " ")

4. RCU Window will be displayed on the screen. Click on "Get RCU Configuration".

  ![RCU Window](./images/config-4.png " ")

5. The wizard will connect to the database user and verify the details. A "Successfully Done" message will be displayed in the result log. Click "Next".

  **Note:** If you get a network adapter error message. Refer to the appendix to start the listener services.

    ![RCU Window](./images/config-5.png " ")

6. Keep the default values and click Next in the Component data sources tab.
    
  ![Component Datasources](./images/config-6.png " ")

7. Click Next on the JDBC Test Connection tab.

  ![Test RCU connection](./images/config-7.png " ")

8. Select "Topology" in the Advanced Configuration tab and click Next.

  ![Configure Topology](./images/config-8.png " ")

9. Click Add in the "Managed Servers" tab and add ODI\_server2 in it. Modify the listen address to odiha-2, and listen port to 15101. Select the JRF-MAN-SVR, ODI-MGD-SVRS, and WSM-CACHE-SVR server groups for ODI_server2. Click Next.

  ![Add new managed server](./images/config-9.png " ")

  ![Configure Server groups](./images/config-10.png " ")

10. Click Add in the Cluster tab, type the Cluster Name as ODI_Cluster and click "Next".

  ![Add Cluster](./images/config-11.png " ")

  ![Add Cluster](./images/config-12.png " ")

11. Keep the default values as it is and click Next on Server Templates & Dynamic Servers screen.

  ![Server template screen](./images/config-13.png " ")

  ![Dynamic servers screen](./images/config-14.png " ")

12. Assign ODI\_server1 and ODI\_server2 servers to ODI_Cluster in the "Assign Servers to Clusters" screen.

  ![Add servers to clusters](./images/config-15.png " ")

  ![Add servers to clusters](./images/config-16.png " ")

  ![Add servers to clusters](./images/config-17.png " ")

  Click Next.

13. Click "Next" on the Coherence clusters screen.

  ![Coherence clusters screen](./images/config-18.png " ")

14. Click "Add" in the Machines tab. Add ODI\_Machine\_2, rename the Node manager listen address to "odiha-2" and click next. 

  ![Machines screen](./images/config-19.png " ")

  ![Adding second machine screen](./images/config-20.png " ")

15. Assign ODI\_server2 to ODI\_Machine\_2 in the next tab. Click Next.

  ![Assign admin server and odi server 1 to machine 1](./images/config-21a.png " ")

  ![Assign odi server2 to machine 2](./images/config-22a.png " ")

16. Click Next on the Virtual targets and Partitions screen.

  ![Virtual target screen](./images/config-23.png " ")

  ![Partitions screen](./images/config-24.png " ")

17. Click "Update" on the configuration summary screen, this will update the existing configuration to the HA setup. Click next on the progress screen and Finish to complete the configuration.

  ![Configuration summary](./images/config-25.png " ")

  ![Configuration progress](./images/config-26.png " ")

  ![End of configuration](./images/config-27.png " ")

This completes the configuration.

## Task 2: Pack the New Configuration
1. Navigate to the below path and issue the pack command as given below.
   
    ```
      <copy>
      cd /u02/app/Oracle/Middleware/Oracle_Home/oracle_common/common/bin
      ./pack.sh -domain=/u02/app/Oracle/Middleware/Oracle_Home/user_projects/domains/odi_domain -template=V12214.jar -template_name=V12214 -managed=true
      </copy>
    ```   

    ![Pack configuration](./images/config-28.png " ")

  This pack command will pack the existing configuration which we need to unpack in the secondary host.

  The above command will create the V12214.jar file in the same path.

    ![V12214.jar file](./images/config-29.png " ")

The pack command is executed successfully.




## Task 3: Unpack the New Configuration in the secondary node
Now, the jar file in Node 1 should be copied to the Node 2 directory, and unpack command should be executed. 

1. For ease of use, the file is already copied to object storage. Use the below commands to download it.
Open the Terminal in Node2 and execute the below commands.

  ![Open the terminal](./images/config-30a.png " ") 

    ```
      <copy>
      cd /u02/app/Oracle/Middleware/Oracle_Home/oracle_common/common/bin/
      ls
      cd /tmp
      rm -rf odi_ha_file
      wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/u9H2k21aUrZmkwzY9lNXe0pxbzmobdeLMP4CngZ32tUaH0QJAUyPUQHNiMbzyxKp/n/natdsecurity/b/labs-files/o/odi_ha_file.zip
      unzip -o  odi_ha_file.zip 
      cd odi_ha_file
      cp V12214.jar /u02/app/Oracle/Middleware/Oracle_Home/oracle_common/common/bin/
      cd /u02/app/Oracle/Middleware/Oracle_Home/oracle_common/common/bin/
      ls
      </copy>
    ```

    ![Download V12214.jar from object storage](./images/config-31a.png " ") 

   **Note:** You can even use other tools to transfer the file from the primary node to the secondary node like Winscp, scp, etc.

2. Login to **odiha-2(Node2)** terminal.Navigate to the configuration path and provide the below command to unpack the configuration and create a domain in the secondary node(odiha-2).

    ```
      <copy>
      cd /u02/app/Oracle/Middleware/Oracle_Home/oracle_common/common/bin
      ./unpack.sh -domain=/u02/app/Oracle/Middleware/Oracle_Home/user_projects/domains/odi_domain -template=V12214.jar
      </copy>
    ```

    ![Unpack the configuration](./images/config-32.png " ")


## Task 4: Start the Node Manager and Admin Server

1. Login to odiha-1 and odiha-2 terminals and navigate to below path.

   ```
    <copy>
    cd /u02/app/Oracle/Middleware/Oracle_Home/user_projects/domains/odi_domain/bin
    </copy>
   ```

2. Use the below command to start the node manager in odiha-1 and odiha-2. Press Enter to come out of nohup.
   
    ```
      <copy>
      nohup sh startNodeManager.sh &
      </copy>
    ```

    ![nohup sh startNodeManager.sh &](./images/config-33.png " ")

3. Node manager status can be viewed using the below command. "Listener started on port 5556" indicates that the Node Manager started. Press "ctrl+c" to come out of tailf command.

    ```
      <copy>
      tailf nohup.out
      </copy>
    ```

    ![tailf nohup.out](./images/config-34.png " ")

Node Manager should be started on odiha-1 and odiha-2 hosts.

4. Now, start the Admin server **only in odiha-1**. The below command will start the Admin server in node 1. Press Enter to come out of nohup.
   
    ```
      <copy>
      nohup sh startWebLogic.sh &
      </copy>
    ```

    ![nohup sh startWebLogic.sh &](./images/config-35.png " ")

5. Admin server status should change to RUNNING state. The status can be viewed using the below command. Press "ctrl+c" to come out of tailf command.

    ```
      <copy>
      tailf nohup.out
      </copy>
    ```

    ![tailf nohup.out](./images/config-36.png " ")


Now, the Node manager and Admin server are started.


## Task 5: Start the ODI Services in both the Nodes

1. Open Google Chrome on the Node-1 desktop.

   ![Google chrome on desktop](./images/config-37.png " ")

2. Navigate to the WebLogic console using the below url.

    ```
      <copy>
      http://odiha-1:7005/console
      </copy>
    ```

    ![Weblogic console](./images/config-38.png " ")

3. Provide the WebLogic user name, and password and login into the WebLogic home page.

    ```
      <copy>
      username: weblogic
      password: Welcome1#
      </copy>
    ```

    ![Weblogic console](./images/config-39.png " ")

4. Weblogic home page will be displayed on the screen. Click on the "servers" option.

  ![Weblogic home page](./images/config-40.png " ")

5. Configuration tab will be displayed on the screen. Click on the control tab.

  ![Configuration tab in Summary of servers](./images/config-41.png " ")

6. ODI server1 and server2 are in shutdown state. Select both servers and click on "Start".

  ![Start ODI services](./images/config-42.png " ")

  ![ODI server state](./images/config-43.png " ")


7. Once the servers are started the state changes to the RUNNING state. You can refresh the page after 2 minutes and verify the server status. It may take approximately 5 minutes to start the ODI services. 

  ![ODI servers in running state](./images/config-44.png " ")

Now, the ODI services are up and running. 


**Note:** A load balancer is already configured with the terraform script, so in the next lab you will test the ODI high availability configuration. The load balancer redirects the traffic to the ODI J2EE agent port (15101). The load balancer listener port is configured on port 80.

You may now proceed to the next lab.


## Appendix 1: Managing Listener Services

1. RCU configuration may fail with a Network Adapter error if listener service is not started.

  ![Network Adapter error](./images/config-rcu-issue.png " ")

    - Start
  
    ```
    <copy>
    lsnrctl start
    </copy>
    ```


## Learn More
- [Oracle Data Integrator](https://docs.oracle.com/en/middleware/fusion-middleware/data-integrator/index.html)

## Acknowledgements

- **Author** - Srivishnu Gullapalli, September 2022
- **Contributors** - Amit Kotarkar
- **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, September 2022