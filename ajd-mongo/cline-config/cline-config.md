# Install Cline AI Assistant in VS Code

## Introduction

**Note:** This lab is optional. If you'd like to use Cline, an AI-powered software engineering assistant in Visual Studio Code (VS Code) for coding tasks, debugging, and more, follow these steps. Otherwise, skip to the next lab.

> **Estimated Time:** 15-30 minutes

---

### About Cline

Cline is a highly skilled AI software engineer with extensive knowledge in programming languages, frameworks, design patterns, and best practices. It can assist with tasks like writing code, editing files, executing commands, and integrating with various tools, all within VS Code.

---

### Objectives

In this lab, you will:
- Install the required VS Code extension for Cline
- Configure Cline with your own LLM (Large Language Model)
- Test the installation and basic functionality

---

### Prerequisites

This lab assumes you have:
* Visual Studio Code installed on your machine
* An account with an LLM provider (e.g., OpenAI, Anthropic) for API keys
* Basic familiarity with VS Code interfaces (helpful but not required)

---

## Task 1: Install VS Code Extension

1. Open Visual Studio Code.

2. Go to the Extensions view by clicking the Extensions icon in the Activity Bar on the side or pressing `Ctrl+Shift+X` (Windows/Linux) or `Cmd+Shift+X` (macOS).

3. Search for 'Cline' in the searchbox.

4. Click Install on the chosen extension.

![Install Extension](./images/cline-extension.png)  <!-- Placeholder; replace with actual image if available -->

## Task 2: Configure Cline

1. Once installed, open the extension settings. For Cline, this is accessible via the command palette (`Ctrl+Shift+P` or `Cmd+Shift+P`) by searching for "Cline".

![Focus on View](./images/focus-on-view.png)

2. Set up the extension to point to your preferred LLM model.

**Note** If cline is not appearing, try restarting the VS Code environment after install.

**Note: Configure Your Own LLM**  
To use Cline effectively, you'll need to set up your preferred Large Language Model (LLM) by providing API keys. This allows customization and avoids reliance on default or shared models.  
- **Choose an LLM Provider:** Popular options include OpenAI (e.g., GPT models), Anthropic (Claude), Google (Gemini), or open-source via Hugging Face. Select based on your needs for cost, performance, and features.  
- **Obtain API Keys:** Sign up for an account with your chosen provider (e.g., at platform.openai.com for OpenAI). Generate an API key from their dashboard – keep it secure and never share it.  
- **Configure in VS Code:** In the extension settings, find the LLM configuration section. Input your API key, select the model (e.g., "gpt-4o" or "claude-3.5-sonnet"), and test the connection. If using a proxy or custom endpoint, configure those as well.  
- **Helpful Tips:** Start with free tiers if available to test; monitor usage to avoid unexpected costs; refer to the provider's documentation for model-specific setup. If issues arise, check the extension's logs or community forums for troubleshooting. For advanced setups, consider editing the extension's config.json file directly.

3. Save the settings and restart VS Code if prompted.

## Task 3: Test the Installation

1. Open a code file in VS Code.

2. Activate Cline by using the extension's shortcut (or ctrl+shift+p, Cline: Focus on view).

3. Test with a simple query, like "Explain this code" or "Generate a function to sort an array."

4. Verify that Cline responds correctly using your configured LLM.

---

## Next Steps

With Cline installed, you can now use it for advanced coding tasks in your projects. Explore features like tool usage (e.g., reading/writing files, executing commands) and integrate it into your workflow. Refer to the extension's documentation for more advanced configurations.

---

## Acknowledgements

**Authors**  
* **Luke Farley**, Senior Cloud Engineer, NA Data Platform S&E

**Contributors**
* **Cline AI** 

**Last Updated By/Date:**  
* **Cline AI**, November 2025
