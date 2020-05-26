#requires -V 5
# Summary: List all Python versions that contain the given executable
# Usage: pyenv whence [--path] <command>

$script:dp0 = $PSScriptRoot
$script:parent_path = Split-Path $dp0
$script:workingdir = Get-Location

if (!$Global:g_pyenv_flag_commonlib_loaded) {
    Import-Module "$parent_path\lib\commonlib.ps1" -Force
    Write-Verbose "($(__FILE__):$(__LINE__)) Common lib not loaded .. loading..."
}

$ErrorActionPreference = "stop"

$script:version="0.1.0"

<#
# Provide pyenv completions
if [ "$1" = "--complete" ]; then
  echo --path
  exec pyenv-shims --short
fi

if [ "$1" = "--path" ]; then
  print_paths="1"
  shift
else
  print_paths=""
fi

whence() {
  local command="$1"
  pyenv-versions --bare | while read -r version; do
    path="$(pyenv-prefix "$version")/bin/${command}"
    if [ -x "$path" ]; then
      [ "$print_paths" ] && echo "$path" || echo "$version"
    fi
  done
}

PYENV_COMMAND="$1"
if [ -z "$PYENV_COMMAND" ]; then
  pyenv-help --usage whence >&2
  exit 1
fi

result="$(whence "$PYENV_COMMAND")"
[ -n "$result" ] && echo "$result"

#>
Write-Host "to-be implemented"