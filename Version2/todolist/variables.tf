variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
  default     = "default"
}


variable "postgresql_config" {
  description = "PostgreSQL Helm chart configuration"
  type = object({
    chart_version    = string
    storage_class   = string
    storage_size    = string
    database        = string
    username        = string
    existing_secret = string
    password_key    = string
    port            = number
  })
  default = {
    chart_version    = "16.2.0"
    storage_class   = "local-path"
    storage_size    = "5Gi"
    database        = "todolist"
    username        = "postgres"
    existing_secret = "postgres-secret"
    password_key    = "POSTGRES_PASSWORD"
    port            = 5432
  }
}

variable "ingress_config" {
  description = "Ingress configuration"
  type = object({
    enabled      = bool
    class_name   = string
    host         = string
  })
  default = {
    enabled      = true
    class_name   = "nginx"
    host         = "altenar-internship-2025.com"
  }
}

variable "backend_service" {
  description = "Backend service configuration"
  type = object({
    type = string
    port = number
  })
  default = {
    type = "ClusterIP"
    port = 8080
  }
}

variable "frontend_service" {
  description = "Frontend service configuration"
  type = object({
    type = string
    port = number
  })
  default = {
    type = "ClusterIP"
    port = 80
  }
}