# Codex Terminal

`Codex Terminal` adds a terminal to the Home Assistant UI and includes the OpenAI Codex CLI.

The terminal opens with direct access to your Home Assistant configuration directory at `/workspace`, so you can inspect files, edit YAML, run Git commands, and use Codex against your real Home Assistant setup.

## What You Can Do

- work with `configuration.yaml`, `automations.yaml`, `scripts.yaml`, `secrets.yaml`, `packages/`, and `blueprints/`
- run the `codex` CLI directly inside Home Assistant
- use Git if your configuration directory is a repository
- keep Codex login and user data across add-on restarts

## Configuration

### `working_directory`

Default: `/workspace`

Defines the directory where the terminal starts.

For most users, the default is correct.

### `shell`

Default: `/bin/bash`

Defines which shell is launched in the terminal.

For normal usage, keep the default unless you have a specific reason to change it.

## First Start

After installing and starting the add-on:

1. Open the add-on through `Open Web UI`.
2. Verify the environment:

```bash
pwd
ls
codex --version
git --version
```

3. Log in to Codex:

```bash
codex login
```

## Typical Usage

Start an interactive Codex session:

```bash
cd /workspace
codex
```

Run a direct prompt:

```bash
codex "Review my Home Assistant automations and suggest improvements."
```

Use the terminal normally:

```bash
cd /workspace
git status
ls packages
```

## Safety Notes

This add-on has write access to your Home Assistant configuration.

That means:

- commands in the terminal can change or delete files
- Codex can make direct changes to your configuration
- mistakes can break your Home Assistant setup

Recommended:

- create backups or snapshots before major changes
- use Git if possible
- review changes before reloading or restarting Home Assistant
