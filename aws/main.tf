terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

# Create a VPC
resource "aws_vpc" "cloud_notification_platform_network" {
  cidr_block = var.cidr_block
  
  tags = {
    Name = "cloud-notification-platform-vpc"
  }
}

# ------------------- Internal IAM -----------------
# Create internal groups
# Ref: aws_references.md – section "Loops and Dynamic Configuration"
resource "aws_iam_group" "teams" {
	for_each 	=		toset(var.team_groups)
	name 		=		each.key
	path		=		"/internal/"
}

