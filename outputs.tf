output "repository_url" {
  description = "URL de la page GitHub du repository"
  value       = github_repository.repo.html_url
}

output "repository_https_clone_url" {
  description = "URL HTTPS pour cloner le repository"
  value       = github_repository.repo.http_clone_url
}

output "repository_ssh_clone_url" {
  description = "URL SSH pour cloner le repository"
  value       = github_repository.repo.ssh_clone_url
}

output "repository_full_name" {
  description = "Nom complet du repository (owner/repo)"
  value       = github_repository.repo.full_name
}
