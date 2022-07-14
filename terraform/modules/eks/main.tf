locals {
  name = "${var.namespace}-eks"
  tags = {
    Example    = local.name
    GithubRepo = "nimble-growth-39-k8s-aws-eks"
    GithubOrg  = "nimblehq"
  }
}

resource "aws_kms_key" "eks" {
  description             = "EKS Secret Encryption Key"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = local.tags
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 18.0"
  cluster_name    = local.name
  cluster_version = "1.22"

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  cluster_addons = {
    # Note: https://docs.aws.amazon.com/eks/latest/userguide/fargate-getting-started.html#fargate-gs-coredns
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  cluster_encryption_config = [{
    provider_key_arn = aws_kms_key.eks.arn
    resources        = ["secrets"]
  }]

  eks_managed_node_groups = {
    default = {
      desired_size = 2

      labels = {
        Example    = "managed_node_groups"
        GithubRepo = "nimble-growth-39-k8s-aws-eks"
        GithubOrg  = "nimblehq"
      }
      tags = {
        ExtraTag = "nimble-growth-39-k8s-aws-eks"
      }
    }
  }

  fargate_profiles = {
    default = {
      name = "default"
      selectors = [
        {
          namespace = "backend"
          labels = {
            Application = "backend"
          }
        },
        {
          namespace = "default"
          labels = {
            WorkerType = "fargate"
          }
        }
      ]

      tags = {
        Owner = "Nimble"
      }

      timeouts = {
        create = "20m"
        delete = "20m"
      }
    }
  }
}
