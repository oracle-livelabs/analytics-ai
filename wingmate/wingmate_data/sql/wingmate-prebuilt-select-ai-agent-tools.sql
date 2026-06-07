rem ============================================================================
rem NAME
rem   wingmate-prebuilt-select-ai-agent-tools.sql
rem
rem DESCRIPTION
rem   SQLcl/SQL*Plus convenience installer for the Oracle pre-built Select AI
rem   Agent tool layers used by Wingmate. This wrapper uses @@ relative
rem   includes, so it is not the recommended path for SQL Developer Web.
rem
rem   1. OCI Autonomous Database AI Agent and Tools
rem   2. Select AI - DBMS Scheduler Monitoring Agent
rem
rem   Run this script as ADMIN from the wingmate_data/sql directory only when
rem   using SQLcl or SQL*Plus. It delegates to the vendored Oracle sample
rem   scripts in prebuilt-select-ai-agents/.
rem
rem   For SQL Developer Web, open SQL Worksheet as ADMIN and run these two
rem   scripts manually in the same order. Provide SCHEMA_NAME=WINGMATE:
rem     prebuilt-select-ai-agents/oci_autonomous_database_tools.sql
rem     prebuilt-select-ai-agents/dbms_scheduler_monitor_tools.sql
rem
rem PARAMETERS TO EDIT
rem   CONFIG_JSON: Optional OCI Autonomous Database tool configuration.
rem     WINGMATE_OCI_CRED is created by wingmate-select-ai-profiles.sql. Add
rem     "compartment_ocid":"<target_compartment_ocid>" if you want the OCI ADB
rem     tools to persist a default compartment.
rem ============================================================================

SET DEFINE ON
SET VERIFY OFF
SET SERVEROUTPUT ON

PROMPT Installing Wingmate pre-built Select AI Agent tool layers into WINGMATE.

DEFINE SCHEMA_NAME = WINGMATE
DEFINE CONFIG_JSON = {"credential_name":"WINGMATE_OCI_CRED","use_resource_principal":false}
@@prebuilt-select-ai-agents/oci_autonomous_database_tools.sql

DEFINE SCHEMA_NAME = WINGMATE
@@prebuilt-select-ai-agents/dbms_scheduler_monitor_tools.sql

ALTER SESSION SET CURRENT_SCHEMA = ADMIN;

PROMPT Wingmate pre-built Select AI Agent tool layers installed.
