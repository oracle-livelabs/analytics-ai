#!/bin/bash
# Copyright (c) 2019-2022 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.

echo "Initializing..."

./initialize.sh

echo "Deploying..."

cd ../terraform
terraform init
terraform plan
terraform apply -auto-approve
terraform output -json > ../assets/parameters.json

cd -

echo "Done"