function ReadUserKeyboard {
    param(
        [string] $message
    )
    $line = Read-Host "$message"
    return $line;
}
  
function WaitForAnyKeyPressed {
    param (
        [string] $message
    )
    Write-Host -NoNewLine "$message";
    $key = ($Host.UI.RawUI.ReadKey("NoEcho, IncludeKeyDown"))
    PrintMessage -m ""
}

function Eval {
    param(
        [string] $expression
    )
    PrintMessage -m "> $expression" -t "info"
    Invoke-Expression $expression
}

function CommandExist {
    param (
        [string] $command
    )
    
    if (!([string]::IsNullOrEmpty((where.exe "$command")))) {
        return $true
    }
    return $false
}