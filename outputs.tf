########################################################################################################################
# Outputs
########################################################################################################################

output "terraform_enterprise_hostname" {
  description = "Hostname of the (newly created) Terraform Enterprise instance."
  value       = var.terraform_enterprise_hostname
}

# output "name" {
#   description = "Name of created SCC WP instance."
#   value       = data.ibm_cm_account.cm_account
# }

# output "name2" {
#   description = "Name of created SCC WP instance."
#   value       = local.data
# }

# output "name3" {
#   description = "Name of created SCC WP instance."
#   value       = data.ibm_cm_account.cm_account.account_filters
# }

# output "name4" {
#   description = "Name of created SCC WP instance."
#   value       = data.ibm_cm_account.cm_account.account_filters[0].id_filters
# }
