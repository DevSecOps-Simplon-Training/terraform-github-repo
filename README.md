# Terraform GitHub Repository Factory

Terraform module that provisions a GitHub repository with sane defaults and branch protection, triggered via a GitHub Actions workflow dispatch.

## What it does

- Creates a public GitHub repository with Issues enabled
- Initializes the repository with a first commit (required for branch protection)
- Applies a `.gitignore` template from GitHub's catalog
- Protects the `main` branch:
  - Requires at least 1 approved pull request review before merging
  - Dismisses stale reviews when new commits are pushed
  - Blocks direct pushes and force pushes to `main`
  - Prevents deletion of the `main` branch
- Injects a starter CI workflow (`.github/workflows/ci.yml`) into the created repository
- Automatically deletes merged feature branches

## Project structure

```
.
├── main.tf                  # GitHub repository and branch protection resources
├── variables.tf             # Input variable declarations
├── outputs.tf               # Repository URLs and full name outputs
├── providers.tf             # Terraform and GitHub provider configuration
├── terraform.tfvars.example # Example variables file (copy to terraform.tfvars locally)
├── .terraform.lock.hcl      # Provider version lock file
└── .github/
    └── workflows/
        └── terraform.yml    # GitHub Actions workflow (workflow_dispatch)
```

## GitHub Actions usage

The workflow is triggered manually from **Actions > Create GitHub Repository with Terraform > Run workflow**.

| Input | Required | Description |
|-------|----------|-------------|
| `repo_name` | Yes | Name of the repository to create |
| `repo_description` | No | Short description of the repository |

### Required GitHub Secrets

Configure these in **Settings > Secrets and variables > Actions**:

| Secret | Description |
|--------|-------------|
| `GH_TOKEN` | GitHub Personal Access Token with `repo` and `workflow` scopes |
| `GH_OWNER` | Your GitHub username or organization name |

## Local usage

1. Copy the example variables file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Fill in your values in `terraform.tfvars` (never commit this file):
   ```hcl
   github_token       = "ghp_xxxxxxxxxxxxxxxxxxxx"
   github_owner       = "your-username"
   repo_name          = "my-new-repo"
   repo_description   = "My project description"
   gitignore_template = "Terraform"
   ```

3. Initialize, plan, and apply:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Variables

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `github_token` | `string` | — | GitHub Personal Access Token |
| `github_owner` | `string` | — | GitHub username or organization |
| `repo_name` | `string` | — | Name of the repository to create |
| `repo_description` | `string` | `""` | Repository description |
| `gitignore_template` | `string` | `"Terraform"` | GitHub `.gitignore` template name |

## Outputs

| Name | Description |
|------|-------------|
| `repository_url` | GitHub web URL of the created repository |
| `repository_https_clone_url` | HTTPS clone URL |
| `repository_ssh_clone_url` | SSH clone URL |
| `repository_full_name` | Full name in `owner/repo` format |

## Requirements

| Tool | Version |
|------|---------|
| Terraform | `>= 1.3.0` |
| GitHub provider | `~> 6.0` |
