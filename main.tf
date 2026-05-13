# -------------------------------------------------------
# Repository GitHub
# -------------------------------------------------------
resource "github_repository" "repo" {
  name        = var.repo_name
  description = var.repo_description
  visibility  = "public"

  # Initialise le repo avec un commit vide (nécessaire pour README et branch protection)
  auto_init = true

  # Ajoute automatiquement un fichier .gitignore depuis les templates GitHub
  gitignore_template = var.gitignore_template

  has_issues   = true
  has_projects = false
  has_wiki     = false

  # Supprime les branches de fusion automatiquement après merge d'une PR
  delete_branch_on_merge = true
}

# -------------------------------------------------------
# Protection de la branche main
# -------------------------------------------------------
resource "github_branch_protection" "main" {
  repository_id = github_repository.repo.node_id
  pattern       = "main"

  # Exige au moins une review approuvée avant de merger
  required_pull_request_reviews {
    required_approving_review_count = 1
    dismiss_stale_reviews           = true
  }

  # Interdit les push directs sur main (même pour les admins)
  enforce_admins = false

  # Empêche les force push sur main
  allows_force_pushes = false

  # Empêche la suppression de la branche main
  allows_deletions = false
}

# -------------------------------------------------------
# Workflow GitHub Actions CI exemple
# -------------------------------------------------------
resource "github_repository_file" "ci_workflow" {
  repository          = github_repository.repo.name
  branch              = "main"
  file                = ".github/workflows/ci.yml"
  commit_message      = "ci: add GitHub Actions CI workflow"
  overwrite_on_create = true

  content = <<-EOT
    name: CI

    on:
      push:
        branches: [ "main" ]
      pull_request:
        branches: [ "main" ]

    jobs:
      build:
        runs-on: ubuntu-latest

        steps:
          - name: Checkout du code
            uses: actions/checkout@v4

          - name: Exemple d'étape
            run: echo "Ajoute tes étapes de build/test ici !"
  EOT
}
