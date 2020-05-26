#require -V 5

$dp0 = $PSScriptRoot
$g_pyenv_root = Split-Path $dp0


function Get-CurrentLineNumber {
  $MyInvocation.ScriptLineNumber
}
# from  https://poshoholic.com/2009/01/19/powershell-quick-tip-how-to-retrieve-the-current-line-number-and-file-name-in-your-powershell-script/

New-Alias -Name __LINE__ -Value Get-CurrentLineNumber -Description 'Returns the current line number in a PowerShell script file.'

function Get-CurrentFileName {
  $MyInvocation.ScriptName | Split-Path -leaf
}

New-Alias -Name __FILE__ -Value Get-CurrentFileName -Description 'Returns the name of the current PowerShell script file.'
#endregion

function getCommand($cmd)
{
    [IO.Path]::Combine( $g_pyenv_libexec_path , "$g_pyenv_fn-$($cmd).ps1")
}
function executeCommand($cmdlet, $arr_rguments) {
  # https://stackoverflow.com/questions/12850487/invoke-a-second-script-with-arguments-from-a-script
  # strange.... if yaml have no contents error happens here...
  if (!$cmdlet) { return; }

  if ($arr_rguments -gt 0) {
    $call_args = $arr_rguments -join ' ' 
  } else {
    $call_args = ""
  }
  Invoke-Expression "& `"$cmdlet`" $call_args"
  if (-Not $?) {throw "Failed to run $cmdlet"}
}

#region global variable set
$Global:g_pyenv_flag_commonlib_loaded = $true
$Global:g_pyenv_libexec_path           = [IO.Path]::Combine( $g_pyenv_root , "libexec")
$Global:g_pyenv_lib_path               = [IO.Path]::Combine( $g_pyenv_root , "lib")
$Global:g_pyenv_versions_path          = [IO.Path]::Combine( $g_pyenv_root , "versions")
$Global:g_pyenv_temp_path              = [IO.Path]::Combine( $g_pyenv_root , "temp")
$Global:g_fn_python_version             = ".python-version"
$Global:g_global_python_version_file    = [IO.Path]::Combine( $g_pyenv_root , "version")
$Global:g_global_externals_path         = [IO.Path]::Combine( $g_pyenv_root , "externals")
$Global:g_global_build_plugin_path      = [IO.Path]::Combine( $g_pyenv_root , "plugins", "python-build")
$Global:g_pyenv_shims_path             = [IO.Path]::Combine( $g_pyenv_root , "shims")
$Global:g_pyenv_config_path            = [IO.Path]::Combine( $g_pyenv_root , "config")
$Global:g_pyenv_exe                    = [IO.Path]::Combine( $g_pyenv_lib_path , "pyshim.exe")
$script:fn_externals_ini                = [IO.Path]::Combine( $g_pyenv_root, "config", "externals.ini")

if ($env:PYTHON_BUILD_PATH)
{
    $Global:g_python_build_path         = $env:PYTHON_BUILD_PATH
} else {
    $Global:g_python_build_path         = [IO.Path]::Combine( $g_pyenv_root , "sources")
}

#endregion


Import-Module "$g_pyenv_lib_path\getargs.ps1" -Force
Import-Module "$g_pyenv_lib_path\powershell-yaml\powershell-yaml.ps1" -Force -DisableNameChecking 3>$null


# check config_env.bat ,config_pyenv.yaml exist , if not copy from template
if (-Not (Test-Path([IO.Path]::Combine($g_pyenv_config_path, "config_env.bat")))) {
  Copy-Item -Path ([IO.Path]::Combine($g_pyenv_config_path, "config_env.bat-template")) `
            -Destination ([IO.Path]::Combine($g_pyenv_config_path, "config_env.bat"))
}

if (-Not (Test-Path([IO.Path]::Combine($g_pyenv_config_path, "config_pyenv.yaml")))) {
  Copy-Item -Path ([IO.Path]::Combine($g_pyenv_config_path, "config_pyenv.yaml-template")) `
            -Destination ([IO.Path]::Combine($g_pyenv_config_path, "config_pyenv.yaml"))
}

#region diagnosis

Function Get-IniFile ($file) {
# https://stackoverflow.com/questions/417798/ini-file-parsing-in-powershell
    $ini = [ordered]@{}
  
    # Create a default section if none exist in the file. Like a java prop file.
    $section = "NO_SECTION"
    $ini[$section] = [ordered]@{}
  
    switch -regex -file $file {
      "^\[(.+)\]$" {
        $section = $matches[1].Trim()
        $ini[$section] = [ordered]@{}
      }
      "^\s*([^#;].+?)\s*=\s*(.*)" {
        # skip comments that starts with sharp
        $name,$value = $matches[1..2]
        # skip comments that start with semicolon:
        #if (!($name.StartsWith(";"))) {
          $ini[$section][$name] = $value.Trim()
        #}
      }
    }
    $ini
  }

  $Global:g_pyenv_externals_ini = Get-IniFile $fn_externals_ini

Function Get-PyVersionNo($version_string){

  $ret_version = [PSCustomObject]@{
    Major = 0
    Minor = 0
    Patch = 0
    Revision = 0
  }

  $arr_ver = $version_string.split('.')

  if($arr_ver[0]) {$ret_version.Major = $arr_ver[0]}
  if($arr_ver[1]) {$ret_version.Minor = $arr_ver[1]}
  if($arr_ver[2]) {$ret_version.Patch = $arr_ver[2]}

  return $ret_version

}

function script:Set-Verbose($val) {

  if ($VerbosePreference -ine $val) {
      $VerbosePreference = $val
  }
}


Function Expand-7z() {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$Path, 

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$Destination
  )

  $7z_bin = [IO.Path]::Combine($Global:g_global_externals_path , $g_pyenv_externals_ini['7z']['outfile'])
  
  $call_args = "x $($Path) -o$(Destination) -bso1 -y"

  Invoke-Expression  "& `"$7z_bin`" $call_args"

}

# LOAD YAML
[string[]]$script:fileContent = Get-Content "$([IO.Path]::Combine($g_pyenv_config_path, 'config_pyenv.yaml'))"

$script:content = ''
foreach ($line in $fileContent) { $content = $content + "`n" + $line }

try {
$Global:g_pyenv_config_yaml = ConvertFrom-YAML $content -Ordered
} catch {
  Write-Host "$(__FILE__):$(__LINE__)) error while loading yaml"
  exit 1
}
