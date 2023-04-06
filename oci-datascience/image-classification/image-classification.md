# Image Classification Model

## Introduction

Image classification with a machine learning model is the task of training a model with a set of images labeled in different classes and using the model to predict the label of an image the model has not encountered before.  It has many broad applications ranging from quality control for manufacturing to crop monitoring for precision agriculture. An important application is using machine learning models to classify medical images for disease diagnosis.  

In this lab, you’ll learn how to create your own deep learning model to diagnose pneumonia on chest x-ray images of patients. You’ll use Data Science notebook sessions to train a custom deep learning model and also use transfer learning to tune a pre-trained model on the x-ray images. You will learn how to deploy your model for consumption by third-party applications.

*Estimated Time*: 60 minutes

Watch the video below for a quick walk-through of the lab.
[Image Classification Model](videohub:1_awn9ur86)

### Objectives

In this lab, you will:

* Learn how to work with a JupyterLab notebook.
* Perform data exploration with Accelerated Data Science (ADS) SDK.
* Define a custom deep learning model and train the model.
* Apply transfer learning on a pre-trained model.
* Save a model to the Data Science model catalog.
* Deploy a model with Data Science model deployment.

### Prerequisites

This lab assumes that you have:
* A Data Science notebook session.
* A working knowledge of Python

## Task 1: Set up Conda Environment

1.  After you log into OCI Data Science and create a notebook, open the notebook.  Once inside, go to **File** and select **New Launcher**.  You will see the **Environment Explorer**. When you click on **Environment Explorer**, you will see a list of pre-built conda environments you can install. A conda environment is a collection of libraries, programs, components and metadata. It defines a reproducible set of libraries that are used in the data science environment.

    ![Conda Environment Explorer](images/conda-environment-explorer.png " ")

1.  For this lab, we are going to use the TensorFlow 2.8 for CPU on Python 3.8 conda v 1.0.  Scroll through the list of pre-built conda environments to find it.

    ![Tensorflow Conda](images/tensorflow-conda-expand-details.png " ")

1.  Under **Install**, copy the command and execute it in a terminal.  You can launch a new terminal by going to the Launcher and finding the icon for terminal.

    ![Tensorflow Conda](images/tensorflow-conda.png " ")

    ![Open Terminal](images/open-terminal.png " ")

1.  When prompted for the version number, press Enter.

## Task 2: Download Image Classification JupyterLab Notebook from Object Storage

1. To access the image classification JupyterLab notebook, we are going to clone the Oracle Data Science and AI repository.  Navigate to the Oracle Data Science and AI repository https://github.com/oracle-samples/oci-data-science-ai-samples/

1.  Click on **Code** and copy the link under **HTTPS**

    ![Copy repository link](./../common/images/copy-git-repo-link.png " ")

1.  Navigate to the git extension icon on the left and then click **Clone a Repository**.

    ![Open Git Extension](./../common/images/git-extension.png " ")

1.  Paste the HTTPS link and click **Clone**.  

    ![Clone Repository ](./../common/images/clone-repository.png " ")

1.  After you have cloned the repository, you will see the **oci\_data\_science\_ai\_samples** folder. Click on the folder.

    ![Navigate to directory](./../common/images/navigate-directory.png " ")

    * Click on the **labs** folder

    * Click on the **xray-diagnostics** folder

    * Click on the **notebooks** folder

    * Click on the file **ChestXrays\_Train.ipynb**

1.  After you have opened the notebook, select TensorFlow 2.8 for CPU on Python 3.8 conda.

![Select tensorflow conda](images/select-conda-environ.png " ")

1.  Go through the **ChestXrays\_Train.ipynb**.  You can run each cell in the JupyterLab notebook by clicking on it and pressing *shift + enter*. That will execute the cell and advance to the next cell. Or you can go to the `Run` tab and choose "Run Selected Cells".

You may now **proceed to the next lab**.

## References

For more information, please refer to our:

* [Service Documentation](https://docs.oracle.com/en-us/iaas/data-science/using/data-science.htm)
* [Keras Documentation](https://keras.io/)

## Acknowledgements

* **Author**: [Wendy Yip](https://www.linkedin.com/in/wendy-yip-a3990610/), Data Scientist
* **Last Updated By/Date**:
    * [Wendy Yip](https://www.linkedin.com/in/wendy-yip-a3990610/), Data Scientist, Jan 2023
