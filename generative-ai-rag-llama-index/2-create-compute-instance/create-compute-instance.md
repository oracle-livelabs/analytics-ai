# Lab 2: Set up the Compute Instance and Connect to GitHub Code

### Objective 
This lab you will be creating a virtual machine that will install python 3.11, clone the GitHub Repo, and open necessary port. 

### Prerequisites
* Labs 1 of this Livelab completed.

Estimated Time: 30 minutes

## Task 1: Set up the VM Machine

1. Open the main "hamburger" menu in the top left corner of the Console. Select "Compute" and then click "Instances." <br>
 &nbsp;&nbsp;&nbsp;&nbsp;<img src="images/hamburger-menu-compute.png" width="500" height="320"><br>

2. Select the correct compartment from the "List Scope"→"Compartment" on the left side of the page, and then click the "Create Instance" button. <br>
&nbsp;&nbsp;&nbsp;<img src="images/Compute-instance-create-instance-button.png" width="750" height="320"><br>

3. Fill in the following information 
    Name: LiveLab
    Shape: VM.Standard.A1.FLEX
    Image: Oracle Linux 
    Click on 'Edit' on Primary VNIC Information
    Click 'Create New Virtual Cloud Network' 
    Download SSH Private Key and Save Public Key 
    Click 'Create' <br>

&nbsp;&nbsp;&nbsp;<img src="images/On-Creation-VM.png" width="450" height="320"><br>

&nbsp;&nbsp;&nbsp;<img src="images/Download-Private-Public-Key.png" width="450" height="320"><br>

## Task 2: Install Python and Clone the Repo
1. Go to Cloud Shell <br>

2. Log into your instance 
    ssh i ~/[private-key] <username>@<public_ip_address> <br>

&nbsp;&nbsp;&nbsp;<img src="images/Open-Cloud-Shell.png" width="1000" height="320"><br>



3.install python 3.11 <br>
    sudo yum update <br>
    sudo yum upgrade <br>
    sudo yum install python3.11-devel <br>
    python3.11 --version <br>

&nbsp;&nbsp;&nbsp;<img src="images/Clone-Repo.png" width="1000" height="320"><br>

4. Install requirement.text
   pip install -r requirement.txt <br>


## Task 3: Open Port on VCN

1. On your network open port 8501
   Go your VCN <br>
   Go to Default Security Lists <br>
   Add ingress rules <br>
    CIDR: 0.0.0.0/0 <br> 
    IP protocol: TCP <br>
    Destination Port Range: 8501 <br<

   &nbsp;&nbsp;&nbsp;<img src="images/VCN-Port-Opening.png" width="750" height="320"><br>

## **Acknowledgements**

* **Authors** - Shay Hameed

You may now **proceed to the next lab**

