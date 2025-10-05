# Confiure Slack as a New Application

## Introduction

In this lab, we will learn how to configure Slack as a new application. This involves creating a Slack app, configuring OAuth scopes, adding the app to a Slack workspace.

Estimated Time: 20 minutes

### Objectives

In this lab, you will:

- Get a Slack workspace.
- Create a Slack app.
- Add OAuth scopes for the Slack app.
- Add the app to the Slack workspace.
- Update Environment Variable file

### Prerequisites

This lab assumes you have:

- Access to a Slack workspace with permissions to create a Slack app.

## Task 1: Get a Slack Workspace

To make your digital assistant (or standalone bot) available in Slack, you need to have a Slack workspace where you have the necessary permissions to create a Slack app.

If you don't have such a workspace, you can create your own. See Slack's [Create a new workspace](https://slack.com/create) page.

## Task 2: Create a Slack App

1. Go to Slack's [Your Apps](https://api.slack.com/apps) page.
2. Click **Create a Slack App**.
3. In the **Create a Slack App** dialog, fill in the **App Name** and **Development Slack Workspace** fields, and click **Create App**.

    Once the app is created, its Basic Information page appears.
4. Turning On **Socket Mode** will route  app interactions and events over a WebSockets connection instead of sending these payloads to Request URLs.

## Task 3: Add OAuth Scopes for the Slack App

You add OAuth scopes for permissions that you want to give to the bot and to the user.

1. In the left navigation of the web console for your Slack app, within the **Features** section, select **OAuth and Permissions**.
2. Scroll to the **Scopes** section of the page.
3. The scopes fall into these categories:
    - **Bot Token Scopes**
    - **User Token Scopes**
4. In the **Bot Token Scopes** section, add the scopes that correspond to the bot-level permissions you want to allow. At minimum, the following bot token scopes are required:
    - `app_mentions:read`
    - `channels:history`
    - `channels:read`
    - `chat:write`
    - `groups:history`
    - `im:history`
    - `mpim:history`
    - `users:read`

    Depending on the skill's features, other scopes might be required. For example, the following scopes are required for working with attachments:
    - `files:read`
    - `files:write`

5. In the **User Token Scopes** section, add the scopes that correspond to the user-level permissions you want to allow. The following user token scopes are required:
    - `files:read`
    - `files:write`

    Depending on the requirements of your bot, you may need to add other scopes.

## Task 4: Add the App to the Workspace

1. Scroll back to the top of the **OAuth & Permissions** page.
2. Within the **OAuth Tokens & Redirect URLs** section, click **Install to Workspace**.

    A page will appear showing what the app will be able to do.

3. At the bottom of the page, click **Allow**.

    Once you have completed this step, you should be able to see the app in your Slack workspace by selecting **Apps** in the left navigation.
4. Notedown **Slack tokens**
   **SLACK_APP_TOKEN**: Go to settings, select Basic Information, choose App-level tokens and click on token Name and copy it.
   **SLACK_BOT_TOKEN**: Go to **OAuth & Permissions****OAuth & Permissions** and copy OAuth Token

## Task 5: Update Environment Variable File

In Lab 6, we have created Envrionment Variable file. Update this file with **SLACK_APP_TOKEN** and **SLACK_BOT_TOKEN**.
Download latest python script with Slack configuration.
[slack_app.py](https://c4u04.objectstorage.us-ashburn-1.oci.customer-oci.com/p/EcTjWk2IuZPZeNnD_fYMcgUhdNDIDA6rt9gaFj_WZMiL7VvxPBNMY60837hu5hga/n/c4u04/b/livelabsfiles/o/labfiles%2Fslack_app.py)

## Learn More

- [Slack API Documentation](https://api.slack.com/start)

## Acknowledgements

- **Author**
    **Nikhil Verma**, Principal Cloud Architect, NACIE
