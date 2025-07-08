# Cloud Provider Authentication Guide for Terraform

This guide explains how to authenticate Terraform with both **AWS** and **Azure**, using secure and recommended practices.

---

## AWS Authentication with IAM User

### 1. Create an IAM User
- Go to the [AWS IAM Console](https://console.aws.amazon.com/iam/)
- Create a new user, e.g., `terraform-user`
- Select **Programmatic access**
- Attach the policy: `AdministratorAccess` (for testing) or use least privilege policies for production
- Download the credentials (`Access Key ID` and `Secret Access Key`)

### 2. Configure AWS CLI

Run:

```bash
aws configure
```

Then enter:
- `AWS Access Key ID`
- `AWS Secret Access Key`
- Default region: e.g., `eu-north-1`
- Output format: `json`

### 3. Terraform Provider Block Example

```hcl
provider "aws" {
  region = var.aws_region
}
```

---

## Azure Authentication with Service Principal

### 1. Get the Subscription ID

```bash
az account show --query id -o tsv
```

### 2. Create a Service Principal

```bash
az ad sp create-for-rbac \
  --name terraform-sp \
  --role Contributor \
  --scopes /subscriptions/<the-subscription-id>
```

Save the output, which contains:

- `appId` → `ARM_CLIENT_ID`
- `password` → `ARM_CLIENT_SECRET`
- `tenant` → `ARM_TENANT_ID`

Add the subscription ID manually:
- `ARM_SUBSCRIPTION_ID`

### Why Not Use `~/.azure/credentials`?

Terraform does not use any file inside `~/.azure/` for credentials. That directory is only used by the Azure CLI for login sessions.

Terraform requires one of:
- `ARM_` environment variables (recommended)
- Explicit credentials in the provider block (not secure)

Recommended approach: Save credentials in a secure file such as `~/.azure_terraform_credentials.env`:

```bash
export ARM_CLIENT_ID="..."
export ARM_CLIENT_SECRET="..."
export ARM_TENANT_ID="..."
export ARM_SUBSCRIPTION_ID="..."
```

Then load the file using:

```bash
source ~/.azure_terraform_credentials.env
```

This keeps secrets out of Terraform code and version control.

### 3. Export Environment Variables

```bash
export ARM_CLIENT_ID="..."
export ARM_CLIENT_SECRET="..."
export ARM_TENANT_ID="..."
export ARM_SUBSCRIPTION_ID="..."
```

### 4. Terraform Provider Block Example

```hcl
provider "azurerm" {
  features {}
}
```

---

## Best Practices

- Avoid using root users for either AWS or Azure.
- Use environment variables for credentials, not hard-coded values.
- Use separate tfvars files for AWS and Azure projects.
- Add `.env` files to `.gitignore` to avoid accidental commits.

---

## Next Step

Once authenticated, run:

```bash
terraform init
terraform plan -var-file=aws.tfvars
terraform apply -var-file=aws.tfvars
```

Or use `azure.tfvars` in the Azure folder.
