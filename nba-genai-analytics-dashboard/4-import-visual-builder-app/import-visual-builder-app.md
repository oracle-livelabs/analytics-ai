# Use application to analyze player performance with Generative AI

## Introduction

This lab will show you how to create a visual builder instance, 

Estimated time - 20 minutes


### Objectives

* Create a Visual Builder Instance
* Import the application
* Enable the Analytics iframe

## Task 1: Create a Visual Builder Instance

1. Navigating the OCI console, select the **menu button** in the top-left corner and navigate to **Developer Services** and scroll down to click **Visual Builder**. 

  ![Menu showing navigation to Visual Builder](images/navigate-vb.png)

2. Click **Create Instance**.

  ![Button showing create instance](images/create-instance.png)
   
3. Name your instance (for example *NBA_LL*), validate you are in your compartment, and click **Create Visual Builder Instance**. There will be a confirmation that it was successful and the status will say **CREATING**.

  ![menu for naming and creating instance](images/name-instance.png)

1. Notice the Status updates to Complete. Once complete, click on the **instance** and select **Service homepage**. 

  ![homepage for visual builder instance](images/open-instance.png)

## Task 2: Import the application

1. Click **Import Application**. 

  ![welcome page button to get started](images/import-app.png)

2. Select **Application from file**.

  ![button to import from file](images/app-from-file.png)

3. Drag and drop the zip file to update the fields and click **Import**.

  ![import menu with updated fields](images/drag-and-drop.png)

## Task 3: Enable the Analytics iframe

1. Click the **side-menu** and click **settings**.

    ![Menu navigation to settings](images/vb-settings.png)

2. Click **New Origin** and paste in the **Origin Address** from the previous lab. Click the **check mark** to save.

    ![Add new Cross-Origin Address](images/cross-origins.png)

3. Update the Analytics app with the visual builder information for safe domains by navigating back to the Oracle Analyics Cloud dashboard,  selecting the **side menu button** and clicking the **Console** button.

  ![menu for the OAC console](images/oac-console.png)

4. Click **Safe Domains**.

  ![Safe Domains button](images/safe-domains.png)

5. Enter the domain of the visual builder app url in the empty field and clicked **Embedded**.

  ![Enter field of Safe Domains](images/embedded.png) 

6. Navigate back to the Visual builder webpage and then homepage using the side-menu and selecting **All Applications**. Click the **name** of the app to open the dashboard to begin editting.

  ![menu for the imported app](images/open-app.png)

3. Click the drop down arrow for the text **watch-live** and select the option **watch-live-start**.

  ![app structure tree](images/watch-live-start.png)

2. Select the option **Oracle Analytics Project** from the structure tree.

  ![app structure tree - Analytics option](images/structure-tree-analytics.png)

3. Update the **Host** and **Project Path** from the information gathered from the previous lab on the right-side menu of the webpage. Make sure Compatability Mode is **yes**. The iframe in the preview of the webpage will automatically update with the Analytics workbook. If it does not, the you will need to repeat steps the steps from the previous lab to ensure you have it correctly mapped.

  ![Analytics configuration menu](images/update-analytics.png)

4. Repeat steps **2** and **3** for the page **watch-live-tiny**.

  ![app structure tree](images/watch-live-tiny.png)

You may now **proceed to the next lab**.

## Learn More


## Acknowledgements

* **Authors:**
	* Nicholas Cusato - Cloud Engineer