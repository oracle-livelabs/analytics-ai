# Lab 9: Consume Partner Data through Delta Sharing

## Introduction

Seer also receives governed data from organizations that do not share its database or cloud provider. In this optional lab, you will register a Delta Sharing provider, create an external table over a shared dataset, and combine partner data with ALH context.

**Estimated Time:** 20 minutes

### Objectives

In this lab, you will:

- Obtain and protect a Delta Sharing profile.
- Register a Delta Sharing provider in Data Studio.
- Link a shared table as an ALH external table.
- Query the shared data and relate it to the workshop's governance model.
- Review token, version, and compatibility considerations.

### Prerequisites

- Completion of Labs 1 through 8
- Browser permission to download and upload a Delta Sharing profile
- Outbound network access from ALH to the sharing provider

> **Optional-lab notice:** This first draft uses the public Delta Sharing examples. The provider and dataset will be live-tested before the lab is considered production-ready. Do not use an unverified public profile for sensitive data.

## Task 1: Obtain the public provider profile

1. Open the [Delta Sharing public examples](https://github.com/delta-io/delta-sharing/tree/main/examples).

2. Locate the `open-datasets.share` profile and download it to a secure local folder.

3. Do not open, paste, or capture the profile contents. A profile can contain an endpoint and bearer token and must be handled as a secret.

## Task 2: Enable and open Data Share

1. Sign in to the workshop ALH as `ADMIN`.

2. Open **Data Studio**, and then select **Data Share**.

3. Enable sharing for `ADMIN` if prompted. If Data Studio asks you to sign out after changing privileges, sign in again before continuing.

4. Select **Consume Share**.

## Task 3: Register the Delta Sharing provider

1. Select **Subscribe to Share Provider**, and then select **Delta Share Provider**.

2. Create a provider named `SEER_PARTNER_SHARE`.

3. Upload `open-datasets.share` as the provider JSON profile.

4. Select the available public share and complete the subscription.

5. If the provider cannot be reached or the profile has expired, stop this optional lab. Do not attempt to edit or manufacture a replacement bearer token.

## Task 4: Link a shared table

1. Continue to **Link Data** with the **Share** source selected.

2. Select `SEER_PARTNER_SHARE`, expand the available schemas, and choose a small tabular dataset such as the public Boston housing example.

3. Add it to the link cart and name the target `PARTNER_REFERENCE_EXT`.

4. Start the job, confirm the additional **Run** prompt, and wait for the link report to show success.

5. Preview the external table. The shared data remains governed by the provider and is accessed through the registered profile.

## Task 5: Query and assess the shared product

1. Return to SQL and inspect the table:

    ```sql
    <copy>
    SELECT *
    FROM partner_reference_ext
    FETCH FIRST 10 ROWS ONLY;
    </copy>
    ```

2. Evaluate whether a production partner share is ready for Seer's agents:

    - Is the provider accountable and approved?
    - Is the schema contract documented?
    - Does the profile use a renewable short-lived credential?
    - How are versions or provider changes communicated?
    - Does the shared table use Delta features supported by ALH?
    - What lineage and classification should be recorded locally?

3. Record the source as a partner reference product rather than representing it as Seer-owned Gold data.

## Task 6: Protect the profile

1. Delete the local downloaded profile after the lab if it is no longer needed.

2. Do not commit the profile to Git, attach it to support tickets, or include it in screenshots.

3. Remove the provider subscription during workshop cleanup.

## Lab 9 Recap

You consumed an open-protocol data share as an ALH external table and evaluated the additional trust, credential, compatibility, and lineage controls required before partner data can support applications or agents.

## Learn More

- [Consume a Delta Share](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/adp-consume-share.html)
- [Share and Consume Data with Data Share](https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/autonomous-data-share.html)

## Acknowledgements

- **Author:** Eli Schilling, Cloud Architect || Evangelist
- **Contributors:** Oracle LiveLabs and ONA Lab Experience Teams
- **Last Updated By / Date:** ONA Lab Experience team, July 2026
