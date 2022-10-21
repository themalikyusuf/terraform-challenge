project_name       = "test-project"
azs                = ["us-west-1b", "us-west-1c"]
vpc_cidr           = "10.0.0.0/16"
private_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets     = ["10.0.3.0/24", "10.0.4.0/24"]
enable_nat_gateway = true
single_nat_gateway = true
