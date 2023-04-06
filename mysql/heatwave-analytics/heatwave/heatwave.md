# Run Queries Leveraging HeatWave

## Introduction

MySQL HeatWave is 6.5X faster than Amazon Redshift at half the cost, 7X faster than Snowflake at one-fifth the cost, and 1400X faster than Amazon Aurora at half the cost. So in this lab we will run queries with HeatWave enabled and without and finally observe the results.

Estimated Time: 20 minutes

### Objectives

In this lab, you will:
- Import data into MySQL Database Service and Load tables to HeatWave
- Execute queries leveraging HeatWave and compare the query execution time with and without HeatWave enabled

### Prerequisites

- All previous labs have been successfully completed.

[Lab 3 Demo](youtube:jUxF5wZfrnc)

## Task 1: Import data into MySQL Database Service and Load tables to HeatWave

1. Back to the ssh connection at the cloud shell, if it is disconnected, type the following command to connect again to the instance using the public IP address of the compute instance.


    ```
    <copy>ssh -i <private-key-file-name>.key opc@<compute_instance_public_ip></copy>
    ```

  	![ssh connect](./images/connect-ip-instance.png)

  	Unpack the airport database sample downloaded in Lab1-Task3.7

    ```
    <copy>unzip airport-db.zip</copy>
    ```

  	![unpack database sample](./images/unpack-database-sample.png)

  	After it is done extracting the files, verify the extracted material executing the following command:
    ```
    <copy>ls /home/opc/airport-db</copy>
    ```

  	Among the output, you should see the following file names:

  	![database files](./images/see-database-files.png)

  	Using MySQL DB private IP address and fill in the password you used creating the DB system at Lab1/Task5.4, Connect to MySQL DB System with MySQL Shell with the following command:
    
	  ```
    <copy>mysqlsh --user=admin --password=**PASSWORD** --host=<mysql_private_ip_address> --port=3306 --js</copy>
    ```
  	![connect to mysql shell](./images/connect-mysql.png)

	  > **Note:**  For the best practice it is recommended to remove the password from the command line as follows:
	
    ```
	  <copy>export PASSWORD=**PASSWORD**</copy>
    ```

    ```
	  <copy>mysqlsh --user=admin --password=`echo $PASSWORD` --host=<mysql_private_ip_address> --port=3306 --database=airportdb --sql</copy>
	  ```
2. From the MySQL Shell connection, import the data set into MySQL DB System.
  
  	This command will commit a dry run of the import.

    ```
    <copy>util.loadDump("/home/opc/airport-db", {dryRun: true, resetProgress:true, ignoreVersion:true})</copy>
    ```
  	![import db into mysql db system dry run](./images/import-db-into-mysql.png)

   	If it terminates without errors, execute the following to load the dump for real:
    ```
    <copy> util.loadDump("/home/opc/airport-db", {dryRun: false, threads: 8, resetProgress:true, ignoreVersion:true})</copy>
    ```

  	![import db into mysql](./images/import-db-into-mysql-2.png)

  	> **Note:** It takes around 3 minutes to finish.

  	![MySQL shell connect](./images/mysql-connected.png)

3. Check the imported data. From MySQL Shell execute the commands:

    ```
    <copy> \sql  </copy>
    ```
    ```
    <copy> SHOW DATABASES; </copy> 
    ```  

	
  You should see the following output:

  ![MySQL Database](./images/show-mysql-db.png)

	Continue with commands:
    ```
    <copy>
    USE airportdb;
    </copy>
    ```

    ```
    <copy>
    SHOW TABLES;
    </copy>
    ```
  	You should see the following output:

  	![Airport db tables](./images/view-airport-db-tables.png)

4. Let's start testing a simple query but yet effective query, to find per-company average age of passengers from Germany, Spain and Greece.
  
  	From the previous SQL prompt, run the following query and check the execution time (approximately 12-13s):
    ```
    <copy>
    SELECT
    airline.airlinename,
    AVG(datediff(departure,birthdate)/365.25) as avg_age,
    count(*) as nb_people
    FROM
    booking, flight, airline, passengerdetails
    WHERE
    booking.flight_id=flight.flight_id AND
    airline.airline_id=flight.airline_id AND
    booking.passenger_id=passengerdetails.passenger_id AND
    country IN ("GERMANY", "SPAIN", "GREECE")
    GROUP BY
    airline.airlinename
    ORDER BY
    airline.airlinename, avg_age
    LIMIT 10;
    </copy>
    ```
  	![Query run for airportdb](./images/query-airport-db.png)

  	Exit from MySQL Shell:
    
    ```
    <copy>
    \exit
    </copy>
    ```
  	![exit sql db](./images/exit-mysql-db.png)

## Task 2: Execute queries leveraging HeatWave

1. On the OCI console, go to **DATABASES** >> **DB Systems** and select the instance we created earlier _**mysql-analytics-test**_.
  ![OCI Console](./images/open-db-systems.png)
  ![OCI Console](./images/select-mysql-instance.png)


	Check under the _**HeatWave**_ section, that HeatWave nodes are in _**Active**_ status,
  	![OCI Console](./images/check-heatwave-active.png)


  	If HeatWave nodes are in _**Active**_ status, you can run the following Auto Parallel Load command to load the airportdb tables into HeatWave, from your bastion host ssh connection, using the following command:

    Note: replace the `**PASSWORD**` with the password you have used creating MySQL DB System at Lab1/Task5.4.

    ```
    <copy>
    mysqlsh --user=admin --password=**PASSWORD** --host=<mysql_private_ip_address> --port=3306 --sql
    </copy>
    ```

  	![connect to mysql shell](./images/connect-mysql-shell2.png)

    ```
    <copy>CALL sys.heatwave_load(JSON_ARRAY('airportdb'), NULL);</copy>
    ```
  	![load db into Heatwave](./images/load-db.png)

  	Let's verify that the tables are loaded in the HeatWave cluster, and the loaded tables have an `AVAIL_RPDGSTABSTATE` load status.
    ```
    <copy>USE performance_schema;</copy>
    ```
    ```
    <copy>SELECT NAME, LOAD_STATUS FROM rpd_tables,rpd_table_id WHERE rpd_tables.ID = rpd_table_id.ID;</copy>
    ```
  	![Performance schema tables](./images/view-performance-schema-tables.png)

2. Let's come back to the previous query and execute it this time using HeatWave.

  	Change to the airport database. Enter the following command at the prompt:
    ```
    <copy>
    USE airportdb;
    </copy>
    ```
  	![connect to airportdb](./images/connect-airport-db2.png)

  	Now let's enable _**HeatWave**_  and let the Magic begin:
    ```
    <copy>
    set @@use_secondary_engine=ON;
    </copy>
    ```
  	![enable secondary engine](./images/enable-secondary-engine.png)

  	To verify if `use_secondary_engine` is enabled (ON), enter the following command at the prompt: 
    ```
    <copy>SHOW VARIABLES LIKE 'use_secondary_engine%';</copy>
    ```
  	![verification engine enabled](./images/verification-enabled.png)

3. Check the explain plan of the previous query and confirm it will be using secondary engine:
    ```
    <copy>
    EXPLAIN SELECT
    airline.airlinename,
    AVG(datediff(departure,birthdate)/365.25) as avg_age,
    count(*) as nb_people
    FROM
    booking, flight, airline, passengerdetails
    WHERE
    booking.flight_id=flight.flight_id AND
    airline.airline_id=flight.airline_id AND
    booking.passenger_id=passengerdetails.passenger_id AND
    country IN ("GERMANY", "SPAIN", "GREECE")
    GROUP BY
    airline.airlinename
    ORDER BY
    airline.airlinename, avg_age
    LIMIT 10;
    </copy>
    ```
  	You should see a message "Using secondary engine RAPID" in the **Extra** output

  	![run query explain](./images/run-query-explain.png)

  	Re-run the previous query and check the execution time again:
    ```
    <copy>
    SELECT
    airline.airlinename,
    AVG(datediff(departure,birthdate)/365.25) as avg_age,
    count(*) as nb_people
    FROM
    booking, flight, airline, passengerdetails
    WHERE
    booking.flight_id=flight.flight_id AND
    airline.airline_id=flight.airline_id AND
    booking.passenger_id=passengerdetails.passenger_id AND
    country IN ("GERMANY", "SPAIN", "GREECE")
    GROUP BY
    airline.airlinename
    ORDER BY
    airline.airlinename, avg_age
    LIMIT 10;
    </copy>
    ```

  	This second execution with HeatWave should be about 1.5-1s, try again the query!

  	![run heatwave query](./images/run-heatwave-query.png)

  	Exit MySQL Shell

    ```
    <copy>
    \exit
    </copy>
    ```

  	As we observe the execution time obtained using HeatWave and without, such as the first query using HeatWave it took approximately 1 sec in comparison with 12 sec that the query took to process which is relatively much longer than when a HeatWave cluster is enabled. 

  	Well done, you can now proceed to the next lab!

## Acknowledgements
  - **Author** - Rawan Aboukoura - Technology Product Strategy Manager, Vittorio Cioe - MySQL Solution Engineer
  - **Contributors** - Priscila Iruela - Technology Product Strategy Director, Victor Martin - Technology Product Strategy Manager 
  - **Last Updated By/Date** - Anoosha Pilli, September 2021
