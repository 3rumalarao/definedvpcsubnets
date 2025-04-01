resource "aws_efs_file_system" "this" {
  performance_mode = var.efs.performance_mode
  encrypted        = var.efs.encrypted

  tags = merge(var.common_tags, {
    Name = "${var.environment}-efs"
  })
}

resource "aws_efs_mount_target" "this" {
  for_each = toset(var.private_subnets)

  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = each.value
  security_groups = var.efs_security_groups
}
 
