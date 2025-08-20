resource "helm_release" "frontend" {
  name       = "todolist-frontend"
  repository = null
  chart      = "./frontend"
  namespace  = "default"
  timeout    = 600
  wait       = true

  set {
    name  = "replicaCount"
    value = "1"
  }

  # Image
  set {
    name  = "image.repository"
    value = "sudolicious1/todolist-frontend"
  }

  set {
    name  = "image.pullPolicy"
    value = "Always"
  }

  # Service
  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  set {
    name  = "service.port"
    value = "80"
  }

  # Ingress
  set {
    name  = "ingress.enabled"
    value = "true"
  }

  set {
    name  = "ingress.className"
    value = "nginx"
  }

  set {
    name  = "ingress.hosts[0].host"
    value = "altenar-internship-2025.com"
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
  value = "\"false\""
  }

  set {
  name  = "ingress.hosts[0].paths[0].backend.serviceName"
  value = "todolist-frontend"
  }

  set {
  name  = "ingress.hosts[0].paths[0].backend.servicePort"
  value = "80"
  }
  
  set {
  name  = "ingress.hosts[0].paths[1].backend.serviceName"
  value = "todolist-backend"
  }

  set {
  name  = "ingress.hosts[0].paths[1].backend.servicePort"
  value = "8080"
  }

  # backend
  set {
    name  = "backend.serviceName"
    value = "todolist-backend"
  }

  set {
    name  = "backend.servicePort"
    value = "8080"
  }

  # Переменные окружения
  set {
    name  = "env.REACT_APP_API_BASE_URL"
    value = "/api"
  }

  # Зависимости
  depends_on = [helm_release.backend]
}