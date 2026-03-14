#!/usr/bin/env bash
set -euo pipefail

WORKDIR="${1:-/workspace}"
SHELL_BIN="${2:-/bin/bash}"
STARTUP_MODE="${3:-menu}"

cd "${WORKDIR}"

run_shell() {
  exec "${SHELL_BIN}" -l
}

run_codex() {
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
}

pause_for_menu() {
  echo
  read -r -p "Press Enter to return to the menu..."
}

show_menu() {
  clear || true
  cat <<EOF
Codex Terminal
==============

Workspace: ${WORKDIR}
Startup mode: menu

Choose what you want to do:
  1) Start a new Codex session
  2) Resume the most recent Codex session
  3) Choose a previous Codex session
  4) Open a normal shell
  5) Start Codex with web search and no sandbox/approval prompts
  6) Exit

Helpful shell commands:
  codex-menu
  codex-new
  codex-resume
  codex-last
  codex_resume_last
EOF
}

run_menu() {
  local choice

  while true; do
    show_menu
    echo
    read -r -p "Selection [1-6]: " choice
    echo

    case "${choice}" in
      1)
        run_codex "Starting a new Codex session..." codex
        pause_for_menu
        ;;
      2)
        run_codex "Resuming the most recent Codex session..." codex resume --last
        pause_for_menu
        ;;
      3)
        run_codex "Opening the Codex session picker..." codex resume
        pause_for_menu
        ;;
      4)
        echo "Opening shell..."
        echo
        run_shell
        ;;
      5)
        run_codex \
          "Starting Codex with web search and without sandbox/approval prompts..." \
          env NETWORK_ACCESS=true codex --search --dangerously-bypass-approvals-and-sandbox
        pause_for_menu
        ;;
      6)
        echo "Closing Codex Terminal."
        exit 0
        ;;
      *)
        echo "Invalid selection. Please choose a number from 1 to 6."
        pause_for_menu
        ;;
    esac
  done
}

case "${STARTUP_MODE}" in
  menu)
    run_menu
    ;;
  shell)
    run_shell
    ;;
  codex)
    run_codex "Starting a new Codex session..." codex
    echo
    echo "Dropping into shell."
    run_shell
    ;;
  codex_resume_last)
    run_codex "Resuming the most recent Codex session..." codex resume --last
    echo
    echo "Dropping into shell."
    run_shell
    ;;
  codex_resume_picker)
    run_codex "Opening the Codex session picker..." codex resume
    echo
    echo "Dropping into shell."
    run_shell
    ;;
  *)
    echo "Unknown startup_mode '${STARTUP_MODE}'. Falling back to menu."
    echo
    run_menu
    ;;
esac
