########################################################################################################################
# Outputs
########################################################################################################################

output "name" {
  description = "Name of created SCC WP instance."
  value       = local.catalog_id
}

output "name2" {
  description = "Name of created SCC WP instance."
  value       = local.catalog_revision
}
