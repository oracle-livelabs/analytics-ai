# Process data from Silver into Gold schema

## Introduction

In this lab we will promote the data that was curated and processed in the **Silver** catalog schema into the Gold schema to make it easily consumable for business users.

Estimated Lab Time: 30 minutes

### Objectives

In this lab, you will:
* Use the notebook functionality of AI Data Platform to process data
* Use data that is loaded in Silver schema and process into Gold layer

### Prerequisites 

*List the prerequisites for this lab using the format below. Fill in whatever knowledge, accounts, etc. is necessary to complete the lab. Do NOT list each previous lab as a prerequisite.*

This lab assumes you have:
* An Oracle Cloud account
* All previous labs successfully completed

*This is the "fold" - below items are collapsed by default*

## Task 1: Process data with notebooks into Gold schema in AI Data Platform

1. Step 1

  Open the workspace you created and open the **Silver-to-gold** folder. In the main pane you open the file starting with name **17_silver_drivers.ipynb**. 
  Before  running this notebook, please check the parameter cell if the right catalog names and schema names are defined. Otherwise your notebook may error out.
  
  When you have completed the first notebook in the **Silver-to-gold** folder, you can open and run the other notebooks from that folder to populate the tables in the following order:
  - 17_silver_drivers.ipynb
  - 18-silver_constructors.ipynb
  - 15_silver_team_ranking.ipynb
  - 16_silver_driver_ranking.ipynb

## Acknowledgements
* **Author** - Wilbert Poeliejoe
* **Contributors** -  <Name, Group> -- optional
* **Last Updated By/Date** - <Name, Month Year>