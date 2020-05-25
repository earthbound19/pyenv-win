#requires -V 5
# pyshim-local.ps1

$script:dp0 = $PSScriptRoot
$script:parent_path = Split-Path $dp0
$script:workingdir = Get-Location

if (!$Global:g_pyshim_flag_commonlib_loaded) {
    Import-Module "$parent_path\lib\commonlib.ps1" -Force
    Write-Verbose "($(__FILE__):$(__LINE__)) Common lib not loaded .. loading..."
}

$script:nl = [Environment]::NewLine

function script:gen_shim ($shim, $shim_path_exe, $shim_version, $shim_args) {

    Copy-Item -Path ($Global:g_pyshim_exe) -Destination ([IO.Path]::Combine($Global:g_pyshim_shims_path,  "$shim.exe"))
    
    $shim_file = [IO.Path]::Combine($Global:g_pyshim_shims_path,  "$shim.shim")
    $shim_path = [IO.Path]::Combine($Global:g_pyshim_versions_path,  $shim_version,  "tools", $shim_path_exe)

    Set-Content -Path $shim_file -Value "path = $($shim_path)" -NoNewline
    
    if ($shim_args) {
        Add-Content -Path $shim_file -Value "$($nl)args = $shim_args" -NoNewLine
    }

}
function script:make_shims($st_version) {

    New-Item -ItemType Directory -Force -Path $Global:g_pyshim_shims_path > $null
    Remove-Item ([IO.Path]::Combine($Global:g_pyshim_shims_path,  "*.*"))

    $p_semantic_ver = Get-PyVersionNo($st_version)
    
    $st_M_m_version = "$($p_semantic_ver.Major).$($p_semantic_ver)"

    #create python.exe and shim
    gen_shim "python" "python.exe" $st_version ""
    gen_shim "python3" "python3.exe" $st_version ""
    #create pip.exe and shim
    gen_shim "pip" "python.exe" $st_version "-m pip"
    #create pip.exe and shim shim not supported yet (console only)
    #gen_shim "pythonw" "pythonw.exe" $st_version ""
}


function script:Main($argv) {
    $sopts = ""
    $loptions = @("verbose")

    $opts, $remains, $errmsg = getargs $argv $sopts $loptions

    if ($opts.verbose) {Set-Verbose('Continue') }
    
    $script:python_global_version = "system"

    $script:pyshim_version_list = Get-ChildItem -Name -Path $Global:g_pyshim_versions_path -Directory
    if (Test-Path $Global:g_global_python_version_file) {
        $python_global_version = (Get-Content -Path $g_global_python_version_file -TotalCount 1).Trim()
    }

    if(!$remains) {
        if(-Not (Test-Path ($g_global_python_version_file))) {
            Write-Host "system" -NoNewline
        } else {
            if ($pyshim_version_list -contains $python_global_version) {
                Write-Host "$python_global_version" -NoNewline
            } else {
                Write-Host "pyshim: global version set to $python_global_version, but not exist" `
                 -ForegroundColor White -BackgroundColor Red 
            }
        }
    } else {
        $st_version = $remains[0]

        if ($pyshim_version_list -contains $st_version) {
            Set-Content -Path $Global:g_global_python_version_file -Value $st_version  -NoNewline
            make_shims($st_version)
        } else {
            Write-Host "system" -NoNewline
        }

    }


    

}

script:Main($args)