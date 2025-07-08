# Run Terraform Script

This script simplifies the Terraform workflow for each cloud provider.

## 📄 File: `run-terraform.sh`

```bash
#!/bin/bash

# Usage: ./run-terraform.sh aws   OR   ./run-terraform.sh azure

cd "$1" || exit 1

terraform init -migrate-state
terraform plan -var-file="$1.tfvars"
terraform apply -var-file="$1.tfvars"
```

## ✅ How to Use

From the project root, run:

```bash
./run-terraform.sh aws
```

or

```bash
./run-terraform.sh azure
```

## 🧠 Notes

- Place the script in the project root (same level as `aws/`, `azure/` folders).
- Assumes `aws.tfvars` and `azure.tfvars` exist in their respective folders.
- Automatically runs `terraform init` with state migration.
- Useful for consistent and repeatable execution of Terraform actions.
