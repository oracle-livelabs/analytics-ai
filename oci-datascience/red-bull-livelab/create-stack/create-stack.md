# Create Stack using Resource Manager 

## Introduction

In this lab, we will walk you through the necessary steps to help you spin-up different resources, via Resource Manager, that you would need in order to complete this workshop.

Estimated Time: 60 minutes 

### Objectives

In this lab you will:

* Create Stack using Resource Manager

### Prerequisites

  This lab asssumes that you have completed all the previous labs. 

## **Task 1:** Create Stack

After creating your Oracle Cloud account, there is some infrastructure that must be deployed before you can enjoy this tutorial. 

1. Click the button below to begin the deploy of the Data Science stack and custom image:

  [![Alerts page](./images/deploy.jpeg " ")](https://cloud.oracle.com/resourcemanager/stacks/create?region=home&zipUrl=https://github.com/oracle-devrel/redbull-analytics-hol/releases/latest/download/redbull-analytics-hol-latest.zip)

2. If needed, log into your account. You should then be presented with the **Create Stack** page.

  These next few steps will deploy a stack to your OCI tenancy. This will include a Compute instance and the necessary tools to deploy and run JupyterLab from within your OCI account.

  Under _Stack Information_ (the first screen), check the box _I have reviewed and accept the Oracle Terms of Use_. Once that box is checked, the information for the stack will be populated automatically.

  ![Alerts Page](./images/rm-1.jpeg)

3. Click **Next** at the bottom of the screen. This will take you to the Configure Variables page. On this page you'll need to provide the SSH key we created in the prerequisites if you want SSH access to your Compute instance.

  ![Alerts Page](./images/rm-2.jpeg)

4. On the Review page, be sure _Run Apply_ is checked, and click **Create**.

  ![Alerts Page](./images/rm-3.jpeg)

5. This will take you to the **Job Details** page, and OCI will begin creating the stack and deploying the custom image for the lab. This will take about 11 minutes. When it completes (assuming everything went smoothly), the **Job Details** will show a bright green square with "Succeeded" below it.

  ![Alerts Page](./images/rm-4.jpeg)

6. Once the Create Stack job has succeeded, click the hamburger menu in the upper left, select **Compute** in the sidebar, and click **Instances** in the menu.

  ![Alerts Page](./images/rm-5.jpeg)

7. On the Instances screen, make sure "redbullhol" is selected under _Compartment_. If "redbullhol" isn't in the dropdown menu, you may need to refresh the page for the new compartment to show up.

  ![Alerts Page](./images/rm-6.jpeg)

8. Once the "redbullhol" compartment is selected, you should see a running Instance in the list. The address you'll need to access it is in the Public IP column. Copy the IP address shown.

  ![Alerts Page](./images/rm-7.jpeg)

9. Next, open a new tab in your browser to load up the web UI for JupyterLab. Paste the IP address you just copied with     ```:8888``` added to the end. The URL should look like ``` https://xxx.xxx.xxx.xxx:8888 ``` (substituting the public IP we   copied in the previous step). JupyterLab is running on port 8001, so when you navigate to this URL you should see the Juypter login.

  _Note: You should not be on VPN when opening JupyterLab_.

  ![Alerts Page](./images/rm-8.jpeg)

10. Retrieve the token to log in to the JupyterLab. For that, Open the PuTTY utility from the Windows start menu.

  ![Alerts Page](./images/red-bull-hol-10.jpeg)


11. In the **Host Name** (or IP address) dialog box, enter the Public IP address of your OCI Compute Instance. The Public IP of your instance should have been pasted in your text file.
  ![Alerts Page](./images/red-bull-hol-11.jpeg)


12. Under **Category**, expand **Connection** and then select the **Data** field. Enter **opc**. OCI instances will default to the username opc if they have Oracle Linux's Operating System installed.

  ![Alerts Page](./images/red-bull-hol-12.jpeg)

13. Under **Connection**, expand **SSH** and select the **Auth** category.

  ![Alerts Page](./images/red-bull-hol-13.jpeg)

14. Click on the **Browse** button and locate the private key file you created in the earlier step. Once selected, click **Open**.

  ![Alerts Page](./images/red-bull-hol-14.jpeg)

15. Now, click the **Open** button in PuTTY to initiate the SSH connection to your cloud instance.

  ![Alerts Page](./images/red-bull-hol-15.jpeg)


16. Click **Accept** to bypass the Security Alert about the uncached key.

  ![Alerts Page](./images/red-bull-hol-16.jpeg)

17. Connection successful. You are now securely connected to your OCI Cloud instance.

  ![Alerts Page](./images/red-bull-hol-17.jpeg)

18. Enter the following command: ``` pwd ```

  ![Alerts Page](./images/red-bull-hol-18.jpeg)

19. Enter the following command: ``` cd ./redbullenv/bin ```

  ![Alerts Page](./images/red-bull-hol-19.jpeg)

20. Enter the following command: ``` ./jupyter server list ```

  ![Alerts Page](./images/red-bull-hol-20.jpeg)

21. Once executed, **copy the token string** (token string appears within "**token**=" and "**:: /home/opc**") and paste it into your text file. We will need this token string to enter into the Jupyter notebook login screen.

  ![Alerts Page](./images/red-bull-hol-21.jpeg)

22. **Close** the PuTTY utility process.

  ![Alerts Page](./images/red-bull-hol-22.jpeg)

23. Next, open a new tab in your browser to load up the web UI for JupyterLab. Paste the **jupyter_url** you copied to your text file. The URL resembles ```https://xxx.xxx.xx.xx:8888 ``` (substituting the Public IP of your instance). JupyterLab is running on port 8888, so when you navigate to this URL you should see the Jupyter login.

*Note: it is recommended to be off any VPN when opening JupyterLab.*

  ![Alerts Page](./images/red-bull-hol-23.jpeg)

24. We can now use the token string to enter into the Jupyter notebook login screen. We can also set a password for the notebook so that in the future, we can use the password rather than a token authentication. Under the "**Setup a Password**" section, **paste** in the **token string** from your text file. Set the **New Password** to anything you want, like **Redbull1**. Then click **Log in and set new password**.

  ![Alerts Page](./images/red-bull-hol-24.jpeg)

25. You should now see the Jupyter Lab. Navigate in the sidebar to ```/redbull-analytics-hol/beginners/``` to see the Jupyter notebooks for this lab.

The notebooks are numbered and you'll progress through them in order. These will walk you through collecting and analyzing the data we'll use to predict some races.

You may now **proceed to the next lab**.

## Acknowledgements
* **Author** - Olivier Francois Xavier Perard , Principal Data Scientist
* **Last Updated By/Date** - Samrat Khosla, Advanced Data Services, September 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.
