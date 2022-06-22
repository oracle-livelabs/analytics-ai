# Starting the web application

## Introduction

This lab explains the steps to deploy the UI access, that aready exists in your jupyter notebook to predict first 5 drivers for a given race. So this lab is just to explain what these files and their functions are doing to and for our model.      

Estimated Time: 60 minutes

### Objectives

In this lab, you will:
* See the results from the lab 

### Prerequisites

* An Oracle Free Tier, Always Free, Paid or LiveLabs Cloud Account


## **Task 1**: Let's see the results

To see the results of the lab, you'll need to start the web server using Terminal.

1. In the menu at the top of the page, select ```File->New->Terminal```.

  
2. Enter the following commands, hitting return after each one (feel free to copy and paste)

    ```
    cd /home/opc/redbull-analytics-hol/beginners/web
    source /home/opc/redbullenv/bin/activate
    python3 app.py

    ```

3. Open a web browser to the public IP of your Jupyter Lab, but use port 8443 instead of port 8001:

  ```https://xxx.xxx.xxx.xxx:8443```

Congratulations! You have completed this workshop!


## Acknowledgements
* **Author** - Olivier Francois Xavier Perard , Principal Data Scientist
* **Last Updated By/Date** - Samrat Khosla, Advanced Data Services, September 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
