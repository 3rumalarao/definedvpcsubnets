resource "aws_db_subnet_group" "this" {
  name       = "${var.environment}-db-subnet-group"
  subnet_ids = var.rds_mysql.subnet_ids

  tags = merge(var.common_tags, {
    Name = "${var.environment}-db-subnet-group"
  })
}

resource "aws_db_instance" "mysql" {
  count                   = var.rds_mysql.enabled ? 1 : 0
  identifier              = "${var.environment}-mysql"
  engine                  = var.rds_mysql.engine
  instance_class          = var.rds_mysql.instance_class
  allocated_storage       = var.rds_mysql.allocated_storage
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = var.rds_mysql.security_groups
  backup_retention_period = var.rds_mysql.backup_retention_days

  tags = merge(var.common_tags, {
    Name = "${var.environment}-mysql"
  })
}
