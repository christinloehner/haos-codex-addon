# Codex Terminal for Home Assistant OS

`Codex Terminal` is a Home Assistant add-on that gives you a terminal directly inside the Home Assistant interface and includes the OpenAI Codex CLI.

The add-on is designed for users who want to manage their Home Assistant configuration from inside HAOS. It provides direct read/write access to your Home Assistant configuration directory, so you can inspect files, edit YAML, use Git, and run Codex against your real setup.

Current release history:

- [codex_terminal/CHANGELOG.md](https://github.com/christinloehner/haos-codex-addon/blob/main/codex_terminal/CHANGELOG.md)

## What This Add-on Is

After installation, `Codex Terminal` gives you:

- a terminal in the Home Assistant UI via Ingress
- the `codex` CLI preinstalled
- common helper tools such as `rg`, `fd`, `jq`, `yq`, `python3`, `pip`, `sqlite3`, `grep`, `sed`, `less`, and `tree`
- direct access to your Home Assistant configuration under `/workspace`
- persistent Codex login and user data across restarts

This means you can work directly with files such as:

- `configuration.yaml`
- `automations.yaml`
- `scripts.yaml`
- `secrets.yaml`
- `packages/`
- `blueprints/`

## What This Add-on Is For

This add-on is useful if you want to:

- inspect and edit Home Assistant YAML files
- create or modify automations, scripts, and packages
- run Codex directly against your Home Assistant configuration
- use Git commands inside your Home Assistant config directory
- analyze or refactor an existing Home Assistant setup

This add-on is intentionally powerful. It is not a sandbox. Anything you do in the terminal can affect your actual Home Assistant configuration.

## Before You Install

Before using the add-on, make sure you understand the following:

- the Home Assistant configuration directory is mounted with write access
- commands executed manually or through Codex can modify or delete files
- incorrect changes can break automations, scripts, dashboards, or Home Assistant startup

Recommended before you begin:

- create a Home Assistant backup or snapshot
- use Git for your Home Assistant configuration if possible
- only run prompts and commands you understand

## Repository URL

To install this add-on, add the following custom add-on repository to Home Assistant:

```text
https://github.com/christinloehner/haos-codex-addon
```

## Full Installation Guide

These steps are written from the perspective of a Home Assistant user who wants to install the add-on in Home Assistant OS.

### 1. Open the Add-on Store

In Home Assistant:

1. Open `Settings`.
2. Open `Add-ons`.
3. Open the `Add-on Store`.

### 2. Add the custom repository

If you have not added this repository yet:

1. In the `Add-on Store`, open the menu in the top right.
2. Choose `Repositories`.
3. In the repository field, paste:

```text
https://github.com/christinloehner/haos-codex-addon
```

4. Confirm and close the repository dialog.

Home Assistant should now load the add-ons from this repository.

### 3. Find and install `Codex Terminal`

After the repository has been added:

1. Stay in the `Add-on Store`.
2. Look for `Codex Terminal`.
3. Open the add-on page.
4. Click `Install`.
5. Wait until the installation finishes.

Depending on your system, Home Assistant may need a short time to build or download the add-on image.

### 4. Review the add-on configuration

Before starting the add-on, review the configuration tab.

The default configuration is:

```yaml
working_directory: /workspace
shell: /bin/bash
startup_mode: menu
```

For most users, the defaults are correct.

### 5. Start the add-on

On the add-on page:

1. Click `Start`.
2. Wait until the add-on is running.
3. Then click `Open Web UI`.

This opens the terminal through Home Assistant Ingress.

## Configuration Options

The add-on currently exposes three options.

### `working_directory`

Default:

```yaml
working_directory: /workspace
```

This is the directory where the terminal starts.

For most users, `/workspace` is the correct setting because it points to the mounted Home Assistant configuration directory.

You can change it if you want the terminal to open in a specific subdirectory, for example:

```yaml
working_directory: /workspace/packages
```

If the directory does not exist, the add-on falls back to `/workspace`.

### `shell`

Default:

```yaml
shell: /bin/bash
```

This defines which shell is launched in the terminal.

For normal usage, leave this unchanged unless you have a specific reason to use a different shell.

### `startup_mode`

Default:

```yaml
startup_mode: menu
```

This controls what happens immediately after you open the terminal.

Available values:

- `menu`: show an interactive start menu
- `shell`: open a normal shell prompt
- `codex`: start a new interactive Codex session immediately
- `codex_resume_last`: resume the most recent Codex session automatically
- `codex_resume_picker`: open the Codex resume picker so you can choose a previous session

For most users, `menu` is the best choice because it gives you clear options immediately when the add-on opens.

## First Start

When you open the add-on for the first time, you should now see a start menu instead of a bare shell prompt.

The menu offers these options:

- start a new Codex session
- resume the most recent Codex session
- choose a previous Codex session
- open a normal shell
- start Codex with web search and without sandbox or approval prompts

If you prefer the old behavior, you can change `startup_mode` to `shell`.

You can verify the environment with:

```bash
pwd
ls
codex --version
git --version
```

You can also verify the common helper tools:

```bash
rg --version
fd --version
jq --version
yq --version
python3 --version
pip --version
sqlite3 --version
tree --version
less --version
```

Normally:

- `pwd` should point to `/workspace` or your configured working directory
- your Home Assistant configuration files should be visible there
- `codex` should already be installed

## Logging In to Codex

Before using Codex, log in once:

```bash
codex login
```

Follow the authentication process shown in the terminal.

The add-on stores Codex user data persistently, so your login should remain available across restarts of the add-on.

## How To Use the Add-on

### Basic terminal usage

You can use the add-on as a normal shell inside your Home Assistant configuration:

```bash
cd /workspace
ls
```

Examples:

```bash
cat configuration.yaml
ls packages
git status
rg automation .
yq '.automation' configuration.yaml
```

Helpful shortcuts are available in the shell:

```bash
codex-menu
codex-new
codex-resume
codex-last
codex_new
codex_resume
codex_resume_last
codex_resume_picker
```

These commands let you reopen the menu, start a new Codex session, open the resume picker, or resume the most recent session.

### Start an interactive Codex session

```bash
cd /workspace
codex
```

This is useful if you want Codex to inspect, explain, or modify files interactively.

### Start Codex with advanced flags

If you want Codex to use live web search and run with fewer guardrails, you can start it manually with additional flags.

Example:

```bash
cd /workspace
NETWORK_ACCESS=true codex --search --dangerously-bypass-approvals-and-sandbox
```

This is an advanced mode. It is appropriate only if you understand what these flags do and you are intentionally running the add-on as a powerful admin tool.

What these options mean:

- `NETWORK_ACCESS=true`: enables network access for the Codex process in your shell environment
- `--search`: allows Codex to use live web search
- `--dangerously-bypass-approvals-and-sandbox`: removes Codex approval prompts and sandbox protections

Important risk:

- Codex may execute commands without interactive confirmation
- Codex may perform broader file changes more quickly
- Codex may combine internet-sourced information with direct write access to your Home Assistant files
- mistakes become more dangerous because the normal safety friction is reduced

If you use this mode, it is strongly recommended that you:

- keep your own rules and constraints in `AGENTS.md` or equivalent guidance
- use Git in `/workspace`
- review diffs before restarting or reloading Home Assistant
- keep current backups or snapshots
- use it only on systems you control and understand

### Run a direct Codex prompt

```bash
codex "Review my Home Assistant automations and suggest improvements."
```

Other example prompts:

```bash
codex "Explain my configuration.yaml and point out risky parts."
codex "Refactor my packages into a cleaner structure."
codex "Look through scripts.yaml and identify duplicates."
codex "Help me create a new Home Assistant automation for my hallway lights."
```

## Common Use Cases

Users typically install this add-on to:

- review existing Home Assistant YAML
- create or improve automations and scripts
- search through packages and blueprints
- let Codex explain an unfamiliar configuration
- apply targeted edits without leaving the Home Assistant UI
- run Git commands in a Home Assistant configuration repository

## Updating the Add-on

When a newer version of the add-on is published in the same repository, Home Assistant should show an update on the add-on page.

To update the add-on:

1. Open `Settings`.
2. Open `Add-ons`.
3. Open `Codex Terminal`.
4. If an update is available, click `Update`.
5. Wait until the update finishes.
6. Start the add-on again if it does not restart automatically.

If Home Assistant does not show the update immediately:

1. Go back to the `Add-on Store`.
2. Refresh the store or reopen it.
3. Open `Codex Terminal` again and check for the update.

Your add-on configuration and persistent Codex data should remain available because they are stored outside the container image.

## Safety Notes

This add-on has direct write access to your Home Assistant configuration.

That means:

- commands in the terminal can change or delete files
- Codex can make direct changes to your configuration
- mistakes can break your Home Assistant setup

Good practice:

- create backups before major changes
- review YAML carefully after edits
- use Git if possible
- review diffs before restarting or reloading Home Assistant

Advanced Codex modes such as:

```bash
NETWORK_ACCESS=true codex --search --dangerously-bypass-approvals-and-sandbox
```

remove important safety layers. They can be useful, but they should only be used deliberately and with your own process controls in place.

## Troubleshooting

### The add-on does not appear in the Add-on Store

Check that you added the correct repository URL:

```text
https://github.com/christinloehner/haos-codex-addon
```

Then reopen or refresh the `Add-on Store`.

### The terminal starts in the wrong directory

Check the `working_directory` option. If it points to a path that does not exist, the add-on falls back to `/workspace`.

### I do not see my Home Assistant files

Your Home Assistant configuration should be available under `/workspace`. If not, restart the add-on and open the terminal again.

### `codex` is not recognized

Run:

```bash
codex --version
```

If that still fails, restart the add-on and inspect the add-on logs.

### Codex login did not persist

Run:

```bash
codex login
```

If the problem continues, inspect the add-on logs and try restarting the add-on.

### I changed files and now Home Assistant has problems

Restore from backup, snapshot, or Git history if available. This add-on does not block destructive changes.

## Changelog

Release history is available in [codex_terminal/CHANGELOG.md](https://github.com/christinloehner/haos-codex-addon/blob/main/codex_terminal/CHANGELOG.md).

## In Short

`Codex Terminal` gives you a terminal and Codex CLI directly inside Home Assistant OS, with access to your real configuration files. That is exactly what makes it useful, and exactly what makes it sensitive. Use it like a powerful admin tool, not like a sandbox.
