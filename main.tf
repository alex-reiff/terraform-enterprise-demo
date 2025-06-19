resource "terraform_data" "auto_replace" {
  input = timestamp()
}

resource "null_resource" "echo1" {
  provisioner "local-exec" {
    command     = "echo \"### Retrieving current global catalog settings...\""
    interpreter = ["/bin/bash", "-c"]
  }
  lifecycle {
    replace_triggered_by = [
      terraform_data.auto_replace
    ]
  }
}

data "ibm_cm_account" "cm_account" {}

resource "null_resource" "echo2" {
  depends_on = [null_resource.echo1]
  provisioner "local-exec" {
    command     = "echo \"### Retrieved global catalog settings.\n### Validating Terraform Enterprise configuration...\""
    interpreter = ["/bin/bash", "-c"]
  }
  lifecycle {
    replace_triggered_by = [
      terraform_data.auto_replace
    ]
  }
}

locals {
  data = {
    id   = data.ibm_cm_account.cm_account.id
    _rev = data.ibm_cm_account.cm_account.rev

    # pass thru
    account_filters = {
      include_all = data.ibm_cm_account.cm_account.account_filters[0].include_all,
      id_filters  = data.ibm_cm_account.cm_account.account_filters[0].id_filters[0]
    }

    terraform_engines = [
      {
        name            = var.terraform_enterprise_engine_name
        type            = "terraform_enterprise"
        public_endpoint = var.terraform_enterprise_hostname
        api_token       = var.terraform_enterprise_instance_token
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
  }
}

resource "null_resource" "echo3" {
  depends_on = [null_resource.echo2]
  provisioner "local-exec" {
    command     = "echo \"### Terraform Enterprise is properly configured. Beginning installation...\""
    interpreter = ["/bin/bash", "-c"]
  }
  lifecycle {
    replace_triggered_by = [
      terraform_data.auto_replace
    ]
  }
}

resource "null_resource" "echo4" {
  depends_on = [null_resource.echo3]
  provisioner "local-exec" {
    command     = "echo \"### Installation completed!\n### Adding to global catalog configuration...\""
    interpreter = ["/bin/bash", "-c"]
  }
  lifecycle {
    replace_triggered_by = [
      terraform_data.auto_replace
    ]
  }
}

resource "restapi_object" "tfe-engines" {
  path           = "/api/v1-beta/catalogaccount"
  data           = jsonencode(local.data)
  create_method  = "PUT" # Specify the HTTP method for updates
  update_method  = "PUT"
  destroy_method = "PUT"
}

resource "null_resource" "echo5" {
  depends_on = [null_resource.echo4]
  provisioner "local-exec" {
    command     = "echo \"### Terraform enterprise now configured in global catalog.\n### Access it here: $TFE_HOSTNAME\""
    interpreter = ["/bin/bash", "-c"]
    environment = {
      TFE_HOSTNAME = var.terraform_enterprise_hostname
    }
  }
  lifecycle {
    replace_triggered_by = [
      terraform_data.auto_replace
    ]
  }
}
