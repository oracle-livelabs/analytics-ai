
# Lab 3: Gather Insights with Oracle Analytics Cloud (OAC)

## Introduction

In this lab, you will use **Oracle Analytics Cloud** (OAC) to explore, visualize, and share insights from your refined airline dataset in the GOLD schema of Autonomous AI Lakehouse. Building on your work in Lab 2, you’ll connect OAC directly to your gold table and create impactful, interactive dashboards.

> **Estimated Time:** 1 hour

---

### About Oracle Analytics Cloud (OAC)

OAC provides a powerful cloud platform for business intelligence, self-service analytics, and data visualization. It seamlessly integrates with Oracle’s lakehouse ecosystem so you can connect, explore, and act on your cleansed and enriched data with ease.

---

### Objectives

In this lab, you will:
- Connect OAC to your “gold” airline dataset in Autonomous AI Lakehouse
- Create visualizations such as bar and pie charts using key fields (delays, airline, sentiment)
- Build and customize an interactive dashboard to answer analytic questions

---

### Prerequisites

This lab assumes you have:
- Completed **Lab 2: Process and Refine Data in AI Data Platform and Lakehouse**, with your gold airline data in the GOLD schema of Autonomous AI Lakehouse
- Access to Oracle Analytics Cloud (OAC)
- Basic familiarity with web-based dashboards (OAC is point-and-click, no prior BI experience needed)

---

## Task 1: Download the Wallet to Autonomous AI Lakehouse

1. Navigate to the Autonomous AI Lakehouse instance from Lab 2 in your OCI tenancy.

2. Select **Database connection** and download the wallet for the lakehouse.

![Download Wallet](./images/ai-lakehouse-db-wallet1.png)

3. For Wallet Type 'Instance Wallet', click on 'Download Wallet' button

![Download Wallet](./images/ai-lakehouse-db-wallet2.png)

4. Set the wallet password, and click the 'Download' button.

![Download Wallet](./images/ai-lakehouse-db-wallet3.png)

---

## Task 2: Connect OAC to Your Gold Data Table

1. Using the Navigation menu, navigate to Analytics & AI -> Analytics -> Analytics Cloud

![Analytics Cloud](./images/oac-instance1.png)

2. Click on the OAC instance 'aidpoacxx' name, and then 'Analytics Home Page', to open the service console. 

![Analytics Cloud](./images/oac-instance2.png)

![Analytics Cloud](./images/oac-instance3.png)

3. Go to **Create → Connection**, then select Oracle Autonomous Warehouse (Now Autonomous AI Lakehouse) 

![Create Connection](./images/create-connection1.png)

![Select Lakehouse](./images/create-adl-conn.png)

4. Provide the name **adl-conn-xx**, the  details for the lakehouse, and upload the wallet as client credentials from Task 1. Use GOLD_XX schema credentials.

![Create ADL Connection](./images/create-adl-conn-3.jpg)

5. Select Save.

6. From the OAC home page, select Create > Dataset

![Create Dataset](./images/create-dataset2.png)

7. Select the **adl-conn-xx** just created 

![Create ADL Dataset](./images/create-adl-conn-4.jpg)

8. Wait for the data to load. Expand the Schemas on the left-hand side and GOLD\_XX schema. Drag and drop the **AIRLINE\_SAMPLE\_GOLD** table to the white space to the right 

![Create Gold Dataset](./images/create-dataset-gold1.jpg)

9. Select the save button at the top right to create the dataset. Name the dataset **aidp\_gold\_xx\_dataset**.

![Save Gold Dataset](./images/create-dataset1.png)

---

## Task 3: Build a Workbook with Gold data

1. From the OAC home page, select Create > Workbook

![Create Workbook](./images/create-workbook1.png)

2. Select the dataset just created > Add to workbook

![Select Dataset](./images/select-dataset1.png)

3. You can now drag and drop fields for visualization. For example, to create a pie chart of the average departure delay by airline, drag the following fields onto the canvas - 
    - AVG\_DEP\_DELAY
    - AIRLINE

![Drag OAC fields](./images/oac-chart1.png)

Drag the 'Airline' to the 'Color' field

![Drag OAC fields](./images/oac-chart2.png)

From the dropdown, select Pie as the chart to see a visualization

![Select Visualization](./images/oac-chart3.png)

The fields should be finally mapped as follows:

![Average Departure Delay Pie Chart](./images/avg-dep-delay-pie.png) 

 - You'll be able to view the pie chart visualization of the average departure delay by airline.

![Average Departure Delay Pie Chart](./images/avg-dep-delay-pie-2.png)

4. We can also create a bar chart by average departure delay. 

Drag and drop the following fields onto the canvas.
 - AVG\_DEP\_DELAY
 - Airline

![OAC Chart](./images/oac-chart4.png)

Drop the fields outside of the existing pie chart. 

![OAC Chart](./images/oac-chart5.png)

Drag the 'Airline' to the 'Color' field

![OAC Chart](./images/oac-chart6.png)

The fields should be finally mapped as follows:

![Average Departure Delay Bar Chart](./images/avg-dep-delay-bar.png)

- You can now see a bar chart visualization of the average departure delay by airline - 

![Average Departure Delay Bar Chart](./images/avg-dep-delay-bar-2.png)

5. Finally we'll add a new table graph for the reviews and sentiments. 

Drag the following fields
 - Airline
 - Review
 - Sentiment

![OAC Chart](./images/oac-chart7.png)

Drop the fields underneath the existing charts. 

![OAC Chart](./images/oac-chart8.png)

The fields should be finally mapped as follows 

![Sentiment Table](./images/sentiment-table.png)

- You should now be able to see a table of sentiments  

![Sentiment Table](./images/sentiment-table-2.png)

- Once all the charts are configured, the workbook will show all the analytics on one page 

![Analytics AIDP](./images/aidp-oac-workbook1.png)

6. Save the Workbook

![Analytics AIDP](./images/aidp-oac-workbook3.png)


---

## Task 4: Configure OAC Assistant

1. From the OAC Navigator, go to Console

![Console](./images/oac-genai1.png)

2. Click on Generative AI

![GenAI](./images/oac-genai2.png)

3. If the 'Status' shows 'Active', proceed to the next step.

If the 'Status' shows 'Inactive', click the 3 dots and then click 'Set Active'

![GenAI](./images/oac-genai4.png)

The 'Status' should be set to 'Active'

![GenAI](./images/oac-genai5.png)

4. For each of the features, the dropdown should indicate 'Oracle Analytics'. If that's indicated, proceed to the next step.

If not, for each of the features, click the dropdown and select 'Oracle Analytics'

![GenAI](./images/oac-genai6.png)

Click 'Update'

![GenAI](./images/oac-genai7.png)

Finally the Generative AI service should be set as follows:

![GenAI](./images/oac-genai3.png)

5. From the OAC Home Page, open the OAC Workbook "aidp-gold-xx-workbook" (that you created)

![Assistant1](./images/aidp-oac-workbook5.png)

![Assistant1](./images/aidp-oac-workbook6.png)

6. CLick the 'edit' mode

![Assistant1](./images/aidp-oac-workbook7.png)

7. Click the  "Present" tab. In the left panel, scroll down to the 'Insights Panel'. Ensure that the "Workbook Assistant" is turned "On" in the 'Insights Panel', and your dataset 'aidp_gold_xx_dataset' is checked.

![Assistant1](./images/aidp-oac-workbook2.png)

8. Save the updated workbook

![Assistant1](./images/aidp-oac-workbook8.png)

---

## Task 5: Index OAC Dataset for OAC Assistant

1. From the OAC Navigator, go to Data

![Data1](./images/oac-assistant1.png)

2. For the "aidp\_gold\_xx\_dataset" that you created, click on Menu and then Inspect

![Data2](./images/oac-assistant2.png)

3. Click on "Search", and in the dropdown select "Assistants and Homepage Search"

![Data3](./images/oac-assistant3.png)

4. Ensure that the dataset is indexed correctly for "Name & values, click Save, and then click "Run Now"

![Data4](./images/oac-assistant4.png)

5. The dataset index gets initiated.

![Data5](./images/oac-assistant5.png)

---

## Task 6: View OAC Assistant

1. From the OAC Home Page, open the OAC Workbook "aidp-gold-xx-workbook" (that you created), and then click Auto Insights -> Assistant

![Data6](./images/oac-assistant6.png)

2. You can ask the question "Show average departure delay by airline." in natural language, and you'll get the response.

![Data7](./images/oac-assistant7.png)

3. You can change the Chart type to Pie, and see the response.

![Data8](./images/oac-assistant8.png)

4. You can ask a different question "Show average distance by airlines", and see the response.

![Data9](./images/oac-assistant9.png)


---

## Task 7 (Optional): Add More Visualizations

- **Scatter Plot:** Explore relationship between arrival and departure delays, color by airline.
- **Pie Chart:** Show distribution of sentiments across all flights.
- **Pivot Table:** Tabulate airlines, delays, and sentiment together for easy comparison.
- **Dashboard:** Drag your visuals onto a canvas to create an interactive, multi-chart dashboard.


---

## Task 8 (Optional): Customize and Share

- Edit titles, axis labels, and colors for clarity.
- Save your workbook.
- Optionally, share your dashboard with others or export visuals as images/PDF.

---

## Next Steps

**Congratulations!** You now have a fully functioning pipeline from raw data to analytic insight using **Autonomous Transaction Processing**, **AI Data Platform**, **Autonomous AI Lakehouse**, and **Analytics Cloud**. Feel free to experiment with more charts, filters, or custom calculations—and use your dashboard to present your findings.

---

## Acknowledgements

**Authors**
* **Luke Farley**, Senior Cloud Engineer, ONA Data Platform
* **Kaushik Kundu**, Master Principal Cloud Architect, ONA Data Platform

**Contributors**
* **Enjing Li**, Senior Cloud Engineer, ONA Data Platform
* **JB Anderson**, Senior Cloud Engineer, ONA Data Platform

**Last Updated By/Date:**
* **Kaushik Kundu**, Master Principal Cloud Architect, ONA Data Platform, December 2025
