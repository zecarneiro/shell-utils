
# Get another informations on your script
# $SCRIPT_DIR = ($PSScriptRoot)
# $SCRIPT_FULL_PATH = "$PSCommandPath"

function Dirname {
    param (
        [String] $file
    )
    return ([System.IO.Path]::GetDirectoryName($file))
}

function Basename {
    param (
        [string] $file
    )
    return ([io.fileinfo]$file).basename
}

function GetWorkingDir {
    return (Get-Location | Foreach-Object { $_.Path })
}

function IsDirectory {
    param (
        [string] $file
    )
    if ((FileExist -file "$file")) {
        return (Get-Item "$file" -Force) -is [System.IO.DirectoryInfo]
    }
    return $FALSE
}
  
function FileDelete {
    param (
        [string] $file
    )
    if ((FileExist -file "$file")) {
        Eval -expression "Remove-Item `"$file`" -Recurse -Force"
    } else {
        PrintMessage -m "File not exist: ${file}" -t "warnning"
    }
}

function CreateDirectory {
    param (
        [string] $file
    )
    if (!(FileExist -file "$file")) {
        Eval -expression "New-Item -ItemType Directory -Force -Path `"$dir`""
    }
}

function WriteFile {
    param(
        [string] $f,
        [string] $d = "",
        [switch] $a
    )
    $file = $f; $append = $a; $data = $d
    if (!$append) {
        FileDelete -file "$file"
    }
    if (!(FileExist -file "$file")) {
        Out-File -FilePath "$file"
    }
    Add-Content -Path "$file" -Value "$data"
}

function FileExist {
    param(
        [string] $file
    )
    if (((Test-Path -Path "$file")) -or (Test-Path -Path "$file" -PathType Leaf)) {
        return $TRUE
    }
    return $FALSE
}

function HasInternetConnection {
    return ((Test-Connection 8.8.8.8 -Count 1 -Quiet) -or (Test-Connection 8.8.4.4 -Count 1 -Quiet) -or (Test-Connection time.google.com -Count 1 -Quiet))
}

function Download {
    param(
        [string] $u,
        [string] $o
    )
    $uri = $u; $outfile = $o
    if (HasInternetConnection) {
        Invoke-WebRequest -Uri "$uri" -OutFile "$outfile"
    } else {
        PrintMessage -m "No Internet connection available" -t "error"
    }
}

function RestartSO {
    param(
        [string] $message
    )
    if ($message.length -gt 0) {
        WaitForAnyKeyPressed -message "$message"
    }
    shutdown /r /t 0
    exit 0
}

function ShutdownSO {
    param(
        [string] $message
    )
    if ($message.length -gt 0) {
        WaitForAnyKeyPressed -message "$message"
    }
    shutdown /s /t 0
    exit 0
}