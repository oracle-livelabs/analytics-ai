# Implementing Data Quality Control

## Introduction
This lab describes how to implement data quality control. An introduction to data integrity control is provided.

*Note*: ODI provides very basic quality checks. For complex use cases use Enterprise Data Quality (EDQ)

*Estimated Lab Time*: 60 minutes

### About Data Integrity Control
Data integrity control is essential in ensuring the overall consistency of the data in your information systems applications. Application data is not always valid for the constraints and declarative rules imposed by the information system. You may, for instance, find orders with no customer, or order lines with no product, and so forth.

Oracle Data Integrator provides a working environment to detect these constraint violations and to store them for recycling or reporting purposes. There are two different types of controls: *Static Control* and *Flow Control*. Refer to the Appendix section for more.

### Objectives
Some data in our source may be inconsistent. There may be constraints in the target table that are not implemented in the source table or there may be supplementary rules that you wish to add. In our case we have two constraints that we want to enforce on the SRC\_CUSTOMER table:
  * *Customers must be over 21 years of age.* However there could be some records corresponding to younger customers in the input table.
  * *The CITY\_ID column must refer to an entry in the SRC\_CITY table.* However there could be some values that do not exist in the city table.

We want to determine which rows do not satisfy these two constraints and automatically copy the corresponding invalid records into an error table for analysis.

Enforcing these types of rules requires the use of a *check constraint* (also referred to as a *condition*), as well as a *reference constraint* between the SRC\_CITY and SRC\_ CUSTOMER tables.

### Prerequisites
This lab assumes you have:
- Basic knowledge of Oracle Database
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- You have completed:
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup
    - Lab: Initialize Environment

## Task 1: Creating Constraints
This step describes how to create the following constraints:

  * Age Constraint
  * Reference Constraint

Creating an age constraints consists in adding a data validity condition on a column. To create the age constraint:

1. In the Models accordion in Designer Navigator, expand the *Orders Application* model.
2. Expand the SRC\_CUSTOMER datastore.
3. Right-click the Constraints node and select **New Condition**

    ![](./images/insert_new_condition.png)  

4. In the Definition tab of the Condition Editor:
    * In the Name field, enter the name of your condition. For example: AGE \> 21.
    * From the Type list, select **Oracle Data Integrator Condition**.
    * In the Where clause field, enter the following SQL code: SRC\_CUSTOMER.AGE \> 21
    * In the Message field, specify the error message as it will appear in your error table:

    **Note:** You can enter this text directly in the Where clause field or you can use the Expression Editor. To open the Expression Editor click **Launch the expression editor** in the Where clause toolbar menu. The constraints created by Oracle Data Integrator are not actually created on the database. The constraints are stored in the ODI Repository.

    ```
    Customer Age is not over 21
    ```

    ![](./images/condition_editor.png)

5.  From the File main menu, select **Save** to save the condition.


## **Appendix:** Data Integrity Control
Oracle Data Integrator provides a working environment to detect constraint violations and to store them for recycling or reporting purposes. There are two different types of controls: *Static Control* and *Flow Control*.

1. Static Control

Static Control implies the existence of rules that are used to verify the integrity of your application data. Some of these rules (referred to as constraints) may already be implemented in your data servers (using primary keys, reference constraints, etc.)
With Oracle Data Integrator, you can enhance the quality of your data by defining and checking additional constraints, without declaring them directly in your servers. This procedure is called **Static Control** since it allows you to perform checks directly on existing, *static*, data.

2. Flow Control
The information systems targeted by transformation and integration processes often implement their own declarative rules. The **Flow Control** function is used to verify an application's incoming data according to these constraints before loading the data into these targets. The flow control procedure is detailed in the *Mapping* lab.

3. Benefits
The main advantages of performing data integrity checks are the following:

  * *Increased productivity* by using the target database for its entire life cycle. Business rule violations in the data slow down application programming throughout the target database's life-cycle. Cleaning the transferred data can therefore reduce application programming time.
  * *Validation of the target database's model*. The rule violations detected do not always imply insufficient source data integrity. They may reveal a degree of incompleteness in the target model. Migrating the data before an application is rewritten makes it possible to validate a new data model while providing a test database in line with reality.
  * *Improved quality of service* for the end-users. Ensuring data integrity is not always a simple task. Indeed, it requires that any data violating declarative rules must be isolated and recycled. This implies the development of complex programming, in particular when the target database incorporates a mechanism for verifying integrity constraints. In terms of operational constraints, it is most efficient to implement a method for correcting erroneous data (on the source, target, or recycled flows) and then to reuse this method throughout the enterprise.

4. SRC\_CUSTOMER Control Example
This example guides you through the data integrity audit process (Static Control).
The *Orders Application* contains data that does not satisfy business rule constraints on a number of different levels. The objective is to determine which data in this application does not satisfy the constraints imposed by the information system.

You may now [proceed to the next lab](#next).

## Learn More
- [Oracle Data Integrator](https://docs.oracle.com/en/middleware/fusion-middleware/data-integrator/index.html)

## Acknowledgements

- **Author** - Narayanan Ramakrishnan, December 2020
- **Contributors** - Srivishnu Gullapalli
- **Last Updated By/Date** - Rene Fontcha, LiveLabs Platform Lead, NA Technology, January 2021
