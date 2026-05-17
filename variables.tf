###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-e"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "public_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "private_cidr" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network"
}

variable "vpc_public_subnet_name" {
  type        = string
  default     = "public"
  description = "VPC public subnet name"
}

variable "vpc_private_subnet_name" {
  type        = string
  default     = "private"
  description = "VPC private subnet name"
}

variable "nat-instance" {
  type        = string
  default     = "nat-instance"
  description = "NAT instance name"
}

variable "vm_cpu" {
  type        = number
  default     = 2
}

variable "vm_ram" {
  type        = number
  default     = 2
}

variable "vm_core_fraction" {
  type        = number
  default     = 20
}

variable "vm_preemptible" {
  type        = bool
  default     = true
}

variable "vm_image_id" {
  type        = string
  default     = "fd80mrhj8fl2oe87o4e1"
}

variable "vm_ip_address" {
  type        = string
  default     = "192.168.10.254"
}

variable "vm_nat" {
  type        = bool
  default     = true
}

variable "private_vm" {
  type        = string
  default     = "private_vm"
  description = "private VM instance name"
}

variable "private_vm_nat" {
  type        = bool
  default     = false
}

variable "public_vm" {
  type        = string
  default     = "public_vm"
  description = "public VM instance name"
}

variable "public_vm_nat" {
  type        = bool
  default     = true
}

variable "vm_platform_id" {
  type        = string
  default     = "standard-v3"
}