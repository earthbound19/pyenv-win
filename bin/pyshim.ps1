#requires -V 5
# this file is as ASCII code (ÇÑ±Û)

$script:dp0 = $PSScriptRoot
$script:g_pyenv_root = Split-Path $dp0


if([bool]($args -match '--verbose'))
{
    $VerbosePreference = 'continue'
}


Import-Module "$g_pyenv_root\lib\commonlib.ps1" -Force





function script:Main($argv) {

    $remains = {$argv[1..$argv.length]}.Invoke()
    # to adjust array later convert to collection
    $cmdlet = getCommand $argv[0]


    if (Test-Path $cmdlet)
    {
        executeCommand $cmdlet $remains

    } else {
        switch ($argv[0]) {
            {($_ -ceq 'version-name')} 
            { 
                $cmdlet = getCommand('version')
                $remains.Insert(0, '--name')
                executeCommand $cmdlet $remains
                break;
            }
            {($_ -ceq 'versions')} 
            { 
                $cmdlet = getCommand('version')
                $remains.Insert(0, '--list')
                executeCommand $cmdlet $remains
                break;
            }
            Default {}
        } # end of switch
    } # end of else
}

script:Main($args)
