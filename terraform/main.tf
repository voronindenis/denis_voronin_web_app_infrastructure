# Initialize Selectel provider with service user.
provider "selectel" {
  username    = var.username
  password    = var.password
  domain_name = var.domain_name
  auth_region = var.region
  auth_url    = var.auth_url
}

# Create the main project with user.
# This module should be applied first:
# terraform apply -target=module.project_with_user
module "project_with_user" {
  source = "./modules/project_with_user"

  project_name      = var.project_name
  project_user_name = var.project_user_name
  user_password     = var.user_password
}

# Initialize Openstack provider.
provider "openstack" {
  user_name           = var.project_user_name
  tenant_name         = var.project_name
  password            = var.user_password
  project_domain_name = var.domain_name
  user_domain_name    = var.domain_name
  auth_url            = var.auth_url
  region              = var.region
}

# Create an OpenStack Compute instance.
module "server" {
  source = "./modules/server_remote_root_disk"

  # OpenStack Instance parameters.
  keypair_name           = var.keypair_name
  server_group_id        = var.server_group_id
  server_image_name      = var.server_image_name
  server_license_type    = var.server_license_type
  server_name            = var.server_name
  server_preemptible_tag = var.server_preemptible_tag
  server_ram_mb          = var.server_ram_mb
  server_root_disk_gb    = var.server_root_disk_gb
  server_vcpus           = var.server_vcpus
  server_volume_metadata = var.server_volume_metadata
  server_volume_type     = var.server_volume_type
  server_zone            = var.server_zone

  depends_on = [
    module.project_with_user,
  ]
}
