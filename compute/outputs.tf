output "instances" {
  value = {
    private_servers = aws_instance.private_servers,
    applications    = aws_instance.applications,
    public_instances = aws_instance.public_instances
  }
}
