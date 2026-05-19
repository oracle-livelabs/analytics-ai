# Lab 3: Build Security Wingmate on APEX 

## Introduction
This lab will walk you through setting up the Security Wingmate page for the APEX application. Chat with your Wingmate about policies

Estimated time - 10 minutes

### Objectives

In this lab, you will:
* Build a Security Page of Wingmate App
* Test the App's Chat Feature

### Prerequisites

This lab assumes you have the following:

* Completed the previous lab
* Some SQL knowledge is perfered but not necessary

## Task 1: Build a Security Page of Wingmate App

1. Navitage to the APEX app WINGMATE, and select **Create Page**.

	![create page button](./images/create-page.png "")

2. Leave the default blank page settings, and select **Next**.

	![default blank page option](./images/blank-page.png "")

3. Name the blank page **Security Wingmate** and select **Create Page**.

	![page naming text box](./images/name-security-wingmate.png "")

4. Right click **Body** on the application tree to the left and select **Create Region**.

	![create region button](./images/create-region.png "")

5. On the right side panel under Identification for the region, Enter the name **WingmateChat**.

	![name wingmatechat region](./images/name-region-wingmate.png "")

6. In the center of the App Builder, select the **Buttons** menu, and drag and drop the **text button** to the Region Body of WingmateChat region.

	![create page button](./images/startwingmatebutton.png "")

7. Name the button on the right panel **StartWingmate**.

	![name the page button](./images/name-wingmate-button.png "")

8. Right click the new button and select **Create Dynamic Action**.

	![left menu for button and dynamic action](./images/dynamic-startwingmate-button.png "")

9. Name the dynamic action **Chat**.

	![Name dynamic action](./images/chat-action.png "")

10. Select the **True** Action on the left panel.

	![Select true action](./images/select-show.png "")
	
11. Select **Show AI Assistant** on the right panel. Select source to match the GenAI credentials from Lab 1. Pastes the following in the **System Prompt**:

	![true action description](./images/show-genai.png "")

12. Right-click **Show AI Assistant** on the left panel and click **Create Action**.

	![Create action button](./images/create-action.png "")

13. Select **Hide** for the Action, and under affected elements, select **Button** and **Start Wingmate** for the object.

	![Hide Action Button](./images/hidden-action.png "")

14. Save the work done and view the by clicking the **Green Run Button** on the top right of the screen.

	![Save and Run button](./images/save-and-run.png "")

## Task 2: Test the App's Chat Feature

1. On the popup screen, login using the same credentials from when you created the workspace. 

2. On the Security Wingmate page, select **Start Wingmate Chat**. 

	![Start Wingmate button](./images/start-wingmate-chat.png "")

3. Select the first prompt **How many policies do I have in my OCI tenancy?**.

	![Prompt button in chat](./images/use-prompt.png "")

4. Observe and validate the response. Refresh the page to compare the other prompt and validate the data matches expectations.

You may now **proceed to the next lab**.

## Acknowledgements

* **Authors:**
	* Nicholas Cusato - Cloud Architect
	* Royce Fu - Master Principle Cloud Architect
* **Last Updated by/Date** - Nicholas Cusato, Febuary 2026
