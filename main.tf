data "ibm_cm_account" "cm_account" {}

locals {
  data = {
    id   = data.ibm_cm_account.cm_account.id
    _rev = data.ibm_cm_account.cm_account.rev

    account_filters = data.ibm_cm_account.cm_account.account_filters
    terraform_engines = [
      {
        name : var.terraform_enterprise_engine_name
        type           = "terraform_enterprise"
        public_endoint = var.terraform_enterprise_hostname
        api_token      = var.terraform_enterprise_instance_token
        da_creation = {
          enabled = var.enable_automatic_deployable_architecture_creation
          # default_private_catalog_id = var.default_private_catalog_id
          # "polling_info": { // If polling info is not provided, we will try to auto-create DAs in all workspaces in all orgs
          #   "scopes": [
          #     {
          #       "name": "kz-test",
          #       "type": "project" // Type can be project | org | workspace to poll on to auto-create DAs
          #     }
          #   ]
          # }
        }
      }
    ]
  }
}

resource "restapi_object" "tfe-engines" { //need to PUT all fields in the body, TODO pull down whole object and update in place
  path           = "/api/v1-beta/catalogaccount"
  data           = jsonencode(local.data)
  create_method  = "PUT" # Specify the HTTP method for updates
  update_method  = "PUT"
  destroy_method = "PUT"
}
