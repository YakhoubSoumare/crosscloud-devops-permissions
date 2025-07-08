
# Remote State Management in Terraform (AWS + Azure)

This guide explains how to configure remote backend storage for Terraform using AWS S3 + DynamoDB and Azure Storage Account + Container. Remote state enables collaboration and consistency across team environments.

---

## AWS Remote Backend (S3 + DynamoDB)

### Step 1: Create an S3 Bucket

```bash
aws s3api create-bucket   --bucket <unique-s3-bucket-name>   --region <the-region>   --create-bucket-configuration LocationConstraint=<the-region>
```

- Stores the remote terraform.tfstate file.
- Bucket names must be globally unique.

### Step 2: Create a DynamoDB Table for Locking

```bash
aws dynamodb create-table   --table-name <dynamodb-lock-table-name>   --attribute-definitions AttributeName=LockID,AttributeType=S   --key-schema AttributeName=LockID,KeyType=HASH   --billing-mode PAY_PER_REQUEST
```

- Prevents concurrent modifications to the same state.

### Step 3: Configure backend.tf

```hcl
terraform {
  backend "s3" {
    bucket         = "<unique-s3-bucket-name>"
    key            = "aws/terraform.tfstate"
    region         = "<the-region>"
    encrypt        = true
    dynamodb_table = "<dynamodb-lock-table-name>"
  }
}
```

---

## Azure Remote Backend (Storage Account + Container)

### Step 1: Create a Resource Group

```bash
az group create   --name <backend-resource-group-name>   --location "<the-region>"
```

- Contains the backend infrastructure components.

### Step 2: Create a Storage Account

```bash
az storage account create   --name <unique-storage-account-name>   --resource-group <backend-resource-group-name>   --location "<the-region>"   --sku Standard_LRS   --kind StorageV2   --allow-blob-public-access false
```

- Must be globally unique across Azure.

### Step 3: Create a Blob Container

```bash
az storage container create   --name tfstate   --account-name <unique-storage-account-name>   --auth-mode login
```

- Stores the state file as a .tfstate blob.

### Step 4: Configure backend.tf

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "<backend-resource-group-name>"
    storage_account_name = "<unique-storage-account-name>"
    container_name       = "tfstate"
    key                  = "azure/terraform.tfstate"
  }
}
```

---

## How to Verify

### AWS

```bash
aws s3 ls s3://<unique-s3-bucket-name>/aws
```

```bash
aws dynamodb describe-table   --table-name <dynamodb-lock-table-name>
```

### Azure

```bash
az storage blob list   --account-name <unique-storage-account-name>   --container-name tfstate   --auth-mode login   --output table
```

---

## Notes

- All services support free-tier or low-cost usage if inactive.
- Never push .tfstate or .terraform to Git.
- Use terraform init -migrate-state when switching to remote state.

---

## Best Practices

- Use one bucket/container per environment (e.g., dev, prod).
- Lock state using DynamoDB or Azure Storage blob container versioning.
- Run terraform init -migrate-state after configuring backends.
