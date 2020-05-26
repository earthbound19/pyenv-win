#requires -V 5
# pyenv-local.ps1

$script:dp0 = $PSScriptRoot
$script:parent_path = Split-Path $dp0
$script:workingdir = Get-Location

if (!$Global:g_pyenv_flag_commonlib_loaded) {
    Import-Module "$parent_path\lib\commonlib.ps1" -Force
    Write-Verbose "($(__FILE__):$(__LINE__)) Common lib not loaded .. loading..."
}

function script:cmd_unset() {
    if (Test-Path $g_fn_python_version) {
        Remove-Item $g_fn_python_version -Force
    }
}

function script:Main($argv) {

    $sopts = ""
    $loptions = @("unset", "verbose")

    $opts, $remains, $errmsg = getargs $argv $sopts $loptions

    if ($opts.verbose) {Set-Verbose('Continue') }

    $pyenv_version_list = Get-ChildItem -Name -Path $Global:g_pyenv_versions_path -Directory

    if($opts.unset) { cmd_unset ; return }

    elseif($remains) {
        $st_version_to_set = $remains[0]

        Write-Verbose "($(__FILE__):$(__LINE__)) version to set: $st_version_to_set"

        if ($pyenv_version_list -contains $st_version_to_set) {
            Set-Content -Path $g_fn_python_version -Value $st_version_to_set -NoNewline
        } else {
            Write-Host "pyenv: version '$st_version_to_set' not installed"
        }
    } else {

        $cmd_version = getCommand('version')
        $cmd_args = '--name'

        executeCommand $cmd_version $cmd_args
    }



}

script:Main($args)