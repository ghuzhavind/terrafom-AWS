output "webserver_instance_id" {
  value = aws_instance.my_web_server.id
}

output "webserver_public_ip" {
  value = aws_eip.my_static_ip.public_ip
}

output "webserver_security_group_id" {
  value = aws_security_group.my_web_server.id
}
output "webserver_security_group_arn" {
  value       = aws_security_group.my_web_server.arn
  description = "Amazon Resource Name"
}
