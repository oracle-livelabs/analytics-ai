# Lab 1: Initial Setup

## Introduction

In this lab, we are going to create the underlying resources required for our use-case such as: a storage bucket, database instance, key vault and more.

**Estimated Time**: 30 minutes

## Objectives

In this lab, you will:

* Verify that your tenancy is subscribed to one of the supported regions.
* Create the required access policies.
* Create a storage bucket & upload manufacturing procurement policy documents into it.

## Prerequisites

This lab assumes you have:

* An Oracle Cloud account

---

## Task 1: Ensure your tenancy is subscribed to a supported region

The OCI Generative AI Agents service is currently available in the following regions:

* US East (us-ashburn-1)
* Brazil East (sa-saopaulo-1)
* Germany Central (eu-frankfurt-1)
* Japan Central (ap-osaka-1)
* UK South (uk-london-1)
* US Midwest (us-chicago-1)

We will now ensure that your tenancy is subscribed to one of these regions:

1. On the top right, click the **Regions** drop down menu.

   ![Screenshot showing the tenancy regions list](./images/region-selection-drop-down.png)

2. Review the list of regions your tenancy is subscribed in. If any of the regions mentioned above appear on the list, select one of them and skip to the next task.

3. Click the **Manage Regions** link at the bottom of the list.

4. In the Infrastructure Regions list, locate one of the regions mentioned above, click the action menu on its far right and click the **subscribe** option from the pop-up menu.

   ![Screenshot showing how to subscribe to a region](./images/subscribe-to-region.jpg)

> **Note**: When you subscribe to a region, you cannot unsubscribe from it.

5. Click the **Subscribe** button at the bottom of the Subscribe to New Region dialog.

   ![Screenshot showing the new region subscription approval dialog](./images/subscribe-new-region-dialog.png)
The operation might take a few minutes to complete. When complete, the new region will appear in the Regions drop down menu on the main screen. Please select the added region from the list as the active region.

---

## Task 2: Create access policies

In this task, we are going to create policies which will grant us access to the OCI Generative AI Agents service as well as the additional services we are going to use in this workshop such as Object Storage, Autonomous AI Database, Key Vault and others.

> **Note**: If you are an administrator of the current tenancy, please skip to the next task. If you are NOT an administrator of the current tenancy, and you don't have permissions to create the required policies, please reach out to the tenancy administrator to create those on your behalf.

In addition to granting access to your user or user group to access the various resources required for the use-case, we will also need to grant the OCI Generative AI service access to resources like Object Storage or Database Tools for it to be able to process the data on those resources.

In order to facilitate those permissions, we will create a Dynamic Group which will help us control the access the service itself will have.

### Create Dynamic Group

1. Click the navigation menu on the top left.
2. Click **Identity & Security**.
3. Click **Domains**.

   ![Screenshot showing how to navigate to the domains section of the console](./images/domains-navigation.png)
   
4. Under the List scope, make sure that the **root compartment** is selected.
5. Click the **Default** domain from the Domains table.

   ![Screenshot showing how to navigate to the default domain section](./images/default-domain-navigation.png)
   
6. On the left click **Dynamic Groups**.
7. Click the **Create dynamic group** button at the top of the Dynamic groups table.

8. Name the dynamic group: `oci-genai-agents-service`

      ```text
      <copy>
      oci-genai-agents-service
      </copy>
      ```

9. Provide an optional description (example: *This group represents the OCI Generative AI Agents service*)

      ```text
      <copy>
      This group represents the OCI Generative AI Agents service
      </copy>
      ```

10. Select the **Match any rules defined below** option in the Matching rules section.
11. Enter the following expression in the Rule 1 textbox:

      ```text
      <copy>
      ANY {resource.type='genaiagentdataingestionjob', resource.type='genaiagent'}
      </copy>
      ```

### Create Access Policies

Next, we will create the access policies:

1. Click the navigation menu on the top left.
2. Click **Identity & Security**.
3. Click **Policies**.

   ![Screenshot showing how to navigate to the policies section](./images/policies-navigation.png)

4. On the left under List scope, select the **root compartment**. The root compartment should appear first in the list, have the same name as the tenancy itself and have the text (root) next to its name.
5. Click the **Create Policy** button on the top left of the Policies table.

   ![Screenshot showing how to initiate the creation of a new policy](./images/create-new-policy-navigation.png)
   
6. Provide a name for the policy (example: `oci-generative-ai-agents-workshop`).

      ```text
      <copy>
      oci-generative-ai-agents-workshop
      </copy>
      ```

7. Provide a description (example: *OCI Generative AI Agents Hands-On-Lab Policy*).

      ```text
      <copy>
      OCI Generative AI Agents Hands-On-Lab Policy
      </copy>
      ```

8. Make sure that the **root compartment** is selected.
9. Enable the **Show manual editor** option.
10. In the Policy Builder textbox, enter the following policy statements:

      ```text
      <copy>
      allow group <your-user-group-name> to manage genai-agent-family in tenancy
      allow group <your-user-group-name> to manage object-family in tenancy
      allow group <your-user-group-name> to manage secret-family in tenancy
      allow dynamic-group oci-genai-agents-service to read objects in tenancy
      allow dynamic-group oci-genai-agents-service to read secret-bundle in tenancy
      allow dynamic-group oci-genai-agents-service to read database-tools-family in tenancy
      allow dynamic-group oci-genai-agents-service to use database-tools-connections in tenancy
      </copy>
      ```

> **Important**: Make sure to replace `<your-user-group-name>` with the user group your user is associated with (for example: Administrators). If you have named the dynamic group anything other than `oci-genai-agents-service`, please replace any reference to `oci-genai-agents-service` with the name you have given the dynamic group.

In order, these policies will enable:

* Your user group to create agents, knowledge bases etc.
* Your user group to create storage buckets and upload files into them.
* Your user group to create vaults & secrets.
* The OCI Generative AI Agents service to read files uploaded to object storage.
* The OCI Generative AI Agents service to read secrets stored in key vaults.
* The OCI Generative AI Agents service to read information about database connections.
* The OCI Generative AI Agents service to execute queries through database connections.

11. Click the **Create** button.

   ![Screenshot showing the steps to create a new policy](./images/create-new-policy-mfg.png)

---

## Task 3: Create a storage bucket for the procurement policy documents

The procurement and manufacturing policy PDFs that we are going to upload into a storage bucket in this task will be used by the agent whenever a VP of Manufacturing requires specific policy guidance to evaluate supplier performance, procurement exceptions, or spending compliance.

1. Click the navigation menu on the top left.
2. Click **Storage**.
3. Click **Buckets**.

   ![Screenshot showing how to navigate to the storage buckets section](./images/navigate-to-buckets.png)

4. On the left under List scope, select the **root compartment**.
5. Click the **Create Bucket** button on the top left of the Buckets table.
   
   ![Screenshot showing the create bucket button](./images/create-new-storage-bucket.png)

6. Name the bucket: `manufacturing-procurement-policies`

   ```
   <copy>
   manufacturing-procurement-policies
   </copy>
   ```
   
7. Keep all other settings with their default values and click the **Create** button.

8. Click the newly created `manufacturing-procurement-policies` bucket from the Buckets list.

   ![Screenshot showing how to select the newly created storage buckets](./images/select-storage-bucket-mfg.png)

9. At this point, we will prepare the procurement policy documents to be uploaded to the storage bucket.

10. **Click here to download the manufacturing procurement policies zip file.**

   ![Screenshot the downloaded manufacturing zip file](./images/downloaded-mfg-zipfiles.png)

11. Unzip the file — you should have 8 PDF files representing different procurement and manufacturing policies:

| File Name | Description |
|-----------|-------------|
| `Supplier_Quality_Standards.pdf` | Quality rating criteria and risk scoring |
| `PO_Exception_Approval_Policy.pdf` | Exception types and approval thresholds |
| `Pricing_Variance_Thresholds.pdf` | Acceptable price variance limits |
| `Expedite_Request_Procedures.pdf` | Expedite justification and costs |
| `Supplier_Probation_Procedures.pdf` | Probation triggers and process |
| `Sole_Source_Justification_Policy.pdf` | Single-source documentation requirements |
| `Production_Impact_Escalation_Policy.pdf` | Escalation for production issues |
| `Spend_Compliance_Standards.pdf` | Budget and approval limits |

   ![Screenshot showing the unzipped manufacturing](./images/unzipped-mfg.png)

12. Click the **Upload** button on the top left of the Objects table or on the top right of the bucket details page.

   ![Screenshot showing the storage bucket upload button](./images/click-upload-mfg.png)

13. Click the **select files** link under the Choose Files from your Computer section.

   ![Screenshot showing the select files for upload links](./images/select-files-to-upload.png)

14. Navigate to the location in which you have unzipped the procurement policy documents (typically the Download folder) and select all 8 of the policy documents. After all files have been selected, click **Open** button.

   ![Screenshot showing the select files for upload links](./images/select-zip-files-mfg.png)

15. Click the **Upload** button to start the upload process.

     ![Screenshot showing all of the manufacturing manuals selected for upload](./images/upload-zipfiles-mfg.png)

16. Once all of the files have **Finished** showing next to them, click the **Close** button.

   ![Screenshot showing upload button](./images/uploading-files-mfg.png)

17. At this point you should see all 8 of the procurement policy documents listed under the Objects table.

   ![Screenshot showing upload button](./images/uploaded-files-mfg.png)

---

## Summary

You have successfully completed this lab. You have:

* Verified your tenancy is subscribed to a supported region
* Created the necessary IAM policies and dynamic group
* Created a storage bucket and uploaded the procurement policy documents

**You may now proceed to the next lab.**

---

## Learn More

* [Region subscription](https://docs.oracle.com/iaas/Content/Identity/Tasks/managingregions.htm)
* [Managing Dynamic Groups](https://docs.oracle.com/iaas/Content/Identity/Tasks/managingdynamicgroups.htm)
* [Getting Access to Generative AI Agents](https://docs.oracle.com/iaas/Content/gen-ai-agents/iam-policies.htm)

## Acknowledgements

* **Author** - Taylor Zheng
* **Contributors** - Anthony Marino, Uma Kumar, Deion Locklear, Wynne Yang