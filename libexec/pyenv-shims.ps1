#requires -V 5
# Summary: List existing pyenv shims
# Usage: pyenv shims [--short]

$script:dp0 = $PSScriptRoot
$script:parent_path = Split-Path $dp0
$script:workingdir = Get-Location

if (!$Global:g_pyenv_flag_commonlib_loaded) {
    Import-Module "$parent_path\lib\commonlib.ps1" -Force
    Write-Verbose "($(__FILE__):$(__LINE__)) Common lib not loaded .. loading..."
}

$ErrorActionPreference = "stop"
<#
[ -n "$PYENV_DEBUG" ] && set -x

# Provide pyenv completions
if [ "$1" = "--complete" ]; then
  echo --short
  exit
fi

shopt -s nullglob

for command in "${PYENV_ROOT}/shims/"*; do
  if [ "$1" = "--short" ]; then
    echo "${command##*/}"
  else
    echo "$command"
  fi
done | sort
#>
Write-Host "To-be implemented"