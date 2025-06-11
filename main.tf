resource "restapi_object" "catalog_info" { # get catalog content
  path           = "/api/v1-beta/catalogaccount"
  data           = ""
  create_method  = "GET" # Specify the HTTP method for updates
  update_method  = "GET"
  destroy_method = "GET"
}

locals {
  catalog_id       = restapi_object.catalog_info.api_data["id"]
  catalog_revision = restapi_object.catalog_info.api_data["_rev"]
}


resource "restapi_object" "tfe-engines" { # real call
  path = "/api/v1-beta/catalogaccount"
  data = jsonencode({
    id   = local.catalog_id
    _rev = local.catalog_revision
    terraform_engines = [
      {
        name : var.tfe_engine_name
        type           = "tfe"
        public_endoint = var.tfe_endpoint       // Host name for TFE instance
        api_token      = var.tfe_instance_token // Token for TFE instance
        da_creation = {
          enabled                    = var.da_creation_enabled // True --> auto-create DAs in private catalog from workspace
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
