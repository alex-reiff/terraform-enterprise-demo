########################################################################################################################
# Input Variables
########################################################################################################################

variable "tfe_engine_name" {
  type        = string
  description = "List of resource tag to associate with the instance."
  default     = "tfe-demo"
}

variable "tfe_endpoint" {
  type        = string
  description = "List of resource tag to associate with the instance."
}

variable "tfe_instance_token" {
  type        = string
  description = "List of resource tag to associate with the instance."
}

variable "da_creation_enabled" {
  type        = bool
  description = "List of resource tag to associate with the instance."
  default     = false
}

variable "default_private_catalog_id" {
  type        = string
  description = "List of resource tag to associate with the instance."
  default     = null
}
