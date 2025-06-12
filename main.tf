resource "restapi_object" "catalog_info" { # get catalog content
  path           = "/api/v1-beta/catalogaccount"
  data           = ""
  create_method  = "GET"
  update_method  = "GET"
  destroy_method = "GET"
}

locals {
  catalog_id               = restapi_object.catalog_info.api_data["id"]
  catalog_revision         = restapi_object.catalog_info.api_data["_rev"]
  catalog_account_boundary = restapi_object.catalog_info.api_data["account_boundary"]
  catalog_account_filters  = restapi_object.catalog_info.api_data["account_filters"]
  # data = jsonencode({
  #   id   = local.catalog_id
  #   _rev = local.catalog_revision

  #   account_boundary = local.catalog_account_boundary
  #   account_filters  = local.catalog_account_filters
  #   terraform_engines = [
  #     {
  #       name : var.terraform_enterprise_engine_name
  #       type           = "tfe"
  #       public_endoint = var.terraform_enterprise_hostname
  #       api_token      = var.terraform_enterprise_instance_token
  #       da_creation = {
  #         enabled                    = var.enable_automatic_deployable_architecture_creation
  #         default_private_catalog_id = var.default_private_catalog_id
  #         # "polling_info": { // If polling info is not provided, we will try to auto-create DAs in all workspaces in all orgs
  #         #   "scopes": [
  #         #     {
  #         #       "name": "kz-test",
  #         #       "type": "project" // Type can be project | org | workspace to poll on to auto-create DAs
  #         #     }
  #         #   ]
  #         # }
  #       }
  #     }
  #   ]
  # })
}

resource "restapi_object" "tfe-engines" { //need to PUT all fields in the body, TODO pull down whole object and update in place
  path = "/api/v1-beta/catalogaccount"
  data = jsonencode({
    id   = local.catalog_id
    _rev = local.catalog_revision

    account_boundary = local.catalog_account_boundary
    account_filters  = local.catalog_account_filters
    terraform_engines = [
      {
        name : var.terraform_enterprise_engine_name
        type           = "tfe"
        public_endoint = var.terraform_enterprise_hostname
        api_token      = var.terraform_enterprise_instance_token
        da_creation = {
          enabled                    = var.enable_automatic_deployable_architecture_creation
          default_private_catalog_id = var.default_private_catalog_id
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
  })
  create_method  = "PUT" # Specify the HTTP method for updates
  update_method  = "PUT"
  destroy_method = "PUT"
}
