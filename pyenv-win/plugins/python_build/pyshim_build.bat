@echo off
setlocal
set D=%~dp0
SET "_THIS_FILE_=%~nx0"
SET "MSBUILD=C:\opt\vsbuild\v16\MSBuild\current\Bin\MSBuild.exe"
SET "Nuget=C:\Apps\pyshim-win.git\pyenv-win\externals\nuget.exe"


SET _p_platformtoolset="/p:PlatformToolset=v140"
SET _p_targetsdk="/p:WindowsTargetPlatformVersion=10.0.15063.0"
set BUILDX86=
set BUILDX64=
set REBUILD=
set PACKAGES=
SET __SRCDIR=
SET __TARGET=

:CheckOpts
if "%~1" EQU "-h" goto Help
if "%~1"=="-t" (set __TARGET=%2) & shift & shift & goto CheckOpts
if "%~1" EQU "-x86" (set BUILDX86=1) && shift && goto CheckOpts
if "%~1" EQU "-x64" (set BUILDX64=1) && shift && goto CheckOpts
if "%~1" EQU "-r" (set REBUILD=-r) && shift && goto CheckOpts
if "%~1" EQU "--src" (set "__SRCDIR=%~2") && shift && shift && goto CheckOpts
if "%~1" EQU "-p" (set PACKAGES=%PACKAGES% %~2) && shift && shift && goto CheckOpts

IF NOT DEFINED __SRCDIR (ECHO source directory not exist see usage by %_THIS_FILE_% -h)
rem https://stackoverflow.com/questions/12538562/removing-trailing-backslash-in-a-batch-file
IF "%__SRCDIR:~-1%"=="\" SET __SRCDIR=%__SRCDIR:~,-1%
echo [%_THIS_FILE_%] source directory set to %__SRCDIR%

rem set "PCBUILD=%__SRCDIR%\PCBuild"
if "%Py_OutDir%"=="" set Py_OutDir=%PCBUILD%
set _DISTDIR_="/p:IntermediateOutputPath=%__SRCDIR%\Tools\nuget\output_dist"
set _NUGETPKGDIR_="/p:OutputPath=%__SRCDIR%\Tools\nuget\output_nupkg"


rem if not defined BUILDX86 if not defined BUILDX64 (set BUILDX86=1) && (set BUILDX64=1)
if not defined BUILDX86 if not defined BUILDX64 (set BUILDX64=1)
echo [%_THIS_FILE_%] Entering %__SRCDIR%\Tools\nuget directory
pushd %__SRCDIR%\Tools\nuget

if defined PACKAGES set PACKAGES="/p:Packages=%PACKAGES%"

IF /I "%__TARGET%" EQU "Clean" GOTO CLEAN 
IF /I "%__TARGET%" EQU "CleanAll" GOTO CLEAN

echo [%_THIS_FILE_%] calling external "%__SRCDIR%\Tools\msi\get_externals.bat"
call "%__SRCDIR%\Tools\msi\get_externals.bat"

echo [%_THIS_FILE_%] finding msbuild
call "%__SRCDIR%\PCBuild\find_msbuild.bat" %MSBUILD%
if ERRORLEVEL 1 (echo Cannot locate MSBuild.exe on PATH or as MSBUILD variable & exit /b 2)


if defined BUILDX86 (
    if defined REBUILD ( call %__SRCDIR%\PCBuild\build.bat" -e -r  %_p_platformtoolset% %_p_targetsdk%
    ) else if not exist "%Py_OutDir%win32\python.exe" call "%__SRCDIR%\PCBuild\build.bat" -e  %_p_platformtoolset% %_p_targetsdk%
    if errorlevel 1 goto :eof

    %MSBUILD% "make_pkg.proj" /p:Configuration=Release /p:Platform=x86  %_DISTDIR_% %_NUGETPKGDIR_% %PACKAGES% 
    if errorlevel 1 goto :eof
)

if defined BUILDX64 (
    if defined REBUILD ( call "%__SRCDIR%\PCBuild\build.bat" -p x64 -e -r %_p_platformtoolset% %_p_targetsdk%
    ) else if not exist "%Py_OutDir%amd64\python.exe" call "%__SRCDIR%\PCBuild\build.bat" -p x64 -e %_p_platformtoolset% %_p_targetsdk%
    if errorlevel 1 goto :eof
    %MSBUILD% "make_pkg.proj" /p:Configuration=Release /p:Platform=x64 %_DISTDIR_% %_NUGETPKGDIR_% %PACKAGES% 
    if errorlevel 1 goto :eof
)

popd
endlocal
exit /B 0

REM Clean / CleanAll __TARGET
:CLEAN
echo [%_THIS_FILE_%] cleaning .... with  %__TARGET% %__SRCDIR%
IF DEFINED BUILDX64 (
    call "%__SRCDIR%\PCBuild\build.bat" -t %__TARGET% -p x64
) else (
    call "%__SRCDIR%\PCBuild\build.bat" -t %__TARGET% 
)
popd
endlocal
exit /B 0

:Help
echo build.bat [-x86] [-x64] [--out DIR] [-r] [-h]
echo.
echo    -x86                Build x86 installers
echo    -x64                Build x64 installers
echo    -r                  Rebuild rather than incremental build
echo    --src [DIR]         source directory
echo    -t Clean ^| CleanAll
echo.     Set the clean __TARGET manually
echo    -h                  Show usage
