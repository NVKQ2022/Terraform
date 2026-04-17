terraform/
├── modules/                # Reusable Terraform modules
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── compute/
│   ├── aks/
│   ├── database/
│   └── monitoring/
│
├── environments/           # Environment-specific configurations
│   ├── dev/
│   │   ├── main.tf
│   │   ├── providers.tf
│   │   ├── backend.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   │
│   ├── staging/
│   └── prod/
│
├── global/                 # Shared, non-environment-specific infra
│   ├── iam/
│   ├── dns/
│   └── remote-state/
│
├── policies/               # Policy-as-code
│   ├── sentinel/
│   └── opa/
│
├── scripts/                # Helper scripts (bash, PowerShell)
│
├── versions.tf             # Terraform & provider versions
├── locals.tf               # Global locals (optional)
├── README.md
└── .gitignore

folder structure
