# Easy Shop - dbt Project

A study dbt project built on BigQuery using the dbt Fusion engine.

## Setup

### 1. Create a GCP Account
Go to [cloud.google.com](https://cloud.google.com) and create a free account.

### 2. Create a GCP Project
In the GCP Console, create a new project (do **not** use the default project GCP creates automatically). Note your **Project ID** — you'll need it later.

### 3. Enable the BigQuery API
Inside your project, navigate to **APIs & Services > Enable APIs** and enable the **BigQuery API**.

### 4. Create a Service Account
1. Go to **IAM & Admin > Service Accounts** and create a new service account
2. Grant it the **BigQuery Admin** role (or at minimum **BigQuery Data Editor** + **BigQuery Job User**)
3. Under the service account's **Keys** tab, create a new JSON key and download it
4. Store the key file somewhere safe on your machine (e.g. `~/warehouse_keys/easyshop_SA.json`)

### 5. Create a Virtual Environment
```bash
python3 -m venv .venv
source .venv/bin/activate  # on Windows: .venv\Scripts\activate
```

### 6. Install dbt
```bash
pip install dbt-fusion
```

### 7. Configure your dbt Profile
Add the following to `~/.dbt/profiles.yml`:

```yaml
easy_shop:
  target: dev
  outputs:
    dev:
      type: bigquery
      threads: 16
      database: <your-gcp-project-id>
      schema: dbt_<your_name>
      method: service-account
      keyfile: /path/to/your/easyshop_SA.json
      location: US
```

### 8. Load the Source Data
The raw source data is loaded via dbt seeds into the `raw` dataset:
```bash
dbt seed
```

### 9. Run the Project
```bash
dbt build
```

This runs all models, tests, and seeds in the correct order.

## Project Structure

```
easy_shop/
├── models/
│   ├── staging/   # Views on top of raw sources
│   └── marts/     # Final tables for consumption
├── macros/        # Reusable SQL macros and generic tests
├── seeds/         # Raw CSV source data
└── tests/         # Singular tests
```
