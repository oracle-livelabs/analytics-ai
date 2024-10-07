# Lab 2: Set up the Compute Instance and Connect to GitHub Code

### Objective 
This lab you will be creating a virtual machine that will install python 3.11, clone the GitHub Repo, and open necessary port. 

Estimated Time: 30 minutes

### Prerequisites
* Lab 1 of this Livelab completed.



## Task 1: Set up the VM Machine

1. Open the main "hamburger" menu in the top left corner of the Console. Select "Compute" and then click "Instances." <br>

![Selecting Compute from Hamburger Menu](images/hamburger-menu-compute1.png)

2. Select the correct compartment from the "List Scope"→"Compartment" on the left side of the page, and then click the "Create Instance" button. <br>


![Clicking Create Compute Instance Button](images/compute-instance-create-instance-button1.png)

3. Fill in the following information 
    Name: LiveLab
    Shape: VM.Standard.A1.FLEX
    Image: Oracle Linux 
    Click on 'Edit' on Primary VNIC Information
    Click 'Create New Virtual Cloud Network' 
    Download SSH Private Key and Save Public Key 
    Click 'Create' <br>


![Creation Page of the VM](images/on-creation-vm1.png)

![Downloading the Private/Public Keys](images/download-private-public-key1.png)


## Task 2: Install Python and Clone the Repo
1. Go to Cloud Shell <br>

2. Log into your instance 
    ssh i ~/[private-key] <username>@<public_ip_address> <br>


![Opening Cloud Shell](images/open-cloud-shell1.png)


3.install python 3.11 <br>
    sudo yum update <br>
    sudo yum upgrade <br>
    sudo yum install python3.11-devel <br>
    python3.11 --version <br>


![Clone Repo](images/clone-repo1.png)

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

  
   ![Open Port 8501](images/vcn-port-opening1.png)

## **Acknowledgements**

* **Authors** - Shay Hameed

You may now **proceed to the next lab**

