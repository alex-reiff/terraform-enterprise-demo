########################################################################################################################
# Outputs
########################################################################################################################

output "name" {
  description = "Name of created SCC WP instance."
  value       = module.tfe-demo.name
}

output "name2" {
  description = "Name of created SCC WP instance."
  value       = module.tfe-demo.name2
  sensitive   = true
}
