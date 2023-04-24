#!/bin/bash
# Copyright (c) 2019-2022 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.

tenancy_ocid=$(oci iam compartment list \
--all \
--compartment-id-in-subtree true \
--access-level ACCESSIBLE \
--include-root \
--raw-output \
--query "data[?contains(\"id\",'tenancy')].id | [0]")

echo "$tenancy_ocid"