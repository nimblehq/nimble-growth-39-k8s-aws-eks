variable "namespace" {
  description = "Namespace for the VPCs, used as the prefix for the VPC names, e.g. acme-web-staging"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs to attach to the EKS"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
