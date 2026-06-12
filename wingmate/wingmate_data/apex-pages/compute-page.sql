--------------------------------------------------------------------------------
-- Copyright © 2025, Oracle and/or its affiliates. All rights reserved.
--------------------------------------------------------------------------------
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
,p_default_application_id=>107
,p_default_id_offset=>18490018078026509
,p_default_owner=>'WINGMATE'
);
end;
/
 
prompt APPLICATION 107 - Ask Oracle
--
-- Application Export:
--   Application:     107
--   Name:            Ask Oracle
--   Exported By:     WINGMATE
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 14
--   Manifest End
--   Version:         24.2.16
--   Instance ID:     8644960393976696
--

begin
null;
end;
/
prompt --application/pages/delete_00014
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>14);
end;
/
prompt --application/pages/page_00014
begin
wwv_flow_imp_page.create_page(
 p_id=>14
,p_name=>'Compute Wingmate'
,p_alias=>'COMPUTE-WINGMATE1'
,p_step_title=>'Compute Wingmate'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(19432495199405421)
,p_plug_name=>' CPU and Memory Usage Trend'
,p_title=>'Memory Usage Trend'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_imp.id(189979725895435051)
,p_plug_display_sequence=>80
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(19432528455405422)
,p_region_id=>wwv_flow_imp.id(19432495199405421)
,p_chart_type=>'line'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_connect_nulls=>'Y'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_time_axis_type=>'auto'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(19432684609405423)
,p_chart_id=>wwv_flow_imp.id(19432528455405422)
,p_seq=>10
,p_name=>'Memory'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT collection_time,',
'       instance_name,',
'       cpu_utilization_pct,',
'       memory_utilization_pct',
'FROM oci_compute_metrics',
'WHERE collection_time >= (',
'    SELECT MAX(collection_time) - INTERVAL ''24'' HOUR',
'    FROM oci_compute_metrics',
')',
'ORDER BY collection_time;'))
,p_series_name_column_name=>'INSTANCE_NAME'
,p_items_value_column_name=>'MEMORY_UTILIZATION_PCT'
,p_items_label_column_name=>'COLLECTION_TIME'
,p_items_short_desc_column_name=>'INSTANCE_NAME'
,p_line_style=>'dotted'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(19432714092405424)
,p_chart_id=>wwv_flow_imp.id(19432528455405422)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(19432892100405425)
,p_chart_id=>wwv_flow_imp.id(19432528455405422)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(56597881812176526)
,p_name=>'ComputeOverview'
,p_title=>'Compute Overview'
,p_template=>wwv_flow_imp.id(189958308536435032)
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT *',
'FROM compute_wingmate_overlay_v'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(190039431624435101)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38124029028608238)
,p_query_column_id=>1
,p_column_alias=>'AGENT_CONFIG_ARE_ALL_PLUGINS_DISABLED'
,p_column_display_sequence=>10
,p_column_heading=>'Agent Config Are All Plugins Disabled'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38124455472608241)
,p_query_column_id=>2
,p_column_alias=>'AGENT_CONFIG_IS_MANAGEMENT_DISABLED'
,p_column_display_sequence=>20
,p_column_heading=>'Agent Config Is Management Disabled'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38124897825608241)
,p_query_column_id=>3
,p_column_alias=>'AGENT_CONFIG_IS_MONITORING_DISABLED'
,p_column_display_sequence=>30
,p_column_heading=>'Agent Config Is Monitoring Disabled'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38125237407608242)
,p_query_column_id=>4
,p_column_alias=>'AGENT_CONFIG_PLUGINS_CONFIG'
,p_column_display_sequence=>40
,p_column_heading=>'Agent Config Plugins Config'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38125684399608243)
,p_query_column_id=>5
,p_column_alias=>'AVAILABILITY_CONFIG_IS_LIVE_MIGRATION_PREFERRED'
,p_column_display_sequence=>50
,p_column_heading=>'Availability Config Is Live Migration Preferred'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38126117198608243)
,p_query_column_id=>6
,p_column_alias=>'AVAILABILITY_CONFIG_RECOVERY_ACTION'
,p_column_display_sequence=>60
,p_column_heading=>'Availability Config Recovery Action'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38126515459608244)
,p_query_column_id=>7
,p_column_alias=>'AVAILABILITY_DOMAIN'
,p_column_display_sequence=>70
,p_column_heading=>'Availability Domain'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38126902756608244)
,p_query_column_id=>8
,p_column_alias=>'CAPACITY_RESERVATION_ID'
,p_column_display_sequence=>80
,p_column_heading=>'Capacity Reservation Id'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38127282956608245)
,p_query_column_id=>9
,p_column_alias=>'OCIRA_COMPARTMENT_KEY'
,p_column_display_sequence=>90
,p_column_heading=>'Ocira Compartment Key'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38127667713608245)
,p_query_column_id=>10
,p_column_alias=>'COMPARTMENT_ID'
,p_column_display_sequence=>100
,p_column_heading=>'Compartment Id'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38128067031608246)
,p_query_column_id=>11
,p_column_alias=>'DEDICATED_VM_HOST_ID'
,p_column_display_sequence=>110
,p_column_heading=>'Dedicated Vm Host Id'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38128464162608246)
,p_query_column_id=>12
,p_column_alias=>'DISPLAY_NAME'
,p_column_display_sequence=>120
,p_column_heading=>'Display Name'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38128888998608247)
,p_query_column_id=>13
,p_column_alias=>'FAULT_DOMAIN'
,p_column_display_sequence=>130
,p_column_heading=>'Fault Domain'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38129249598608247)
,p_query_column_id=>14
,p_column_alias=>'OCIRA_INSTANCE_KEY'
,p_column_display_sequence=>140
,p_column_heading=>'Ocira Instance Key'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38129676093608248)
,p_query_column_id=>15
,p_column_alias=>'ID'
,p_column_display_sequence=>150
,p_column_heading=>'Id'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38130060531608248)
,p_query_column_id=>16
,p_column_alias=>'OCIRA_IMAGE_KEY'
,p_column_display_sequence=>160
,p_column_heading=>'Ocira Image Key'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38130487544608249)
,p_query_column_id=>17
,p_column_alias=>'IMAGE_ID'
,p_column_display_sequence=>170
,p_column_heading=>'Image Id'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38130824944608249)
,p_query_column_id=>18
,p_column_alias=>'LAUNCH_OPTIONS_BOOT_VOLUME_TYPE'
,p_column_display_sequence=>180
,p_column_heading=>'Launch Options Boot Volume Type'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38131290850608250)
,p_query_column_id=>19
,p_column_alias=>'LAUNCH_OPTIONS_FIRMWARE'
,p_column_display_sequence=>190
,p_column_heading=>'Launch Options Firmware'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38131644713608251)
,p_query_column_id=>20
,p_column_alias=>'LAUNCH_OPTIONS_IS_CONSISTENT_VOLUME_NAMING_ENABLED'
,p_column_display_sequence=>200
,p_column_heading=>'Launch Options Is Consistent Volume Naming Enabled'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38132091285608251)
,p_query_column_id=>21
,p_column_alias=>'LAUNCH_OPTIONS_NETWORK_TYPE'
,p_column_display_sequence=>210
,p_column_heading=>'Launch Options Network Type'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38132430536608252)
,p_query_column_id=>22
,p_column_alias=>'LAUNCH_OPTIONS_REMOTE_DATA_VOLUME_TYPE'
,p_column_display_sequence=>220
,p_column_heading=>'Launch Options Remote Data Volume Type'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38132855202608253)
,p_query_column_id=>23
,p_column_alias=>'LIFECYCLE_STATE'
,p_column_display_sequence=>230
,p_column_heading=>'Lifecycle State'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38133295522608254)
,p_query_column_id=>24
,p_column_alias=>'PLATFORM_CONFIG_IS_MEASURED_BOOT_ENABLED'
,p_column_display_sequence=>240
,p_column_heading=>'Platform Config Is Measured Boot Enabled'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38133630871608254)
,p_query_column_id=>25
,p_column_alias=>'PLATFORM_CONFIG_IS_SECURE_BOOT_ENABLED'
,p_column_display_sequence=>250
,p_column_heading=>'Platform Config Is Secure Boot Enabled'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38134072043608255)
,p_query_column_id=>26
,p_column_alias=>'PLATFORM_CONFIG_IS_TRUSTED_PLATFORM_MODULE_ENABLED'
,p_column_display_sequence=>260
,p_column_heading=>'Platform Config Is Trusted Platform Module Enabled'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38134485018608256)
,p_query_column_id=>27
,p_column_alias=>'PLATFORM_CONFIG_TYPE'
,p_column_display_sequence=>270
,p_column_heading=>'Platform Config Type'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38134901034608256)
,p_query_column_id=>28
,p_column_alias=>'REGION'
,p_column_display_sequence=>280
,p_column_heading=>'Region'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38135138748608257)
,p_query_column_id=>29
,p_column_alias=>'SHAPE'
,p_column_display_sequence=>290
,p_column_heading=>'Shape'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38135575909608257)
,p_query_column_id=>30
,p_column_alias=>'SHAPE_CONFIG_BASELINE_OCPU_UTILIZATION'
,p_column_display_sequence=>300
,p_column_heading=>'Shape Config Baseline Ocpu Utilization'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38136004590608258)
,p_query_column_id=>31
,p_column_alias=>'SHAPE_CONFIG_GPUS'
,p_column_display_sequence=>310
,p_column_heading=>'Shape Config Gpus'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38136380956608258)
,p_query_column_id=>32
,p_column_alias=>'SHAPE_CONFIG_LOCAL_DISKS'
,p_column_display_sequence=>320
,p_column_heading=>'Shape Config Local Disks'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38136743797608259)
,p_query_column_id=>33
,p_column_alias=>'SHAPE_CONFIG_LOCAL_DISKS_TOTAL_SIZE_IN_GBS'
,p_column_display_sequence=>330
,p_column_heading=>'Shape Config Local Disks Total Size In Gbs'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38137155604608260)
,p_query_column_id=>34
,p_column_alias=>'SHAPE_CONFIG_MEMORY_IN_GBS'
,p_column_display_sequence=>340
,p_column_heading=>'Shape Config Memory In Gbs'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38137576123608260)
,p_query_column_id=>35
,p_column_alias=>'SHAPE_CONFIG_OCPUS'
,p_column_display_sequence=>350
,p_column_heading=>'Shape Config Ocpus'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38137919513608261)
,p_query_column_id=>36
,p_column_alias=>'TIME_CREATED'
,p_column_display_sequence=>360
,p_column_heading=>'Time Created'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38138321872608261)
,p_query_column_id=>37
,p_column_alias=>'TIME_MAINTENANCE_REBOOT_DUE'
,p_column_display_sequence=>370
,p_column_heading=>'Time Maintenance Reboot Due'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38138783535608262)
,p_query_column_id=>38
,p_column_alias=>'RESOURCE_URL'
,p_column_display_sequence=>380
,p_column_heading=>'Resource Url'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38139187671608262)
,p_query_column_id=>39
,p_column_alias=>'OCIRA_UPDATE_DATE'
,p_column_display_sequence=>390
,p_column_heading=>'Ocira Update Date'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38139525674608263)
,p_query_column_id=>40
,p_column_alias=>'OCIRA_END_DATE'
,p_column_display_sequence=>400
,p_column_heading=>'Ocira End Date'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38139933675608263)
,p_query_column_id=>41
,p_column_alias=>'COLLECTION_TIME'
,p_column_display_sequence=>410
,p_column_heading=>'Collection Time'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38140362429608264)
,p_query_column_id=>42
,p_column_alias=>'CPU_ALLOCATED_OCPUS'
,p_column_display_sequence=>420
,p_column_heading=>'Cpu Allocated Ocpus'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38140793559608264)
,p_query_column_id=>43
,p_column_alias=>'MEMORY_ALLOCATED_GBS'
,p_column_display_sequence=>430
,p_column_heading=>'Memory Allocated Gbs'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38141189256608265)
,p_query_column_id=>44
,p_column_alias=>'CPU_UTILIZATION_PCT'
,p_column_display_sequence=>440
,p_column_heading=>'Cpu Utilization Pct'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38141555781608265)
,p_query_column_id=>45
,p_column_alias=>'CPU_UTILIZATION_PCT_P95'
,p_column_display_sequence=>450
,p_column_heading=>'Cpu Utilization Pct P95'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38142014098608266)
,p_query_column_id=>46
,p_column_alias=>'CPU_UTILIZATION_PCT_P99'
,p_column_display_sequence=>460
,p_column_heading=>'Cpu Utilization Pct P99'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38142367511608267)
,p_query_column_id=>47
,p_column_alias=>'MEMORY_UTILIZATION_PCT'
,p_column_display_sequence=>470
,p_column_heading=>'Memory Utilization Pct'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38142756232608267)
,p_query_column_id=>48
,p_column_alias=>'MEMORY_UTILIZATION_PCT_P95'
,p_column_display_sequence=>480
,p_column_heading=>'Memory Utilization Pct P95'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38143211948608268)
,p_query_column_id=>49
,p_column_alias=>'MEMORY_UTILIZATION_PCT_P99'
,p_column_display_sequence=>490
,p_column_heading=>'Memory Utilization Pct P99'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38143552102608269)
,p_query_column_id=>50
,p_column_alias=>'CPU_USAGE_OCPUS'
,p_column_display_sequence=>500
,p_column_heading=>'Cpu Usage Ocpus'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(38143946293608270)
,p_query_column_id=>51
,p_column_alias=>'MEMORY_USED_GBS'
,p_column_display_sequence=>510
,p_column_heading=>'Memory Used Gbs'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(57465882228324528)
,p_plug_name=>'CPU Utilization by Instance'
,p_title=>'CPU Utilization by Instance'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_imp.id(189979725895435051)
,p_plug_display_sequence=>50
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(38144813127608273)
,p_region_id=>wwv_flow_imp.id(57465882228324528)
,p_chart_type=>'bar'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>false
,p_show_row=>false
,p_show_start=>false
,p_show_end=>false
,p_show_progress=>false
,p_show_baseline=>false
,p_legend_rendered=>'off'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>false
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(38146422674608276)
,p_chart_id=>wwv_flow_imp.id(38144813127608273)
,p_seq=>10
,p_name=>'New'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT instance_name,',
'       cpu_utilization_pct',
'FROM compute_metrics_latest_v',
'WHERE cpu_utilization_pct IS NOT NULL',
'ORDER BY cpu_utilization_pct DESC'))
,p_items_value_column_name=>'CPU_UTILIZATION_PCT'
,p_items_label_column_name=>'INSTANCE_NAME'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(38145225294608274)
,p_chart_id=>wwv_flow_imp.id(38144813127608273)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(38145886421608275)
,p_chart_id=>wwv_flow_imp.id(38144813127608273)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(57484203506400283)
,p_plug_name=>'Memory Utilization by Instance'
,p_title=>'Memory Utilization by Instance'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_imp.id(189979725895435051)
,p_plug_display_sequence=>60
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(38118034142608222)
,p_region_id=>wwv_flow_imp.id(57484203506400283)
,p_chart_type=>'bar'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_stack_label=>'off'
,p_connect_nulls=>'Y'
,p_value_position=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>false
,p_show_row=>false
,p_show_start=>false
,p_show_end=>false
,p_show_progress=>false
,p_show_baseline=>false
,p_legend_rendered=>'off'
,p_legend_position=>'auto'
,p_overview_rendered=>'off'
,p_horizontal_grid=>'auto'
,p_vertical_grid=>'auto'
,p_gauge_orientation=>'circular'
,p_gauge_plot_area=>'on'
,p_show_gauge_value=>false
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(38119760314608226)
,p_chart_id=>wwv_flow_imp.id(38118034142608222)
,p_seq=>10
,p_name=>'New'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT instance_name,',
'       memory_utilization_pct',
'FROM compute_metrics_latest_v',
'WHERE memory_utilization_pct IS NOT NULL',
'ORDER BY memory_utilization_pct DESC'))
,p_items_value_column_name=>'MEMORY_UTILIZATION_PCT'
,p_items_label_column_name=>'INSTANCE_NAME'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
,p_items_label_display_as=>'PERCENT'
,p_threshold_display=>'onIndicator'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(38118593556608223)
,p_chart_id=>wwv_flow_imp.id(38118034142608222)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(38119142960608224)
,p_chart_id=>wwv_flow_imp.id(38118034142608222)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(57484771424400288)
,p_plug_name=>' CPU and Memory Usage Trend'
,p_title=>'CPU Usage Trend'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_imp.id(189979725895435051)
,p_plug_display_sequence=>70
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(38120805313608230)
,p_region_id=>wwv_flow_imp.id(57484771424400288)
,p_chart_type=>'line'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'off'
,p_connect_nulls=>'Y'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_time_axis_type=>'auto'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(38123055215608233)
,p_chart_id=>wwv_flow_imp.id(38120805313608230)
,p_seq=>10
,p_name=>'CPU'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT collection_time,',
'       instance_name,',
'       cpu_utilization_pct,',
'       memory_utilization_pct',
'FROM oci_compute_metrics',
'WHERE collection_time >= (',
'    SELECT MAX(collection_time) - INTERVAL ''24'' HOUR',
'    FROM oci_compute_metrics',
')',
'ORDER BY collection_time;'))
,p_series_name_column_name=>'INSTANCE_NAME'
,p_items_value_column_name=>'CPU_UTILIZATION_PCT'
,p_items_label_column_name=>'COLLECTION_TIME'
,p_items_short_desc_column_name=>'INSTANCE_NAME'
,p_line_style=>'dotted'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(38121297542608230)
,p_chart_id=>wwv_flow_imp.id(38120805313608230)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_format_scaling=>'auto'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_tick_label_rotation=>'auto'
,p_tick_label_position=>'outside'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(38121889430608231)
,p_chart_id=>wwv_flow_imp.id(38120805313608230)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_format_type=>'decimal'
,p_decimal_places=>0
,p_format_scaling=>'none'
,p_scaling=>'linear'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'on'
,p_minor_tick_rendered=>'off'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>false
,p_zoom_order_weeks=>false
,p_zoom_order_months=>false
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(57485301097400294)
,p_plug_name=>'Wingmate Chat'
,p_title=>'Wingmate Chat'
,p_region_name=>'wingmate-chat'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(189979725895435051)
,p_plug_display_sequence=>20
,p_location=>null
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(81077294751625180)
,p_plug_name=>'OCI Compute Wingmate'
,p_icon_css_classes=>'fa-hardware'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(189904809670434985)
,p_plug_display_sequence=>10
,p_location=>null
,p_plug_source=>'Compute Wingmate framework page. Use this page for OCI compute inventory, host insights, CPU and memory utilization, capacity planning, rightsizing, and performance recommendations.'
,p_plug_query_num_rows=>15
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(38117296462608214)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(57485301097400294)
,p_button_name=>'StartWingmate'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(190172219428435218)
,p_button_image_alt=>'Startwingmate'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(38147297518608284)
,p_name=>'ShowChat'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(38117296462608214)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38147752785608287)
,p_event_id=>wwv_flow_imp.id(38147297518608284)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'Compute Wingmate'
,p_action=>'NATIVE_OPEN_AI_ASSISTANT'
,p_attribute_01=>'INLINE'
,p_attribute_03=>'#wingmate-chat'
,p_attribute_14=>'Which compute instances have the highest CPU utilization?'
,p_attribute_15=>'Which compute instances look underutilized based on CPU and memory?'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(38148279258608289)
,p_event_id=>wwv_flow_imp.id(38147297518608284)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_imp.id(38117296462608214)
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
