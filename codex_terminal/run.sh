#!/usr/bin/with-contenv bashio
set -euo pipefail

WORKDIR="$(bashio::config 'working_directory')"
SHELL_BIN="$(bashio::config 'shell')"

if [[ -z "${WORKDIR}" ]]; then
  WORKDIR="/workspace"
fi

if [[ -z "${SHELL_BIN}" ]]; then
  SHELL_BIN="/bin/bash"
fi

if [[ ! -d "${WORKDIR}" ]]; then
  bashio::log.warning "Working directory ${WORKDIR} does not exist, falling back to /workspace"
  WORKDIR="/workspace"
fi

mkdir -p /data/codex-home

export HOME="/data/codex-home"
export CODEX_HOME="/data/codex-home"
export SHELL="${SHELL_BIN}"
export TERM="xterm-256color"

cat >/data/codex-home/.bashrc <<'EOF'
export HOME=/data/codex-home
export CODEX_HOME=/data/codex-home
export TERM=xterm-256color
cd /workspace
EOF

bashio::log.info "Starting ttyd on ingress port 7681"
bashio::log.info "Workspace: ${WORKDIR}"

exec ttyd \
  --port 7681 \
  --writable \
  --cwd "${WORKDIR}" \
  "${SHELL_BIN}" -l
