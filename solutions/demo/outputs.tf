# #######################################################################################################################
# Outputs
# #######################################################################################################################

output "terraform_enterprise_hostname" {
  description = "Hostname of the (newly created) Terraform Enterprise instance."
  value       = module.tfe-demo.terraform_enterprise_hostname
}

# output "name" {
#   description = "Name of created SCC WP instance."
#   value       = module.tfe-demo.name
# }

# output "name2" {
#   description = "Name of created SCC WP instance."
#   value       = module.tfe-demo.name2
#   sensitive   = true
# }

# output "name3" {
#   description = "Name of created SCC WP instance."
#   value       = module.tfe-demo.name3
#   sensitive   = true
# }

# output "name4" {
#   description = "Name of created SCC WP instance."
#   value       = module.tfe-demo.name4
#   sensitive   = true
# }

# output "name_" {
#   description = ""
#   value       = data.ibm_iam_auth_token.auth_token
# }
