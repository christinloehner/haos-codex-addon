# Codex Terminal

`Codex Terminal` startet ein Ingress-Terminal in Home Assistant und bindet den Home-Assistant-Konfigurationsordner unter `/workspace` mit Schreibrechten ein.

## Was das Add-on kann

- Zugriff auf `configuration.yaml`, `automations.yaml`, `scripts.yaml`, `packages/`, `blueprints/` und weitere Dateien unter `/workspace`
- Vorinstalliertes `codex` CLI
- Persistente Codex-Konfiguration unter `/data/codex-home`
- Nutzung direkt ueber die Home-Assistant-Oberflaeche per Ingress

## Nach der Installation

Ingress oeffnen und im Terminal zunaechst pruefen:

```bash
pwd
ls
codex --version
```

Danach Codex authentifizieren:

```bash
codex login
```

## Optionen

### `working_directory`

Default: `/workspace`

Arbeitsverzeichnis beim Start des Terminals.

### `shell`

Default: `/bin/bash`

Shell, die im Terminal gestartet werden soll.

## Sicherheit

Dieses Add-on ist bewusst maechtig:

- Der Home-Assistant-Konfigurationsordner ist read/write gemappt.
- Alles, was im Terminal oder ueber Codex ausgefuehrt wird, kann deine HA-Konfiguration veraendern.
- Fuer ein oeffentlich verteiltes Add-on waere das zu weitreichend. Fuer dein eigenes HAOS-System ist es genau der Zweck.

## Typischer Ablauf

```bash
cd /workspace
codex
```

Oder direkt mit Prompt:

```bash
codex "Pruefe meine Home Assistant YAML-Dateien und schlage Verbesserungen vor."
```
