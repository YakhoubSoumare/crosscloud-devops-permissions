#!/bin/bash

##############################################################################
# Author: Yakhoub Soumare
# Date: 2025-07-08
# Version: 1.0
# Purpose: Automate Terraform workflow (init, plan, apply) for AWS or Azure
# Supports switching between environments using TFVARS files
##############################################################################

# Choose: aws or azure
cd "$1" || exit 1

terraform init -migrate-state
terraform plan -var-file="$1.tfvars"
terraform apply -var-file="$1.tfvars"
