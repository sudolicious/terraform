variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
  default     = "default"
}

variable "backend_image" {
  description = "Docker image Backend"
  type = object({
    repository = string
  })
  default = {
    repository = "sudolicious1/todolist-backend"
  }
}

variable "frontend_image" {
  description = "Docker image Frontend"
  type = object({
    repository = string
  })
  default = {
    repository = "sudolicious1/todolist-frontend"
  }
}