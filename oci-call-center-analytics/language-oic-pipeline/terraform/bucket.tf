# Copyright (c) 2019-2022 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.

resource "oci_objectstorage_bucket" "customer_feedback_analytics" {
  compartment_id = oci_identity_compartment.customer_feedback_analytics.id
  name = var.bucket_name
  namespace = var.object_storage_namespace
  object_events_enabled = true
}