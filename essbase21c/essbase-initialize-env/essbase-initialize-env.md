# Initialize Environment

## Introduction

This lab provides detailed instructions of connecting to Essbase 21c using Web UI. This compute instance comes with Essbase installed and configured with Oracle database, both managed using Unix/Linux *systemd* services to automatically start and shutdown as required.

*Estimated Lab Time:* 10 Minutes.

### Objectives
- Initialize the workshop environment.

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- Local Computer (Windows/Mac) with Microsoft Excel
- You have completed:
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup

## Task 1: Validate That Required Processes are Up and Running.
1. Now with access to your remote desktop session, proceed as indicated below to validate your environment before you start executing the subsequent labs. The following Processes should be up and running:

    - Database Listener
        - LISTENER
    - Database Server instance
        - ORCL
    - Essbase Server

2. On the *Web Browser* window on the right preloaded with *Essbase Console*, click on the *Username* field and select the saved credentials to login. These credentials have been saved within *Web Browser* and are provided below for reference

    - Username

    ```
    <copy>Weblogic</copy>
    ```

    - Password

    ```
    <copy>Oracle_4U</copy>
    ```

    ![](images/essbase-login.png " ")

3. Confirm successful login. Please note that it takes about 5 minutes after instance provisioning for all processes to fully start.

    ![](images/essbase-landing.png " ")

    If successful, the page above is displayed and as a result your environment is now ready.  

4. If you are still unable to login or the login page is not functioning after reloading the application URL, open a terminal session and proceed as indicated below to validate the services.

    - Database and Listener
    ```
    <copy>
    sudo systemctl status oracle-database
    </copy>
    ```

    ![](images/db-service-status-1.png " ")
    ![](images/db-service-status-2.png " ")

    - WLS Admin Server and Essbase Server
    ```
    <copy>
    sudo systemctl status essbase
    </copy>
    ```

    ![](images/essbase-service-status.png " ")

5. If you see questionable output(s), failure or down component(s), restart the corresponding service(s) accordingly

    - Database and Listener

    ```
    <copy>
    sudo sudo systemctl restart oracle-database
    </copy>
    ```

    - WLS Admin Server and Essbase Server

    ```
    <copy>
    sudo sudo systemctl restart essbase
    </copy>
    ```

## Task 2: Download and Stage Workshop Artifacts (on local PC/Mac)
Due to the requirements for *Microsoft Excel*, some tasks cannot be performed on the remote desktop. As a result, return to your local computer/workstation and perform the following:

1. Download [`essbase_21c_labfiles.zip`](https://objectstorage.us-ashburn-1.oraclecloud.com/p/51DwosGpWuwiHMYKbcgWcxsHkBaYipTRlGh-bcMSTVaCfVBwDwYoRfA4VpPSh7LR/n/natdsecurity/b/labs-files/o/essbase_21c_labfiles.zip) and save to a staging area on your laptop or workstation.

2. Uncompress the ZIP archive.

You may now [proceed to the next Lab](#next)

## Appendix 1: Managing Startup Services

1. Database Service (Database and Listener).

    - Start

    ```
    <copy>sudo systemctl start oracle-database</copy>
    ```

    - Stop

    ```
    <copy>sudo systemctl stop oracle-database</copy>
    ```

    - Status

    ```
    <copy>sudo systemctl status oracle-database</copy>
    ```

    - Restart

    ```
    <copy>sudo systemctl restart oracle-database</copy>
    ```

2. Essbase Service (WLS Admin Server and Essbase Server)

    - Start

    ```
    <copy>sudo systemctl start essbase</copy>
    ```

    - Stop

    ```
    <copy>sudo systemctl stop essbase</copy>
    ```

    - Status

    ```
    <copy>sudo systemctl status essbase</copy>
    ```

    - Restart

    ```
    <copy>sudo systemctl restart essbase</copy>
    ```

## Acknowledgements

- **Authors** - Sudip Bandyopadhyay, Manager, Analytics Platform Specialist Team, NA Technology
- **Contributors** - Kowshik Nittala, Eshna Sachar, Jyotsana Rawat, Venkata Anumayam, Rene Fontcha
* **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, August 2021
