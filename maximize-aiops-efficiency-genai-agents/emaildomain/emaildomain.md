# Email Domain Creation and Configuration

## Introduction

This lab is optional, if you don't need email notifications then you can skip this Lab.
In this lab will show the setup of your domain in the Oracle Email Delivery Service. In order to complete this lab, you will need a domain that you mange and control. You will need to make DNS changes so it's important that you own and control this domain.

Estimated Time: 15 minutes

### About OCI Email Delivery

The Oracle Cloud Infrastructure Email Delivery service provides a fast and reliable managed solution for sending secured, high-volume marketing and transactional emails.

### Objectives

In this lab, you will:

* Create a Domain within Email Delivery
* Create a DKIM Record
* Create a DNS Zone for your Domain
* Create CNAME Record

### Prerequisites

This lab assumes you have:

* Oracle Cloud account
* Domain you control and have access to DNS Management

## Task 1: Create a Domain in the Email Delivery Service

1. Click the **Navigation menu** in the upper left, navigate to **Developer Services** then select **Application Integration - Email Delivery**.
    ![Navigate to Email Delivery](images/picture1.png)

2. This will take you to  the Email Deliverability and Reputation Governance Dashboard were you may monitor your usage.

    Click on **Email Domains**.
    ![Enter Email Domain Information](images/picture2.png)

3. Within Email Domain, verify you are in the correct compartment and specify an **Email Domain Name**. Click the **Create Email Domain** button.
    ![Specify Name and Domain for Email Domain](images/picture3.png)

4. After a brief time, your domain will become *active* and you may move onto the next task.

## Task 2: Create DKIM for your Email Domain

1. DKIM (Domain Keys Identified Mail) is used to verify an email is sent and authorized by the owner of the sender's domain. While in your newly setup email domain, click on the **Add DKIM** button.
    ![Create DKIM Selector](images/picture4.png)

    The DKIM Selector is made up of a prefix, the OCI short region code and the date in this format **prefix - shortregioncode - yyyymm**.

1. Use your domain information, region and date in a similar fashion and enter in the **DKIM Selector** field. Click the **Generate DKIM Record** button.
    ![Generate DKIM Record](images/picture5.png)

2. *Copy* the newly created CNAME Record and CNAME Value for DNS. Click the **Create DKIM** button when complete.
![Copy DKIM Record](images/picture9.png)

## Task 3: Create DNS Zone and Add DKIM Record

1. Click the **Navigation menu** in the upper left, navigate to **Networking** then select **DNS Management - Zones**.
    ![Navigate to DNS Management Zones](images/picture10.png)

2. Next click the **Create Zone** button under Public Zones.
    ![Create Zones Button](images/picture11.png)

3. Verify you are in the correct compartment and enter your domain name in the zone name field. Click the **Create** button.
    ![Create Public Zone](images/picture12.png)

4. Open your newly created zone and click on **Records**.
    ![Open DNS Records](images/picture13.png)

5. Click on the **Manage Records** button.
    ![Manage Records Button](images/picture14.png)

6. Click on the **Add Record** button
    ![Add Record Button](images/picture15.png)

7. Retrieve the DKIM Record information you saved earlier.

    Update the
    * Name using the domainkey information from the DKIM Record. (Please note the OCI Console appends the domain.)
    * Change the **Type** to **CNAME**.
    * Update the RDATA/Answer Target with the CNAME information from the DKIM Record created earlier.

    When complete click the **Add Record** Button.
    ![Add CNAME to DNS Record](images/picture16.png)

1. While on the Manage Records screen for DNS Management, click on the **Review Changes** button.
    ![Publish DNS Changes](images/picture17.png)

2. Next, click on the **Publish changes** button to publish your DNS Records.
    ![Confirm Publish DNS Changes](images/picture18.png)

3. It may take some time for your DNS changes to take effect depending on your DNS provider. This may take as long as 24-72 hours. Please proceed to the next lab when ready.

## Learn More

* [Email Delivery Overview](https://docs.oracle.com/en-us/iaas/Content/Email/Concepts/overview.htm)
* [Configuring DKIM](https://docs.oracle.com/en-us/iaas/Content/Email/Tasks/configure-dkim-using-the-console.htm)
* [Managing DKIM](https://docs.oracle.com/en-us/iaas/Content/Email/Tasks/configuredkim.htm)
* [Setting up an Email Domain with DKIM](https://docs.oracle.com/en-us/iaas/Content/Email/Tasks/managing_dkim-setup_email_domain_with_dkim.htm)
* [DNS Management Overview](https://docs.oracle.com/en-us/iaas/Content/DNS/Tasks/consoleoverview.htm)

## Acknowledgements

* **Author**
    **Nikhil Verma**, Principal Cloud Architect, NACIE
* **Last Updated By/Date**
    **Nikhil Verma**, Principal Cloud Architect, NACIE, May 2026
