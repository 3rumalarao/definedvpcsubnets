locals {
  # Flatten the applications map to create two instances per application.
  app_instances = flatten([
    for app_key, app in var.applications : [
      for i in range(2) : {
        app_key         = app_key,
        index           = i,
        instance_config = app
      }
    ]
  ])
}

# Private Servers
resource "aws_instance" "private_servers" {
  for_each = var.private_servers

  ami           = each.value.ami_ids[0]
  instance_type = each.value.instance_type
  subnet_id     = each.value.subnet_id
  key_name      = each.value.key_name

  vpc_security_group_ids = [for sg in each.value.security_groups : var.vpc_security_group_ids[sg]]
  iam_instance_profile   = var.common_iam_role != "" ? var.common_iam_role : null

  tags = merge(var.common_tags, {
    Name = each.key,
    Type = "Private"
  })
}

# Application Servers
resource "aws_instance" "applications" {
  for_each = { for item in local.app_instances : "${item.app_key}-${item.index}" => item }

  ami           = each.value.instance_config.ami_ids[0]
  instance_type = each.value.instance_config.instance_type
  subnet_id     = each.value.instance_config.subnet_ids[each.value.index]
  key_name      = each.value.instance_config.key_name

  vpc_security_group_ids = [for sg in each.value.instance_config.security_groups : var.vpc_security_group_ids[sg]]
  iam_instance_profile   = var.common_iam_role != "" ? var.common_iam_role : null

  tags = merge(var.common_tags, {
    Name   = "${each.value.app_key}-${each.value.index + 1}",
    Type   = "Application",
    Domain = each.value.instance_config.domain_name
  })
}

# Public Instances
resource "aws_instance" "public_instances" {
  for_each = var.public_instances

  ami           = each.value.ami_ids[0]
  instance_type = each.value.instance_type
  subnet_id     = each.value.subnet_id
  key_name      = each.value.key_name

  vpc_security_group_ids = [for sg in each.value.security_groups : var.vpc_security_group_ids[sg]]
  iam_instance_profile   = var.common_iam_role != "" ? var.common_iam_role : null

  associate_public_ip_address = true

  tags = merge(var.common_tags, {
    Name = each.key,
    Type = "Public"
  })
}
