# This file contains specified outputs of created resources
# Here we have the load balancer DNS name. We can copy and paste in a browser to see our service when it is up and running 
output "lb_dns_name" {
  value = aws_lb.ecs_lb.dns_name
}
