@echo off
rem set variable to build ( ANSI Encoding- ÇÑ±Û)
SET "MSBUILD=C:\opt\vsbuild\v16\MSBuild\current\Bin\MSBuild.exe"
SET _p_platformtoolset="/p:PlatformToolset=v140"
SET _p_targetsdk="/p:WindowsTargetPlatformVersion=10.0.15063.0"
SET "PYTHON=%~dp0pythonx86\tools\python.exe"

IF NOT EXIST %PYTHON% (
   %Nuget% install pythonx86 -ExcludeVersion -o .
)