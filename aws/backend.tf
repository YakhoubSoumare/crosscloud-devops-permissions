# Ref: REFERENCES.md - section "Terraform Backends"
terraform {
  backend "s3" {
    bucket         = "cloud-terraform-state-devops-course-eu-north-1"	# name of already created bucket
    key            = "aws/terraform.tfstate" 				# path to state file
    region         = "eu-north-1"							
    encrypt        = true	
    dynamodb_table = "terraform-lock-table-devops-course"	# name of already created table
  }
}
