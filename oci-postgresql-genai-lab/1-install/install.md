# Install the Components

## Introduction
In this lab, you will install all the components needed for this workshop. Some of these will be provisioned manually and many will be provisioned automatically using a provided Terraform script.

Estimated time: 40 min

### Objectives

- Provision all the cloud components

### Prerequisites

- An OCI Account with sufficient credits where you will perform the lab. (Some of the services used in this lab are not part of the *Always Free* program.)
- Choose which web browser to use before you start. There is an option in a later lab to download a github repo to your local computer using the OCI Console Cloud Shell. Some users have experienced a bug attempting to do this with the Firefox Browser Extended Support Release (ESR). The Chrome browser is an alternative in this case.
- Check that your tenancy has access to the **Chicago or Frankfurt Region**
    - For Paid Tenancy
        - Click on region on top of the screen
        - Check that the Chicago (or Frankfurt) Region is there (Green rectangle)
        - If not, Click on Manage Regions to add it to your regions list. You need Tenancy Admin right for this.
        - Click on the US MidWest (Chicago)
        - Click Subscribe

    ![Chicago Region](images/chicago-region.png)

    - For Free Trial, the home region should be Chicago (or Frankfurt)
- The OCI User used in this LiveLab should have OCI Administrator Priviliges in the OCI Tenancy


## Task 1: Create a Compartment

The compartment will be used to contain all the components of the lab.

You can
- Use an existing compartment to run the lab 
- Or create a new one (recommended)

1. Login to your OCI account/tenancy

2. Go the 3-bar/hamburger menu of the console and select
    1. Identity & Security
    1. Compartments
    ![Menu Compartment](images/compartment1.png =40%x*)
    
2. Click ***Create Compartment***
    - Give a name: ***oci-starter***
    - Then again: ***Create Compartment***
    ![Create Compartment](images/compartment2.png)

## Task 2: Create OCI API Key

The API key will be used to access OCI command line tool and OCI Generative AI service programatically 

1. Go to OCI Console Homepage

2. Click User icon on the top right and *User Settings*

    ![Create API key](images/create-api-keys-1.png)
    
3. Go to *Tokens & Keys*, then *Add API Key*
    ![Create API key](images/create-api-keys-2.png)
    
4. Generate API Key pair and Download the Private an Public Key. 
    ![Create API key](images/create-api-keys-3.png)
    
***We will use the public key later in provisioning the stack and private key to connect to the VM***



## Task 3: Run Terraform script to provision the stack

1. Download the Github code to your Local machine

    ````
   git clone https://github.com/shadabshaukat/oracle-livelabs.git
     ````

       
3. Go to OCI Console Home Page

4. Click on *Developer Services* and then *Stack*
    ![Resource Manager](images/resource-manager-1.png)

5. Change your compartment to the one created in Task 1 above

6. Select *My Configuration* scroll down to the *Stack Configuration* and add the newly downloaded folder
       ![Resource Manager](images/resource-manager-2.png)
       
   Select the *oci_postgres_tf_stack* folder from your local machine
       ![Resource Manager](images/resource-manager-3.png)
       
7. Select the compartment and click **Next**
       ![Resource Manager](images/resource-manager-4.png)

8. Select **compute_assign_public_ip**
          ![Resource Manager](images/resource-manager-5.png)

9. Paste the Public SSH key created in Task 2 and check **create compute** | **create_psql_configurtion** box
    ![Resource Manager](images/resource-manager-5-a.png)

10. pgvector extension and user variables added
     ![Resource Manager](images/resource-manager-5-c.png)

11. Enter Postgres Admin user and password
              ![Resource Manager](images/resource-manager-6.png)

12. Enter a region and click next
              ![Resource Manager](images/resource-manager-7.png)

13. Select *Run apply* and create the stack
              ![Resource Manager](images/resource-manager-8.png)

14. Wait about 10-15 minutes for the stack to finish provisioning
              ![Resource Manager](images/resource-manager-9.png)
              

Copy the last 10 lines of the job log and save it in a notepad, it will be like something below

````
Outputs:
compute_instance_id = "ocid1.instance.oc1.iad.anuw......................oq"
compute_private_ip = "10.10.2.212"
compute_public_ip = "150.x.x.174"
compute_state = "RUNNING"
psql_admin_pwd = <sensitive> 
````


14. Go to OCI Console *Compute* and then *Instances*
              ![Resource Manager](images/get-public-ip-1.png)

Copy the public IP of the instance 
              ![Resource Manager](images/get-public-ip-2.png)


## Task 4: SSH into the VM -- Setup App

1. Go to your Terminal and Copy the public IP from Task 3 step 14 and use the Private Key from Task 2.

      ![SSH Host](images/ssh-to-host-1.png)

2. Install Linux Packages
   
````
sudo dnf install -y curl git unzip firewalld
````

3. Add firewall rules
   
````
# uv installer and PATH
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"

# Firewalld rules for the app port (default 8000)
sudo systemctl enable --now firewalld
sudo firewall-cmd --permanent --add-port=8000/tcp
sudo firewall-cmd --reload
````

4. Download the Code Repository

````
   git clone https://github.com/shadabshaukat/oracle-livelabs.git
 ````

5. Configure the variables to reflect the provisioned stack and API keys

**You may now proceed to the [next lab](#next)**

## Known issues

## Acknowledgements

- **Author**
    - Shadab Mohammad, Master Principal Cloud Architect

