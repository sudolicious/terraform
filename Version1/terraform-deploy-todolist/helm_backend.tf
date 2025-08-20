resource "helm_release" "backend" {
  name       = "todolist-backend"
  repository = null
  chart      = "./backend"
  namespace  = "default"
  timeout    = 600

  set {
    name  = "externalDatabase.host"
    value = "todolist-postgresql.default.svc.cluster.local"
  }

  set {
    name  = "externalDatabase.port"
    value = "5432"
  }

  set {
    name  = "externalDatabase.database"
    value = "todolist"
  }

  set {
    name  = "externalDatabase.user"
    value = "postgres"
  }

  set {
    name  = "externalDatabase.existingSecret"
    value = "postgres-secret"
  }

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  # Зависимости
  depends_on = [helm_release.postgresql]
}