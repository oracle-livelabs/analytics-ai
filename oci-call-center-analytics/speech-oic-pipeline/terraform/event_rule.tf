# Copyright (c) 2019-2022 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.

resource "oci_events_rule" "customer_feedback_analytics" {
  depends_on = [
    oci_identity_compartment.customer_feedback_analytics,
    oci_identity_group.customer_feedback_analytics,
    oci_ons_notification_topic.customer_feedback_analytics
  ]

	actions {
		actions {
			action_type = "ONS"
			is_enabled = true
			topic_id = oci_ons_notification_topic.customer_feedback_analytics.id
		}
	}

	compartment_id = oci_identity_compartment.customer_feedback_analytics.id
	display_name = var.event_rule_display_name
	is_enabled = true
	condition = jsonencode({
		eventType = "com.oraclecloud.objectstorage.createobject"
    data = {
      compartmentId = oci_identity_compartment.customer_feedback_analytics.id
      additionalDetails = {
        bucketName = var.bucket_name
      }
    }
	})
}