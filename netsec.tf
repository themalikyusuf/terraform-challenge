# This file contains network and security resources

# VPC Module which creates a VPC, 2 private subnets(with a single shared NAT gateway) and 2 public subnets
# P.S: It is better and safer to create resources from scratch to create our own module
module "ecs_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.16.1"

  name               = "${var.project_name}-vpc"
  azs                = var.azs
  cidr               = var.vpc_cidr
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway

  tags = {
    Environment = "development"
  }
}

# The Load balancer's security group. Allows traffic from the internet(on port 80)
resource "aws_security_group" "lb_sg" {
  name        = "${var.project_name}-lb-sg"
  description = "Allows inbound traffic to the LB"
  vpc_id      = module.ecs_vpc.vpc_id

  ingress {
    from_port        = 80
    to_port          = 80
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    protocol         = "tcp"
  }

  egress {
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    protocol         = "-1"
  }

  tags = {
    Environment = "development"
  }
}

# The Service's security group. Allows traffic to the service on port 80
resource "aws_security_group" "ecs_sg" {
  name        = "${var.project_name}-ecs-sg"
  description = "Allow inbound traffic to ECS"
  vpc_id      = module.ecs_vpc.vpc_id

  ingress {
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
  }

  tags = {
    Environment = "development"
  }
}
