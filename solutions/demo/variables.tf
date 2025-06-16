########################################################################################################################
# Input variables
########################################################################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API key used to authenticate with the catalog API."
  sensitive   = true
}

variable "region" {
  type        = string
  description = "Region to provision all resources created by this example."
  default     = "us-south"
}

variable "ibmcloud_catalog_management_api_endpoint" {
  type        = string
  description = "The catalog management API endpoint to use. Defaults to the public endpoint. [Learn more](https://cloud.ibm.com/apidocs/resource-catalog/private-catalog#endpoint-url)"
  default     = "https://cm.globalcatalog.test.cloud.ibm.com"
}

variable "terraform_enterprise_engine_name" {
  type        = string
  description = "Name to give to the Terraform Enterprise engine."
  default     = "tfe-demo"
}

variable "terraform_enterprise_hostname" {
  type        = string
  description = "Host name of the Terraform Enterprise instance."
}

variable "terraform_enterprise_instance_token" {
  type        = string
  description = "Token for the Terraform Enterprise instance."
  sensitive   = true
}

variable "enable_automatic_deployable_architecture_creation" {
  type        = bool
  description = "Whether to automatically create Deployable Architectures in associated private catalog from workspace."
  default     = false
}

variable "default_private_catalog_id" {
  type        = string
  description = "If `enable_deployable_architecture_creation` is true, specify the private catalog ID to create the Deployable Architectures in."
  default     = null
}
