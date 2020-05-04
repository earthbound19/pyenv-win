#requires -V 5
# pyshim-install.ps1

$script:dp0 = $PSScriptRoot
$script:parent_path = Split-Path $dp0
$script:workingdir = Get-Location

if (!$Global:g_pyshim_flag_commonlib_loaded) {
    Import-Module "$parent_path\lib\commonlib.ps1" -Force
    Write-Verbose "($(__FILE__):$(__LINE__)) Common lib not loaded .. loading..."
}

function script:Main($argv) {

    $sopts = "lfskvg"
    $loptions = @("list", "force", "skip-existing", "keep", "verbose", "version" , "debug", "build")
    
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

    #region checking global python and set to $pyton_version
    if (Test-Path $Global:g_global_python_version_path) {
        Write-Verbose ( "($(__FILE__):$(__LINE__)) checking global python version in " + $Global:g_global_python_version_path)
        $python_version = (Get-Content -Path $Global:g_global_python_version_path -TotalCount 1).Trim()
    }
    #endregion

    if ($opts.list) {
        Get-ChildItem -Name -Path $Global:g_pyshim_versions_path -Directory

    } else {
    #regioin option null, -name
        $search_path = $workingdir
 
        $local_python_version_path = ""

        While($search_path)
        {
            if (Test-Path ([IO.Path]::Combine($search_path, $Global:g_fn_python_version))) 
            {
                $local_python_version_path = [IO.Path]::Combine($search_path, $Global:g_fn_python_version)
                Write-Verbose ("($(__FILE__):$(__LINE__)) " + "local version found in: {0}" -f $search_path) 
                break;
            }
            else {
                #https://stackoverflow.com/questions/45240480/how-to-step-backwards-in-a-path-using-powershell
                #$search_path = Resolve-Path (Join-Path $search_path '..')
                Write-Verbose ("($(__FILE__):$(__LINE__)) " + "local version not found in: {0}" -f $search_path)
                $search_path = Split-Path $search_path
                continue;
            }
        }

        $python_locating_src = " (set by $($Global:g_global_python_version_path))"
        Write-Verbose ("($(__FILE__):$(__LINE__)) " + "determining python version with global: {0}" -f $python_version)
        
        #region print out python version default is global            
        if ($local_python_version_path) {
            $python_version = (Get-Content -Path $local_python_version_path -TotalCount 1).Trim()
            $python_locating_src = " (set by $($local_python_version_path))"

        } elseif (!$python_version) {
            $python_version = "system"
        
        }
        
        if ($opts.name) {
            Write-Host "$python_version"
        } else {
            Write-Host "$python_version $python_locating_src"
        }
    #endregion
    } # enf of if

}

script:Main($args)