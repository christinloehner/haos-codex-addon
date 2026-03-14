# Codex Terminal for Home Assistant OS

`Codex Terminal` is a Home Assistant add-on that opens a terminal directly inside the Home Assistant interface and includes the OpenAI Codex CLI.

The add-on is meant for users who want to work on their Home Assistant configuration from inside HAOS. It gives the terminal and Codex direct read/write access to your Home Assistant config directory, so you can inspect files, edit YAML, use Git, and run Codex against your actual setup.

## What This Add-on Does

After installation, the add-on provides:

- a terminal in the Home Assistant UI via Ingress
- the `codex` CLI preinstalled
- direct access to your Home Assistant configuration under `/workspace`
- persistent Codex login and user data across restarts

Typical files you can work with include:

- `configuration.yaml`
- `automations.yaml`
- `scripts.yaml`
- `secrets.yaml`
- `packages/`
- `blueprints/`

## Who This Is For

This add-on is for users who explicitly want powerful terminal access inside Home Assistant OS.

It is useful if you want to:

- inspect and edit Home Assistant YAML files
- run Codex directly against your live Home Assistant configuration
- use Git commands inside your config directory
- review, refactor, or explain existing automations and packages

It is not a locked-down or beginner-safe add-on. Anything you do in the terminal can affect your Home Assistant configuration.

## Before You Install

You should understand these points before using the add-on:

- the Home Assistant configuration directory is mounted with write access
- commands executed manually or through Codex can change or delete files
- incorrect changes can break automations, scripts, dashboards, or Home Assistant startup

Recommended before use:

- create a Home Assistant backup or snapshot
- use Git for your Home Assistant config if possible
- only run prompts and commands you understand

## Installation in Home Assistant

If this add-on repository has already been added to your Home Assistant instance, installation is simple:

1. Open `Settings -> Add-ons`.
2. Open the `Add-on Store`.
3. Find `Codex Terminal`.
4. Open the add-on page.
5. Click `Install`.
6. Wait until installation finishes.

If the repository is not yet available in your Home Assistant add-on store, the person providing this add-on to you must give you the repository URL first.

## Updating the Add-on

When a new add-on version is published in the same repository, Home Assistant should show an update on the add-on page.

To update:

1. Open `Settings -> Add-ons`.
2. Open `Codex Terminal`.
3. If an update is available, click `Update`.
4. Wait for the update to finish.
5. Start the add-on again if it does not restart automatically.

If Home Assistant does not show the update immediately, open the `Add-on Store` and refresh the repository data, then check the add-on page again.

Your add-on configuration and persistent Codex data should remain in place because they are stored outside the container image.

## Configuration

The add-on exposes two configuration options.

### `working_directory`

Default:

```yaml
working_directory: /workspace
```

This defines the directory where the terminal starts.

For most users, the default `/workspace` is correct because it points to the mounted Home Assistant configuration directory.

If you want the terminal to open in a specific subdirectory, you can change it, for example:

```yaml
working_directory: /workspace/packages
```

If the directory does not exist, the add-on falls back to `/workspace`.

### `shell`

Default:

```yaml
shell: /bin/bash
```

This defines which shell is launched inside the terminal.

For normal usage, leave this at the default unless you have a specific reason to change it.

## First Start

After installation:

1. Start the add-on.
2. Open it via `Open Web UI` or directly through Home Assistant Ingress.
3. A terminal session should appear.

When the terminal opens, you can verify the environment with:

```bash
pwd
ls
codex --version
git --version
```

Normally, you should be working inside `/workspace`, which is your Home Assistant config directory.

## Logging In to Codex

Before using Codex, log in once:

```bash
codex login
```

Follow the authentication flow shown in the terminal.

The add-on stores Codex user data persistently, so your login should remain available across restarts.

## How To Use the Add-on

### Basic terminal usage

You can use the add-on like a normal shell inside your Home Assistant config:

```bash
cd /workspace
ls
```

Examples:

```bash
cat configuration.yaml
ls packages
git status
```

### Start an interactive Codex session

```bash
cd /workspace
codex
```

This is useful if you want an interactive workflow and want Codex to inspect or modify your Home Assistant files.

### Run a direct Codex prompt

```bash
codex "Review my Home Assistant automations and suggest improvements."
```

Other examples:

```bash
codex "Explain my configuration.yaml and point out risky parts."
codex "Refactor my packages into a cleaner structure."
codex "Look through scripts.yaml and identify duplicates."
```

## Common Use Cases

Users typically install this add-on to:

- review existing Home Assistant YAML
- clean up large automation setups
- search through packages and blueprints
- let Codex explain unfamiliar configuration files
- apply targeted edits without leaving the Home Assistant UI
- run Git commands in a configuration repository

## Important Safety Notes

This add-on is intentionally powerful.

That means:

- it can modify your Home Assistant configuration directly
- it can break your setup if you run destructive commands
- Codex suggestions should be reviewed before you rely on them

Good practice:

- make backups before major changes
- check YAML carefully after edits
- review diffs if you use Git
- restart or reload Home Assistant only after confirming changes are correct

## Troubleshooting

### The terminal starts in the wrong place

Check the `working_directory` option. If it points to a missing path, the add-on falls back to `/workspace`.

### I do not see my Home Assistant files

Your config should be available under `/workspace`. If not, restart the add-on and check whether it opened correctly.

### `codex` is not recognized

Open the add-on terminal again and run:

```bash
codex --version
```

If that still fails, restart the add-on and inspect the add-on logs.

### Codex login did not persist

Log in again with:

```bash
codex login
```

If the problem continues, check the add-on logs and the add-on's persistent data handling.

### I changed files and Home Assistant now has problems

Restore from backup, snapshot, or Git history if available. This add-on does not prevent damaging file changes.

## In Short

`Codex Terminal` gives you a terminal and Codex CLI directly inside Home Assistant OS, with access to your real configuration files. That is exactly what makes it useful, and exactly what makes it sensitive. Use it like a powerful admin tool, not like a sandbox.
