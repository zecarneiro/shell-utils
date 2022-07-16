#!/bin/bash
# Autor: José M. C. Noronha
# shellcheck source=/dev/null

declare TYPE_IMPORT="$1"
declare SCRIPT_SHELL_UTILS_FULL_PATH="${BASH_SOURCE[0]:-$0}"
declare SHELL_UTILS_DIR="$(dirname "$SCRIPT_SHELL_UTILS_FULL_PATH")"

# ---------------------------------------------------------------------------- #
#                                    IMPORT                                    #
# ---------------------------------------------------------------------------- #
if [[ "${TYPE_IMPORT}" == "-all" ]]||[  "${TYPE_IMPORT}" == "-console" ]; then
    source "$SHELL_UTILS_DIR/linux/console.sh"
fi
if [[ "${TYPE_IMPORT}" == "-all" ]]||[  "${TYPE_IMPORT}" == "-fileSystem" ]; then
    source "$SHELL_UTILS_DIR/linux/file-system.sh"
fi
if [[ "${TYPE_IMPORT}" == "-all" ]]||[  "${TYPE_IMPORT}" == "-functions" ]; then
    source "$SHELL_UTILS_DIR/linux/functions.sh"
fi
if [[ "${TYPE_IMPORT}" == "-all" ]]||[  "${TYPE_IMPORT}" == "-packages" ]; then
    source "$SHELL_UTILS_DIR/linux/packages.sh"
fi

# ---------------------------------------------------------------------------- #
#                                     OTHER                                    #
# ---------------------------------------------------------------------------- #
# Update APT Repository
Eval "sudo apt update"

# Upgrade APT Package
Eval "sudo apt upgrade -y"