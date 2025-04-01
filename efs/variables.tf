variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "efs" {
  description = "EFS configuration"
  type = object({
    performance_mode = string
    encrypted        = bool
    efs_mount_points = list(string)
  })
}

variable "common_tags" {
  type = map(string)
}

variable "environment" {
  type = string
}

variable "efs_security_groups" {
  description = "Security groups for EFS mount targets"
  type        = list(string)
  default     = []
}
 
