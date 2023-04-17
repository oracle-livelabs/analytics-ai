# Copyright (c) 2019-2022 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.

resource "oci_identity_user" "api_caller" {
  depends_on = [
    oci_identity_group.customer_feedback_analytics
  ]

  compartment_id = var.tenancy_ocid
  description = "This user is used to trigger the OIC process which analyzes the customer feedback"
  name = var.api_caller_name
}

resource "oci_identity_user_group_membership" "api_caller_group_membership"  {
 group_id = oci_identity_group.customer_feedback_analytics.id
 user_id = oci_identity_user.api_caller.id
}

resource "oci_identity_api_key" "api-key" {
  depends_on = [
    oci_identity_user.api_caller
  ]

  key_value = file(var.api_public_key_file_path)
  user_id = oci_identity_user.api_caller.id
}

output "REST_connection_configuration" {
  value = {
    api_caller_user_ocid = oci_identity_user.api_caller.id,
    api_key_fingerprint = oci_identity_api_key.api-key.fingerprint
    tenancy_ocid = var.tenancy_ocid,
  }
}
