# Connecting ODA to Slack as a New Application

## Introduction

In this lab, we will learn how to connect Oracle Digital Assistant (ODA) to Slack as a new application. This involves creating a Slack app, configuring OAuth scopes, adding the app to a Slack workspace, and creating a channel in ODA to interact with Slack.

Estimated Time: 30 minutes

### Objectives

In this lab, you will:
- Get a Slack workspace.
- Create a Slack app.
- Add OAuth scopes for the Slack app.
- Add the app to the Slack workspace.
- Create a channel in Oracle Digital Assistant.
- Configure the Webhook URL in the Slack app.
- Test your bot in Slack.

### Prerequisites

This lab assumes you have:
- Access to a Slack workspace with permissions to create a Slack app.
- An Oracle Digital Assistant instance.

## Task 1: Get a Slack Workspace

To make your digital assistant (or standalone bot) available in Slack, you need to have a Slack workspace where you have the necessary permissions to create a Slack app.

If you don't have such a workspace, you can create your own. See Slack's [Create a new workspace](https://slack.com/create) page.

## Task 2: Create a Slack App

1. Go to Slack's [Your Apps](https://api.slack.com/apps) page.
2. Click **Create a Slack App**.
3. In the **Create a Slack App** dialog, fill in the **App Name** and **Development Slack Workspace** fields, and click **Create App**.

    Once the app is created, its Basic Information page appears.

4. Scroll down to the **App Credentials** section and note the values of the **Client ID**, **Client Secret**, and **Signing Secret**.

    You will need these credentials when you set up the channel in Oracle Digital Assistant.

## Task 3: Add OAuth Scopes for the Slack App

You add OAuth scopes for permissions that you want to give to the bot and to the user.

1. In the left navigation of the web console for your Slack app, within the **Features** section, select **OAuth and Permissions**.
2. Scroll to the **Scopes** section of the page.
3. The scopes fall into these categories:
    - **Bot Token Scopes**
    - **User Token Scopes**
4. In the **Bot Token Scopes** section, add the scopes that correspond to the bot-level permissions you want to allow. At minimum, the following bot token scopes are required:
    - `chat:write`
    - `im:history`
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

## Task 5: Create a Channel in Oracle Digital Assistant

1. In Oracle Digital Assistant, click **Channels** in the left menu and then choose **Users**.
2. Click **+ Channel** to open the **Create Channel** dialog.
3. Give your channel a name.
4. Choose **Slack** as the channel type.
5. Fill in the values for **Client ID**, **Client Secret**, and **Signing Secret** that you obtained when you created your Slack app.

    You can retrieve these values from the Settings page of your Slack app.

6. If you are setting up the channel for group chats and you want messages to go to the group without mentioning the Slack app name, select **Allow Messages Without App Mention in Group Chat**.
7. Click **Create**.
8. In the Channels page, copy the WebHook URL and paste it somewhere convenient on your system. You’ll need this to finish setting up the Slack app.
9. Click the ![Route To ... dropdown icon](./media/image1.png) and select the digital assistant or skill that you want to associate with the channel.
10. In the **Route To** dropdown, select the digital assistant or skill that you want to associate with the channel.
11. Switch on the **Channel Enabled** control.

## Task 6: Configure the Webhook URL in the Slack App

1. In the left navigation of the web console for your Slack app, select **Interactivity & Shortcuts**.
2. Turn the **Interactivity** switch ON.
3. In both the **Request URL** and **Options Load URL** fields, paste the webhook URL that was generated when you created the channel in Oracle Digital Assistant.
4. Click **Save Changes**.
5. In the left navigation, select **OAuth & Permissions**.
6. In the **Redirect URLs** field, click **Add New Redirect URL**.
7. Paste the webhook URL, append `/authorizeV2`, and click **Add**.
8. Click **Save URLs**.
9. In the left navigation, select **App Home**.
10. In the **Your App’s Presence in Slack** section, turn on the **Always Show My Bot as Online** switch.
11. Scroll down the page to the **Show Tabs** section, and turn the **Messages Tab** switch on.
12. Select the **Allow users to send Slash commands and messages from the messages tab** checkbox.
13. In the left navigation, select **Event Subscriptions**.
14. Set the **Enable Events** switch to ON.
15. In the **Request URL** field, paste the webhook URL.

    After you enter the URL, a green **Verified** label should appear next to the Request URL label.

16. Expand the **Subscribe to bot events** section of the page, click **Add Bot User Event**, and add the following event:
    - `message.im`

    If you plan to make the bot available in [group chats](https://docs.oracle.com/en/cloud/paas/digital-assistant/use-chatbot/group-chats.html#GUID-5C38EC0E-1D13-4BE0-BB92-735C9B53C097), also add the following events:
    - `app_mention`
    - `message.mpim`
    - `message.channels`

17. Click **Save Changes**.
18. In the left navigation, select **Manage Distribution**.
19. Click the **Add to Slack** button and then click **Allow**.

    At this point, you should get the message **You've successfully installed your App in Slack**.

## Task 7: Test Your Bot in Slack

With the Slack channel and messaging configuration complete, you can test your bot (digital assistant or skill) in Slack.

1. Open the Slack workspace where you have installed the app.
2. In the left navigation bar, select the app that is associated with your digital assistant.
3. In the **Message** field, enter text to start communicating with the digital assistant.

## Learn More

- [Oracle Digital Assistant Documentation](https://docs.oracle.com/en/cloud/paas/digital-assistant/index.html)
- [Slack API Documentation](https://api.slack.com/start)

## Acknowledgements

**Author** - Anshuman Panda, Principal Generative AI Specialist, Alexandru Negrea
, AI and App Integration Specialist Leader
