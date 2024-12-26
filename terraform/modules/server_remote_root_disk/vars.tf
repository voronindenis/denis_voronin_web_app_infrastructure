variable "server_vcpus" {
  default = 4
}

variable "server_ram_mb" {
  default = 8192
}

variable "server_root_disk_gb" {
  default = 8
}

variable "server_volume_type" {
  default = "fast.ru-9a"
}

variable "server_volume_metadata" {
  default = {}
}

variable "server_name" {
  default = "server_1"
}

variable "server_image_name" {}

variable "server_zone" {
  default = "ru-9a"
}

variable "server_license_type" {
  default = ""
}
variable "server_group_id" {
  default = ""
}

variable "server_preemptible_tag" {
  default = []
}

variable "keypair_name" {
  default = "keypair_1"
}

