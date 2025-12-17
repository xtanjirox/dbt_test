# DBT Monitoring Test Project

A simple dbt project using DuckDB for testing with Dagster integration.

## Project Structure

```
dbt_monitoring_test/
├── dbt_project.yml       # Project configuration with vars
├── profiles.yml          # Connection profiles (dev, prod, test)
├── models/
│   ├── staging/          # Staging models (views)
│   │   ├── stg_customers.sql
│   │   ├── stg_orders.sql
│   │   └── schema.yml
│   └── marts/            # Mart models (tables)
│       ├── customer_orders.sql
│       └── schema.yml
└── seeds/
    ├── customers.csv
    └── orders.csv
```

## Setup

1. Install dependencies:
```bash
pip install dbt-core dbt-duckdb
```

2. Run dbt commands:
```bash
# Load seed data
dbt seed

# Run models
dbt run

# Run tests
dbt test

# Generate documentation
dbt docs generate
```

## Multiple Targets

The project includes three targets in `profiles.yml`:
- **dev**: Uses `dev_database.duckdb` (default)
- **prod**: Uses `prod_database.duckdb`
- **test**: Uses in-memory database

Switch targets:
```bash
dbt run --target prod
dbt run --target test
```

## Variables

Variables are defined in `dbt_project.yml`:
- `environment`: Environment identifier (default: "dev")
- `data_source`: Data source identifier (default: "sample")

Override variables:
```bash
dbt run --vars '{"environment": "production", "data_source": "live"}'
```

## Dagster Integration

This project is ready for Dagster integration using `dagster-dbt`. The simple structure makes it easy to:
- Schedule dbt runs
- Monitor model execution
- Track data lineage
- Set up alerting

Example Dagster asset definition:
```python
from dagster_dbt import DbtCliResource, dbt_assets

@dbt_assets(manifest=dbt_manifest_path)
def dbt_monitoring_test_assets(context, dbt: DbtCliResource):
    yield from dbt.cli(["build"], context=context).stream()
```
