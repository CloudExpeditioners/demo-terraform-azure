variable "app_name" {
  description = "Application name"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]{1,16}$", var.app_name))
    error_message = "App name must contain only lowercase letters, numbers and hyphens, maximum 16 characters."
  }
}

variable "environment" {
  description = "Environment name"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "location" {
  description = "Azure region location"
  type        = string
}
