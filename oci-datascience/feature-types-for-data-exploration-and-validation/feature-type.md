# Feature Type Tutorial

## Introduction

There is a distinction between the data type of a feature and the nature of the data that it represents. The data type represents the form of the data that the computer understands. ADS uses the term "feature type" to refer to the nature of the data. For example, a medical record id could be represented as an integer, its data type, but the feature type would be "medical record id". The feature type represents the data in the way the data scientist understands it. ADS provides the feature type module on top of your Pandas dataframes and series to manage and use the typing information to better understand your data.

The feature type framework comes with some common feature types. However, the power of using feature types is that you can easily create your own and apply them to your specific data. You don't need to try to represent your data in a synthetic way that does not match the nature of your data. This framework allows you to create methods that validate whether the data fits the specifications of your organization. For example, for a medical record type, you could create methods to validate that the data is properly formatted. You can also have the system generate warnings to sure the data is valid as a whole or create graphs for summary plots.

The framework allows you to create and assign multiple feature types. For example, a medical record id could also have a feature type id and the integer feature type.

The feature type system allows data scientists to separate the concept of how data is represented physically from what the data actually measures. That is, the data can have feature types that classify the data based on what it represents and not how the data is stored in memory. Each set of data can have multiple feature types through a system of multiple inheritances. As a concrete example, an organization that sells cars might have a set of data that represents the purchase price of a car, that is the wholesale price. You could have a feature set of ``wholesale_price``, ``car_price``, ``USD``, and ``continuous``.

All default feature types have methods for creating summary statistics and a plot to represent the data. This allows you to have summary information for each feature of your dataset while only using a single command. However, the default feature types may not provide the exact details needed in your specific use case. Therefore, feature types have been designed with expandability in mind. When creating a new feature type, the summary statistics and plots that are specific to your feature type can be customized.

The feature type system works at the Pandas dataframe and series levels. This allows you to create summary information across all of your data and at the same time dig into the specifics of one feature.

The ``.feature_count()`` method returns a dataframe that provides a summary of the number of features in a dataframe. Each row represents a feature type. It provides a count of the number of times that feature type is used in the dataframe. It also provides a count of the number of times that the feature type was the primary feature type. The primary feature type is the feature type that has no children feature types.

The ``.feature_stat()`` method returns a dataframe where each row represents a summary statistic and the numerical value for that statistic.

The ``.feature_plot()`` method returns a Seaborn plot object that summarizes the feature. It can be modified after it is returned so that you can customize it to fit your needs.

There are also a number of correlation methods such as ``.correlation_ratio()``, ``.pearson()``, and ``.cramersv()`` that provide information about the correlation between different features in the form of a dataframe. Each row represents a single correlation metic. This information can also be represented in a plot with the ``.correlation_ratio_plot()``, ``.pearson_plot()``, and ``.cramersv_plot()`` methods.

Feature type warnings are used for rapid validation of the data. For example, the ``wholesale_price`` might have a method that ensures that the value is a positive number because you can't purchase a car with negative money. The ``car_price`` feature type may have a check to ensure that it is within a reasonable price range. ``USD`` can check the value to make sure that it represents a valid US dollar amount. It can't have values below one cent. The ``continuous`` feature type is the default feature type and it represents the way the data is stored internally.

The feature type validators are a set of ``is_*`` methods, where ``*`` is generally the name of the feature type. For example, the method ``.is_wholesale_price()`` can create a boolean Pandas series that indicates what values meet the validation criteria. It allows you to quickly identify which values need to be filtered or require future examination into problems in the data pipeline. The feature type validators can be as complex as they need to be. For example, they might take a client ID and call an API to validate that each client ID is active.

The feature type manager provides the tools to manage the handlers that are used to drive this system. The system works by creating functions that are then registered as feature type validators or warnings. The role of ``feature_type_manager`` is to provide the interface to manage these handlers.

A feature type has the following attributes that can be overridden:

- ``description``: A description of the feature type.
- ``name``: The name of the feature type.

If you wish to create custom summary statistics for a feature type, then override the ``.feature_stat()`` method. To create a custom summary plot, override the ``.feature_plot()`` method.

In this lab, you will learn how to use Feature Types to improve your exploratory data analysis (EDA) by generating meaningful statistics, graphs, counting, and producing correlation metrics. You will also learn about the Feature Type Warning system that allows you to use built-in warnings and create custom warnings to check the overall proprieties of a feature. The Feature Type Validator system is discussed in detail. This system allows you to write custom validation rules that empower you to rapidly confirm that your data is clean and meets the assumptions of your models. The multiple inheritance system will be discussed and you create a custom feature type.

*Estimated Time*: 90 minutes

### Objectives

In this lab, you will:
* Learn how to execute cells in JupyterLab and perform other basic operations in a notebook.
* Learn about the difference between how Python stores your data and how it is represented as a Feature Type.
* Assign multiple inheritances to features.
* Select columns from a dataframe based on the feature type.
* Perform common operations in an EDA such as counting, creating summary statistics, understanding relationships between covariants using correlations, and plotting the data.
* Use Feature Type Warnings to validate that an entire feature conforms to your assumptions.
* Create custom Feature Type Warnings and add them to a Feature Type.
* Use Feature Type Validators to confirm that each metric is valid. You will use default as well as create custom validators.
* Extend the usefulness of validators by using open and closed conditions
* Create a custom feature type class.

### Prerequisites

This lab assumes that you have:
* A Data Science notebook session.

## Task 1: Working with JupyterLab

Now that JupyterLab is open, it can be seen that the screen is split into two sections. By default, the left side has the file browser open but it can change based on what navigation icons are selected on the far left side of the screen. The right side of the screen contains the workspace. It will have a notebook, terminal, console, launcher, Notebook Examples, etc.

![Notebook session](./../feature-types-for-data-exploration-and-validation/images/notebook-session.png)

There is a menu across the top of the screen. For this lab, the most interesting menu item is **Run**. It will allow you to execute code cells in the document. It is recommended that you manually execute the cells one at a time as you progress through the notebook. It is, generally important, that you execute them in order. To do this from the keyboard, press *shift + enter* in a cell and it will execute it and advance to the next cell. Alternatively, you can run all of the cells at once. To do this, click on Run then "Run Selected Cells".

## Task 2: Summary of Commands

The following is a summary of the steps that are covered in this lab along with the most important Python commands. You can use it as a reference guide for when you build your own feature types.

1. **List registered feature types**: ``feature_type_manager.feature_type_registered()``
1. **Define a feature type on a series**: ``series.ads.feature_type = ['credit_card', 'string']``
1. **Description of feature types on a series**: ``series.ads.feature_type_description``
1. **List of feature types on a series**: ``series.ads.feature_type``
1. **Obtain a feature type object**: ``object = feature_type_manager.feature_type_object('string')``
1. **Define feature types on a dataframe**: ``df.ads.feature_type = {'Attrition': ['boolean', 'category'], 'JobFunction': ['category']}``
1. **Default feature type on a series**: ``series.ads.default_type``
1. **Default feature type on a dataframe**: ``df.ads.default_type``
1. **Create a tag feature type**: ``Tag('North American')``
1. **Select columns based on feature type**: ``df.ads.feature_select(include=['continous'], exclude=['USD'])``
1. **Count features types in a dataframe**: ``df.ads.feature_count()``
1. **Summary statistics on a series**: ``series.ads.feature_stat()``
1. **Register a feature type class**: ``feature_type_manager.feature_type_register(MyFeatureType)``
1. **Summary statistics on a dataframe**: ``df.ads.feature_stat()``
1. **Pearson correlation table**: ``df.ads.pearson()``
1. **Pearson correlation heat map**: ``df.ads.pearson_plot()``
1. **Correlation ratio table**: ``df.ads.correlation_ratio()``
1. **Correlation ratio heat map**: ``df.ads.correlation_ratio_plot()``
1. **Cramér's V table**: ``df.ads.cramersv()``
1. **Cramér's V heat map**: ``df.ads.cramersv_plot()``
1. **Feature plot on a series**: ``series.ads.feature_plot()``
1. **Feature plot on a dataframe**: ``df.ads.feature_plot()``
1. **List registered feature type warnings**: ``feature_type_manager.warning_registered()``
1. **Feature type warnings on a series**: ``series.ads.warning()``
1. **Feature type warnings on a dataframe**: ``df.ads.warning()``
1. **Feature type warnings on a feature type object**: ``MyFeatureTypeObject.warning.registered()``
1. **Register a feature type warning**: ``MyFeatureTypeObject.warning.register(name="warning_name", handler=my_handler)``
1. **Unregister a feature type warning**: ``MyFeatureTypeObject.warning.unregister('warning_name')``
1. **Feature type warnings registered on a dataframe**: ``df.ads.warning_registered()``
1. **List registered feature type validators**: ``feature_type_manager.validator_registered()``
1. **List feature type validators on a feature type object**: ``MyFeatureTypeObject.validator.registered()``
1. **List feature type validators on a series**: ``series.ads.validator_registered()``
1. **List feature type validators on a dataframe**: ``df.ads.validator_registered()``
1. **Default validation on a series**: ``series.ads.validator.is_credit_card()``
1. **Default validation on a series using a feature type object**: ``MyFeatureTypeObject.validator.is_credit_card(series)``
1. **Register a default feature type validator**: ``MyFeatureTypeObject.validator.register(name='is_visa_card', handler=is_visa_card_handler)``
1. **Register a closed value condition feature type validator**: ``MyFeatureTypeObject.validator.register(name='is_credit_card', condition={'card_type': 'Visa'}, handler=is_visa_card_handler)``
1. **Closed validation on a series**: ``series.ads.validator.is_credit_card(card_type="Visa")``
1. **Closed validation on a series using a feature type object**: ``MyFeatureTypeObject.validator.is_credit_card(series, card_type="Visa")``
1. **Register an open value condition feature type validator**: ``MyFeatureTypeOject.validator.register(name='is_credit_card', condition=('card_type',), handler=is_any_card_handler)``
1. **Open validation on a series**: ``series.ads.validator.is_credit_card(card_type="Mastercard")``
1. **Open validation on a series using a feature type object**: ``MyFeatureTypeObject.validator.is_credit_card(series, card_type="Mastercard")``
1. **Unregister a closed feature type validator**: ``MyFeatureTypeObject.validator.unregister(name="is_credit_card", condition = {"card_type": "Visa"})``
1. **Unregister an open feature type validator**: ``MyFeatureTypeObject.validator.unregister(name="is_credit_card", condition = ("card_type",))``
1. **Unregister a default feature type validator**: ``MyFeatureTypeObject.validator.unregister(name="is_visa_card")``
1. **Name attribute on a feature type**: ``MyFeatureTypeObject.name``
1. **Description attribute on a feature type**: ``MyFeatureTypeObject.description``

## Task 3: Install a Conda Environment

A conda environment is a collection of libraries, programs, components and metadata. It defines a reproducible set of libraries that are used in the data science environment. There is an Environment Explore that allows you to learn about the different conda environments that are available. We are going to use the Data Exploration and Manipulation for CPU Python 3.7.

1. Open a terminal window by clicking on **File**, **New** and then **Terminal**.
1. Run the command: `odsc conda install -s dataexpl_p37_cpu_v3`
1. You will receive a prompt related to what version number you want. Press `Enter` to select the default.
1. Wait for the conda environment to be installed.

## Task 4: Download Notebook

1. Open a terminal window by clicking on **File**, **New** and then **Terminal**.
1. Run the command `wget https://raw.githubusercontent.com/oracle-samples/oci-data-science-ai-samples/master/labs/feature-types-for-data-exploration-and-validation/feature_type_tutorial.ipynb`

## Task 5: Feature Type Tutorial Notebook

1. Use the File Browser to locate the ``feature_type_tutorial.ipynb``.
1. Open the notebook by clicking on it.
1. If you are asked for a kernel choose `dataexpl_p37_cpu_v3`
1. Read through the document. When you encounter a chunk of code, click in the cell and press *shift + enter* to execute it. When the cell is running a ``[*]`` will appear in the top left corner of the cell. When it is finished, a number will appear in ``[ ]``, for example ``[1]``.

![Running-cell has an asterisk ](./../common/images/running-cell.png)

![Executed shell has a number in it](./../common/images/jlab-executed-cell.png)

1. Execute the cells in order. If you run into problems and want to start over again, click the **restart** button then click **Restart**.
![Restart](./../common/images/restart-kernel-button.png)

![Restart kernel](./../common/images/restart-kernel-confirmation.png)

1. Step through the lab and look at the tools that are provided by the feature type module in the Oracle Accelerated Data Science (ADS) SDK. This automates a number of time-consuming and repetitive processes. Validate your data and quickly explore it, with minimal code.

## Task 6: Next Steps

There are some other notebooks that you may find interesting. They can be accessed by clicking **File** and then clicking **New Launcher**. This will open Launcher. Click **Notebook Examples** and select a notebook and then click **Load Example**. Some notebooks of interest are:

* **visual\_genome.ipynb**: Explore the Visual Genome dataset that is provided by Oracle Open Data.
* **data\_visualizations.ipynb**: It provides a comprehensive overview of the data visualization tools in ADS. This includes smart data visualization for columns based on data types and values.
* **transforming\_data.ipynb**: Learn about the ``ADSDatasetFactory`` and how it can clean and transform data.

You may now **proceed to the next lab**.

## Acknowledgements

* **Author**: [John Peach](https://www.linkedin.com/in/jpeach/), Principal Data Scientist
* **Last Updated By/Date**:
  * [John Peach](https://www.linkedin.com/in/jpeach/), Principal Data Scientist, April 2022
