resource "random_string" "random_name" {
  length  = 5
  special = false
}

# module "flavor" {
#   source        = "../flavor"
#   flavor_name   = "flavor-${random_string.random_name.result}"
#   flavor_vcpus  = var.server_vcpus
#   flavor_ram_mb = var.server_ram_mb
# }

module "nat" {
  source = "../nat"
}

resource "openstack_networking_port_v2" "port_1" {
  name       = "${var.server_name}-eth0"
  network_id = module.nat.network_id

  fixed_ip {
    subnet_id = module.nat.subnet_id
  }
}

module "image_datasource" {
  source     = "../image_datasource"
  image_name = var.server_image_name
}

resource "openstack_blockstorage_volume_v3" "volume_1" {
  name              = "volume-for-${var.server_name}"
  size              = var.server_root_disk_gb
  image_id          = module.image_datasource.image_id
  volume_type       = var.server_volume_type
  availability_zone = var.server_zone
  metadata          = var.server_volume_metadata

  lifecycle {
    ignore_changes = [image_id]
  }
}

resource "openstack_compute_instance_v2" "instance_1" {
  name              = var.server_name
  # flavor_id          = module.flavor.flavor_id
  // NOTE: [Denis Voronin] 25.12.2024 - flavor_id is shared Line fixed configurations with vCPU share of 10%;
  // https://docs.selectel.ru/en/cloud/servers/create/configurations/#shared-line
  flavor_id          = "9013"
  key_pair          = var.keypair_name
  availability_zone = var.server_zone

  network {
    port = openstack_networking_port_v2.port_1.id
  }

  dynamic "network" {
    for_each = var.server_license_type != "" ? [var.server_license_type] : []

    content {
      name = var.server_license_type
    }
  }

  block_device {
    uuid             = openstack_blockstorage_volume_v3.volume_1.id
    source_type      = "volume"
    destination_type = "volume"
    boot_index       = 0
  }

  tags = var.server_preemptible_tag

  vendor_options {
    ignore_resize_confirmation = true
  }

  dynamic "scheduler_hints" {
    for_each = var.server_group_id != "" ? [var.server_group_id] : []
    content {
      group = var.server_group_id
    }
  }
}

module "floatingip" {
  source = "../floatingip"
}

resource "openstack_networking_floatingip_associate_v2" "association_1" {
  port_id     = openstack_networking_port_v2.port_1.id
  floating_ip = module.floatingip.floatingip_address
}
