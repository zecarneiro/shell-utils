#!/bin/bash
# shellcheck disable=SC2005

# Get another informations on your script
# SCRIPT_FULL_PATH="${BASH_SOURCE[0]:-$0}"
# SCRIPT_DIR="$(dirname "$SCRIPT_FULL_PATH")"

function Dirname {
  local file="$1"
  echo "$(dirname "$file")"
}

function Basename {
  local file="$1"
  echo "$(basename "$file")"
}

function GetWorkingDir {
  echo "$(pwd)"
}

function IsDirectory {
  local file="$1"
  if [[ -d "$file" ]]; then
    true; return
  fi
  false; return
}

function FileDelete {
  local file="$1"
  if FileExist "${file}"; then
    if IsDirectory "${file}"; then
      Eval "rm -rf \"${file}\""
    else
      Eval "rm -rf \"${file}\""
    fi
  else
    PrintMessage -m "File not exist: ${file}" -t "warnning"
  fi
}

function CreateDirectory {
  local file="$1"
  if ! IsDirectory "${file}"; then
    Eval "mkdir -p \"${file}\""
  fi
}

function WriteFile {
  local file append data
  # shellcheck disable=SC2214
  local opt OPTARG OPTIND
  while getopts 'f:a:d' opt; do
    case "${opt}" in
        f) file=${OPTARG};;
        a) append=${OPTARG};;
        d) data=${OPTARG};;
        *) ;;
    esac
  done
  if [ "$append" -eq 1 ]; then
    echo "$data" | tee -a "$file" > /dev/null
  else
    echo "$data" > "$file"
  fi
}

function FileExist {
  local file="$1"
  if IsDirectory "${file}"||[ -f "${file}" ]; then
    true; return
  fi
  false; return
}

function HasInternetConnection {
  if ! ping -c 1 8.8.8.8 -q &> /dev/null||! ping -c 1 8.8.4.4 -q &> /dev/null||! ping -c 1 time.google.com -q &> /dev/null; then
    false; return
  fi
  true; return
}

function Download {
  local uri outfile
  # shellcheck disable=SC2214
  local opt OPTARG OPTIND
  while getopts 'u:o:' opt; do
    case "${opt}" in
        u) uri=${OPTARG};;
        o) outfile=${OPTARG};;
        *) return 1;;
    esac
  done
  if HasInternetConnection; then
    if ! CommandExist "wget"; then
      Eval "sudo apt install wget -y"
    fi
    wget -O"$outfile" "$uri"
  else
    PrintMessage -m "No Internet connection available" -t "error"
  fi
}

function RestartSO {
  local message="$1"
  if [[ -n "${message}" ]]; then
    WaitForAnyKeyPressed "$message"
  fi
  sudo shutdown -r now
  exit 0
}

function ShutdownSO {
  local message="$1"
  if [[ -n "${message}" ]]; then
    WaitForAnyKeyPressed "$message"
  fi
  sudo shutdown -h now
  exit 0
}





















  


# function HasInternetConnection {
#     return ((Test-Connection 8.8.8.8 -Count 1 -Quiet) -or (Test-Connection 8.8.4.4 -Count 1 -Quiet) -or (Test-Connection time.google.com -Count 1 -Quiet))
# }

# function Download {
#     param(
#         [ValidateNotNullorEmpty()]
#         [string] $uri,
#         [ValidateNotNullorEmpty()]
#         [string] $outfile
#     )
#     if (HasInternetConnection) {
#         Invoke-WebRequest -Uri "$uri" -OutFile "$outfile"
#     } else {
#         PrintMessage -message "No Internet connection available" -type "error"
#     }
# }

# function Sed {
#     param(
#         [ValidateNotNullorEmpty()]
#         [string] $file,
#         [string] $regex,
#         [string] $replace
#     )
#     (Get-Content $file) -replace $regex, $replace | Set-Content $file
# }