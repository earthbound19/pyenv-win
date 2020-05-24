
$script:dp0 = $PSScriptRoot
$script:parent_path = Split-Path $dp0
$script:workingdir = Get-Location

if (!$Global:g_pyshim_flag_commonlib_loaded) {
    Import-Module "$parent_path\lib\commonlib.ps1" -Force
    Write-Verbose "($(__FILE__):$(__LINE__)) Common lib not loaded .. loading..."
}

$script:nuget_bin = [IO.Path]::Combine($Global:g_global_externals_path, "nuget.exe")

if (-Not (Test-Path($Global:g_global_externals_path))) {
    New-Item -ItemType Directory -Force -Path $Global:g_global_externals_path > $null
}

function script:Main($argv) {
    $sopts = "h"
    $loption = @("verbose", "file:", "help")

    $opts, $remains, $errmsg = getargs $argv $sopts $loptions
    
    $external_app = $remains[0]
    

    
    Write-Verbose "called get_externals.ps1 : [$($external_app)] " 

# https://stackoverflow.com/questions/417798/ini-file-parsing-in-powershell
    switch ($external_app)
    {
        {($_ -ceq 'nuget')} {
            Write-Host "nuget url $($g_pyshim_externals_ini['nuget']['url'])"
            $out_file = [IO.Path]::Combine( $Global:g_global_externals_path , $g_pyshim_externals_ini['nuget']['outfile'])
            Invoke-WebRequest $g_pyshim_externals_ini['nuget']['url'] -OutFile "$($out_file)"
            if (!$?) {
                Write-Error "($(__FILE__):$(__LINE__)) nuget installation failed."
                break;
            }
        }
        {($_ -ceq '7z')} {
             Write-Host "getting 7z nuget_package $($g_pyshim_externals_ini['7z']['nuget_pkg'])"

             & "$script:nuget_bin" install $g_pyshim_externals_ini['7z']['nuget_pkg'] -ExcludeVersion `
               -OutputDirectory $Global:g_pyshim_temp_path 

             if (!$?) {
                Write-Error "($(__FILE__):$(__LINE__)) nuget '7za' installation failed."
                break;
             } else {
                $out_file = [IO.Path]::Combine($Global:g_pyshim_temp_path ,$g_pyshim_externals_ini['7z']['nuget_pkg'],`
                              $g_pyshim_externals_ini['7z']['nuget_move'])
                Move-Item -Path $out_file -Destination $Global:g_global_externals_path
                $script:license_dir = [IO.Path]::Combine($g_global_externals_path ,"licenses", `
                $g_pyshim_externals_ini['7z']['nuget_pkg'])
                New-Item -ItemType Directory -Force -Path "$license_dir"  > $null
                Move-Item  -Path ([IO.Path]::Combine($Global:g_pyshim_temp_path ,`
                $g_pyshim_externals_ini['7z']['nuget_pkg'], "tools", "*.*")) `
                -Destination $license_dir
                Remove-Item -Path ([IO.Path]::Combine($Global:g_pyshim_temp_path ,"*")) -Force -Recurse
             } 
        }
    } # end of switch

}



script:Main($args)