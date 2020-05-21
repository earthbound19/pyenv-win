#require -V 5

$dp0 = $PSScriptRoot
$g_pyenv_root = Split-Path $dp0




#region diagnosis
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



#region global variable set
$Global:g_pyshim_flag_commonlib_loaded = $true
$Global:g_pyshim_libexec_path           = [IO.Path]::Combine( $g_pyenv_root , "libexec")
$Global:g_pyshim_lib_path               = [IO.Path]::Combine( $g_pyenv_root , "lib")
$Global:g_pyshim_versions_path          = [IO.Path]::Combine( $g_pyenv_root , "versions")
$Global:g_fn_python_version             = ".python-version"
$Global:g_global_python_version_file    = [IO.Path]::Combine( $g_pyenv_root , "version")
$Global:g_global_externals_path         = [IO.Path]::Combine( $g_pyenv_root , "externals")
$Global:g_global_build_plugin_path      = [IO.Path]::Combine( $g_pyenv_root , "plugins", "python_build")

if ($env:PYTHON_BUILD_PATH)
{
    $Global:g_python_build_path         = $env:PYTHON_BUILD_PATH
} else {
    $Global:g_python_build_path         = [IO.Path]::Combine( $g_pyenv_root , "sources")
}
#endregion

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

  $7z_bin = [IO.Path]::Combine($Global:g_global_externals_path , "7za.exe")
  
  $call_args = "x $($Path) -o$(Destination) -bso1 -y"

  Invoke-Expression  "& `"$7z_bin`" $call_args"

}

Import-Module "$g_pyshim_lib_path\getargs.ps1" -Force

