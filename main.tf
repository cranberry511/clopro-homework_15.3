/*resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "public" {
  name           = var.vpc_public_subnet_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.public_cidr
}

resource "yandex_vpc_subnet" "private" {
  name           = var.vpc_private_subnet_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.private_cidr
  route_table_id = yandex_vpc_route_table.rt.id
}

resource "yandex_compute_instance" "nat-instance" {
  name        = var.nat-instance
  zone        = var.default_zone
  platform_id = var.vm_platform_id

  resources {
    cores  = var.vm_cpu
    memory = var.vm_ram
    core_fraction = var.vm_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id =var.vm_image_id
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.public.id
    nat        = var.vm_nat
    ip_address = var.vm_ip_address
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}

resource "yandex_compute_instance" "public_vm" {
  name        = var.public_vm
  zone        = var.default_zone
  platform_id = var.vm_platform_id

  resources {
    cores  = var.vm_cpu
    memory = var.vm_ram
    core_fraction = var.vm_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id =var.vm_image_id
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.public.id
    nat        = var.vm_nat
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}

resource "yandex_compute_instance" "private_vm" {
  name        = var.private_vm
  zone        = var.default_zone
  platform_id = var.vm_platform_id

  resources {
    cores  = var.vm_cpu
    memory = var.vm_ram
    core_fraction = var.vm_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id =var.vm_image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_preemptible
  } 

  network_interface {
    subnet_id  = yandex_vpc_subnet.private.id
    nat        = var.private_vm_nat
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}

resource "yandex_vpc_route_table" "rt" {
  name       = "my-route-table"
  network_id = yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.vm_ip_address
  }
}*/

resource "random_string" "unique_id" {
  length  = 8
  upper   = false
  lower   = true
  numeric = true
  special = false
}

resource "yandex_kms_symmetric_key" "my_key" {
  name              = "my-kms-key"
  default_algorithm = "AES_256"
  rotation_period   = "24h"
}

resource "yandex_storage_bucket" "my_bucket" {
  bucket     = "mybucket-${random_string.unique_id.result}"
  folder_id  = var.folder_id
  force_destroy = true
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.my_key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "yandex_storage_object" "cat_picture" {
  bucket = "mybucket-${random_string.unique_id.result}"
  key    = "cat.jpg"
  source = "kotik.jpg"
  acl    = "public-read"
  depends_on = [yandex_storage_bucket.my_bucket]
}

/*data "yandex_iam_service_account" "sa" {
  name = "my-account"
}
resource "yandex_compute_instance_group" "ig1" {
  name                = "ig1"
  service_account_id  = data.yandex_iam_service_account.sa.id
  instance_template {
    platform_id = var.vm_platform_id
    resources {
      memory = var.vm_ram
      cores  = var.vm_cpu
      core_fraction = var.vm_core_fraction
    }

    boot_disk {
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
      }
    }
    scheduling_policy {
      preemptible = var.vm_preemptible
    }    
    network_interface {
      network_id = yandex_vpc_network.develop.id
      subnet_ids = [yandex_vpc_subnet.public.id]
    }
    metadata = {
      user-data = data.template_file.cloudinit.rendered
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = [var.default_zone]
  }

  health_check {
    http_options {
      port = 80
      path = "/"
    }
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 2
  }

  load_balancer {
    target_group_name = "my-target-group"
  }
}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    ssh_public_key     = file("~/.ssh/id_ed25519.pub")
    bucket_name        = "mybucket-${random_string.unique_id.result}"
  }
}

resource "yandex_lb_network_load_balancer" "my_nlb" {
  name = "my-network-load-balancer"

  listener {
    name = "my-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.ig1.load_balancer.0.target_group_id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}*/
