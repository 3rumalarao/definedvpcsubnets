variable "backup_and_observability" {
  description = "Backup and observability configuration"
  type = object({
    enable_backup         = bool
    backup_schedule       = string
    backup_retention_days = number
    enable_vpc_flow_logs  = bool
  })
}

variable "common_tags" {
  type = map(string)
}

variable "environment" {
  type = string
}
