########################################################################################################################
# TFE
########################################################################################################################

module "tfe-demo" {
  source                              = "../.."
  terraform_enterprise_engine_name    = "my-tfe"
  terraform_enterprise_hostname       = "https://ibm-tfe.schematics.test.cloud.ibm.com/"
  terraform_enterprise_instance_token = "1123"
}
