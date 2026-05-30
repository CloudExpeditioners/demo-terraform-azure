variable "app_name" {
  description = "Application name"
  type        = string
  default     = "demo"

  validation {
    condition     = length(var.app_name) > 0 && length(var.app_name) <= 10
    error_message = "App name must be between 1 and 10 characters."
  }
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "westeurope"

  validation {
    condition     = length(var.location) > 0
    error_message = "Location cannot be empty."
  }
}
