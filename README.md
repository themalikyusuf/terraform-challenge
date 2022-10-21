# Terraform-Challenge

This Terraform project creates an ECS Service to run a Docker container. The following AWS resources are created as part of this project: 

- 1 VPC with 2 private, 2 public subnets and 1 NAT Gateway
- 1 Application Load Balancer and Listener
- 1 Target Group
- 1 ECS Cluster
- 1 ECS Task Definition
- 1 ECS Service

Running the project requires:
Before running this project, you should have Terraform CLI(1.1.7+) and AWS CLI installed. Then `export` your IAM credentials to authenticate the Terraform AWS provider.

```
export AWS_ACCESS_KEY_ID=x
```
```
export AWS_SECRET_ACCESS_KEY=x
```

From the root directory, initialize and apply the project.
```
terraform init
```
```
terraform apply
```

The Load balancer DNS name is outputted after the Terraform run. We can copy and paste in a browser to see our service when it is up and running.
