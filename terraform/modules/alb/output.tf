output "alb_dns_name" {
  value = aws_alb.application_load_balancer.dns_name
}
output "alb_arn" {
  value = aws_alb.application_load_balancer.arn
}
output "target_groups" {
  value = [ for group in aws_lb_target_group.target_group : {
        id = group.id,
        name = group.name,
        arn = group.arn,
        port = group.port
  }]
}
output "listeners" {
  value = [ for listener in aws_alb_listener.listener: {
    id = listener.id
    arn = listener.arn
    port = listener.port
  }]
}
output "additional_ssl_listener" {
  value = [ for listener in aws_alb_listener.additional_ssl_listener: {
    id = listener.id
    arn = listener.arn
    port = listener.port
  }]
}
output "lb_security_group_id" {
  value = var.balancer_type == "network" ? "" : aws_security_group.load_balancer_security_group[0].id
}