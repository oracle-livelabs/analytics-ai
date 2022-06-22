# Getting Started with OCI Data Science

## Introduction

This lab will guide you on provisioning an OCI Data Science environment.

Estimated time: 15 minutes

### Objectives

In this lab you will:
* Become familiar with the set up of the OCI Data Science service.

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account (see prerequisites in workshop menu)

## **Task 1**: Provision OCI Data Science

This guide shows how to use the Resource Manager to provision the service using Resource Manager. This process is mostly automated. However, if you prefer a step-by-step manual approach to control every aspect of the provisioning, please follow the following instructions instead: [manual provisioning steps](https://docs.cloud.oracle.com/en-us/iaas/data-science/data-science-tutorial/tutorial/get-started.htm#concept_tpd_33q_zkb).

1. Download the terraform configuration source

    Download [Terraform configuration source](https://objectstorage.eu-frankfurt-1.oraclecloud.com/p/Y1AdqPkxQdFho1SEuMMO7W8DlMWAkr0FUwdnL-m3ysgXirfHz9IV48yyAkRARF-b/n/odca/b/datascienceworkshop/o/oci-ods-orm.zip) and store it on your local PC. Depending on the browser you might have to use Left/Right click to do this. Make sure the extension of the saved file is .zip

2. In your Oracle Cloud console, open the menu.
   ![Open Menu](./images/openmenu.png)

3. Select Resource Manager -> Stacks.

   ![Stack](./images/resourcemanager.png)

4. Click the "Create Stack" button.

   ![Create Stack](./images/createstackbutton.png)

5. Select the configuration source you download earlier

    Select ".ZIP" and drag the file you downloaded to the box.

    ![Select ZIP](./images/select-zip.png)

6. Choose a compartment that you've created or use Root.

   ![Choose Compartment](./images/newimage3.png)

7. Click "Next".

   ![Next](./images/newimage4.png)

8. Disable Project and Notebook creation

    In the section "Project and Notebook Configuration" *uncheck* the checkbox "Create a Project and Notebook Session" (we will create them using the console later).

    ![Disable Projection Creation](./images/disable-ods-creation.png)

9. Make sure "Enable Vault Support" is disabled

   ![Disable Valut](./images/newimage6.png)

10. Make sure "Provision Functions and API Gateway" is disabled

   ![Disable API Gateway](./images/disablefunctions.png)

11. Click "Next".

   ![Next](./images/newimage7.png)

12. Click "Create".

   ![Create](./images/create.png)

13. Run the job

   Go to "Terraform Actions" and choose "Apply".

   ![Apply TF](./images/applytf.png)

14. Click Apply once more to confirm the submission of the job.

   Provisioning should take about 5 minutes after which the status of the Job should become "Succeeded".

15. Create Oracle Data Science Project

   Open the OCI Data Science projects and choose "Create Project".

   ![Open DS](./images/open-ods.png)

   ![Create Project](./images/create-project-1.png)

   Choose a name and description and press "Create".

   ![Choose Name](./images/create-project-2.png)

16. Provision an Oracle Data Science notebook

   ![Provision Notebook](./images/create-notebook-1.png)

   - Select a name.
   - We recommend you choose VM.Standard2.8 (*not* VM.Standard.*E*2.8) as the shape. This is a high performance shape, which will be useful for tasks such as AutoML.
   - Set blockstorage to 50 GByte.
   - Select defaults for VCN and subnet. These should point to the resources that were created earlier by the resource manager.

   ![Create Notebook](./images/create-notebook-2.png)

   Finally click "Create". The process should finish after about 5 minutes and the status of the notebook will change to "Active".

## **Task 2**: Open the OCI Data Science notebook

1. Open the notebook that was provisioned

   The name of the notebook may be different than shown here in the screenshot.

   ![Open Notebook](./images/open-notebook.png)

   ![Click Open](./images/open-notebook2.png)

## **Task 3**: Install a Conda Package

A Conda package is a collection of libraries, programs, components and metadata. It defines a reproducible set of libraries that are used in the data science environment. We are going to use the General Machine Learning for CPUs conda. The following commands will install this Conda.

1. Open a terminal window by clicking on **File**, **New** and then **Terminal**.
2. Run the command: 
   
    ```python
    <copy>
   odsc conda install -s mlcpuv1
   </copy>
   ```

3. You will receive a prompt related to what version number you want. Press `Enter` to select the default.
4. Wait for the conda package to be installed.

   This will take about 5 minutes.

## **Task 4**: Upload the Jupyter Notebook

1. Download the notebook and save it locally on your machine.

   The .ipynb notebook is accessed through a Pre Authenticated Request (PAR) in OCI Object Storage. Inside the data science notebook session, open the terminal.

   Select the + sign in the top left hand corner, and then select Terminal.

   ![Terminal](images/terminal.png)

   Copy the following command into the terminal to download the Jupyter Notebook from OCI Object Storage to the active Data Science notebook session. 
   
   ```python
   <copy>
   wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/GWt3Iw4OFlZtcx1ZkJVfOwc7z2xW_grd6HGSEr7KpR4Pe8Dzxc8n84G_ps6mMqlS/n/orasenatdpltintegration03/b/times_series_lab/o/Online_Retail_Notebook.ipynb
   </copy>
   ```

   ![Run Curl](images/run_curl2.png)

   You should now see the following file in your directory on the left.

   ![Notebook Found](images/notebookfound.png)

   This is the Jupyter notebook that you will use for the remainder of the lab.

2. Upload the Data

   The CSV file that consists of the retail data is also stored in OCI Object Storage.

   Similar to the last step, open the terminal and run the following command to download the CSV file to the Data Science Notebook Session.

   ```python
   <copy>
   wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/MKEi6E7lvuIHAQ-lm9-chjwTrdrHFRPNYdiRw6ljDVV9t2lv1FniDuUfAI5wf7fm/n/orasenatdpltintegration03/b/times_series_lab/o/Online_Retail.csv
   </copy>
   ```

   ![CSV Added](images/added_csv.png)

   You should now see the following file in the directory.

   ![Directory](images/add_csv2.png)

3. Select the installed kernel

   Open the .ipynb file, and select the kernel on the top right side of the page.

   ![Choose Kernel](images/select-kernel.png)

   Select the kernel [conda env:mlcpuv1] from the drop down menu.

   ![Dropdown Kernel Menu](images/select-kernel2.png)

4. Install mlxtend and pvis

   Next you will have to install the package mlxtend on the kernel. Mlxtend (which stands for machine learning extensions) is a Python library that consists of useful data
   science tools. The library has its own Apriori Algorithm built in that we will use for the association rule learning. 

   Pyvis is a Python library for interactive visualizations that we will use to visiualize the association of the different products in the data set.

   Run the first cell that contains the command 'pip install mlxtend' and 'pip install pyvis' by putting the cursor into the cell and selecting the play icon at the top of the page.

   ![Install Librarues](images/install.png)

   ![Run Cell](images/play.png)

5. Restart the Kernel

   In order for the tools in the mlxtend package to become available, you must restart the kernel.

   Select kernel in the drop down bar at the top of the page and then "Restart Kernel". Make sure to save everything first by selecting File -> Save Notebook.

   ![Restart Kernel](images/restart.png)

6. Import all the necessary libraries

   Run the second cell of the notebook that contains all the import statements. This will import the industry standard data science tools that we will use throughout the lab.

   ![Import Libraries](images/imports.png)

You may now proceed to the next lab.

## Acknowledgements
* **Authors** - Jeroen Kloosterman - Product Strategy Manager - Oracle Digital, Lyudmil Pelov - Senior Principal Product Manager - A-Team Cloud Solution Architects, Fredrick Bergstrand - Sales Engineer Analytics - Oracle Digital, Hans Viehmann - Group Manager - Spatial and Graph Product Management, Simon Weisser - Cloud Engineer
* **Last Updated By/Date** - Simon Weisser, Dec 2021

