output "instances" {
  value = {
    private_servers = aws_instance.private_servers,
    applications    = aws_instance.applications,
    public_instances = aws_instance.public_instances
  }
}

output "application_instances" {
  description = "Mapping of application name to list of instance IDs"
  value = {
    for app in keys(var.applications) : app =>
    [
      for i in range(0,2) : aws_instance.applications[app][i].id
    ]
  }
}
