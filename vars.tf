# Varible definitions
variable "project_name" {
  type        = string
  description = "The name of the project"
}

variable "azs" {
  type        = list(any)
  description = "Region availability zones"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
}

variable "private_subnets" {
  type        = list(any)
  description = "Private subnets CIDR"
}

variable "public_subnets" {
  type        = list(any)
  description = "Public subnets CIDR"
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Enable to provision NAT Gateways for private networks"
}
variable "single_nat_gateway" {
  type        = bool
  description = "Enable to provision a single shared NAT Gateway across all private networks"
}
