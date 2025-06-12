########################################################################################################################
# TFE
########################################################################################################################

module "tfe-demo" {
  source                                            = "../.."
  terraform_enterprise_engine_name                  = var.terraform_enterprise_engine_name
  terraform_enterprise_hostname                     = var.terraform_enterprise_hostname
  terraform_enterprise_instance_token               = var.terraform_enterprise_instance_token
  enable_automatic_deployable_architecture_creation = var.enable_automatic_deployable_architecture_creation
  default_private_catalog_id                        = var.default_private_catalog_id
}
