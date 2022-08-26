# Prepare Setup

## Introduction
This lab will show you how to download the Oracle Resource Manager (ORM) stack zip file needed to setup the resource needed to run this workshop. This workshop requires the following resources:
<if type="advanced">
- 1 x Compute instance
- 1 x Virtual Cloud Network (VCN).
</if>
<if type="basics">
- 1 x Compute instance
- 1 x Virtual Cloud Network (VCN).
</if>
<if type="ha">
- 2 x Compute instances
- Virtual Cloud Network (VCN)
- Load Balancer
</if>


*Estimated Lab Time:* 15 minutes

### Objectives
- Download ORM stack
- Configure an existing Virtual Cloud Network (VCN)

### Prerequisites
This lab assumes you have:
- An Oracle Free Tier or Paid Cloud account

## Task 1: Download Oracle Resource Manager (ORM) stack zip file
1.  Click on the link below to download the Resource Manager zip file you need to build your environment:
<if type="advanced">
    - [odi-mkplc-advanced.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/_EIwsXv5v6KkKcQldUQixExqAgJCbY826XovJec4I25rc4dHEZW4whrF-nb2QUye/n/natdsecurity/b/stack/o/odi-mkplc-advanced.zip)
</if>
<if type="basics">
    - [odi-mkplc-basics.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/m4wcgeN1hw9D1zV3pgOkbRjwanAt5dIW7QsZS7znZNnHU63vh495UHhkiRtaDJHE/n/natdsecurity/b/stack/o/odi-mkplc-basics.zip)
</if>
<if type="ha">
    - [odi-mkplc-ha.zip](https://objectstorage.us-ashburn-1.oraclecloud.com/p/Egai3bjUiIJF-xVL1Zr6s1ZfC_S2mN70rAWSmz5iU6INHuM9XJkeqcP-jGLPdtVB/n/natdsecurity/b/stack/o/odi-mkplc-ha.zip)
</if>


2.  Save in your downloads folder.

We strongly recommend using this stack to create a self-contained/dedicated VCN with your instance(s). Skip to *Task 3* to follow our recommendations. If you would rather use an exiting VCN then proceed to the next task to update your existing VCN with the required Ingress rules.

## Task 2: Adding security rules to an existing VCN

This workshop requires a certain number of ports to be available, a requirement that can be met by using the default ORM stack execution that creates a dedicated VCN. In order to use an existing VCN/subnet, the following rules should be added to the security list.

| Type           | Source Port    | Source CIDR | Destination Port | Protocol | Description                           |
| :-----------   |   :--------:   |  :--------: |    :----------:  | :----:   | :------------------------------------ |
| Ingress        | All            | 0.0.0.0/0   | 22               | TCP      | SSH                                   |
| Ingress        | All            | 0.0.0.0/0   | 80               | TCP      | Remote Desktop using noVNC            |
| Egress         | All            | N/A         | 80               | TCP      | Outbound HTTP access                  |
| Egress         | All            | N/A         | 443              | TCP      | Outbound HTTPS access                 |
{: title="List of Required Network Security Rules"}

<!-- **Notes**: This next table is for reference and should be adapted for the workshop. If optional rules are needed as shown in the example below, then uncomment it and add those optional rules. The first entry is just for illustration and may not fit your workshop -->

<!--
| Type           | Source Port    | Source CIDR | Destination Port | Protocol | Description                           |
| :-----------   |   :--------:   |  :--------: |    :----------:  | :----:   | :------------------------------------ |
| Ingress        | All            | 0.0.0.0/0   | 443               | TCP     | e.g. Remote access for web app        |
{: title="List of Optional Network Security Rules"}
-->

1.  Go to *Networking >> Virtual Cloud Networks*
2.  Choose your network
3.  Under Resources, select Security Lists
4.  Click on Default Security Lists under the Create Security List button
5.  Click Add Ingress Rule button
6.  Enter the following:  
    - Source Type: CIDR
    - Source CIDR: 0.0.0.0/0
    - IP Protocol: TCP
    - Source Port Range: All (Keep Default)
    - Destination Port Range: *Select from above table*
    - Description: *Select corresponding description from above table*
7.  Click the Add Ingress Rules button
8. Repeat steps [5-7] until a rule is created for each port listed in the table

<if type="ha">
  **Notes**: Using an existing VCN will likely lead to failure, unless certain conditions are met. You must ensure that it's using the CIDR *10.0.0.0/16* and contains the following 3 subnets:

    - subnet-llw-lb (10.0.0.0/29) - Dedicated to the load balancer
    - subnet-llw-1 (10.0.1.0/24)  - For Node1
    - subnet-llw-2 (10.0.2.0/24)  - For Node2

  If these conditions can't be met, we highly recommend that you revert to the default and let ORM stack create a dedicated VCN for your workshops
</if>

## Task 3: Setup Compute   
Using the details from the two Tasks above, proceed to the lab *Environment Setup* to setup your workshop environment using Oracle Resource Manager (ORM) and one of the following options:
-  Create Stack:  *Compute + Networking*
-  Create Stack:  *Compute only* with an existing VCN where security lists have been updated as per *Task 2* above

You may now proceed to the next lab.

## Acknowledgements

* **Author** - Rene Fontcha, Master Principal Solutions Architect, NA Technology
* **Contributors** - Kay Malcolm, Product Manager, Database Product Management
* **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, August 2022
