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

resource "null_resource" "run_kubespray" {
  provisioner "local-exec" {
    command = "wsl bash /mnt/c/Users/olga/terraform/Version4/todolist/kubespray_setup.sh"
  }
}

resource "null_resource" "wait_for_kubeconfig" {
  provisioner "local-exec" {
    command = <<EOT
      echo "Waiting for kubeconfig..."
      timeout /t 60 /nobreak
      if exist "C:\\Users\\olga\\.kube\\config" (
        echo "Kubeconfig created!"
      ) else (
        echo "Kubeconfig not found"
        exit 1
      )
    EOT
  }

  depends_on = [null_resource.run_kubespray]
}

# Deploy Todolist with helm
resource "helm_release" "postgresql" {
  name       = "todolist-postgresql"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = var.postgresql_config.chart_version
  namespace  = var.namespace
  timeout    = 600

  set {
    name  = "global.postgresql.auth.existingSecret"
    value = var.postgresql_config.existing_secret
  }

  set {
    name  = "global.postgresql.auth.secretKeys.userPasswordKey"
    value = var.postgresql_config.password_key
  }

  set {
    name  = "global.postgresql.auth.username"
    value = var.postgresql_config.username
  }

  set {
    name  = "global.postgresql.auth.database"
    value = var.postgresql_config.database
  }

  set {
    name  = "primary.persistence.enabled"
    value = "true"
  }

  set {
    name  = "primary.persistence.storageClass"
    value = var.postgresql_config.storage_class
  }

  set {
    name  = "primary.persistence.size"
    value = var.postgresql_config.storage_size
  }

  # Wait for kubeconfig
  depends_on = [
    null_resource.wait_for_kubeconfig,
    null_resource.run_kubespray
  ]
}

resource "helm_release" "backend" {
  name       = "todolist-backend"
  repository = null
  chart      = "./backend"
  namespace  = var.namespace
  wait       = true  #wait for pod readiness
  timeout    = 600

set {
    name  = "externalDatabase.host"
    value = "todolist-postgresql.${var.namespace}.svc.cluster.local"
  }

  set {
    name  = "externalDatabase.port"
    value = var.postgresql_config.port
  }

  set {
    name  = "externalDatabase.database"
    value = var.postgresql_config.database
  }

  set {
    name  = "externalDatabase.user"
    value = var.postgresql_config.username
  }

  set {
    name  = "externalDatabase.existingSecret"
    value = var.postgresql_config.existing_secret
  }

  set {
    name  = "service.type"
    value = var.backend_service.type
  }

  set {
    name  = "service.port"
    value = var.backend_service.port
  }

  depends_on = [helm_release.postgresql]
}

resource "helm_release" "frontend" {
  name       = "todolist-frontend"
  repository = null
  chart      = "./frontend"
  namespace  = var.namespace
  timeout    = 600
  wait       = true

  set {
    name  = "service.type"
    value = var.frontend_service.type
  }

  set {
    name  = "service.port"
    value = var.frontend_service.port
  }

  set {
    name  = "ingress.enabled"
    value = var.ingress_config.enabled
  }

  set {
    name  = "ingress.className"
    value = var.ingress_config.class_name
  }

  set {
    name  = "ingress.hosts[0].host"
    value = var.ingress_config.host
  }

  set {
    name  = "ingress.hosts[0].paths[0].path"
    value = "/"
  }

  set {
    name  = "ingress.hosts[0].paths[0].pathType"
    value = "Prefix"
  }

  set {
    name  = "ingress.hosts[0].paths[1].path"
    value = "/api"
  }

  set {
    name  = "ingress.hosts[0].paths[1].pathType"
    value = "Prefix"
  }

  set {
    name  = "ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/rewrite-target"
    value = "/$1"
  }

  set {
    name  = "ingress.annotations.nginx\\.ingress\\.kubernetes\\.io/ssl-redirect"
    value = "false"
  }

  set {
    name  = "ingress.hosts[0].paths[0].backend.serviceName"
    value = "todolist-frontend"
  }

  set {
    name  = "ingress.hosts[0].paths[0].backend.servicePort"
    value = var.frontend_service.port
  }

  set {
    name  = "ingress.hosts[0].paths[1].backend.serviceName"
    value = "todolist-backend"
  }

  set {
    name  = "ingress.hosts[0].paths[1].backend.servicePort"
    value = var.backend_service.port
  }

  set {
    name  = "backend.serviceName"
    value = "todolist-backend"
  }

  set {
    name  = "backend.servicePort"
    value = var.backend_service.port
  }

  set {
    name  = "env.REACT_APP_API_BASE_URL"
    value = "/api"
  }

  depends_on = [helm_release.backend]
}
