# Setup

## Introduction

In this lab, we are going to create the underlying resources required for our use-case such as: a storage bucket, Autonomous AI Database instance, key vault and more.

Estimated Time: 30 minutes

### Objectives

In this lab, you will:

- Verify that your tenancy is subscribed to one of the supported regions.
- Create the required access policies.
- Create a storage bucket & update loan policy manuals into it.

### Prerequisites

This lab assumes you have:

- An Oracle Cloud account

## Task 1: Ensure your tenancy is subscribed to a supported region

The OCI Generative AI Agents service is currently available in the following regions:

- US East (us-ashburn-1)
- Brazil East (sa-saopaulo-1)
- Germany Central (eu-frankfurt-1)
- Japan Central (ap-osaka-1)
- UK South (uk-london-1)
- US Midwest (us-chicago-1)

We will now ensure that your tenancy is subscribed to one of these regions:

1. On the top right, click the Regions drop down menu.

   ![Screenshot showing the tenancy regions list](./images/region-selection-drop-down.png)

1. Review the list of regions your tenancy is subscribed in. If any of the regions mentioned above appear on the list, select one of them and skip to the next task.

1. Click the **Manage Regions** link at the bottom of the list.

1. In the **Infrastructure Regions** list, locate one of the regions mentioned above, click the action menu on it's far right and click the subscribe option from the pop-up menu.

   ![Screenshot showing how to subscribe to a region](./images/subscribe-to-region.jpg)

> **Note:** When you subscribe to a region, you cannot unsubscribe from it.

1. Click the **Subscribe** button at the bottom of the **Subscribe to New Region** dialog.

   ![Screenshot showing the new region subscription approval dialog](./images/subscribe-new-region-dialog.png)

The operation might take a few minutes to complete. When complete, the new region will appear in the **Regions** drop down menu on the main screen. Please select the added region from the list as the active region.

## Task 2: Create access policies

In this task, we are going to create policies which will grant us access to the OCI Generative AI Agents service as well as the additional services we are going to use in this workshop such as Object Storage, ADB, Key Vault and others.

> **Note:** If you are an administrator of the current tenancy, please skip to the next task.
If you are **NOT** an administrator of the current tenancy, and you don't you have permissions to create the required policies, please reach out to the tenancy administrator to create those on your behalf.

In addition to granting access to your user or user group to access the various resources required for the use-case, we will also need to grant the OCI Generative AI service access to resources like Object Storage or Database Tools for it to be able to process the data on those resources.

In order to facilitate those permissions, we will create a Dynamic Group which will help us control the access the service itself will have.

1. Click the navigation menu on the top left.
1. Click **Identity & Security**.
1. Click **Domains**.

   ![Screenshot showing how to navigate to the domains section of the console](./images/domains-navigation.png)

1. Under the **List scope**, make sure that the **root** compartment is selected.
1. Click the **Default** domain from the **Domains** table.

   ![Screenshot showing how to navigate to the default domain section](./images/default-domain-navigation.png)

1. On the left click **Dynamic Groups**.
1. Click thd **Create dynamic group** button at the top of the **Dynamic groups** table.

   ![Screenshot showing how to navigate to the dynamic groups section](./images/dynamic-group-navigation.png)

1. Name the dynamic group: _oci-genai-agents-service_

    ```text
      <copy>
      oci-genai-agents-service
      </copy>
      ```
1. Provide an optional description (example: `This group represents the OCI Generative AI Agents service`)
   
      ```text
      <copy>
      This group represents the OCI Generative AI Agents service
      </copy>
      ```

1. Select the **Match any rules defined below** option in the **Matching rules** section.
1. Enter the following expression in the **Rule 1** textbox:

      ```text
      <copy>
      ANY {resource.type='genaiagentdataingestionjob', resource.type='genaiagent'}
      </copy>
      ```

   ![Screenshot showing how to configure the dynamic group](./images/create-dynamic-group.jpg)

Next, we will create the access policies:

1. Click the navigation menu on the top left.
1. Click **Identity & Security**.
1. Click **Policies**.

   ![Screenshot showing how to navigate to the policies section](./images/policies-navigation.png)

1. On the left under **List scope**, select the root compartment. The root compartment should appear first in the list, have the same name as the tenancy itself and have the text **(root)** next to it's name.

1. Click the **Create Policy** button on the top left of the **Policies** table.

   ![Screenshot showing how to initiate the creation of a new policy](./images/create-new-policy-navigation.png)

1. Provide a name for the policy (example: _oci-generative-ai-agents-workshop_).

      ```text
      <copy>
      oci-generative-ai-agents-workshop
      </copy>
      ```

1. Provide a description (example: _OCI Generative AI Agents Hands-On-Lab Policy_).

      ```text
      <copy>
      OCI Generative AI Agents Hands-On-Lab Policy
      </copy>
      ```

1. Make sure that the root compartment is selected.
1. Enable the **Show manual editor** option.
1. In the **Policy Builder** textbox, enter the following policy statements:

      ```text
      <copy>
      allow group <your-user-group-name> to manage genai-agent-family in tenancy
      allow group <your-user-group-name> to manage object-family in tenancy
      allow group <your-user-group-name> to manage secret-family in tenancy
      allow dynamic-group oci-genai-agents-service to read objects in tenancy
      allow dynamic-group oci-genai-agents-service to read secret-bundle in tenancy
      allow dynamic-group oci-genai-agents-service to read database-tools-family in tenancy
      </copy>
      ```

      Make sure to replace _<your-user-group-name>_ with the user group your user is associated with (for example: _Administrators_).
      If you have named the dynamic group anything other than _oci-genai-agents-service_, please replace any reference to _oci-genai-agents-service_ with the name you have given the dynamic group.

   In order, these policies will enable:

      - Your user group to create agents, knowledge bases etc.
      - Your user group to create storage buckets and upload files into them.
      - Your user group to create vaults & secrets.
      - The OCI Generative AI Agents service to read files uploaded to object storage.
      - The OCI Generative AI Agents service to read secrets stored in key vaults.
      - The OCI Generative AI Agents service to read information about database connections.

1. Click the **Create**

![Screenshot showing the steps to create a new policy](./images/create-new-policy.png)

## Task 3: Create a storage bucket for the merchandising policy documents

The merchandising policy PDFs that we are going to upload into a storage bucket in this task will be used by the agent whenever a Chief Merchandising Officer requires specific policy guidance to evaluate supplier quality, RTV claims, or product return thresholds.


1. Click the **navigation** menu on the top left.
1. Click **Storage**.
1. Click **Buckets**.

   ![Screenshot showing how to navigate to the storage buckets section](./images/navigate-to-buckets.png)

1. On the left under **List scope**, select the root compartment.
1. Click the **Create Bucket** button on the top left of the **Buckets** table.

   ![Screenshot showing the create bucket button](./images/create-new-storage-bucket.png)

1. Name the bucket: _retail-merchandising-policies_
1. Keep all other settings with their default values and click the **Create** button.

   ![Screenshot showing how to create a storage buckets](./images/create-storage-bucket.png)

1. Click the newly created **retail-merchandising-policies** bucket from the **Buckets** list.

   ![Screenshot showing how to select the newly created storage buckets](./images/select-storage-bucket.png)

1. At this point, we will prepare the merchandising policy documents to be uploaded to the storage bucket:
      1. Click [here](./files/loan_policy_manuals.zip) to download the retail merchandising policies zip file.

      ![Screenshot the downloaded loan policy manuals zip file](./images/downloaded-merchandising-zip.png)

      1. Unzip the file — you should have 8 PDF files representing different merchandising policies and standards:
      
      - Supplier_Quality_Standards.pdf
      - RTV_Claim_Policy.pdf
      - Product_Return_Thresholds.pdf
      - Defective_Merchandise_Handling.pdf
      - Regional_Distribution_Guidelines.pdf
      - Supplier_Probation_Procedures.pdf
      - Inventory_Disposition_Policy.pdf
      - Customer_Return_Policy.pdf

      ![Screenshot showing the unzipped loan policy manuals](./images/unzipped-merchandising-docs.png)

1. Click the **Upload** button on the top left of the **Objects** table *or* on the top right of the bucket details page.

   ![Screenshot showing the storage bucket upload button](./images/click-upload.png)

1. Click the **select files** link under the **Choose Files from your Computer** section.

   ![Screenshot showing the select files for upload links](./images/select-files-to-upload.png)

1. Navigate to the location in which you have unzipped the merchandising policy documents (typically the Download folder) and select all 8 of the policy documents.  After all files have been selected, click **Open** button

    ![Screenshot showing all of the loan policy manuals selected for upload](./images/select-all-merchandising-docs.png)

1. Click the **Upload** button to start the upload process.

   ![Screenshot showing upload button](./images/upload-merchandising-docs.png)

1. Once all of the files have **Finished** showing next to them, click the **Close** button.

   ![Screenshot showing the loan policy manuals finished uploading](./images/merchandising-docs-finished-uploading.png)

1. At this point you should see all 8 of the merchandising policy documents listed under the **Objects** table.

   ![Screenshot showing the loan policy manuals listed in the bucket](./images/merchandising-docs-listed-in-bucket.png)

You may now **proceed to the next lab**

## Learn More

- [Region subscription](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingregions.htm#ariaid-title7)
- [Managing Dynamic Groups](https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/managingdynamicgroups.htm)
- [Getting Access to Generative AI Agents](https://docs.oracle.com/en-us/iaas/Content/generative-ai-agents/iam-policies.htm)

## Acknowledgements

- **Author** - Anthony Marino, Deion Locklear
- **Contributors** - Uma Kumar, Hanna Rakhsha, Taylor Zheng
