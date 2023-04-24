# Copyright (c) 2019-2022 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.

resource "oci_ons_notification_topic" "customer_feedback_analytics" {
  depends_on = [
    oci_identity_compartment.customer_feedback_analytics,
    oci_identity_policy.customer_feedback_analytics
  ]

  compartment_id = oci_identity_compartment.customer_feedback_analytics.id
  name = var.notification_topic_name
}

resource "oci_ons_subscription" "customer_feedback_analytics" {
  depends_on = [
    oci_ons_notification_topic.customer_feedback_analytics,
    oci_identity_compartment.customer_feedback_analytics
  ]

  compartment_id = oci_identity_compartment.customer_feedback_analytics.id
  topic_id = oci_ons_notification_topic.customer_feedback_analytics.id
  protocol = "CUSTOM_HTTPS"
  endpoint = format(
    "https://%s:%s@%s/ic/api/integration/v1/flows/rest/CUSTOMER_FEEDBACK_ANALYTICS/1.0/process-new-csv",
    urlencode(var.oic_service_invoker_user_name),
    urlencode(var.oic_service_invoker_user_password),
    var.oic_instance_host_name
  )
}

output "notification_endpoint" {
  sensitive = true
  value = oci_ons_subscription.customer_feedback_analytics.endpoint
}