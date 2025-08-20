terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"
    }
  }
}

provider "kubernetes" {
  config_path = "C:/Users/olga/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "C:/Users/olga/.kube/config"
  }
}