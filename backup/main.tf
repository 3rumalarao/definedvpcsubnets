resource "aws_backup_vault" "this" {
  name = "${var.environment}-backup-vault"
  tags = var.common_tags
}

resource "aws_backup_plan" "this" {
  count = var.backup_and_observability.enable_backup ? 1 : 0

  name = "${var.environment}-backup-plan"

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.this.name
    schedule          = var.backup_and_observability.backup_schedule

    lifecycle {
      delete_after = var.backup_and_observability.backup_retention_days
    }
  }

  tags = var.common_tags
}
