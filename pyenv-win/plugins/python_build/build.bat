@echo off
setlocal
set D=%~dp0
SET "MSBUILD=c:\opt\vsbuild\v16\MSBuild\Current\bin\MSBuild.exe"
set PCBUILD=%D%..\PCBuild\
if "%Py_OutDir%"=="" set Py_OutDir=%PCBUILD%

set BUILDX86=
set BUILDX64=
set REBUILD=
set OUTPUT="/p:pshimOutputPath=%D%.\output"
set OUTPUTPKG="/p:OutputPath=%D%.\output_pkg"
set PACKAGES=

:CheckOpts
if "%~1" EQU "-h" goto Help
if "%~1" EQU "-x86" (set BUILDX86=1) && shift && goto CheckOpts
if "%~1" EQU "-x64" (set BUILDX64=1) && shift && goto CheckOpts
if "%~1" EQU "-r" (set REBUILD=-r) && shift && goto CheckOpts
if "%~1" EQU "-o" (set OUTPUT="/p:OutputPath=%~2") && shift && shift && goto CheckOpts
if "%~1" EQU "--out" (set OUTPUT="/p:OutputPath=%~2") && shift && shift && goto CheckOpts
if "%~1" EQU "-p" (set PACKAGES=%PACKAGES% %~2) && shift && shift && goto CheckOpts

if not defined BUILDX86 if not defined BUILDX64 (set BUILDX86=1) && (set BUILDX64=1)

echo [%~nx0] calling external "%D%..\tools\msi\get_externals.bat"
call "%D%..\tools\msi\get_externals.bat"
echo [%~nx0] finding msbuild
call "%PCBUILD%\find_msbuild.bat" %MSBUILD%
if ERRORLEVEL 1 (echo Cannot locate MSBuild.exe on PATH or as MSBUILD variable & exit /b 2)

if defined PACKAGES set PACKAGES="/p:Packages=%PACKAGES%"

if defined BUILDX86 (
    if defined REBUILD ( call "%PCBUILD%.\build.bat" -e -r  "/p:PlatformToolset=v140" "/p:WindowsTargetPlatformVersion=10.0.15063.0"
    ) else if not exist "%Py_OutDir%win32\python.exe" call "%PCBUILD%\build.bat" -e  "/p:PlatformToolset=v140" "/p:WindowsTargetPlatformVersion=10.0.15063.0"
    if errorlevel 1 goto :eof

    %MSBUILD% "%D%make_pkg.proj" /p:Configuration=Release /p:Platform=x86 "/p:PlatformToolset=v140" "/p:WindowsTargetPlatformVersion=10.0.15063.0" %OUTPUT% %PACKAGES% %OUTPUTPKG%
    if errorlevel 1 goto :eof
)

if defined BUILDX64 (
    if defined REBUILD ( call "%PCBUILD%.\build.bat" -p x64 -e -r  "/p:PlatformToolset=v140" "/p:WindowsTargetPlatformVersion=10.0.15063.0"
    ) else if not exist "%Py_OutDir%amd64\python.exe" call "%PCBUILD%\build.bat" -p x64 -e "/p:PlatformToolset=v140" "/p:WindowsTargetPlatformVersion=10.0.15063.0"
    if errorlevel 1 goto :eof

    %MSBUILD% "%D%make_pkg.proj" /p:Configuration=Release /p:Platform=x64 "/p:PlatformToolset=v140" "/p:WindowsTargetPlatformVersion=10.0.15063.0" %OUTPUT% %PACKAGES% %OUTPUTPKG%
    if errorlevel 1 goto :eof
)

exit /B 0

:Help
echo build.bat [-x86] [-x64] [--out DIR] [-r] [-h]
echo.
echo    -x86                Build x86 installers
echo    -x64                Build x64 installers
echo    -r                  Rebuild rather than incremental build
echo    --out [DIR]         Override output directory
echo    -h                  Show usage
