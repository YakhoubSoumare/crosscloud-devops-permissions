# crosscloud-devops-permissions

This project provisions cloud access control for development, DevOps, and management roles across AWS and Azure using Terraform. It provides a unified approach to defining, applying, and managing role-based permissions through infrastructure-as-code.

## Project Structure

```
crosscloud-devops-permissions
├── aws/                    # AWS-specific Terraform configurations
├── azure/                  # Azure-specific Terraform configurations
├── run-terraform.sh        # CLI wrapper to apply Terraform to selected cloud
├── branching_strategy.md   # Git branching guide for teams
├── README.md               # Project documentation
└── .gitignore              # Ignored files and directories
```

## Features

- Role definitions for developers, DevOps, and managers
- Modular configuration for AWS IAM and Azure RBAC
- Uses separate Terraform state backends per cloud
- Supports dynamic role scope and assignments
- Unified CLI for deployment (`run-terraform.sh`)

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- AWS CLI and credentials
- Azure CLI with login session

## Usage

Run Terraform for the selected cloud environment (`aws` or `azure`):

```bash
./run-terraform.sh aws
./run-terraform.sh azure
```

This script will:

1. Navigate to the appropriate subdirectory
2. Initialize the backend
3. Plan and apply the infrastructure using the correct `.tfvars` file

## AWS Components

- IAM group policies for developers, DevOps, and managers
- Data sources and outputs for identity and resource reference
- S3 backend configuration for remote state

## Azure Components

- Custom role definitions for developers and DevOps
- Built-in role assignment for managers
- Scoped RBAC control at subscription or resource group level
- Remote state management

## Git Workflow

Refer to `branching_strategy.md` for recommended practices including:

- `main`, `dev`, and `feature/*` branches
- Merge testing before commit
- Protected branches and pull request usage

## Documentation

### AWS

- [`aws/aws_references.md`](aws/aws_references.md): IAM policy guides, data sources, and backend configuration

### Azure

- [`azure/azure_references.md`](azure/azure_references.md): Role definition examples, assignment scopes, and backend

### Role Scope in Azure

- [`azure/scope_role.md`](azure/scope_role.md): Explanation of `scope` vs `assignable_scopes` in RBAC

## References

- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform AzureRM Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Terraform Backend Config](https://developer.hashicorp.com/terraform/language/settings/backends)
- [Azure RBAC Docs](https://learn.microsoft.com/en-us/azure/role-based-access-control/overview)
- [AWS IAM Docs](https://docs.aws.amazon.com/IAM/latest/UserGuide/)

---

This repository provides a reproducible setup for managing DevOps permissions across clouds using a secure and modular Terraform workflow.
