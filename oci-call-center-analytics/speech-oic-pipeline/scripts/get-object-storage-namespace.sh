#!/bin/bash
# Copyright (c) 2019-2022 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.

storage_namespace_json=$(oci os ns get)
namespace_in_quotes=$(echo "$storage_namespace_json" | grep -Po '": "([^"]+)"')
namespace=$(echo "$namespace_in_quotes" | grep -Po "[a-zA-Z0-9]+")
echo "$namespace"