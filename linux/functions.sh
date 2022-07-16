#!/bin/bash

declare NO_COLOR='\033[0m'
declare RED_COLOR='\033[0;31m'
declare BLUE_COLOR='\033[0;34m'
declare YELLOW_COLOR='\033[0;33m'
declare GREEN_COLOR='\033[0;32m'

function PrintMessage {
  local message type_message
  # shellcheck disable=SC2214
  local opt OPTARG OPTIND
  while getopts 'm:t:' opt; do
    case "${opt}" in
        m) message=${OPTARG};;
        t) type_message=${OPTARG};;
        :) echo "Error: -${OPTARG} requires an argument.";;
        *) ;;
    esac
  done
  if [[ "${type_message}" == "error" ]]; then
    echo -e "${RED_COLOR}${message}${NO_COLOR}" >&2
  elif [[ "${type_message}" == "info" ]]; then
    echo -e "${BLUE_COLOR}${message}${NO_COLOR}" >&2
  elif [[ "${type_message}" == "warnning" ]]; then
    echo -e "${YELLOW_COLOR}${message}${NO_COLOR}" >&2
  elif [[ "${type_message}" == "success" ]]; then
    echo -e "${GREEN_COLOR}${message}${NO_COLOR}" >&2
  else
    echo -e "${message}" >&2
  fi
}

function IsAdmin {
  if [ "$(id -u)" -eq 0 ]; then
    true; return
  fi
  false; return
}

function Cut {
  local delimiter data direction # direction = L/R
  CUT_PARSED_ARGUMENTS=$(getopt --longoptions data:,direction:,delimiter: -o "" -- "$@")
  CUT_VALID_ARGUMENTS=$?
  if [ "$CUT_VALID_ARGUMENTS" != "0" ]; then
    PrintMessage -m "Invalid arguments on Cut command" "error"
    return 1
  fi
  eval set -- "$CUT_PARSED_ARGUMENTS"
  while :; do
    case "$1" in
      --direction) direction=$2; shift 2  ;;
      --delimiter) delimiter=$2; shift 2  ;;
      --data) data=$2; shift 2  ;;
      --) shift; break ;;
    esac
  done
  if [[ -n "${data}" ]]; then
    if [[ "${direction}" == "R" ]]; then
      data="$(echo "$data" | awk -F "$delimiter" '{ print $2 }')"
    elif [[ "${direction}" == "L" ]]; then
      data="$(echo "$data" | awk -F "$delimiter" '{ print $1 }')"
    fi
    echo "$data"
  fi
}

function Grep {
  local file regex
  # shellcheck disable=SC2214
  local opt OPTARG OPTIND
  while getopts ":f:r:" opt; do
    case "${opt}" in
        f) file=${OPTARG};;
        r) regex=${OPTARG};;
        *) ;;
    esac
  done
  # shellcheck disable=SC2002
  # shellcheck disable=SC2005
  echo "$(cat "$file" | grep "$regex")"
}

function Trim() {
    local data characters
    # shellcheck disable=SC2214
    local opt OPTARG OPTIND
    while getopts ":d:c:" opt; do
      case "${opt}" in
          d) data=${OPTARG};;
          c) characters=${OPTARG};;
          *) ;;
      esac
    done
    if [ -z "$characters" ]; then
        characters='" "\n\r'
    fi
    echo "$(echo "$data" | sed "s/[$characters]//g")"
}

RemoveWord() (
  set -f
  IFS=' '

  s=$1
  w=$2

  set -- $1
  for arg do
    shift
    [ "$arg" = "$w" ] && continue
    set -- "$@" "$arg"
  done

  printf '%s\n' "$*"
)