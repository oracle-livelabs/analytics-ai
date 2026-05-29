# Lab 3: Build a Security Wingmate Agent

## Introduction
This lab walks you through setting up the Security Wingmate Agent page for the APEX application. You will chat with your Wingmate about identity and access management policies.

Estimated Time: 10 minutes

### Objectives

In this lab, you will:
* Configure Select AI for the `CIS_IAM_POLICIES` table
* Configure the imported Security Overview page
* Connect the page to the OCI Generative AI service created in Lab 2
* Test the app's chat feature

### Prerequisites

This lab assumes you have the following:

* Completed Labs 1 and 2
* Access to the `WINGMATE` APEX application
* Imported `OCI Wingmate` framework application from Lab 2
* `OCI_GENAI` Generative AI service object created in APEX
* `CIS_IAM_POLICIES` loaded in the `WINGMATE` schema
* Some SQL knowledge is preferred but not necessary

## Task 1: Configure Select AI for Security Policy Data

> **SME Gate:** Confirm the final Select AI provider attributes, compartment ID, model, table list, wrapper function, imported page ID, APEX page layout, region names, dynamic action settings, assistant prompt, welcome message, prompt examples, screenshots, and expected validation responses.

1. Navigate to **SQL Workshop** and select **SQL Commands**.

2. Confirm the `CIS_IAM_POLICIES` table has rows.

	```sql
	<copy>
	SELECT SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA') AS current_schema
	FROM dual;

	SELECT COUNT(*) AS iam_policy_rows
	FROM cis_iam_policies;
	</copy>
	```

	> **Note:** Keep the `CURRENT_SCHEMA` value. You will use it as the table owner in the Select AI profile. In some APEX workspaces this value is `WINGMATE`; in others it may be `WKSP_WINGMATE`.

3. Confirm Select AI package access.

	```sql
	<copy>
	SELECT table_name, privilege
	FROM all_tab_privs
	WHERE table_name = 'DBMS_CLOUD_AI';
	</copy>
	```

	> **Note:** If no row is returned, ask the database administrator to grant `EXECUTE` on `DBMS_CLOUD_AI` to the schema shown in Step 2.

4. Create a database credential for Select AI using the OCI API key values from Lab 2.

	```sql
	<copy>
	BEGIN
	    DBMS_CLOUD.CREATE_CREDENTIAL(
	        credential_name => 'GENAI_CRED',
	        user_ocid       => '<oci_user_ocid>',
	        tenancy_ocid    => '<oci_tenancy_ocid>',
	        private_key     => '<private_key_contents>',
	        fingerprint     => '<api_key_fingerprint>'
	    );
	END;
	/
	</copy>
	```

5. Create a Select AI profile that can see the security policy table.

	```sql
	<copy>
	BEGIN
	    DBMS_CLOUD_AI.CREATE_PROFILE(
	        profile_name => 'WINGMATE_SECURITY',
	        attributes   => '{
	            "provider": "oci",
	            "credential_name": "GENAI_CRED",
	            "object_list": [
	                {"owner": "<current_schema>", "name": "CIS_IAM_POLICIES"}
	            ],
	            "oci_compartment_id": "<compartment_ocid>",
	            "region": "<region-identifier>",
	            "model": "xai.grok-4"
	        }'
	    );
	END;
	/
	</copy>
	```

	> **Note:** Replace `<current_schema>` with the schema value returned in Step 2. If your tenancy requires an OCI Generative AI endpoint OCID or a different model value for Select AI, add the approved provider attributes before creating the profile.

6. Test Select AI directly.

	```sql
	<copy>
	SELECT DBMS_CLOUD_AI.GENERATE(
	           prompt       => 'How many IAM policies are loaded in CIS_IAM_POLICIES?',
	           profile_name => 'WINGMATE_SECURITY',
	           action       => 'narrate'
	       ) AS response
	FROM dual;
	</copy>
	```

7. Create a wrapper function for the APEX page to call from a page item computation.

	```sql
	<copy>
	CREATE OR REPLACE FUNCTION security_wingmate_selectai (
	    p_prompt IN CLOB
	) RETURN CLOB
	AUTHID DEFINER
	AS
	    l_response CLOB;
	BEGIN
	    l_response := DBMS_CLOUD_AI.GENERATE(
	        prompt       => p_prompt,
	        profile_name => 'WINGMATE_SECURITY',
	        action       => 'narrate'
	    );

	    RETURN l_response;
	END;
	/
	</copy>
	```

## Task 2: Configure the Security Overview Page

1. In App Builder, open the imported **OCI Wingmate** application.

2. Open the imported **Security Overview** page.

	![security page button](./images/nav-secure.png "")

3. Right-click **Body** on the application tree to the left and select **Create Region**.

	![create region button](./images/create-region.png "")

4. On the right side panel under Identification for the region, enter the name **WingmateChat**.

	![name wingmatechat region](./images/name-region-wingmate.png "")

5. With the **WingmateChat** region selected, set the region **Static ID** to `wingmate-chat`.

	> **Note:** The Static ID creates a CSS target for the inline chat. The AI Assistant action will use `#wingmate-chat` as the container selector.

	![name wingmatechat static id](./images/static-id.png "")

6. Right-click **Security Overview** in the Rendering tree and select **Create Page Item**.

7. Configure the page item:

	* **Name:** `P2_SECURITY_POLICY_CONTEXT`
	* **Type:** `Hidden`
	* **Value Protected:** `Off`

8. Right-click `P2_SECURITY_POLICY_CONTEXT` and select **Create Computation**.

9. Configure the computation:

	* **Type:** `Expression`
	* **Language:** `PL/SQL`
	* **PL/SQL Expression:**

		```sql
		<copy>
		security_wingmate_selectai(
		    'Summarize the IAM policy data in CIS_IAM_POLICIES. Include the total policy count, the main groups or principals, broad permissions such as manage or all-resources, and any policy statements that deserve review.'
		)
		</copy>
		```

10. In the center of the App Builder, select the **Buttons** menu, and drag and drop the **text button** to the Region Body of WingmateChat region.

	![create page button](./images/startwingmatebutton.png "")

11. Name the button on the right panel **StartWingmate**.

	![name the page button](./images/name-wingmate-button.png "")

12. Right-click the new button and select **Create Dynamic Action**.

	![left menu for button and dynamic action](./images/dynamic-startwingmate-button.png "")

13. Name the dynamic action **Chat**.

	![Name dynamic action](./images/chat-action.png "")

14. Select the **True** Action on the left panel.

	![Select true action](./images/select-show.png "")
	
15. Select **Show AI Assistant** on the right panel. Select the source to match the `OCI_GENAI` service from Lab 2. Paste the following in the **System Prompt**:

	```
	<copy>
	You are OCI Security Wingmate, an assistant for OCI identity and access management policy review. Use the Select AI-generated policy context below as your source of truth. Be concise, explain policy impact, and call out missing data instead of guessing.

	Select AI policy context:
	&P2_SECURITY_POLICY_CONTEXT.
	</copy>
	```

	Under **Appearance**, use these values:

	* **Display As:** `Inline`
	* **Container Selector:** `#wingmate-chat`

	Under **Initial Prompt**, use this value:

	* **Type:** `None`

	Under **Prompt Suggestions**, add these messages:

	* `How many IAM policies are loaded?`
	* `Which policies grant broad access?`
	* `Which groups or principals have manage permissions?`
	* `Summarize the policies by resource type.`

	![true action description](./images/show-genai.png "")

16. Right-click **Show AI Assistant** on the left panel and click **Create Action**.

	![Create action button](./images/create-action.png "")

17. Select **Hide** for the Action, and under affected elements, select **Button** and **Start Wingmate** for the object.

	![Hide Action Button](./images/hidden-action.png "")

	* **Note:** Untoggle the **Fire on Initialization** button in the execution field below.

18. Save the work done and view the page by clicking the **Green Run Button** on the top right of the screen.

	![Save and Run button](./images/save-and-run.png "")

## Task 3: Test the App's Chat Feature

1. On the Security Overview page, select **Start Wingmate Chat**.

	![Start Wingmate button](./images/start-wingmate-chat.png "")

2. Select the first prompt **How many IAM policies are loaded?**.

	![Prompt button in chat](./images/use-prompt.png "")

3. Ask a follow-up question:

	```text
	<copy>Which policies grant broad access?</copy>
	```

4. If the assistant says it cannot see policy data, rerun the Select AI test query from Task 1 and confirm the wrapper function returns a response. Then confirm `P2_SECURITY_POLICY_CONTEXT` has a computation and is referenced in the AI Assistant system prompt.

You may now **proceed to the next lab**.

## Acknowledgements

* **Authors:**
	* Nicholas Cusato - Cloud Architect
	* Royce Fu - Master Principal Cloud Architect
* **Last Updated by/Date** - Royce Fu, May 2026
