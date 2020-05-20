
$script:dp0 = $PSScriptRoot
$script:parent_path = Split-Path $dp0
$script:workingdir = Get-Location

$script:externals_ini = [IO.Path]::Combine( $dp0, "externals.ini")

if (!$Global:g_pyshim_flag_commonlib_loaded) {
    Import-Module "$parent_path\lib\commonlib.ps1" -Force
    Write-Verbose "($(__FILE__):$(__LINE__)) Common lib not loaded .. loading..."
}

$script:nuget_bin = [IO.Path]::Combine($Global:g_global_externals_path, "nuget.exe")

function script:Main($argv) {
    $sopts = "h"
    $loption = @("verbose", "file:", "help")

    $opts, $remains, $errmsg = getargs $argv $sopts $loptions
    
    $external_app = $remains[0]
    
    $script:pyshim_externals_ini = Get-IniFile $script:externals_ini
    
    Write-Verbose "called get_externals.ps1 : [$($external_app)] " 

# https://stackoverflow.com/questions/417798/ini-file-parsing-in-powershell
    switch ($external_app)
    {
        {($_ -ceq 'nuget')} {
            Write-Host "nuget url $($pyshim_externals_ini['nuget']['url'])"
            $out_file = [IO.Path]::Combine( $Global:g_global_externals_path , $pyshim_externals_ini['nuget']['outfile'])
            Invoke-WebRequest $pyshim_externals_ini['nuget']['url'] -OutFile "$($out_file)"
            if (!$?) {
                Write-Error "($(__FILE__):$(__LINE__)) nuget installation failed."
                break;
            }
        }
        {($_ -ceq '7za')} {
             Write-Host "getting 7za nuget_package $($pyshim_externals_ini['7za']['nuget_package'])"
             & "$script:nuget_bin" install $pyshim_externals_ini['7za']['nuget_package'] -ExcludeVersion -OutputDirectory $Global:g_global_externals_path 

             if (!$?) {
                Write-Error "($(__FILE__):$(__LINE__)) nuget installation failed."
                break;
             } else {
                $out_file = [IO.Path]::Combine( $Global:g_global_externals_path ,$pyshim_externals_ini['7za']['nuget_package'], $pyshim_externals_ini['7za']['outfile'] )
                Move-Item -Path $out_file -Destination $Global:g_global_externals_path
             } 

        }

    }

}



script:Main($args)