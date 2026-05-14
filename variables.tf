variable "github_token" {
  description = "GitHub Personal Access Token (classic) avec les droits repo et workflow"
  type        = string
  sensitive   = true
}

variable "github_owner" {
  description = "Ton username GitHub ou le nom de ton organisation"
  type        = string
}

variable "repo_name" {
  description = "Nom du repository GitHub à créer"
  type        = string
}

variable "repo_description" {
  description = "Description du repository"
  type        = string
  default     = ""
}

variable "gitignore_template" {
  description = "Template .gitignore à utiliser (ex: Terraform, Python, Node, Go...)"
  type        = string
  default     = "Terraform"
}

variable "collaborators" {
  description = "Map des collaborateurs GitHub : username => permission (pull, push, maintain, triage, admin)"
  type        = map(string)
  default     = {}
}
