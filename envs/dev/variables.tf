variable "app_name" {
  description = "Application name used for resource naming"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]{1,16}$", var.app_name))
    error_message = "app_name must be 1-16 characters and contain only lowercase letters, numbers, and hyphens."
  }
}

variable "environment" {
  description = "Deployment environment"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string

  validation {
    condition     = var.location != ""
    error_message = "location must not be empty."
  }
}
