# HAOS Codex Add-on

This repository contains a Home Assistant add-on repository with one add-on: `Codex Terminal`.

The add-on exposes a browser-based terminal through Home Assistant Ingress and includes the OpenAI Codex CLI (`@openai/codex`) out of the box. Its main purpose is to give Codex direct read/write access to your Home Assistant configuration so you can inspect, edit, and manage files from inside Home Assistant OS.

## What This Repository Provides

- A custom Home Assistant add-on repository
- One add-on named `Codex Terminal`
- An Ingress terminal powered by `ttyd`
- Preinstalled tools: `bash`, `curl`, `git`, `nodejs`, `npm`, `openssh-client`, `ttyd`, and `codex`
- Writable access to the Home Assistant configuration directory mounted at `/workspace`
- Persistent Codex home/configuration stored in the add-on data directory

## Add-on Overview

`Codex Terminal` starts a shell inside Home Assistant and opens it in the Home Assistant UI via Ingress.

The add-on is configured to:

- start automatically with Home Assistant
- expose its UI only through Ingress
- launch a writable terminal session on port `7681`
- mount the Home Assistant configuration directory at `/workspace`
- keep Codex login state and shell home data in `/data/codex-home`

This makes it possible to work directly with files such as:

- `configuration.yaml`
- `automations.yaml`
- `scripts.yaml`
- `secrets.yaml`
- `packages/`
- `blueprints/`
- any other files inside your Home Assistant config directory

## Repository Structure

- [`repository.yaml`](/home/christin/haos-codex-addon-github/repository.yaml): Home Assistant add-on repository metadata
- [`codex_terminal/config.yaml`](/home/christin/haos-codex-addon-github/codex_terminal/config.yaml): add-on manifest and configuration schema
- [`codex_terminal/Dockerfile`](/home/christin/haos-codex-addon-github/codex_terminal/Dockerfile): add-on container build definition
- [`codex_terminal/run.sh`](/home/christin/haos-codex-addon-github/codex_terminal/run.sh): startup script that configures the environment and launches `ttyd`
- [`codex_terminal/README.md`](/home/christin/haos-codex-addon-github/codex_terminal/README.md): short add-on store summary
- [`codex_terminal/DOCS.md`](/home/christin/haos-codex-addon-github/codex_terminal/DOCS.md): add-on documentation shown in Home Assistant

## How the Add-on Works

At startup, the add-on:

1. Reads the configured `working_directory` and `shell`.
2. Falls back to `/workspace` and `/bin/bash` if those options are empty.
3. Ensures `/data/codex-home` exists.
4. Sets `HOME` and `CODEX_HOME` to `/data/codex-home`.
5. Writes a `.bashrc` that sets up the shell environment and changes into `/workspace`.
6. Starts `ttyd` on port `7681` with write access enabled.
7. Launches the configured shell as a login shell.

Because the Home Assistant config directory is mounted read/write, any command run manually in the terminal or through Codex can modify your actual Home Assistant configuration.

## Supported Architectures

The add-on manifest declares support for:

- `aarch64`
- `amd64`
- `armv7`

## Installation

### 1. Publish or fork this repository

Host this repository somewhere Home Assistant can reach, typically on GitHub.

Before using it, verify the repository URL in [`repository.yaml`](/home/christin/haos-codex-addon-github/repository.yaml) matches the actual Git repository URL you want to add to Home Assistant.

### 2. Add the repository to Home Assistant

In Home Assistant:

1. Go to `Settings -> Add-ons -> Add-on Store`.
2. Open the repository menu.
3. Add the Git URL of this repository.
4. Refresh the add-on store if necessary.

### 3. Install the add-on

1. Open the add-on `Codex Terminal`.
2. Click `Install`.
3. Review the configuration options.
4. Start the add-on.
5. Open it through Ingress.

## Configuration

The add-on currently exposes two options.

### `working_directory`

- Type: `string`
- Default: `/workspace`

Defines the working directory used when `ttyd` starts the shell.

Use this if you want the terminal to open in a subdirectory of the mounted Home Assistant configuration, for example:

```yaml
working_directory: /workspace/packages
```

If the configured directory does not exist, the add-on logs a warning and falls back to `/workspace`.

### `shell`

- Type: `string`
- Default: `/bin/bash`

Defines the shell binary launched by the terminal session.

Example:

```yaml
shell: /bin/bash
```

The configured shell is started as a login shell.

## Mounted Paths

The add-on mounts the following Home Assistant paths:

- Home Assistant configuration directory to `/workspace` with write access
- Add-on data directory with write access
- Shared directory with write access
- SSL directory with read-only access

In practice, `/workspace` is the most important mount point because it contains the files you usually want Codex to inspect or edit.

## First Start and Codex Login

After opening the add-on through Ingress, verify the environment:

```bash
pwd
ls
codex --version
git --version
```

Then authenticate Codex:

```bash
codex login
```

Because `HOME` and `CODEX_HOME` are stored in `/data/codex-home`, your Codex configuration and login state are designed to persist across add-on restarts.

## Typical Usage

Start an interactive Codex session:

```bash
cd /workspace
codex
```

Run a direct prompt:

```bash
codex "Review my Home Assistant YAML files and suggest improvements."
```

Inspect your configuration with normal shell tools:

```bash
cd /workspace
find . -maxdepth 2 -type f | sort
git status
```

Work on packages or automations:

```bash
cd /workspace/packages
codex "Explain what these Home Assistant package files do."
```

## Example Use Cases

- Review `configuration.yaml` for structural problems
- Refactor automations into `packages/`
- Search for duplicate entities or scripts
- Use Git inside your Home Assistant configuration if that directory is a repository
- Let Codex explain unfamiliar YAML files before you edit them
- Perform targeted edits to dashboards, scripts, automations, and blueprints

## Security and Risk

This add-on is intentionally powerful. That is the entire point of it, but it also means the risk is real.

Important implications:

- The Home Assistant configuration directory is mounted with write access.
- Commands executed in the terminal can modify or delete configuration files.
- Codex can propose and apply changes directly inside your Home Assistant config.
- If you use Git in `/workspace`, you can track changes, but Git does not prevent destructive commands.
- The add-on is better suited for personal or tightly controlled environments than for public distribution.

Recommended precautions:

- Keep backups or snapshots of your Home Assistant instance.
- Use Git for your Home Assistant configuration whenever possible.
- Review generated changes before restarting Home Assistant.
- Be deliberate about what prompts you run through Codex.

## Troubleshooting

### The terminal opens in the wrong directory

Check the `working_directory` option. If it points to a path that does not exist, the add-on falls back to `/workspace`.

### `codex` is not logged in after a restart

The add-on stores Codex home data in `/data/codex-home`. If login state does not persist, inspect the add-on logs and verify the add-on data directory is functioning normally.

### The shell is not what I expected

Check the `shell` option in the add-on configuration. The startup script uses that value and launches it as a login shell.

### I cannot find my Home Assistant files

They should be available under `/workspace`. If they are not, verify the add-on is running with the expected Home Assistant config mapping.

### Changes made in the terminal broke my setup

Restore from Git, a Home Assistant backup, or a snapshot. This add-on does not add any safety layer on top of your file access.

## Development Notes

The container image is intentionally minimal. It installs:

- `bash`
- `curl`
- `git`
- `nodejs`
- `npm`
- `openssh-client`
- `ttyd`
- `@openai/codex` via global `npm install`

The startup behavior is implemented in [`codex_terminal/run.sh`](/home/christin/haos-codex-addon-github/codex_terminal/run.sh), and the image definition lives in [`codex_terminal/Dockerfile`](/home/christin/haos-codex-addon-github/codex_terminal/Dockerfile).

## Intended Audience

This project is a practical add-on for users who want direct terminal access and Codex-assisted editing inside Home Assistant OS. It is not designed as a locked-down, beginner-safe add-on. It is designed for users who explicitly want powerful access to their Home Assistant configuration.
