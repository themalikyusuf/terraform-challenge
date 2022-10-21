provider "aws" {
  region  = "us-west-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.35.0"
    }
  }

  required_version = ">= 1.1.0"
}

data "aws_iam_role" "task_ecs" {
  name = "ecsTaskExecutionRole"
}

# Commented block below is part of the given template but there is no VPC in the us-west-1 region so it is redundant
# data "aws_vpc" "default_vpc" {
#   default = true
# }

# data "aws_subnet_ids" "subnets" {
#   vpc_id = "${data.aws_vpc.default_vpc.id}"
# }
