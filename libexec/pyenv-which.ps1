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
# Provide pyenv completions
if [ "$1" = "--complete" ]; then
  exec pyenv-shims --short
fi

remove_from_path() {
  local path_to_remove="$1"
  local path_before
  local result=":${PATH//\~/$HOME}:"
  while [ "$path_before" != "$result" ]; do
    path_before="$result"
    result="${result//:$path_to_remove:/:}"
  done
  result="${result%:}"
  echo "${result#:}"
}

PYENV_COMMAND="$1"

if [ -z "$PYENV_COMMAND" ]; then
  pyenv-help --usage which >&2
  exit 1
fi

OLDIFS="$IFS"
IFS=: versions=(${PYENV_VERSION:-$(pyenv-version-name)})
IFS="$OLDIFS"

for version in "${versions[@]}"; do
  if [ "$version" = "system" ]; then
    PATH="$(remove_from_path "${PYENV_ROOT}/shims")"
    PYENV_COMMAND_PATH="$(command -v "$PYENV_COMMAND" || true)"
  else
    PYENV_COMMAND_PATH="${PYENV_ROOT}/versions/${version}/bin/${PYENV_COMMAND}"
  fi
  if [ -x "$PYENV_COMMAND_PATH" ]; then
    break
  fi
done

OLDIFS="$IFS"
IFS=$'\n' scripts=(`pyenv-hooks which`)
IFS="$OLDIFS"
for script in "${scripts[@]}"; do
  source "$script"
done

if [ -x "$PYENV_COMMAND_PATH" ]; then
  echo "$PYENV_COMMAND_PATH"
else
  any_not_installed=0
  for version in "${versions[@]}"; do
    if [ "$version" = "system" ]; then
      continue
    fi
    if ! [ -d "${PYENV_ROOT}/versions/${version}" ]; then
      echo "pyenv: version \`$version' is not installed (set by $(pyenv-version-origin))" >&2
      any_not_installed=1
    fi
  done
  if [ "$any_not_installed" = 1 ]; then
    exit 1
  fi

  echo "pyenv: $PYENV_COMMAND: command not found" >&2

  versions="$(pyenv-whence "$PYENV_COMMAND" || true)"
  if [ -n "$versions" ]; then
    { echo
      echo "The \`$1' command exists in these Python versions:"
      echo "$versions" | sed 's/^/  /g'
      echo
      echo "Note: See 'pyenv help global' for tips on allowing both"
      echo "      python2 and python3 to be found."
    } >&2
  fi

  exit 127
fi

#>
Write-Host "to-be implemented"