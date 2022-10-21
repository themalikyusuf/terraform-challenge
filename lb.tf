# This file contains load balancer and target group resources

# Application load balancer. Recieves traffic from the internet and distributes across targets
resource "aws_lb" "ecs_lb" {
  name               = "${var.project_name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [module.ecs_vpc.public_subnets[0], module.ecs_vpc.public_subnets[1]]

  tags = {
    Environment = "development"
  }
}

# Application load balancer listner. Listens for traffic on port 80 and forwards traffic to Target group
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.ecs_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.id
  }

  tags = {
    Environment = "development"
  }
}

# Target group with basic health check. Routes traffic to targets(ECS service)
resource "aws_lb_target_group" "ecs_tg" {
  name        = "${var.project_name}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.ecs_vpc.vpc_id

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "5"
    path                = "/"
    unhealthy_threshold = "2"
  }

  tags = {
    Environment = "development"
  }
}
