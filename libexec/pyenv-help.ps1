#requires -V 5
#
# Summary: Display the full path to an executable
#
# Usage: pyenv which <command>
#
# Displays the full path to the executable that pyenv will invoke when
# you run the given command.
#

$script:dp0 = $PSScriptRoot
$script:parent_path = Split-Path $dp0
$script:workingdir = Get-Location

if (!$Global:g_pyenv_flag_commonlib_loaded) {
    Import-Module "$parent_path\lib\commonlib.ps1" -Force
    Write-Verbose "($(__FILE__):$(__LINE__)) Common lib not loaded .. loading..."
}

$ErrorActionPreference = "stop"

<#


#>
Write-Host "to-be implemented"