# Copyright (c) 2019-2022 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.

resource "oci_identity_group" "customer_feedback_analytics" {
  name = var.group_name
  description = "User is this group will perform actions on behalf of the customer feedback analytics scenario"
  compartment_id = var.tenancy_ocid
}