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
--     PAGE: 13
--   Manifest End
--   Version:         24.2.16
--   Instance ID:     8644960393976696
--

begin
null;
end;
/
prompt --application/pages/delete_00013
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>13);
end;
/
prompt --application/pages/page_00013
begin
wwv_flow_imp_page.create_page(
 p_id=>13
,p_name=>'Multicloud Overview'
,p_alias=>'MULTICLOUD-OVERVIEW1'
,p_step_title=>'Multicloud Overview'
,p_autocomplete_on_off=>'OFF'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'03'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(19370821092792130)
,p_plug_name=>'MultiCloud Insights'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(36100791615263634)
,p_plug_display_sequence=>90
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT *',
'FROM GRAPH_TABLE(MULTICLOUD_GRAPH',
'    MATCH (a) -[e]-> (b)',
'    COLUMNS(',
'        vertex_id(a) AS aid,',
'        edge_id(e) AS eid,',
'        vertex_id(b) AS bid',
'    )',
')',
'FETCH FIRST 5 ROWS ONLY'))
,p_plug_source_type=>'PLUGIN_GRAPHVIZ'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'attribute_05', 'N',
  'attribute_07', 'NAME',
  'attribute_08', 'RELATIONSHIP_TYPE',
  'attribute_09', '40',
  'attribute_10', 'modes:exploration',
  'attribute_14', 'N',
  'attribute_16', '400',
  'bind_variable_pgql', 'N',
  'custom_theme', 'N',
  'darktheme', 'N',
  'default_legend_enabled', 'Y',
  'enable_evolution', 'N',
  'enable_expand', 'N',
  'escapehtml', 'N',
  'evolution_exclude_show', 'N',
  'evolution_preservepositions', 'N',
  'expand_direction', 'outbound',
  'force_clusterenabled', 'N',
  'force_hideunclusteredvertices', 'N',
  'geo_showinfo', 'Y',
  'geo_shownavigation', 'Y',
  'legend_state', 'expanded',
  'livesearch', 'N',
  'max_number_of_hops', '5',
  'number_of_hops', '1',
  'schema_visualization', 'N',
  'showtitle', 'Y',
  'visibility_toggle_mode', 'hideWhenAnyUnchecked')).to_clob
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(19372069813792142)
,p_name=>'AID'
,p_data_type=>'CLOB'
,p_is_visible=>true
,p_display_sequence=>10
,p_use_as_row_header=>false
,p_escape_on_http_output=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(19372163603792143)
,p_name=>'EID'
,p_data_type=>'CLOB'
,p_is_visible=>true
,p_display_sequence=>20
,p_use_as_row_header=>false
,p_escape_on_http_output=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(19372200279792144)
,p_name=>'BID'
,p_data_type=>'CLOB'
,p_is_visible=>true
,p_display_sequence=>30
,p_use_as_row_header=>false
,p_escape_on_http_output=>true
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37282869239462379)
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
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(37284424777462394)
,p_name=>'MultiCloud Insights'
,p_template=>wwv_flow_imp.id(36100791615263634)
,p_display_sequence=>130
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT *',
'FROM ra_multicloud_inventory_v'))
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(36137385917263737)
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
 p_id=>wwv_flow_imp.id(19336760639893270)
,p_query_column_id=>1
,p_column_alias=>'RESOURCE_TYPE'
,p_column_display_sequence=>10
,p_column_heading=>'Resource Type'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(19337186187893270)
,p_query_column_id=>2
,p_column_alias=>'RESOURCE_NAME'
,p_column_display_sequence=>20
,p_column_heading=>'Resource Name'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(19337590546893271)
,p_query_column_id=>3
,p_column_alias=>'REGION'
,p_column_display_sequence=>30
,p_column_heading=>'Region'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(19337968511893272)
,p_query_column_id=>4
,p_column_alias=>'COMPARTMENT'
,p_column_display_sequence=>40
,p_column_heading=>'Compartment'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(19338388882893272)
,p_query_column_id=>5
,p_column_alias=>'LIFECYCLE_STATE'
,p_column_display_sequence=>50
,p_column_heading=>'Lifecycle State'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(19338715057893273)
,p_query_column_id=>6
,p_column_alias=>'RESOURCE_SHAPE'
,p_column_display_sequence=>60
,p_column_heading=>'Resource Shape'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(19339191585893274)
,p_query_column_id=>7
,p_column_alias=>'RESOURCE_SUMMARY'
,p_column_display_sequence=>70
,p_column_heading=>'Resource Summary'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37285253257462402)
,p_plug_name=>'Host CPU Insights'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(36100791615263634)
,p_plug_display_sequence=>50
,p_plug_new_grid_row=>false
,p_location=>null
,p_plug_source_type=>'NATIVE_HELP_TEXT'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37285887442462409)
,p_plug_name=>'HOST INSIGHTS Metrics'
,p_parent_plug_id=>wwv_flow_imp.id(37285253257462402)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(36100791615263634)
,p_plug_display_sequence=>10
,p_location=>null
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37286025219462410)
,p_plug_name=>'CPU Usage over Capacity'
,p_parent_plug_id=>wwv_flow_imp.id(37285887442462409)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_imp.id(36100791615263634)
,p_plug_display_sequence=>10
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(19332874189893258)
,p_region_id=>wwv_flow_imp.id(37286025219462410)
,p_chart_type=>'dial'
,p_width=>'90'
,p_height=>'100'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_value_text_type=>'percent'
,p_value_format_type=>'percent'
,p_value_decimal_places=>0
,p_value_format_scaling=>'auto'
,p_fill_multi_series_gaps=>false
,p_tooltip_rendered=>'Y'
,p_show_series_name=>false
,p_show_group_name=>false
,p_show_value=>false
,p_show_label=>false
,p_show_row=>false
,p_show_start=>false
,p_show_end=>false
,p_show_progress=>false
,p_show_baseline=>false
,p_gauge_orientation=>'circular'
,p_gauge_indicator_size=>.5
,p_gauge_inner_radius=>.9
,p_gauge_plot_area=>'on'
,p_gauge_start_angle=>90
,p_gauge_angle_extent=>360
,p_show_gauge_value=>true
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(19333364398893259)
,p_chart_id=>wwv_flow_imp.id(19332874189893258)
,p_seq=>10
,p_name=>'CPU Metrics'
,p_data_source_type=>'SQL'
,p_data_source=>'SELECT usage as cpu_usage, capacity as cpu_capacity FROM RA_HOSTINSIGHTS_CPU_USAGE_SUMMARY'
,p_items_value_column_name=>'CPU_USAGE'
,p_items_max_value=>'CPU_CAPACITY'
,p_items_label_column_name=>'CPU_USAGE'
,p_items_label_rendered=>false
,p_threshold_display=>'onIndicator'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37797722954461466)
,p_plug_name=>'Memory Usage over Capacity'
,p_parent_plug_id=>wwv_flow_imp.id(37285887442462409)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_imp.id(36100791615263634)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(19331308364893255)
,p_region_id=>wwv_flow_imp.id(37797722954461466)
,p_chart_type=>'dial'
,p_width=>'90'
,p_height=>'100'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_value_text_type=>'percent'
,p_value_format_type=>'percent'
,p_value_decimal_places=>0
,p_value_format_scaling=>'auto'
,p_fill_multi_series_gaps=>false
,p_tooltip_rendered=>'Y'
,p_show_series_name=>false
,p_show_group_name=>false
,p_show_value=>false
,p_show_label=>false
,p_show_row=>false
,p_show_start=>false
,p_show_end=>false
,p_show_progress=>false
,p_show_baseline=>false
,p_gauge_orientation=>'circular'
,p_gauge_indicator_size=>.5
,p_gauge_inner_radius=>.6
,p_gauge_plot_area=>'on'
,p_gauge_start_angle=>90
,p_gauge_angle_extent=>360
,p_show_gauge_value=>true
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(19331879547893256)
,p_chart_id=>wwv_flow_imp.id(19331308364893255)
,p_seq=>10
,p_name=>'Memory Metrics'
,p_data_source_type=>'SQL'
,p_data_source=>'SELECT usage as mem_usage, capacity as mem_capacity FROM RA_HOSTINSIGHTS_MEMORY_USAGE_SUMMARY'
,p_items_value_column_name=>'MEM_USAGE'
,p_items_max_value=>'MEM_CAPACITY'
,p_items_label_column_name=>'MEM_USAGE'
,p_items_label_rendered=>false
,p_threshold_display=>'onIndicator'
);
wwv_flow_imp_page.create_report_region(
 p_id=>wwv_flow_imp.id(37285345215462403)
,p_name=>'ReportPeriod'
,p_template=>wwv_flow_imp.id(36100791615263634)
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'TABLE'
,p_query_table=>'HOSTINSIGHTS_REPORT_PERIOD'
,p_include_rowid_column=>false
,p_ajax_enabled=>'Y'
,p_lazy_loading=>false
,p_query_row_template=>wwv_flow_imp.id(36137385917263737)
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
 p_id=>wwv_flow_imp.id(19334384576893263)
,p_query_column_id=>1
,p_column_alias=>'USAGEUNIT'
,p_column_display_sequence=>10
,p_column_heading=>'Usageunit'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
,p_required_patch=>wwv_flow_imp.id(35996879492263337)
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(19334712772893265)
,p_query_column_id=>2
,p_column_alias=>'RESOURCEMETRIC'
,p_column_display_sequence=>20
,p_column_heading=>'Resourcemetric'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
,p_required_patch=>wwv_flow_imp.id(35996879492263337)
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(19335116340893266)
,p_query_column_id=>3
,p_column_alias=>'TIMEINTERVALEND'
,p_column_display_sequence=>30
,p_column_heading=>'Timeintervalend'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(19335515463893267)
,p_query_column_id=>4
,p_column_alias=>'TIMEINTERVALSTART'
,p_column_display_sequence=>40
,p_column_heading=>'Timeintervalstart'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_report_columns(
 p_id=>wwv_flow_imp.id(19335974541893268)
,p_query_column_id=>5
,p_column_alias=>'ID'
,p_column_display_sequence=>50
,p_column_heading=>'Id'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37798024926461469)
,p_plug_name=>'HOST INSIGHTS CPU and MEMORY'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(36100791615263634)
,p_plug_display_sequence=>60
,p_location=>null
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37798117844461470)
,p_plug_name=>'CPU Usage across Host'
,p_parent_plug_id=>wwv_flow_imp.id(37798024926461469)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_imp.id(36100791615263634)
,p_plug_display_sequence=>10
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(19320911082893230)
,p_region_id=>wwv_flow_imp.id(37798117844461470)
,p_chart_type=>'pie'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'none'
,p_value_format_type=>'decimal'
,p_value_decimal_places=>0
,p_value_format_scaling=>'none'
,p_fill_multi_series_gaps=>false
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>false
,p_show_value=>true
,p_show_label=>false
,p_show_row=>false
,p_show_start=>false
,p_show_end=>false
,p_show_progress=>false
,p_show_baseline=>false
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_pie_other_threshold=>0
,p_pie_selection_effect=>'highlightAndExplode'
,p_show_gauge_value=>false
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(19321470052893234)
,p_chart_id=>wwv_flow_imp.id(19320911082893230)
,p_seq=>10
,p_name=>'Tasks'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'	SELECT',
'    hostname,',
'    capacity,',
'    usage,',
'    average,',
'    usagechangepercent',
'	FROM',
'    ra_hostinsights_res_stat'))
,p_items_value_column_name=>'USAGE'
,p_items_label_column_name=>'HOSTNAME'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_items_label_display_as=>'LABEL'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37798592224461475)
,p_plug_name=>'Key Metrics Distribution'
,p_parent_plug_id=>wwv_flow_imp.id(37798024926461469)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_imp.id(36100791615263634)
,p_plug_display_sequence=>20
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(19322441903893238)
,p_region_id=>wwv_flow_imp.id(37798592224461475)
,p_chart_type=>'polar'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_hover_behavior=>'dim'
,p_stack=>'on'
,p_connect_nulls=>'Y'
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
,p_show_gauge_value=>false
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(19324759883893242)
,p_chart_id=>wwv_flow_imp.id(19322441903893238)
,p_seq=>10
,p_name=>'CPU Utilization'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'	select HOSTNAME, ',
'       UTILIZATIONPERCENT AS CPU_UTIL, ',
'       ''CPU Utilization'' as MetricType',
'	from RA_HOSTINSIGHTS_RES_STAT'))
,p_series_type=>'lineWithArea'
,p_items_value_column_name=>'CPU_UTIL'
,p_items_label_column_name=>'HOSTNAME'
,p_line_type=>'auto'
,p_items_label_rendered=>false
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(19324169224893241)
,p_chart_id=>wwv_flow_imp.id(19322441903893238)
,p_seq=>20
,p_name=>'Memory Utilization'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'	select HOSTNAME, ',
'		UTILIZATIONPERCENT AS MEM_UTIL, ',
'		''MEMORY Utilization'' as MetricType',
'	from RA_HOSTINSIGHTS_RES_STAT_MEMORY'))
,p_series_type=>'lineWithArea'
,p_items_value_column_name=>'MEM_UTIL'
,p_items_label_column_name=>'HOSTNAME'
,p_line_type=>'auto'
,p_items_label_rendered=>false
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(19322979521893239)
,p_chart_id=>wwv_flow_imp.id(19322441903893238)
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
 p_id=>wwv_flow_imp.id(19323566426893240)
,p_chart_id=>wwv_flow_imp.id(19322441903893238)
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
 p_id=>wwv_flow_imp.id(37800851264461497)
,p_plug_name=>'CPU Combination Chart'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(36100791615263634)
,p_plug_display_sequence=>70
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_location=>null
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(37800885861461498)
,p_plug_name=>'CPU Usage Historic and Forecast'
,p_parent_plug_id=>wwv_flow_imp.id(37800851264461497)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_imp.id(36100791615263634)
,p_plug_display_sequence=>10
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_ai_enabled=>false
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(19326159429893244)
,p_region_id=>wwv_flow_imp.id(37800885861461498)
,p_chart_type=>'combo'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hover_behavior=>'none'
,p_stack=>'off'
,p_connect_nulls=>'Y'
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
,p_show_gauge_value=>false
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(19327872155893247)
,p_chart_id=>wwv_flow_imp.id(19326159429893244)
,p_seq=>10
,p_name=>'CPU Historic Usage'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'to_char(cut.endTimestamp, ''DD-MON-YYYY HH24:MI:SS'') AS HISTORIC_TIMESTAMP,',
'cut.usage as historical_usage,',
'''CPU Historic Usage'' as CPU_HIST',
'FROM ',
'HOSTINSIGHTS_CPU_FORECAST_TREND CPU_FORECAST_TREND,',
'JSON_TABLE(',
'    CPU_FORECAST_TREND.HISTORICALDATA,',
'    ''$[*]'' ',
'    COLUMNS (',
'        endTimestamp DATE PATH ''$.endTimestamp'',',
'        usage NUMBER PATH ''$.usage''',
'    )',
') cut',
'ORDER BY cut.endTimestamp ASC'))
,p_series_type=>'bar'
,p_items_value_column_name=>'HISTORICAL_USAGE'
,p_items_label_column_name=>'HISTORIC_TIMESTAMP'
,p_line_style=>'solid'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(19328381904893248)
,p_chart_id=>wwv_flow_imp.id(19326159429893244)
,p_seq=>20
,p_name=>'CPU Forecast Usage'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'to_char(cft.endTimestamp, ''DD-MON-YYYY HH24:MI:SS'') AS PROJECTED_TIMESTAMP,',
'cft.usage as projected_usage,',
'cft.highValue as projected_highValue,',
'cft.lowValue as projected_lowValue,',
'''CPU Historic Usage'' as CPU_HIST    ',
'FROM ',
'HOSTINSIGHTS_CPU_FORECAST_TREND CPU_FORECAST_TREND,',
'JSON_TABLE(',
'    CPU_FORECAST_TREND.PROJECTEDDATA,',
'    ''$[*]'' ',
'    COLUMNS (',
'        endTimestamp DATE PATH ''$.endTimestamp'',',
'        usage NUMBER PATH ''$.usage'',',
'        highValue NUMBER PATH ''$.highValue'',',
'        lowValue NUMBER PATH ''$.lowValue''',
'    )',
') cft',
'ORDER BY cft.endTimestamp ASC'))
,p_series_type=>'lineWithArea'
,p_items_value_column_name=>'PROJECTED_USAGE'
,p_items_label_column_name=>'PROJECTED_TIMESTAMP'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(19326674408893245)
,p_chart_id=>wwv_flow_imp.id(19326159429893244)
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
 p_id=>wwv_flow_imp.id(19327262166893246)
,p_chart_id=>wwv_flow_imp.id(19326159429893244)
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
 p_id=>wwv_flow_imp.id(19369528539792117)
,p_plug_name=>'CPU Usage Historic and Forecast - Mixed Frequency'
,p_title=>'CPU Usage Historic and Forecast - Mixed Frequency'
,p_parent_plug_id=>wwv_flow_imp.id(37800885861461498)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_imp.id(36100791615263634)
,p_plug_display_sequence=>10
,p_location=>null
,p_plug_source_type=>'NATIVE_JET_CHART'
);
wwv_flow_imp_page.create_jet_chart(
 p_id=>wwv_flow_imp.id(19369604468792118)
,p_region_id=>wwv_flow_imp.id(19369528539792117)
,p_chart_type=>'combo'
,p_height=>'400'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
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
,p_legend_rendered=>'off'
,p_time_axis_type=>'mixedFrequency'
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(19369798798792119)
,p_chart_id=>wwv_flow_imp.id(19369604468792118)
,p_seq=>10
,p_name=>'CPU Historic Usage'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'to_char(cut.endTimestamp, ''DD-MON-YYYY HH24:MI:SS'') AS HISTORIC_TIMESTAMP,',
'cut.usage as historical_usage,',
'''CPU Historic Usage'' as CPU_HIST',
'FROM ',
'HOSTINSIGHTS_CPU_FORECAST_TREND CPU_FORECAST_TREND,',
'JSON_TABLE(',
'    CPU_FORECAST_TREND.HISTORICALDATA,',
'    ''$[*]'' ',
'    COLUMNS (',
'        endTimestamp DATE PATH ''$.endTimestamp'',',
'        usage NUMBER PATH ''$.usage''',
'    )',
') cut',
'ORDER BY cut.endTimestamp ASC'))
,p_series_type=>'bar'
,p_items_value_column_name=>'HISTORICAL_USAGE'
,p_items_label_column_name=>'HISTORIC_TIMESTAMP'
,p_line_style=>'solid'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(19370035789792122)
,p_chart_id=>wwv_flow_imp.id(19369604468792118)
,p_seq=>20
,p_name=>'CPU Forecast MAX'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'to_char(cft.endTimestamp, ''DD-MON-YYYY HH24:MI:SS'') AS PROJECTED_TIMESTAMP,',
'cft.highValue as projected_highValue,',
'''CPU Forecast Max Usage'' as CPU_FORECAST_MAX  ',
'FROM ',
'HOSTINSIGHTS_CPU_FORECAST_TREND CPU_FORECAST_TREND,',
'JSON_TABLE(',
'    CPU_FORECAST_TREND.PROJECTEDDATA,',
'    ''$[*]'' ',
'    COLUMNS (',
'        endTimestamp DATE PATH ''$.endTimestamp'',',
'        usage NUMBER PATH ''$.usage'',',
'        highValue NUMBER PATH ''$.highValue'',',
'        lowValue NUMBER PATH ''$.lowValue''',
'    )',
') cft',
'ORDER BY cft.endTimestamp ASC'))
,p_series_type=>'line'
,p_items_value_column_name=>'PROJECTED_HIGHVALUE'
,p_items_label_column_name=>'PROJECTED_TIMESTAMP'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(19370183180792123)
,p_chart_id=>wwv_flow_imp.id(19369604468792118)
,p_seq=>30
,p_name=>'CPU Forecast Usage'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'to_char(cft.endTimestamp, ''DD-MON-YYYY HH24:MI:SS'') AS PROJECTED_TIMESTAMP,',
'cft.usage as projected_usage,',
'cft.highValue as projected_highValue,',
'cft.lowValue as projected_lowValue,',
'''CPU Forecast Usage'' as CPU_FORECAST',
'FROM ',
'HOSTINSIGHTS_CPU_FORECAST_TREND CPU_FORECAST_TREND,',
'JSON_TABLE(',
'    CPU_FORECAST_TREND.PROJECTEDDATA,',
'    ''$[*]'' ',
'    COLUMNS (',
'        endTimestamp DATE PATH ''$.endTimestamp'',',
'        usage NUMBER PATH ''$.usage'',',
'        highValue NUMBER PATH ''$.highValue'',',
'        lowValue NUMBER PATH ''$.lowValue''',
'    )',
') cft',
'ORDER BY cft.endTimestamp ASC'))
,p_series_type=>'bar'
,p_items_value_column_name=>'PROJECTED_USAGE'
,p_items_label_column_name=>'PROJECTED_TIMESTAMP'
,p_line_style=>'solid'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
);
wwv_flow_imp_page.create_jet_chart_series(
 p_id=>wwv_flow_imp.id(19370261556792124)
,p_chart_id=>wwv_flow_imp.id(19369604468792118)
,p_seq=>40
,p_name=>'CPU Forecast MIN'
,p_data_source_type=>'SQL'
,p_data_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'to_char(cft.endTimestamp, ''DD-MON-YYYY HH24:MI:SS'') AS PROJECTED_TIMESTAMP,',
'cft.usage as projected_usage,',
'cft.highValue as projected_highValue,',
'cft.lowValue as projected_lowValue,',
'''CPU Forecast Usage'' as CPU_FORECAST',
'FROM ',
'HOSTINSIGHTS_CPU_FORECAST_TREND CPU_FORECAST_TREND,',
'JSON_TABLE(',
'    CPU_FORECAST_TREND.PROJECTEDDATA,',
'    ''$[*]'' ',
'    COLUMNS (',
'        endTimestamp DATE PATH ''$.endTimestamp'',',
'        usage NUMBER PATH ''$.usage'',',
'        highValue NUMBER PATH ''$.highValue'',',
'        lowValue NUMBER PATH ''$.lowValue''',
'    )',
') cft',
'ORDER BY cft.endTimestamp ASC'))
,p_series_type=>'line'
,p_items_value_column_name=>'PROJECTED_LOWVALUE'
,p_items_label_column_name=>'PROJECTED_TIMESTAMP'
,p_line_style=>'solid'
,p_line_type=>'auto'
,p_marker_rendered=>'auto'
,p_marker_shape=>'auto'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>false
);
wwv_flow_imp_page.create_jet_chart_axis(
 p_id=>wwv_flow_imp.id(19369876257792120)
,p_chart_id=>wwv_flow_imp.id(19369604468792118)
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
 p_id=>wwv_flow_imp.id(19369960615792121)
,p_chart_id=>wwv_flow_imp.id(19369604468792118)
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
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(102075031728047590)
,p_plug_name=>'Multicloud Overview'
,p_icon_css_classes=>'fa-cloud'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(36077464572263574)
,p_plug_display_sequence=>10
,p_location=>null
,p_plug_source=>'Multicloud Wingmate framework page. Use this page for multicloud infrastructure inventory, Exadata resources, VM clusters, capacity, resilience, and optimization recommendations.'
,p_plug_query_num_rows=>15
,p_ai_enabled=>false
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML',
  'show_line_breaks', 'Y')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(19329782623893251)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(37282869239462379)
,p_button_name=>'startWingmate'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(36174336092263855)
,p_button_image_alt=>'Start Wingmate'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(19341810922893305)
,p_name=>'Chat'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(19329782623893251)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(19342313194893309)
,p_event_id=>wwv_flow_imp.id(19341810922893305)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_OPEN_AI_ASSISTANT'
,p_attribute_01=>'INLINE'
,p_attribute_03=>'#wingmate-chat'
,p_attribute_14=>'What are the allocated CPUs for the hosts with the hostname?'
,p_attribute_15=>'Which hostnames have the lowest or zero running OCPU allocation?'
-- Select the target app's wingmate_multicloud_rag AI Configuration after import.
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(19342820986893311)
,p_event_id=>wwv_flow_imp.id(19341810922893305)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_HIDE'
,p_affected_elements_type=>'BUTTON'
,p_affected_button_id=>wwv_flow_imp.id(19329782623893251)
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
