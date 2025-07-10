# ----------- AWS ------------

variable "aws_region" {
  type        = string
  description = "The AWS region to deploy resources in"
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket used for Terraform remote state"
}

variable "dynamodb_table_name" {
  type        = string
  description = "Name of the DynamoDB table used for Terraform state locking"
}

# ----------- Common ------------

variable "cidr_block" {
  type        = string
  description = "CIDR block for VPC"
}

variable "team_groups" {
  type        = list(string)
  default     = ["DevOps", "Developers", "Managers"]
  description = "List of internal IAM groups used by the organisation"
}
