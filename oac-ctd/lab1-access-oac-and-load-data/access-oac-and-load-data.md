# Exercise 1: Access OAC and load data

## Scenario

“9 o’clock of a Friday morning. An email from your manager pops-up asking you to help with some analysis. During a board meeting, expenses review appeared a bit higher than expected. Someone quickly pointed at you as the best person in the company to create some analysis and help identifying the root causes. An excel with expenses data is attached to the email. You wonder who said your name, as you would love to pay the favor back.”

__SUMMARY__

In this first exercise you will connect to the OAC instance, load an excel file, enhance it with extra information and prepare it to be used by the search.

Estimated Lab Time: 15 minutes

### Objectives
* Provision Analytics Cloud
* Connect to the OAC instance
* Load an excel file
* Enhance and prepare the file for search

## **Task 1**: Create an Oracle Analytics Cloud (OAC) Instance

1. Navigate to the Home page and  Menu > Analytics & AI > Analytics Cloud.

![](images/oac_menu.png)

2. Make sure you select the root compartment (unless you have permissions and experience selecting a different one) and click Create Instance.

![](images/oac_create_button.png)

3. Fill the web form with the following information and click Create:

    •	Name: < Instance_Name >

    •	Description: < Analytics Instance for Workshop >

    •	Create in Compartment: root compartment, unless you have permissions and experience selecting a different one

    •	Feature Set: Enterprise Analytics

    •	Capacity: OCPU and 1 - Non Production

    •	License Type: License Included

![](images/oac_form.png)

Your Analytics Instance will start provisioning.

![](images/oac_creating.png)

Note: Provisioning an Oracle Analytics Cloud instance can take from 10 (most likely) to 40 minutes.

## **Task 2**: Connect to the OAC instance

Based on instance provisioning step you have two choices to start using Oracle Analytics Cloud instance.

Option 1 : If you are running this workshop on Oracle Analytics Cloud instance already provisioned for you by workshop instructor follow steps below.

Open the browser and enter the ‘OAC URL’ for ‘Oracle Analytics Cloud’ provided. It would be of the format http://host/dv/ui.

1. Your instructor will provide you with your User Name and Password. Accept the term of service and you will be directed to the main OAC Console page.
2. Login using the credentials provided.

Option 2 : Use fresh provisioned OAC instance from task 1.

![](images/1_oac_login.png)

You will be taken to the OAC Home page.

![](images/2a_oac_home_page.png " ")

On the OAC Home Page

NOTE that you probably won’t have the same list of projects and datasets.

Try Out or Switch to Oracle's Redwood Theme

On the home page you will presented with the pop up box with option to preview Oracle Analytics Redwood look.
Click on Preview it.

![](images/2a_redwood_preview.png " ")

To switch on the Redwood theme for everyone, go to the System Settings page and set the Preview Redwood Theme property.

Click on Preview option in system setting page.

![](images/2b_preview_redwood_theme.png " ")

Note:In the future, Oracle's Redwood theme will be the default look and feel and you won't be able to switch it on or off.

## **Task 3**: Load an excel file

Donwload the file: [OAC_TD_Expenses.xlsx](https://objectstorage.us-ashburn-1.oraclecloud.com/p/jyHA4nclWcTaekNIdpKPq3u2gsLb00v_1mmRKDIuOEsp--D6GJWS_tMrqGmb85R2/n/c4u04/b/livelabsfiles/o/labfiles/OAC_TD_Expenses.xlsx)

1. Click on “Create”

![](images/2_oac_home_page.png " ")

From the available options, focus on ingesting a new set of data to the system.

![](images/3_create_data_set.png " ")

You are led to the data set screen and a pop-up windows appears to let you select where to find the data.
1. Click on “Drop data file here or click to browse” option.

![](images/4_drop_data_file.png " ")

The explorer window appears.


1. Look for the folder with lab files and select “OAC_TD_Expenses.xlsx” file.
2. Click Open

![](images/5_upload_file.png " ")

The file gets uploaded and parsed.


On the screen you have a preview of the data.
1. Change the Name of the dataset adding your initials at the end, to avoid clashing with other attendees, for instance: OAC_TD_Expenses_JAMP
2. Click on “Add”

![](images/6_data_prep_step.png " ")


## **Task 4**: Enhance and prepare the file for search


Now, your data is profiled to provide you with some recommendations to enhance it.

This recommendation list is on the right part of the window.
1. Click anywhere on the “Corporate Card Number” column to see its suggested actions.

![](images/7_corporate_card_number.png " ")


The engine discovered that you have a column with Credit Card numbers which probably is not GDPR complaint at all.

At most probably not needed for any analysis. So the system recommends you to obfuscate or delete this column.
1. Click on the option “Obfuscate Corporate Card Number”

![](images/8_obfuscate_card_number.png " ")


The column gets obfuscated and highlighted so you can easily spot the changes. This step has been added to the list of preparation steps on the left bar. At the end, all the steps will be applied to the dataset.

Now, you can explore other recommendations for a different type of column.

1. Click anywhere on the “Destination Country” column

![](images/9_obfuscate_color.png " ")

The engine detected this field as a Geo-country info so it suggests enhancements related to that, like providing the ISO code for you. This is quite convenient as standard codes are better for joining data and avoid burden with names, characters and string cases.
1. Click on “Enrich Destination Country with iso3”

![](images/10_enrich_destination_country.png " ")

Again, preparation preview gets applied and new column is highlighted.

This is enough for the exercise needs.
1. Click “Apply Script” Once the steps are applied to your data the button will get grayed out.

![](images/11_apply_script.png " ")

Data is now ready to be used, however, to have access to one of the easiest methods, you need to enable searching on the dataset.

To do so:
1. Naviagte to home screen by clicking Go back arrow from top left corner.
2. Click on the Navigator menu (“burger” icon) on the top left corner.
3. Click on “Data”

![](images/12_data_hamburger_icon.png " ")

In this screen you can see a list of the Data Sets that you have access to.

The one at the top should be the file you just created.
1. Click on the “Actions Menu” (burger icon) at the right of the data set entry
2. Select “Inspect”

![](images/13_actions_inspect.png " ")

This menu allows you to configure the access to the file and data.

Here is were you can allow the search engine to run on the data and be “searchable” through the BIAsk bar.
1. Click on Search

![](images/14_search_inspect.png " ")

Search option can be configured in detail and for several Languages.
1. Click on “Index Data Set for Searching” checkbox

![](images/15_index_searching.png " ")

Default settings are enough as your data is in English and searching by names fits with the needs of the exercise.
1. Click on “Save”
2. Click on “Close”

![](images/16_save_close.png " ")

Search engine daemon runs in background every 2-3 minutes. You need to wait that time to be sure data is crawled.

So, time for a coffee or a short talk from your instructor.

![](images/17_home.png " ")


## End of Exercise 1

## Acknowledgements

- **Author** - Mahira Galal, Aydin Heydari and Sushil Mule
- **Adapted by** -  Mahira Galal, Aydin Heydari, Alex Chiru
- **Last Updated By/Date** - Sushil Mule, August 2021