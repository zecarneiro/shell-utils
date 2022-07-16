function PrintMessage {
  param(
    [ValidateSet("error", "info", "warnning", "success", "none", IgnoreCase = $false)] # IgnoreCase set autocomplete
    [string] $t,
    [string] $m = ""
  )
  $type = $t; $message = $m
  if ($type -eq "error") {
    Write-Host "$message" -ForegroundColor Red
  }
  elseif ($type -eq "info") {
    Write-Host "$message" -ForegroundColor Blue
  }
  elseif ($type -eq "warnning") {
    Write-Host "$message" -ForegroundColor Yellow
  }
  elseif ($type -eq "success") {
    Write-Host "$message" -ForegroundColor Green
  }
  else {
    Write-Host "$message"
  }
}

function IsAdmin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  return ($currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator))
}

function Cut {
  param(
    [string] $data,
    [string] $delimiter,
    [ValidateSet("L", "R", IgnoreCase = $false)]
    [string] $direction
  )
  if ($data.Length -gt 0) {
    if ($direction -eq "R") {
      $pos = ($data.IndexOf($delimiter)+$delimiter.Length)
      return $data.Substring($pos)
    } elseif ($direction -eq "L") {
      return $data.Substring(0, $data.IndexOf($delimiter))
    }
    return $data
  }
}

function Grep {
  param (
    [string] $f,
    [string] $r
  )
  $file = $f; $regex = $r
  Select-String -Path $file -Pattern $regex
}

function Sed {
  param(
    [string] $file,
    [string] $regex,
    [string] $replace,
    [switch] $inPlace
  )
  if ($data.Length -eq 0) {
    $data = (Get-Content $file)
  }
  $newData = ($data -replace $regex, $replace)
  if ($inPlace) {
    $newData | Set-Content $file
  } else {
    return $newData
  }
}

function Trim {
  param (
    [string] $d,
    [string] $c="`n "
  )
  $data = $d; $characters = $c
  if ($data.Length -gt 0) {
    $data = $data.Trim($characters)
  }
  return $data
}