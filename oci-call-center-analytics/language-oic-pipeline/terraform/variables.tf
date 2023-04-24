# Copyright (c) 2019-2022 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.

#### UPDATE HERE ##############

variable "oic_instance_host_name" {
  default = "<oci_instance_host_name>"
}

variable "oic_service_invoker_user_name" {
  default = "<oic_service_invoker_user_name>"
}

variable "oic_service_invoker_user_password" {
  sensitive = true
  default = "<oic_service_invoker_user_password>"
}

#### DO NOT UPDATE BELLOW THIS LINE! ##############

variable "tenancy_ocid" {
  default = "<tenancy_ocid>"
}

variable "assets_dir_name" {
  default = "<assets_dir_name>"
}

variable "api_public_key_file_path" {
  default = "<api_public_key_file_path>"
}

variable "compartment_name" {
  default = "customer_feedback_analytics"
}

variable "api_caller_name" {
  default = "customer_feedback_analytics_api_caller"
}

variable "group_name" {
  default = "customer_feedback_analytics"
}

variable "policy_name" {
  default = "customer_feedback_analytics"
}

variable "object_storage_namespace" {
  default = "<object_storage_namespace>"
}

variable "bucket_name" {
  default = "customer_feedback_analytics"
}

variable "notification_topic_name" {
  default = "customer_feedback_analytics"
}

variable "oic_instance_containing_compartment" {
  default = "oci-ai-demos"
}

variable "event_rule_display_name" {
  default = "Customer Feedback Analytics"
}

variable "database_name" {
  default = "CustomerFeedbackAnalytics"
}

variable "database_user_name" {
  default = "CFA"
}

locals {
  assets_dir_path = "${var.assets_dir_name}"
  wallet_file_path = "${local.assets_dir_path}/database-wallet.zip"
  wallet_sso_file_name = "cwallet.sso"
  sql_script_template_file_path = "${local.assets_dir_path}/database.sqltemplate"
  sql_script_file_path = "${local.assets_dir_path}/database.sql"
}
