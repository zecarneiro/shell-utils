param(
    [switch] $all,
    [switch] $console,
    [switch] $fileSystem,
    [switch] $functions,
    [switch] $packages
)

$SHELL_UTILS_DIR = ($PSScriptRoot)
# ---------------------------------------------------------------------------- #
#                                    IMPORT                                    #
# ---------------------------------------------------------------------------- #
if ($all -or $console) {
    . "$SHELL_UTILS_DIR\windows\console.ps1"
}
if ($all -or $fileSystem) {
    . "$SHELL_UTILS_DIR\windows\file-system.ps1"
}
if ($all -or $functions) {
    . "$SHELL_UTILS_DIR\windows\functions.ps1"
}
if ($all -or $packages) {
    . "$SHELL_UTILS_DIR\windows\packages.ps1"
}