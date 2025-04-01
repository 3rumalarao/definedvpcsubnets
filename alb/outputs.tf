output "alb_dns_names" {
  description = "Mapping of application name to ALB DNS names"
  value       = { for k, lb in aws_lb.this : k => lb.dns_name }
}

output "alb_arns" {
  description = "Mapping of application name to ALB ARNs"
  value       = { for k, lb in aws_lb.this : k => lb.arn }
}
