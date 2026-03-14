# Changelog

## 0.1.8

- updated the repository name to `Christins HAOS Codex Addon`
- refreshed repository metadata for the add-on repository listing

## 0.1.7

- added an add-on local changelog file so Home Assistant can show release notes in the add-on UI
- aligned changelog links in the documentation with the add-on local changelog

## 0.1.6

- added `python3`, `py3-pip`, and `sqlite` for Codex workflows that expect Python and SQLite tooling
- kept `npm` and Node.js available for JavaScript- and Home Assistant-related tooling

## 0.1.5

- added more standard CLI tools commonly used in Codex workflows
- added `less`, `tree`, `diffutils`, `patch`, and `make`
- added `procps`, `util-linux`, and `unzip`

## 0.1.4

- added common Codex CLI helper tools to the add-on image
- added `ripgrep` (`rg`) for fast code and config search
- added `fd`, `findutils`, `coreutils`, and `jq`
- added `yq` for YAML processing

## 0.1.3

- changed the default startup mode from a plain shell to a startup menu
- added an interactive menu when opening Codex Terminal
- added menu options for new sessions, resume last, resume picker, shell, and advanced Codex startup
- added underscore command aliases such as `codex_resume_last` for more intuitive manual usage

## 0.1.2

- added configurable startup behavior for the terminal
- added support for starting directly in a new Codex session
- added support for resuming the most recent Codex session automatically
- added support for opening the Codex resume picker at startup
- added shell shortcuts for starting or resuming Codex manually

## 0.1.1

- added user-focused English documentation
- added installation and usage guidance for Home Assistant users
- added safety notes and troubleshooting information
- added this changelog

## 0.1.0

- initial release of the `Codex Terminal` add-on
- Ingress terminal with preinstalled OpenAI Codex CLI
- read/write access to the Home Assistant configuration directory
