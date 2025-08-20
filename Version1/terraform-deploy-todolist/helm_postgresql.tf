resource "helm_release" "postgresql" {
  name       = "todolist-postgresql"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = "16.2.0"
  namespace  = "default"
  force_update = true  # Добавляем принудительное обновление
  recreate_pods = true # Пересоздаем поды при обновлении
  timeout    = 600  # Увеличиваем общий таймаут до 10 минут

  set {
    name  = "global.postgresql.auth.existingSecret"
    value = "postgres-secret"
  }

  set {
    name  = "global.postgresql.auth.secretKeys.userPasswordKey"
    value = "POSTGRES_PASSWORD"
  }

  set {
    name  = "global.postgresql.auth.username"
    value = "postgres"
  }

  set {
    name  = "global.postgresql.auth.database"
    value = "todolist"
  }

  # Настройки persistence
  set {
    name  = "primary.persistence.enabled"
    value = "true"
  }

  set {
    name  = "primary.persistence.storageClass"
    value = "local-path"
  }

  set {
    name  = "primary.persistence.size"
    value = "5Gi"  # Явно указываем размер тома
  }

  # Оптимальные настройки для проверок
  set {
    name  = "primary.readinessProbe.initialDelaySeconds"
    value = "30"  # Задержка перед первой проверкой
  }

  set {
    name  = "primary.readinessProbe.periodSeconds"
    value = "15"  # Интервал между проверками
  }

  set {
    name  = "primary.readinessProbe.timeoutSeconds"
    value = "10"  # Таймаут проверки
  }

  set {
    name  = "primary.startupProbe.enabled"
    value = "true"  # Включаем startup probe
  }

  set {
    name  = "primary.startupProbe.initialDelaySeconds"
    value = "30"
  }

  # Ресурсы для контейнера
  set {
    name  = "primary.resources.requests.memory"
    value = "512Mi"
  }

  set {
    name  = "primary.resources.requests.cpu"
    value = "500m"
  }
}