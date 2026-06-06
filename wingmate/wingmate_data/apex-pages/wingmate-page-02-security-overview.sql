prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX page export
--
-- OCI Wingmate Security page.
--
-- Import this page into the Ask Oracle application created in Lab 2. This export
-- removes and recreates only page 2.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.15'
,p_default_workspace_id=>7947436985061273
,p_default_application_id=>100
,p_default_id_offset=>7965832120953223
,p_default_owner=>'WKSP_TEST'
);
end;
/

prompt APPLICATION 100 - OCI Wingmate Security Page
--
-- Application Export:
--   Application:     100
--   Name:            OCI Wingmate Security Page
--   Export Type:     Page Export
--   Manifest
--     PAGE: 2
--   Manifest End
--   Version:         24.2.15
--

begin
null;
end;
/

prompt --application/pages/delete_00002
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>2);
end;
/

prompt --application/pages/page_00002
begin
wwv_flow_imp_page.create_page(
 p_id=>2
,p_name=>'Security Overview'
,p_alias=>'SECURITY-OVERVIEW'
,p_step_title=>'Security Overview'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'11'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(20824458804569019)
,p_plug_name=>'Security Overview'
,p_region_template_options=>'#DEFAULT#'
,p_plug_display_sequence=>10
,p_location=>null
,p_plug_source=>'Security Wingmate framework page. Use this page for OCI IAM posture, policy analysis, Cloud Guard findings, CIS checks, and security recommendations.'
,p_plug_query_num_rows=>15
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'Y')).to_clob
);
end;
/

prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
