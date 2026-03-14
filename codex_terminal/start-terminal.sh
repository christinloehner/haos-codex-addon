#!/usr/bin/env bash
set -euo pipefail

WORKDIR="${1:-/workspace}"
SHELL_BIN="${2:-/bin/bash}"
STARTUP_MODE="${3:-shell}"

cd "${WORKDIR}"

run_shell() {
  exec "${SHELL_BIN}" -l
}

run_codex_then_shell() {
  local description="$1"
  shift
  local exit_code=0

  echo "${description}"
  echo

  "$@" || exit_code=$?

  if [[ "${exit_code}" -ne 0 ]]; then
    echo
    echo "Codex exited with status ${exit_code}."
  fi

  echo
  echo "Dropping into shell."
  run_shell
}

case "${STARTUP_MODE}" in
  shell)
    run_shell
    ;;
  codex)
    run_codex_then_shell "Starting a new Codex session..." codex
    ;;
  codex_resume_last)
    run_codex_then_shell "Resuming the most recent Codex session..." codex resume --last
    ;;
  codex_resume_picker)
    run_codex_then_shell "Opening the Codex session picker..." codex resume
    ;;
  *)
    echo "Unknown startup_mode '${STARTUP_MODE}'. Falling back to shell."
    echo
    run_shell
    ;;
esac
