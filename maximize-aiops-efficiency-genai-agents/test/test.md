# Test and Validate the AIOps Agent

## Introduction

In this Lab, we will test our AIOPS Agent that we deployed in Lab 6.

Estimated Time: 10 minutes

### Prerequisites

This lab assumes you have:

* All previous labs successfully completed

## Task 1: Initialize Slack App

1. You have to initialize Slack App, this allows communication between Slack, Local Client functions and Remote Generative AI Agent.
![Image1](./images/image1.png "Image 1")

2. Create Slack Channel and Add AIOPS app in this channel.

## Task 2: Test the AIOPS Agent

1. Query1 : **Hi**
![Image2](./images/image2.png "Image 2")

2. Query2: **can you tell me list of steps you will take to remediate OCI instances with CPU_ALARM ?**
![Image3](./images/image3.png "Image 3")

3. Query3: **Please remediate if any instance in CPU_ALARM state and notify <n.nikhilverma89@gmail.com>.**
![Image4](./images/image4.png "Image 4")
Identified test02 instance in **CPU_ALARM** state.
![Image5](./images/image5.png "Image 5")
Get all instance details like **instance_id** and **availability domain**
![Image6](./images/image6.png "Image 6")
Backup and reboot initiated
![Image7](./images/image7.png "Image 7")
Email Notification triggered
![Image8](./images/image8.png "Image 8")

4. Query4: **Can you check if there is any instance still have CPU_ALARM ?**
Identified no instance in CPU_ALARM state.
![Image9](./images/image9.png "Image 9")

## Task 2: Validate OCI Instance

Let's validate OCI Instance for all steps execution.
Full Backup completed by Agent.
![Image10](./images/image10.png "Image 10")
Checked CPU metric and CPU utilization dropped to 10%.
![Image11](./images/image11.png "Image 11")
Email Notification received
![Image12](./images/image12.png "Image 12")
Alarm status showing no alarms
![Image13](./images/image11.png "Image 13")

In this way you can integrate OCI Generative AI Agents with your Runbooks and maximize efficienct in IT operations.

## Acknowledgements

* **Author**
    **Nikhil Verma**, Principal Cloud Architect, NACIE
