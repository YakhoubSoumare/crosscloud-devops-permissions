# Ref: aws_references.md – section "IAM and Policies"

# Define custom IAM policy for DevOps group
resource "aws_iam_policy" "devops_policy" {
  name        = "DevOpsPolicy"
  path        = "/internal/"
  description = "Custom IAM policy for DevOps group"

  policy = jsonencode({
	    Version = "2012-10-17",
	    Statement = [
	    
		  # Allow describing VPC and subnet resources
	      {
	        Sid    = "VPCAndBasicInfra",
	        Effect = "Allow",
	        Action = [
	          "ec2:DescribeVpcs",
	          "ec2:DescribeSubnets",
	          "ec2:CreateTags"
	        ],
	        Resource = "*"
	      },

	      # Allow access to Terraform state in S3 bucket
	      { 
	        Sid    = "S3StateAccess",
	        Effect = "Allow",
	        Action = [
	          "s3:GetObject",
	          "s3:PutObject",
	          "s3:ListBucket"
	        ],
	        Resource = [
	          "arn:aws:s3:::${var.s3_bucket_name}",
	          "arn:aws:s3:::${var.s3_bucket_name}/*"
	        ]
	      },

	      # Allow Terraform state locking with DynamoDB
	      {
	        Sid    = "DynamoDBLocking",
	        Effect = "Allow",
	        Action = [
	          "dynamodb:GetItem",
	          "dynamodb:PutItem",
	          "dynamodb:DeleteItem"
	        ],
	        Resource = "arn:aws:dynamodb:${var.aws_region}:${data.aws_caller_identity.current.account_id}:table/${var.dynamodb_table_name}"
	      },

	      # Full access to AWS IoT Core
	      {
	        Sid    = "IoTCoreAccess",
	        Effect = "Allow",
	        Action = [
	          "iot:*"
	        ],
	        Resource = "*"
	      },

	      # Full access to Lambda functions and logs
	      {
	        Sid    = "LambdaAndLogs",
	        Effect = "Allow",
	        Action = [
	          "lambda:*",
	          "logs:*"
	        ],
	        Resource = "*"
	      },

	      # Allow group-level IAM operations (for internal teams)
	      {
			Sid	   = "IAMGroupScoped",
			Effect = "Allow",
			Action = [
			  "iam:CreateGroup",
			  "iam:DeleteGroup",
			  "iam:GetGroup",
			  "iam:ListGroups",
			  "iam:PutGroupPolicy",
			  "iam:DeleteGroupPolicy",
	  	      "iam:AttachGroupPolicy",
			  "iam:DetachGroupPolicy"
			],
			"Resource": "*"	
	 	  },

	 	  # Full access to SQS for DLQ management
	 	  {
	 	    Sid    = "SQSAccess",
	 	    Effect = "Allow",
	 	    Action = [
	 	      "sqs:CreateQueue",
	 	      "sqs:DeleteQueue",
	 	      "sqs:GetQueueAttributes",
	 	      "sqs:SetQueueAttributes",
	 	      "sqs:SendMessage",
	 	      "sqs:ReceiveMessage",
	 	      "sqs:DeleteMessage",
	 	      "sqs:ListQueues"
	 	    ],
	 	    Resource = "arn:aws:sqs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:*"
	 	  }
	    ]
  })
}

# Attach custom policy to DevOps group
resource "aws_iam_group_policy_attachment" "devops_policy_attach" {
  group      = aws_iam_group.teams["DevOps"].name
  policy_arn = aws_iam_policy.devops_policy.arn
}
