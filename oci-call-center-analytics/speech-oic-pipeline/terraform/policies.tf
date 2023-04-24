# Copyright (c) 2019-2022 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.

resource "oci_identity_policy" "customer_feedback_analytics" {
  depends_on = [
    oci_identity_compartment.customer_feedback_analytics,
    oci_identity_group.customer_feedback_analytics,
    oci_identity_user_group_membership.api_caller_group_membership
  ]

  compartment_id = oci_identity_compartment.customer_feedback_analytics.id
  name = var.policy_name
  description = "Policy for customer feedback analytics scenario"
  statements = [
    "allow group ${var.group_name} to manage ai-service-language-family in compartment ${oci_identity_compartment.customer_feedback_analytics.name}",
    "allow group ${var.group_name} to read object-family in compartment ${oci_identity_compartment.customer_feedback_analytics.name}"
  ]
}
