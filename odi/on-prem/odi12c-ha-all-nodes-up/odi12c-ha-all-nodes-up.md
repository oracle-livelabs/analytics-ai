# Run ODI mapping when both nodes are up

## Introduction
This lab will show you steps to access an ODI instance, execute an ODI job and observe the high availability functionality of ODI.

*Estimated Time*: 20 minutes

### Objectives
In this lab, you will learn
* Verify the Flatfile Data in Node1 and Node2
* Access the Target Table and Truncate the Data in it
* Access ODI Instance through No VNC
* Test the connection to Source and Target Datasource
* Run ODI Mapping in HA setup

### Prerequisites
This lab assumes you have completed all the previous labs.


## Task 1: Verify the Flatfile Data in Node1 and Node2

1. Access the Node1 instance using the NoVNC URL and if SQL Developer and ODI Studio windows are open, minimize them.

2. Double-click on the terminal icon.

  ![Open terminal in Node1](./images/terminal-1.png " ")

3. Run the below commands on the terminal screen.

      ```
        <copy>
        cd /u03/Sample_Files/CSV
        cat user_info.csv
        </copy>
      ```

4. Repeat steps 1 to 3 in Node2.

5. You will notice that the data in Node1 is different from Node2. We will use this data to understand how an ODI agent will extract the data from a file and load it into the target database.
    
   - Node1
  ![Data in user_info.csv file in Node1](./images/terminal-node1.png " ")

  - Node2
  ![Data in user_info.csv file in Node2](./images/terminal-node2.png " ")

**Note:** In the actual High Availability setup, a shared file storage - which is accessible to Node1 and Node 2 - is used as a file datasource.


## Task 2: Access the Target Table and Truncate the Data in it
1. Open the "SQL Developer" window on the desktop in any of the nodes, right-click on "target DB" and click on connect. A connection to the target DB is already created in the SQL developer. You can test the connections to the target database. The database credentials are given below.
   
    ```
      <copy>
      username: target
      password: Welcome1#
      </copy>
    ```   

    ![Connect to target DB in SQL Developer](./images/sql-developer-1.png " ")

2. Query Builder window will be displayed on the screen. Run the below commands in the query builder window.

    ```
      <copy>
      truncate table target.user_login;
      select * from target.user_login;
      </copy>
    ```  

3. As we truncate the data in the target table "user_login", we will see that the select query will return zero rows.

  ![SQL Developer query window](./images/sql-developer-2.png " ")

In further modules, we will load the data in this table using the ODI job.


## Task 3: Access ODI Instance through No VNC.
1. Once you access the Node 1 instance through NoVNC URL, ODI studio is also launched with it. If ODI Studio is not launched, use the below command to launch ODI studio.

    ```
      <copy>
      /home/oracle/scripts/odi_studio_startup.sh
      </copy>
    ```  

2. Open the ODI Studio and click on "Connect to Repository".

  ![ODI Studio home page](./images/odi-studio-1.png " ")

  ![Connect to Repository option in ODI](./images/odi-studio-2a.png " ")

3. Click "OK" when the default login username and password appear on the screen.

  ![ODI Login window](./images/odi-studio-3.png " ")

Now, you have logged into the ODI Studio.


## Task 4: Test the connection to Source and Target Datasource

1. Drill down the Technologies option in the Topology tab.

  ![Topology tab in ODI](./images/odi-topology-1.png " ")

2. Drill down on "File" and double-click on the "File_Generic" data server. 

  ![File Connection](./images/odi-topology-2.png " ") 

3. File Generic connection details will be displayed on the screen. A connection is already created to the **user\_info.csv** file in the path "/u03/Sample_Files/CSV". Click on "Test Connection" to verify the connectivity.

  ![Test connection in File](./images/odi-topology-3.png " ")

4. Change the physical agent to **OracleDIAgent** and click on "Test".

  ![Test Connection using OracleDIAgent](./images/odi-topology-4.png " ")

5. Successful connection dialogue box will be displayed on the screen. Click "OK" and close the **File_Generic** connection window.

  ![Connection Information](./images/odi-topology-5.png " ")

6. Now, drill down the target datasource "Oracle" and verify its connection.
   
  ![Oracle database connection](./images/odi-topology-6.png " ")

7. Double-click on **target** and click on "Test Connection".

  ![Test the target database connection](./images/odi-topology-7.png " ")

8. Change the physical agent to **OracleDIAgent** and click on "Test".

  ![Test connection using OracleDIAgent](./images/odi-topology-4.png " ")

9. Successful connection dialogue box will be displayed on the screen. Click "OK" and close the target connection window.


## Task 5: Run ODI Mapping in HA setup

1. Click on the Designer tab in ODI studio and drill down on "HA_Demo".

  ![Designer tab in ODI](./images/odi-designer-1.png " ")

2. Drill Down on the "Demo" folder, "Mappings" and double-click on "Load File to DB".

  ![Load File to DB mapping in HA_Demo project](./images/odi-designer-2.png " ")

   "Load File to DB" is a simple one-to-one mapping which extracts the data from a flat file and loads the data into the target database. The target table "User_Login" has one additional column called **load\_date** which loads the system date to the table.

  ![Load file to DB mapping](./images/odi-designer-3.png " ")

3. Click on the "Run" icon to execute the mapping.

  ![Run icon in ODI](./images/odi-designer-run.png " ")

4. Run box will appear on the screen. Change the Logical Agent to "OracleDIAgent" and click "OK".

  ![Run box](./images/odi-run-box.png " ")

5. Session started message will appear on the screen. Click "OK".

  ![Session started message](./images/odi-session-start.png " ")

6. Go to the operator tab and check the status of the job.

  ![Operator tab in ODI](./images/odi-operator-1.png " ")

  A green tick mark indicates that the job is successful.

7. Verify the data in the target table by running the below SQL query.

    ```
      <copy>
      select * from target.user_login;
      </copy>
    ```
    ![SQL Developer query window](./images/sql-developer-3.png " ")

  The hostname in above screenshot is "odiha-2". This indicates that the above job is executed by the Node2 ODI agent. The output may be different in your lab as the load balancer routes the traffic to the ODI hosts randomly.


You may now proceed to the next lab.


## Learn More
- [Oracle Data Integrator](https://docs.oracle.com/en/middleware/fusion-middleware/data-integrator/index.html)

## Acknowledgements

- **Author** - Srivishnu Gullapalli, Senior Solution Engineer, NA Technology, September 2022
- **Contributors** - Amit Kotarkar, Senior Solution Engineer, NA Technology, September 2022
- **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, September 2022





