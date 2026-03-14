# Codex Terminal

`Codex Terminal` adds a terminal to the Home Assistant UI and includes the OpenAI Codex CLI.

The terminal opens with direct access to your Home Assistant configuration directory at `/workspace`, so you can inspect files, edit YAML, run Git commands, and use Codex against your real Home Assistant setup.

## Repository URL

Add this repository to Home Assistant to install the add-on:

```text
https://github.com/christinloehner/haos-codex-addon
```

## Installation

### Add the repository

1. Open `Settings -> Add-ons`.
2. Open the `Add-on Store`.
3. Open the menu in the top right.
4. Choose `Repositories`.
5. Paste this repository URL:

```text
https://github.com/christinloehner/haos-codex-addon
```

6. Confirm and close the dialog.

### Install the add-on

1. In the `Add-on Store`, find `Codex Terminal`.
2. Open the add-on page.
3. Click `Install`.
4. Wait until installation finishes.

### Start the add-on

1. Review the configuration if needed.
2. Click `Start`.
3. Click `Open Web UI`.

This opens the terminal through Home Assistant Ingress.

## What You Can Do

- work with `configuration.yaml`, `automations.yaml`, `scripts.yaml`, `secrets.yaml`, `packages/`, and `blueprints/`
- run the `codex` CLI directly inside Home Assistant
- use common helper tools such as `rg`, `fd`, `jq`, `yq`, `python3`, `pip`, `sqlite3`, `grep`, `sed`, `less`, and `tree`
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

### `startup_mode`

Default: `menu`

Controls what happens when you open the terminal.

Available values:

- `menu`
- `shell`
- `codex`
- `codex_resume_last`
- `codex_resume_picker`

For most users, `menu` is the best setting because it shows clear choices as soon as the add-on opens.

## First Start

After installing and starting the add-on:

1. Open the add-on through `Open Web UI`.
2. A startup menu should appear.
3. Choose whether you want to start a new Codex session, resume the last one, open the session picker, or open a shell.
4. Verify the environment if needed:

```bash
pwd
ls
codex --version
git --version
```

5. Log in to Codex if needed:

```bash
codex login
```

You can also verify the helper tools:

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

Your Codex login data is stored persistently and should remain available across restarts.

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

Start Codex with advanced flags:

```bash
cd /workspace
NETWORK_ACCESS=true codex --search --dangerously-bypass-approvals-and-sandbox
```

This mode is powerful but riskier. It enables web search and removes approval and sandbox protection inside Codex.

Use the terminal normally:

```bash
cd /workspace
git status
ls packages
rg automation .
yq '.automation' configuration.yaml
```

Available shell shortcuts:

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

These let you reopen the menu, start a new session, open the resume picker, or resume the latest session manually.

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

Especially be careful with commands like:

```bash
NETWORK_ACCESS=true codex --search --dangerously-bypass-approvals-and-sandbox
```

These reduce safety barriers and should only be used if you understand the implications and have your own review process.

## Updating

When a newer version is available:

1. Open `Settings -> Add-ons`.
2. Open `Codex Terminal`.
3. Click `Update`.
4. Wait until the update finishes.
5. Start the add-on again if needed.

If the update is not shown immediately, refresh or reopen the `Add-on Store`.

## Changelog

Release history is available in [`CHANGELOG.md`](https://github.com/christinloehner/haos-codex-addon/blob/main/codex_terminal/CHANGELOG.md).
