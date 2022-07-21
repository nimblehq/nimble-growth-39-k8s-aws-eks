output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "s3_alb_log_bucket_name" {
  description = "S3 bucket name for ALB log"
  value       = module.s3.aws_alb_log_bucket_name
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_id" {
  description = "AWS EKS cluster ID"
  value       = module.eks.cluster_id
}
