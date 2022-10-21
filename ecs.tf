# This file contains Elastic Container services resources

# ECS Cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.project_name}-cluster"

  tags = {
    Environment = "development"
  }
}

# ECS Service. Ensures we are runing a specified number of tasks at all times
resource "aws_ecs_service" "this" {
  name    = "${var.project_name}-service"
  cluster = aws_ecs_cluster.ecs_cluster.id

  desired_count = 2
  force_new_deployment = true
  launch_type          = "FARGATE"
  task_definition      = aws_ecs_task_definition.ecs_task_definition.arn

  load_balancer {
    container_name   = var.project_name
    container_port   = 5000
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }

  network_configuration {
    subnets         = [module.ecs_vpc.private_subnets[0], module.ecs_vpc.private_subnets[1]]
    security_groups = [aws_security_group.ecs_sg.id]
  }

  tags = {
    Environment = "development"
  }
}

# Task Definition. Describe container configuration
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family = "${var.project_name}-td"
  container_definitions = jsonencode([
    {
      name      = var.project_name
      image     = "themalikyusuf/python-challenge"
      cpu       = 256
      essential = true
      memory    = 512
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
        }
      ]
    },
  ])

  cpu                      = 256
  memory                   = 512
  execution_role_arn       = data.aws_iam_role.task_ecs.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  tags = {
    Environment = "development"
  }
}
