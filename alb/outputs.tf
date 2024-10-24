output "alb_arn" {
  value = aws_lb.devops.arn
}

output "alb_dns_name" {
  value = aws_lb.devops.dns_name
}