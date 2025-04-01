# Private Servers (Non-AZ Spread)
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

# Application Servers (AZ Spread: 2 per application)
resource "aws_instance" "applications" {
  for_each = var.applications
  count    = 2

  ami           = each.value.ami_ids[0]
  instance_type = each.value.instance_type
  subnet_id     = each.value.subnet_ids[count.index]
  key_name      = each.value.key_name

  vpc_security_group_ids = [for sg in each.value.security_groups : var.vpc_security_group_ids[sg]]
  iam_instance_profile   = var.common_iam_role != "" ? var.common_iam_role : null

  tags = merge(var.common_tags, {
    Name   = "${each.key}-${count.index + 1}",
    Type   = "Application",
    Domain = each.value.domain_name
  })
}

# Public Instances (Non-AZ Spread)
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
 
