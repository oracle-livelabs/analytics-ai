#!/bin/bash
# Copyright (c) 2019-2022 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.

running_script_directory=$(dirname "$0")
find_and_replace_script="$running_script_directory/find-and-replace-string-in-file.sh"
terraform_variables_file_path="../terraform/variables.tf"

get_and_set_tenancy_ocid() {
  echo "Retrieving Tenancy OCID..."

  get_tenancy_ocid_script="$running_script_directory/get-tenancy-ocid.sh"
  tenancy_ocid=$(${get_tenancy_ocid_script})

  if [[ "$tenancy_ocid" == "" ]]; then
      echo "Could not obtain the tenancy ID automatically, please edit terraform/varialbes.tf manually"
  fi

  echo "Found: $tenancy_ocid"

  ${find_and_replace_script} \
    --find="<tenancy_ocid>" \
    --replace-with="$tenancy_ocid" \
    --file="$terraform_variables_file_path"
}

get_and_set_object_storage_namespace() {
  echo "Retrieving storage namespace..."

  get_object_storage_namespace_script="$running_script_directory/get-object-storage-namespace.sh"
  object_storage_namespace=$(${get_object_storage_namespace_script})

  if [[ "$object_storage_namespace" == "" ]]; then
      echo "Could not obtain the object storage namespace automatically, please edit terraform/varialbes.tf manually"
  fi

  echo "Found: $object_storage_namespace"

  ${find_and_replace_script} \
    --find="<object_storage_namespace>" \
    --replace-with="$object_storage_namespace" \
    --file="$terraform_variables_file_path"
}

generate_api_keys_and_set_paths() {
  echo "Generating API keys..."

  assets_dir_name="../assets"
  api_keys_base_path_and_name="$assets_dir_name/customer-feedback-analytics-api-key"
  api_private_key_file_path="$api_keys_base_path_and_name-private.pem"
  api_public_key_file_path="$api_keys_base_path_and_name-public.pem"

  openssl genrsa -out "$api_private_key_file_path" 2048
  chmod 600 "$api_private_key_file_path"
  openssl rsa -pubout -in "$api_private_key_file_path" -out "$api_public_key_file_path"

  ${find_and_replace_script} \
    --find="<api_public_key_file_path>" \
    --replace-with="$api_public_key_file_path" \
    --file="$terraform_variables_file_path"

  ${find_and_replace_script} \
    --find="<assets_dir_name>" \
    --replace-with="$assets_dir_name" \
    --file="$terraform_variables_file_path"
}

get_and_set_tenancy_ocid
get_and_set_object_storage_namespace
generate_api_keys_and_set_paths