# Get started - register Free Tier account

## Introduction

Before you get started, you will need an Oracle Cloud account. This lab walks you through the steps of getting an Oracle Cloud Free Tier account and signing in.

Estimated Time: 5 minutes

### Existing Cloud Accounts

If you already have access to an Oracle Cloud account, skip to **Task 2** to sign in to your cloud tenancy.

### Objectives

- Create an Oracle Cloud Free Tier account
- Sign in to your account

### Prerequisites

* A valid email address
* Ability to receive SMS text verification (only if your email isn't recognized)

> **Note**: Interfaces in the following screenshots may look different from the interfaces you will see.

## Task 1: Create Your Free Trial Account

If you already have a cloud account, skip to **Task 2**.

1. Open up a web browser to access the Oracle Cloud account registration form at [oracle.com/cloud/free](https://signup.cloud.oracle.com).

   You will be presented with a registration page.
   ![Registration](https://oracle-livelabs.github.io/common/labs/cloud-login/images/cloud-infrastructure.png " ")
2.  Enter the following information to create your Oracle Cloud Free Tier account.
    * Choose your **Country**
    * Enter your **Name** and **Email**
    * Use hCaptcha to verify your identity

3. Once you have entered a valid email address, select the **Verify my email** button.
   The screen will appear as follows after you select the button:
   ![Verify Email](https://oracle-livelabs.github.io/common/labs/cloud-login/images/verify-email.png " ")

4. Go to your email. You will see an account validation email from Oracle in your inbox. The email will be similar to the following:
   ![Verification Mail](https://oracle-livelabs.github.io/common/labs/cloud-login/images/verification-mail.png " ")

5. Click **Verify email**.

6. Enter the following information to create your Oracle Cloud Free Tier account.
    - Choose a **Password**
    - Enter your **Company Name**
    - Your **Cloud Account Name** will generate automatically based on your inputs. You can change that name by entering a new value. Remember what you wrote. You'll need this name later to sign in.
    - Choose a **Home Region**.  Your Home Region cannot be changed once you sign-up.
    >**Note:** Based on the current design of the workshop and resource availability, it is recommended not to use the London region for this workshop at this time.

    - Click **Continue**
    ![Account Info](https://oracle-livelabs.github.io/common/labs/cloud-login/images/account-info.png " ")

7.  Enter your address information. Choose your country and enter a phone number. Click **Continue**.
    ![Free Tier Address](https://oracle-livelabs.github.io/common/labs/cloud-login/images/free-tier-address.png " ")

8. Click the **Add payment verification method** button.
   ![Payment Verification](https://oracle-livelabs.github.io/common/labs/cloud-login/images/free-tier-payment-1.png " ")

9. Choose the verification method. In this case, click the **Credit Card** button. Enter your information and payment details.

   >**Note:** This is a free credit promotion account. You will not be charged unless you elect to upgrade the account.

   ![Credit Card](https://oracle-livelabs.github.io/common/labs/cloud-login/images/free-tier-payment-2.png " ")

10. Once your payment verification is complete, review and accept the agreement by clicking the check box.  Click the **Start my free trial** button.

    ![Start Free Trial](https://oracle-livelabs.github.io/common/labs/cloud-login/images/free-tier-agreement.png " ")

11. Your account is provisioning and should be available soon! You might want to log out as you wait for your account to be provisioned. You'll receive an email from Oracle notifying you that provisioning is complete, with your cloud account and username.

## Task 2: Sign in to Your Account

*Please note that while your tenancy is initially created, you will only see a direct login. Once your tenancy is fully provisioned, you will see the screens as described below.*

1. Go to [cloud.oracle.com](https://cloud.oracle.com). Enter your Cloud Account Name and click **Next**. This is the name you chose while creating your account in the previous section. It's NOT your email address. If you've forgotten the name, see the confirmation email.

   ![Oracle Cloud](https://oracle-livelabs.github.io/common/labs/cloud-login/images/cloud-oracle.png " ")

2. Click **Continue** to sign in using the *"oraclecloudidentityservice"*.

   ![Sign In](https://oracle-livelabs.github.io/common/labs/cloud-login/images/cloud-login-tenant-single-sigon.png " ")

   When you sign up for an Oracle Cloud account, a user is created for you in Oracle Identity Cloud Service with the username and password you selected. You can use this single sign-on option to sign in to Oracle Cloud Infrastructure and then navigate to other Oracle Cloud services without re-authenticating. This user has administrator privileges for all the Oracle Cloud services included with your account.

3. Enter your Cloud Account credentials and click **Sign In**. Your username is your email address. The password is what you chose when you signed up for an account.

   ![Username and Password](https://oracle-livelabs.github.io/common/labs/cloud-login/images/oci-signin-single-signon.png " ")

4. You are now signed in to Oracle Cloud!

   ![OCI Console Home Page](https://oracle-livelabs.github.io/common/images/console/home-page.png " ")

You may now **proceed to the next lab**.

## **Acknowledgements**

- **Created By/Date** - Kay Malcolm, Database Product Management, Database Product Management, March 2020
- **Contributors** - John Peach, Kamryn Vinson, Rene Fontcha, Arabella Yao
- **Last Updated By** - Arabella Yao, Product Manager, Database Product Management, Dec 2022
