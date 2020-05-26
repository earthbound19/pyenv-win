#requires -V 5
# Summary: Display the version of pyenv
#
# Displays the version number of this pyenv release, including the
# current revision from git, if available.
#
# The format of the git revision is:
#   <version>-<num_commits>-<git_sha>
# where `num_commits` is the number of commits since `version` was
# tagged.

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
git_revision=""

if cd "${BASH_SOURCE%/*}" 2>/dev/null && git remote -v 2>/dev/null | grep -q pyenv; then
  git_revision="$(git describe --tags HEAD 2>/dev/null || true)"
  git_revision="${git_revision#v}"
fi

echo "pyenv ${git_revision:-$version}"
#>
Write-Host "pyenv $version"