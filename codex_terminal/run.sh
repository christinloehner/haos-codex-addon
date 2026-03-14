#!/usr/bin/with-contenv bashio
set -euo pipefail

WORKDIR="$(bashio::config 'working_directory')"
SHELL_BIN="$(bashio::config 'shell')"
STARTUP_MODE="$(bashio::config 'startup_mode')"

if [[ -z "${WORKDIR}" ]]; then
  WORKDIR="/workspace"
fi

if [[ -z "${SHELL_BIN}" ]]; then
  SHELL_BIN="/bin/bash"
fi

if [[ -z "${STARTUP_MODE}" ]]; then
  STARTUP_MODE="menu"
fi

if [[ ! -d "${WORKDIR}" ]]; then
  bashio::log.warning "Working directory ${WORKDIR} does not exist, falling back to /workspace"
  WORKDIR="/workspace"
fi

case "${STARTUP_MODE}" in
  menu|shell|codex|codex_resume_last|codex_resume_picker)
    ;;
  *)
    bashio::log.warning "Unknown startup_mode ${STARTUP_MODE}, falling back to menu"
    STARTUP_MODE="menu"
    ;;
esac

mkdir -p /data/codex-home

export HOME="/data/codex-home"
export CODEX_HOME="/data/codex-home"
export SHELL="${SHELL_BIN}"
export TERM="xterm-256color"
export CODEX_START_DIR="${WORKDIR}"
export CODEX_STARTUP_MODE="${STARTUP_MODE}"

cat >/data/codex-home/.bashrc <<EOF
export HOME=/data/codex-home
export CODEX_HOME=/data/codex-home
export TERM=xterm-256color
export CODEX_START_DIR="${WORKDIR}"
export CODEX_STARTUP_MODE="${STARTUP_MODE}"

alias codex-new='cd "${CODEX_START_DIR}" && codex'
alias codex-resume='cd "${CODEX_START_DIR}" && codex resume'
alias codex-last='cd "${CODEX_START_DIR}" && codex resume --last'
alias codex-menu='/start-terminal.sh "${CODEX_START_DIR}" "${SHELL}" menu'
alias codex_new='cd "${CODEX_START_DIR}" && codex'
alias codex_resume='cd "${CODEX_START_DIR}" && codex resume'
alias codex_resume_last='cd "${CODEX_START_DIR}" && codex resume --last'
alias codex_resume_picker='cd "${CODEX_START_DIR}" && codex resume'

cd "${WORKDIR}"
EOF

cat >/data/codex-home/.bash_profile <<'EOF'
if [[ -f "${HOME}/.bashrc" ]]; then
  . "${HOME}/.bashrc"
fi
EOF

bashio::log.info "Starting ttyd on ingress port 7681"
bashio::log.info "Workspace: ${WORKDIR}"
bashio::log.info "Startup mode: ${STARTUP_MODE}"

exec ttyd \
  --port 7681 \
  --writable \
  --cwd "${WORKDIR}" \
  /start-terminal.sh "${WORKDIR}" "${SHELL_BIN}" "${STARTUP_MODE}"
