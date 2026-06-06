prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.16'
,p_default_workspace_id=>17845167991262488
,p_default_application_id=>1000
,p_default_id_offset=>17946563308379859
,p_default_owner=>'WINGMATE'
);
end;
/

prompt APPLICATION 1000 - OCI Wingmate
--
-- Application Export:
--   Application:     1000
--   Name:            OCI Wingmate
--   Exported By:     WINGMATE
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 12
--   Manifest End
--   Version:         24.2.16
--   Instance ID:     8644960393976696
--

begin
null;
end;
/
prompt --application/pages/delete_00012
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>12);
end;
/
prompt --application/pages/page_00012
begin
wwv_flow_imp_page.create_page(
 p_id=>12
,p_name=>'Security Overview'
,p_alias=>'SECURITY-OVERVIEW1'
,p_step_title=>'Security Overview'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'18'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(36760508396506707)
,p_plug_name=>'WingmateChat'
,p_region_name=>'wingmate-chat'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(36100791615263634)
,p_plug_display_sequence=>20
,p_location=>null
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37277515163505816)
,p_plug_name=>'Identity and Access Management'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(36090917581263609)
,p_plug_display_sequence=>30
,p_query_type=>'TABLE'
,p_query_table=>'CIS_IAM_POLICIES_COPY'
,p_include_rowid_column=>false
,p_plug_source_type=>'NATIVE_IR'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(37277605786505817)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>'Y'
,p_owner=>'WINGMATE'
,p_internal_uid=>37277605786505817
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37277715866505818)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37277864065505819)
,p_db_column_name=>'NAME'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37277958693505820)
,p_db_column_name=>'DEEP_LINK'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Deep Link'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37278051124505821)
,p_db_column_name=>'COMPARTMENT_ID'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Compartment Id'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37278139643505822)
,p_db_column_name=>'DESCRIPTION'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Description'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37278236066505823)
,p_db_column_name=>'LIFECYCLE_STATE'
,p_display_order=>60
,p_column_identifier=>'F'
,p_column_label=>'Lifecycle State'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37278324613505824)
,p_db_column_name=>'STATMENTS'
,p_display_order=>70
,p_column_identifier=>'G'
,p_column_label=>'Statments'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(37278394317505825)
,p_db_column_name=>'EXTRACT_DATE'
,p_display_order=>80
,p_column_identifier=>'H'
,p_column_label=>'Extract Date'
,p_column_type=>'DATE'
,p_heading_alignment=>'LEFT'
,p_tz_dependent=>'N'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(37595462144760972)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'187972'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ID:NAME:DEEP_LINK:COMPARTMENT_ID:DESCRIPTION:LIFECYCLE_STATE:STATMENTS:EXTRACT_DATE'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(57569310300886373)
,p_plug_name=>'Security Overview'
,p_icon_css_classes=>'fa-padlock'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(36077464572263574)
,p_plug_display_sequence=>10
,p_location=>null
,p_plug_source=>'Security Wingmate framework page. Use this page for OCI IAM posture, policy analysis, Cloud Guard findings, CIS checks, and security recommendations.'
,p_plug_query_num_rows=>15
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(18799251756937532)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(36760508396506707)
,p_button_name=>'StartWingmate'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(36174336092263855)
,p_button_image_alt=>'Start Wingmate'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(18803139889937570)
,p_name=>'Chat'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(18799251756937532)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(18803677438937572)
,p_event_id=>wwv_flow_imp.id(18803139889937570)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_AI_ASSISTANT'
,p_attribute_01=>'INLINE'
,p_attribute_03=>'#wingmate-chat'
,p_attribute_14=>'How many policies do I have in my OCI tenancy?'
,p_attribute_15=>'Do I have any duplicate policy statements across policies? '
-- Select the target app's wingmate_security_rag AI Configuration after import.
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(18804184198937575)
,p_event_id=>wwv_flow_imp.id(18803139889937570)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_imp.id(18799251756937532)
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
