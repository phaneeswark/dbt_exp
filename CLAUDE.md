# CLAUDE.md

This file provides guidance to Claude Code when working with this dbt project.

## Project Overview

This is a **dbt (data build tool)** project named `dbt_exp`, used for exploring dbt functionality. It was initialized with dbt version 1.5.2.

- **Project name:** `dbt_exp`
- **Profile:** `dbt_exp` (configured in `~/.dbt/profiles.yml`)
- **dbt version:** 1.5.2

## Repository Structure

```
dbt_exp/                        # Root of the git repository
├── CLAUDE.md                   # This file
├── README.md                   # Brief project description
├── logs/                       # dbt execution logs (git-ignored)
└── dbt_exp/                    # Main dbt project directory
    ├── dbt_project.yml         # Project configuration
    ├── .gitignore
    ├── README.md
    ├── analyses/               # Ad-hoc analyses (empty)
    ├── macros/                 # Custom Jinja macros (empty)
    ├── models/
    │   └── example/
    │       ├── my_first_dbt_model.sql   # Table materialization example
    │       ├── my_second_dbt_model.sql  # View referencing first model
    │       └── schema.yml               # Model docs and tests
    ├── seeds/                  # CSV seed files (empty)
    ├── snapshots/              # Snapshot definitions (empty)
    └── tests/                  # Custom singular tests (empty)
```

## Common dbt Commands

All dbt commands must be run from the `dbt_exp/` project directory:

```bash
cd dbt_exp

# Run all models
dbt run

# Run a specific model
dbt run --select my_first_dbt_model

# Run tests
dbt test

# Run tests for a specific model
dbt test --select my_first_dbt_model

# Run models and tests together
dbt build

# Compile models (without executing)
dbt compile

# Generate and serve documentation
dbt docs generate
dbt docs serve

# Check project configuration
dbt debug
```

## Models

### `example/my_first_dbt_model`
- **Materialization:** `table` (overrides project-level default)
- **Logic:** Creates a simple CTE with ids 1 and NULL
- **File:** `dbt_exp/models/example/my_first_dbt_model.sql`

### `example/my_second_dbt_model`
- **Materialization:** `view` (inherits project-level default)
- **Logic:** Selects from `my_first_dbt_model` where `id = 1`
- **Uses:** `ref()` function to reference upstream model
- **File:** `dbt_exp/models/example/my_second_dbt_model.sql`

## Tests

Tests are defined in `dbt_exp/models/example/schema.yml`. Both models have:
- `unique` test on the `id` column
- `not_null` test on the `id` column

Note: `my_first_dbt_model` contains a NULL id row, so the `not_null` test will fail unless the commented-out filter is enabled.

## Project Configuration

Key settings from `dbt_project.yml`:

- **Default materialization:** `view` for all models under `example/`
- **Clean targets:** `target/`, `dbt_packages/` (removed by `dbt clean`)
- **Git-ignored paths:** `target/`, `dbt_packages/`, `logs/`

## Profile Setup

The dbt profile (`dbt_exp`) must be configured in `~/.dbt/profiles.yml` on the local machine. This file is not tracked in the repository. Ensure it points to a valid database connection before running any dbt commands.

## No External Dependencies

This project has no:
- `packages.yml` (no dbt packages installed)
- Python scripts or `requirements.txt`
- Custom macros or seeds
