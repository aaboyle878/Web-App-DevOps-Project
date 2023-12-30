variable "aks_cluster_name" {
  description = "AKS Cluster Name"
  type = string 
  default = "aaronsDevopsWebAppcluster"
}

variable "cluster_location" {
  description = "Location for the AKS Cluster"
  type = string
  default = "UK South"
}

variable "dns_prefix" {
  type = string
  default = "WebApp"
}

variable "kubernetes_version" {
  type = string
  default = "1.28.4"
}

variable "service_principal_client_id" {
  type = string
  default = "ec344146-68dc-4625-9869-bae7cd165838"
}

variable "service_principal_client_secret" {
  type = string
  default = "ebo8Q~BMVIU_e_VOqiZ3mXWVmNBsTedA6GJAvaO3"
}

# Input variables from the networking module
variable "resource_group_name" {
  type = string
}

variable "vnet_id" {
  type = string
}

variable "control_plane_subnet_id" {
  type = string
}

variable "worker_node_subnet_id" {
  type = string
}

variable "aks_nsg_id" {
  type = string
}
