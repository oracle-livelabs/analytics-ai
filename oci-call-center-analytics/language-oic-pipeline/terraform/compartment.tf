# Copyright (c) 2019-2022 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.

resource "oci_identity_compartment" "customer_feedback_analytics" {
  compartment_id = var.tenancy_ocid
  name = var.compartment_name
  description = "Holds all of the resources for the customer feedback analytics scenario"
}

output "compartment_ocid" {
 value = oci_identity_compartment.customer_feedback_analytics.id
}
