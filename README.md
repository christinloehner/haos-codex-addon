# HAOS Codex Add-on

Dieses Repository enthaelt ein Home-Assistant-Add-on, das ein Ingress-Terminal mit installiertem Codex bereitstellt und den Home-Assistant-Konfigurationsordner beschreibbar einbindet.

Das Ziel ist pragmatisch: Codex soll direkt in HAOS auf YAML-Dateien, `packages/`, `automations.yaml`, `scripts.yaml`, `blueprints/` und weitere Konfigurationsdateien zugreifen koennen.

## Enthaltenes Add-on

- `codex_terminal`: Ingress-Terminal auf Basis von `ttyd` mit vorinstalliertem `@openai/codex`

## Geplanter Einsatz

Im Add-on laeuft ein Shell-Terminal im gemappten Home-Assistant-Konfigurationsordner. Von dort aus kannst du:

- `codex` direkt gegen deine HA-Konfiguration laufen lassen
- YAML-Dateien lesen und aendern
- Git im gemappten Konfigurationsordner nutzen, falls dort ein Repo liegt

## Installation in Home Assistant

1. Dieses Repo nach GitHub pushen.
2. In [repository.yaml](/home/christin/haos-codex-addon/repository.yaml) die Platzhalter-URL auf dein echtes GitHub-Repo setzen.
3. In Home Assistant `Einstellungen -> Add-ons -> Add-on-Store -> Repositories` oeffnen.
4. Die Git-URL dieses Repos hinzufuegen.
5. Das Add-on `Codex Terminal` installieren und starten.
6. Das Add-on per Ingress oeffnen.
7. Im Terminal `codex login` ausfuehren.

## Wichtige Hinweise

- Das Add-on mountet den Home-Assistant-Konfigurationsordner mit Schreibrechten.
- Damit hat Codex effektiv Vollzugriff auf deine HA-YAML-Dateien.
- Das ist absichtlich maechig und sicherheitstechnisch entsprechend sensibel.
- Dieses Repo ist als privates/selbst gehostetes Add-on gedacht, nicht als oeffentliches Store-Add-on.
