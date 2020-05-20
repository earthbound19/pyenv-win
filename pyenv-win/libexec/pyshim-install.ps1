#requires -V 5
# pyshim-install.ps1

$script:dp0 = $PSScriptRoot
$script:parent_path = Split-Path $dp0
$script:workingdir = Get-Location


if (!$Global:g_pyshim_flag_commonlib_loaded) {
    Import-Module "$parent_path\lib\commonlib.ps1" -Force
    Write-Verbose "($(__FILE__):$(__LINE__)) Common lib not loaded .. loading..."
}

$script:nuget_bin           = [IO.Path]::Combine($Global:g_global_externals_path , "nuget.exe")
$script:7z_bin              = [IO.Path]::Combine($Global:g_global_externals_path , "7za.exe")
$script:build_pythonx86_bin = [IO.Path]::Combine($Global:g_global_externals_path, "pythonx86", "Tools", "python.exe")

function script:Check_Externals() {

    if (-not (Test-Path $script:nuget_bin)) {
        Write-Host "nuget missing, installing nuget ..."
        & ([IO.Path]::Combine($g_pyshim_libexec_path, "get_externals.ps1")) 'nuget'
    }

    if (-not (Test-Path $script:7z_bin)) {
        Write-Host "7za missing, installing 7za  ..."
        & ([IO.Path]::Combine($g_pyshim_libexec_path, "get_externals.ps1")) '7za'
    }
    

}

function script:Main($argv) {

    $sopts = "lfskvg"
    $loptions = @("list", "force", "skip-existing", "keep", "verbose", "version" , "debug", "build")
    Check_Externals
    <#

    Usage: pyenv install [-f] [-kvp] <version>
       pyenv install [-f] [-kvp] <definition-file>  ### not supported ###
       pyenv install -l|--list
       pyenv install --version

    -l/--list          List all available versions
    -f/--force         Install even if the version appears to be installed already
    -s/--skip-existing Skip if the version appears to be installed already

    python-build options:

    -k/--keep          Keep source tree in $PYENV_BUILD_ROOT after installation
                        (defaults to $PYENV_ROOT/sources)
    -p/--patch         Apply a patch from stdin before building
    -v/--verbose       Verbose mode: print compilation status to stdout
    --version          Show version of python-build
    -g/--debug         Build a debug version
    #>

    $opts, $remains, $errmsg = getargs $argv $sopts $loptions

    $python_version =""

    #region checking nuget external exists
    if (Test-Path $Global:g_global_python_version_path) {
        Write-Verbose ( "($(__FILE__):$(__LINE__)) checking global python version in " + $Global:g_global_python_version_path)
        # first version in version file is python global version
        $python_version = (Get-Content -Path $Global:g_global_python_version_path -TotalCount 1).Trim()
    }
    #endregion

    $requested_version = $remains[0];
    Write-Host "requested version[$requested_version]"

    # regex pattern created by https://regexr.com/39s32 jc@jmccc.com
    $pattern_version = '^((([0-9]+)\.([0-9]+)\.([0-9]+)(?:-([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?)(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?)$'

    $requested_version -match $pattern_version | Out-String 


}

script:Main($args)