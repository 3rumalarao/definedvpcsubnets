output "compute_instances" {
  description = "All compute instances created"
  value       = module.compute.instances
}

output "efs_id" {
  description = "EFS file system ID"
  value       = module.efs.efs_id
}

output "rds_endpoint" {
  description = "RDS MySQL endpoint"
  value       = module.rds.endpoint
}

output "backup_plan_id" {
  description = "Backup plan ID"
  value       = module.backup.backup_plan_id
}
