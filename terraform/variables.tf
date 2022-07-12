variable "environment" {
  description = "The application environment, used to tag the resources, e.g. `acme-web-staging`"
  type        = string
}

variable "owner" {
  description = "The owner of the infrastructure, used to tag the resources, e.g. `acme-web`"
  type        = string
}

variable "namespace" {
  description = "The namespace for the application infrastructure on AWS, e.g. acme-web"
  type        = string
}

variable "app_port" {
  description = "Application running port"
  type        = number
}
variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "nimble_office_ip" {
  description = "Nimble Office IP"
}

variable "image_limit" {
  description = "Sets max amount of the latest develop images to be kept"
  type        = number
}

variable "health_check_path" {
  description = "Application health check path"
  type        = string
}

variable "domain" {
  description = "Application domain"
  type        = string
}

variable "rds_instance_type" {
  description = "The RDB instance type"
  type        = string
}

variable "rds_database_name" {
  description = "RDS database name"
  type        = string
}

variable "rds_username" {
  description = "RDS username"
  type        = string
}

variable "rds_password" {
  description = "RDS password"
  type        = string
}

variable "rds_autoscaling_min_capacity" {
  description = "Minimum number of RDS read replicas when autoscaling is enabled"
  type        = number
}

variable "rds_autoscaling_max_capacity" {
  description = "Maximum number of RDS read replicas when autoscaling is enabled"
  type        = number
}

variable "bastion_image_id" {
  description = "The AMI image ID for the bastion instance"
  default     = "ami-0801a1e12f4a9ccc0"
}

variable "bastion_instance_type" {
  description = "The bastion instance type"
  default     = "t3.nano"
}

variable "bastion_instance_desired_count" {
  description = "The desired number of the bastion instance"
  default     = 1
}

variable "bastion_max_instance_count" {
  description = "The maximum number of the instance"
  default     = 1
}

variable "bastion_min_instance_count" {
  description = "The minimum number of the instance"
  default     = 1
}

variable "secret_key_base" {
  description = "The Secret key base for the application"
  type        = string
}
