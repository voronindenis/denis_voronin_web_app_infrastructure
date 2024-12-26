variable "username" {}

variable "password" {}

variable "domain_name" {}

variable "project_name" {
  default = "tf_project"
}

variable "project_user_name" {
  default = "tf_user"
}

variable "user_password" {}

variable "keypair_name" {
  default = "keypair_1"
}


variable "auth_url" {
  default = "https://cloud.api.selcloud.ru/identity/v3"
}

variable "region" {
  default = "ru-9"
}

variable "server_name" {
  default = "tf_server"
}

variable "server_zone" {
  default = "ru-9a"
}

variable "server_vcpus" {
  default = 2
}

variable "server_ram_mb" {
  default = 1024
}

variable "server_root_disk_gb" {
  default = 8
}

variable "server_image_name" {
  default = "Ubuntu 22.04 LTS 64-bit"
}

variable "server_volume_type" {
  default = "fast.ru-9a"
}

variable "server_volume_metadata" {
  default = {}
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

variable "user_data" {
  default = ""
}
