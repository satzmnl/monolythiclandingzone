# Azure Monolithic Landing Zone

A modular, multi-environment Terraform repository designed to deploy and manage core Azure Landing Zone infrastructure (Resource Groups, Storage Accounts, and foundational services) across preproduction and production environments.

---

## 📌 Project Overview

* **Cloud Provider:** Microsoft Azure (`azurerm` provider ~> 5.7)
* **Infrastructure as Code (IaC):** Terraform (>= 1.3.0)
* **Architecture Pattern:** Monolithic Landing Zone with reusable sub-modules and decoupled environments
* **State Management:** Remote backend using Azure Blob Storage (`azurerm` backend)
* **Configuration Model:** Variable-driven multi-resource deployment using `for_each` maps

---

## 🏗️ Architecture & Key Components

* **Modular Core:**
  * Reusable, standalone Terraform modules isolated under the `modules/` directory.
  * DRY (*Don't Repeat Yourself*) design allowing parameterization for different resource configurations.
* **Separation of Environments:**
  * Dedicated directories for `preprod` and `prod` under `environments/`.
  * Distinct Terraform state files (`prepod.terraform.tfstate` and `prod.terraform.tfstate`) to isolate blast radiuses.
* **Declarative Resource Creation:**
  * Iterative deployment of Resource Groups and Storage Accounts via Terraform `for_each`.
  * Explicit dependency management (`depends_on = [module.resource_group]`) to ensure resource groups exist before provisioning dependent services.

---

## 📁 Repository Structure

```text
monolythiclandingzone/
├── .gitignore
├── README.md
├── environments/
│   ├── preprod/
│   │   ├── main.tf              # Module invocations for preprod
│   │   ├── provider.tf          # Azure provider and backend configuration
│   │   ├── variables.tf         # Input variable definitions
│   │   └── terraform.tfvars     # (Optional) Environment-specific values
│   └── prod/
│       ├── main.tf              # Module invocations for prod
│       ├── provider.tf          # Azure provider and backend configuration
│       ├── variables.tf         # Input variable definitions
│       └── terraform.tfvars     # (Optional) Environment-specific values
└── modules/
    ├── azurerm_resource_group/
    │   ├── main.tf              # Resource group definition (azurerm_resource_group)
    │   └── variables.tf         # Inputs: var.resource_groups
    └── azurerm_storage_account/
        ├── main.tf              # Storage account definition (azurerm_storage_account)
        └── variables.tf         # Inputs: var.storage_accounts
```

---

## 📦 Modules Included

### 1. `azurerm_resource_group`
* **Path:** `modules/azurerm_resource_group`
* **Purpose:** Manages the lifecycle of Azure Resource Groups.
* **Inputs:**
  * `resource_groups`: Map of objects defining resource group names and locations:
    * `name`: Name of the Azure Resource Group.
    * `location`: Target Azure region (e.g., `eastus`, `centralus`).

### 2. `azurerm_storage_account`
* **Path:** `modules/azurerm_storage_account`
* **Purpose:** Provisions Azure Storage Accounts within the specified resource groups.
* **Inputs:**
  * `storage_accounts`: Map of objects containing storage configurations:
    * `name`: Globally unique storage account name.
    * `resource_group_name`: Name of the parent resource group.
    * `location`: Azure region.
    * `account_tier`: Storage tier (e.g., `Standard`, `Premium`).
    * `account_replication_type`: Redundancy type (e.g., `LRS`, `GRS`, `ZRS`).

---

## 🌍 Environments & State Storage

* **Remote State Store:**
  * **Resource Group:** `rg-prepod`
  * **Storage Account:** `sattarstorage1`
  * **Container Name:** `sattarcontainer`
* **Preproduction (`environments/preprod`):**
  * **State Key:** `prepod.terraform.tfstate`
  * **Scope:** Testing, validation, and staging infrastructure.
* **Production (`environments/prod`):**
  * **State Key:** `prod.terraform.tfstate`
  * **Scope:** Production-grade landing zone resources.

---

## 📋 Prerequisites

* **Terraform:** Version `1.3.0` or higher installed.
* **Azure CLI:** Version `2.50.0+` installed and authenticated (`az login`).
* **Azure Subscription:** Active subscription with Contributor / Owner rights.
* **State Storage:** Pre-existing Azure storage account and container configured for Terraform backend state.

---

## 🚀 Deployment Workflow

* **Step 1: Authenticate with Azure**
  * Run: `az login`
  * Set active subscription: `az account set --subscription "<SUBSCRIPTION_ID_OR_NAME>"`

* **Step 2: Choose Target Environment**
  * For Preproduction:
    ```bash
    cd environments/preprod
    ```
  * For Production:
    ```bash
    cd environments/prod
    ```

* **Step 3: Define Variable Values**
  * Create a `terraform.tfvars` file (example below) or pass values dynamically.

* **Step 4: Initialize Terraform**
  * Connects to the Azure remote backend and downloads provider plugins:
    ```bash
    terraform init
    ```

* **Step 5: Review Execution Plan**
  * Generates and validates the execution plan:
    ```bash
    terraform plan
    ```

* **Step 6: Apply Configuration**
  * Deploys the resources to Azure:
    ```bash
    terraform apply
    ```

* **Step 7: Tear Down (When Required)**
  * Destroys managed infrastructure:
    ```bash
    terraform destroy
    ```

---

## ⚙️ Configuration Example (`terraform.tfvars`)

```hcl
rgs = {
  rg1 = {
    name     = "rg-enterprise-preprod-01"
    location = "eastus"
  }
}

storage_accounts = {
  sa1 = {
    name                     = "saenterprisepreprod01"
    resource_group_name      = "rg-enterprise-preprod-01"
    location                 = "eastus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}
```

---

## 🛡️ Best Practices & Guidelines

* **Security & Secrets:** Never commit `.tfvars` containing sensitive secrets, credentials, or `.terraform` cache directories to version control.
* **State Isolation:** Maintain strict separation between environments to avoid accidental cross-environment modifications.
* **Module Versioning:** Keep module interfaces well-typed and document changes when adding additional landing zone components (e.g., VNets, Key Vaults, NSGs).
* **Code Formatting & Linting:** Run `terraform fmt -recursive` and `terraform validate` prior to pushing commits.
