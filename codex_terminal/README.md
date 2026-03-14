# Codex Terminal

`Codex Terminal` is a Home Assistant add-on that provides a terminal directly in the Home Assistant UI via Ingress and includes the OpenAI Codex CLI.

It is intended for users who want to work on their Home Assistant configuration from inside HAOS instead of switching to an external machine or SSH session.

## What It Can Do

- open a terminal in the Home Assistant UI
- access your Home Assistant configuration under `/workspace`
- run `codex` directly against your real Home Assistant setup
- inspect and edit files such as `configuration.yaml`, `automations.yaml`, `scripts.yaml`, `packages/`, and `blueprints/`
- use common CLI tools such as `rg`, `fd`, `jq`, `yq`, `grep`, `sed`, `less`, and `tree`
- use Git if your Home Assistant config directory is a repository

## Important Warning

This add-on has direct read/write access to your Home Assistant configuration.

That means:

- commands in the terminal can change or delete files
- Codex can make direct changes to your configuration
- incorrect changes can break your Home Assistant setup

This add-on is intentionally powerful. It is not a sandbox.

## Best For

- advanced Home Assistant users
- users who want Codex to help create or improve automations
- users who manage their Home Assistant config with Git
- users who want a terminal and AI-assisted editing inside HAOS

## Before You Use It

- create a backup or snapshot
- use Git if possible
- review generated changes before reloading or restarting Home Assistant
- be especially careful with advanced Codex commands that enable web search or disable safety prompts

## Startup Experience

By default, the add-on opens with a menu so you can choose to:

- start a new Codex session
- resume the most recent Codex session
- choose an older Codex session
- open a normal shell
- start Codex with advanced flags

## Full Documentation

Detailed installation, configuration, update instructions, and safety notes are available in the add-on documentation:

- [DOCS.md](https://github.com/christinloehner/haos-codex-addon/blob/main/codex_terminal/DOCS.md)
