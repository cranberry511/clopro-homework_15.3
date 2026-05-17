terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "= 0.201"
    }
    template = {
      source = "hashicorp/template"
      version = "= 2.2.0"
    }
    random = {
      source = "hashicorp/random"
      version = "= 3.9.0"
    }
  }
  required_version = "=1.14.0"

}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}