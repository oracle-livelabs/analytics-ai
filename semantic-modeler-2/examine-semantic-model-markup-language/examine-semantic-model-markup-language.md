# Examine Semantic Model Markup Language and integrate SMML with Git

## Introduction

This lab shows you how to open the Semantic Model Markup Language (SMML) editor to review and make changes to a semantic model.

You can use Git repositories with Oracle Analytics to enable concurrent semantic modeler development.

A semantic model is comprised of a set of JavaScript Object Notation (JSON) files. When you create and develop a semantic model locally, the model's JSON files are stored in Oracle Cloud. To make the semantic model's JSON files available for other development team members, the semantic model's owner creates a Git repository, initializes it with HTTPS or SSH, and uploads the semantic model's JSON files to the repository. Each developer creates a semantic model and uses HTTPS or SSH to connect to and clone the semantic model's JSON files to their Git repository.

You can use the SMML editor to view and change the JSON SMML schema file of an object in your semantic model. If you are viewing or editing an invalid file, syntax and semantic errors are marked on the relevant line of text.

Estimated Time: 25 minutes

### Objectives

In this lab, you will:
* Examine the Semantic Model Markup Language
* Initialize Git Integration for the semantic model

### Prerequisites

This lab assumes you have:
* Access to Oracle Analytics Cloud
* Access to DV Content Author, BI Data Model Author, or a BI Service Administrator Problems
* Access to the Sample Sales Semantic Model
* Access to a Git Repository using your Github account
* Completion of [Model Your Data With the Semantic Modeler in Oracle Analytics Cloud (OAC): Part 1](https://apexapps.oracle.com/pls/apex/r/dbpm/livelabs/view-workshop?wid=3566&clear=RR,180&session=107559302574644)



## Task 1: Examine the Semantic Model Markup Language

In this section, you will review JSON objects in a semantic model and makes changes to the object definitions using the Semantic Model Markup Language (SMML) editor.

Begin with step 3 if you're continuing this tutorial directly after completing the steps in Test, Deploy, and Validate a Semantic Model tutorial.


1. If you closed your semantic model, sign in to Oracle Analytics Cloud using one of DV Content Author, BI Data Model Author or service administrator credentials. On the Home page, click the **Navigator**, and then click **Semantic Models**.
	![Open Semantic Models](./images/semantic-models.png)

2. In the Semantic Models page, select **Sample Sales**, click **Actions menu**, and then select **Open**.
	![Open Samples Sales](./images/open-sample-sales.png)

3. In the Sample Sales semantic model, click the **Physical Layer**. Expand **MySampleSalesDatabase** and expand **BISAMPLE**.
	![Expand MySampleSalesDatabase and BISAMPLE](./images/bisample.png =400x*)

4. Right-click **SAMP_ PRODUCTS_D**, and select **Open in SMML Editor**.

	![Open SAMP_PRODUCTS_D in SMML Editor](./images/samp-prod-ssml.png)

## Task 2: Back Up Your Semantic Model

In this section, you create an archive of your semantic model as a backup.

1. In the Sample Sales semantic model, click the **Page Menu**, and select **Export**.
	![Click export in semantic model](./images/export.png =400x*)

2. In Export, keep **Sample Sales** as the archive name, select **Archive File (.zip)**, and then click **Export**.
	![Choose Archive File as export option](./images/archive-file.png =400x*)

3. Open the Sample Sales.zip file and save it it your desired location.

	![Export semantic model](./images/save-sample-sales-zip.png)


## Task 3: Setup your Git Repository

In this section, you use your Git repository to store your semantic model. You must have a GitHub account to complete some of the tasks in this lab. If you do not have a GitHub account, create a new one and create a repository for use with this lab.

1. Sign in to GitHub using the URL to your repository.

2. Click **Repositories** and open the repository to use with your semantic model.
	![Open repository with semantic model](./images/semantic-modeler-repo.png)

3. From the repository setup page, click **SSH** and copy your SSH link. We will use this in the next task to integrate your repository with the Sample Sales Semantic Model.

	![copy ssh](./images/sm-ssh.png)

## Task 4: Initialize Git Integration

In this section, you specify your profile name, Git user name, and your personal access token in the Semantic Modeler to initialize Git.

1. In the Sample Sales semantic model, click **Toggle Git Panel**, and then click **Start**.
	![Start Toggle Git Panel](./images/toggle-git-panel.png =400x*)

2. In Initialize Git, paste your Git repository SSH in to **Git Repository URL**, and then click **Continue**.
	![Paste Git Repository URL](./images/git-url.png =500x*)

3. Select a **New Profile**. Enter a **Profile Name**, and select **EC** for **Algorithm**. Then click **Generate Key**.
	![Profile name](./images/profile-name.png =500x*)

4. Click **Copy Key**. We will use this key to authenticate with our Git repository and configure our Git server.

	![Copy key](./images/copy-key.png)

5. Go to your GitHub profile settings. Click **SSH and GPG keys** and select **New SSH key**.

	![New ssh key](./images/new-ssh-key.png)

6. Give the SSH key a **Title** and select **Authentication Key** for Key type. In the Key field, paste the key we generated in OAC and click **Add SSH key**. Once the key has successfully been added, go back to your OAC tab.

	![Add SSH key](./images/add-ssh.png)

7. Click **Initialize Git**.

	![Initialize Git](./images/initialize-git.png)

8. Once you get a Git Initialization Success message, the Git Panel on the right will appear. This means you have successfully initialized your Git repository. You can now commit any changes you make to your semantic model to your Git repository.

 	![Success](./images/git-panel.png)

## Task 5: Review the Git Integration

In this section, you look at the semantic modeler content added to your Git repository.

1. In GitHub, open the repository we created. In the **main** branch, you'll notice the updated contents in the Git repository. Click the **physical** folder.

	![Physical](./images/git-content.png)

2. Then click the **MySampleSalesDatabaseDatabase** folder, and then click the **BISAMPLE** folder to view the contents. The BISAMPLE folder contains the JSON definitions for the physical layer's tables.

	![BISAMPLE content](./images/bi-sample.png)

## Task 6: Change the Semantic Model

In this section, you add a description in SAMP_ PRODUCTS_D to demonstrate changes to the semantic model and how those changes are tracked in Git.

1. In the Physical Layer, double-click **SAMP_ PRODUCTS_D**. Click the **General** tab.
	![SAMP_PRODUCTS_D](./images/samp-prods.png)

2. In Description, enter <code>Test product description to show semantic model changes and Git</code>. Click off the field and the Save button will be active. Click **Save**. The Git panel shows the status of the changes in the semantic model.

	![Open Samp_Products D](./images/samp-products-d.png)

3. In the Git panel, right-click **SAMP_ PRODUCTS_D** and select **View Diffs**.
	![View Diffs](./images/view-diffs.png)

4. This will show the changes that were made in the current branch compared to the original branch. Close the Diff Editor.

	![Close Diff Editor](./images/close-diff-editor.png)

5. In the Git panel, click **Stage All** in Unstaged Changes. In the **commit description** field, enter a description of the changes and click **Commit**.
	![Stage all](./images/stage-all.png)
	![commit](./images/commit.png)

6. In the Git panel, click **Push**, and then click **Push**. The message, "Push successful" appears when the changes are added to your Git repository.
	![Push](./images/push.png)

7. In your Git repository, click the **Physical folder**, click **MySampleSalesDatabase**, click **BISAMPLE**, and then click **SAMP_ PRODUCTS_D.json** to view the changes made in the semantic model.
	![GitHub changes](./images/git-changes.png)

You may now **proceed to the next lab**

## Learn More
* [Edit Semantic Model Objects Using the SMML Editor](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acmdg/edit-semantic-model-objects-using-smml-editor.html)
* [About Using Git Repositories with Semantic Modeler](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acmdg/using-git-repositories-semantic-model-development.html#GUID-5751B7B8-2A8D-4587-ACE4-0CABC9DAC12B)
* [Upload a Semantic Model to a Git Repository Using HTTPS](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acmdg/upload-semantic-model-git-repository-using-https.html)
* [Work With Branches](https://docs.oracle.com/en/cloud/paas/analytics-cloud/acmdg/work-branches.html)

## Acknowledgements
* **Author** - Nagwang Gyamtso, Product Manager, Analytics Product Strategy
* **Contributors** - Pravin Janardanam, Gabrielle Prichard, Lucian Dinescu, Desmond Jung
* **Last Updated By/Date** - Nagwang Gyamtso, March, 2024
