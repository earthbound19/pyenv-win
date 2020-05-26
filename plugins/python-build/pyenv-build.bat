@echo off
setlocal
set D=%~dp0
SET "_THIS_FILE_=%~nx0"

IF NOT DEFINED PYENV_ROOT (
    SET "Nuget=%~dp0..\..\externals\nuget.exe"
    SET "_PYENV_VERSIONS_PATH_=%~dp0..\..\versions"

) ELSE (
   SET "Nuget=%PYENV_ROOT%\externals\nuget.exe"
   SET "_PYENV_VERSIONS_PATH_=%PYENV_ROOT%\versions"
)

FOR /F "delims=" %%F IN ("%_PYENV_VERSIONS_PATH_%") DO SET "_PYENV_VERSIONS_PATH_=%%~fF"

echo [%_THIS_FILE_%] Nuget set to %Nuget%

if EXIST "%D%env_build.bat" call "%D%env_build.bat"

set BUILDX86=
set BUILDX64=
set REBUILD=
set PACKAGES=
SET __SRCDIR__=
SET __CLEAN_TARGET__=
SET "__PYENV_BUILD_PROJ__=pyenv-build.proj"

:CheckOpts
if "%~1" EQU "-h" goto Help
if "%~1" EQU "-t" (set __CLEAN_TARGET__=%2) & shift & shift & goto CheckOpts
if "%~1" EQU "-x86" (set BUILDX86=1) && shift && goto CheckOpts
if "%~1" EQU "-x64" (set BUILDX64=1) && shift && goto CheckOpts
if "%~1" EQU "-r" (set REBUILD=-r) && shift && goto CheckOpts
if "%~1" EQU "--src" (set "__SRCDIR__=%~2") && shift && shift && goto CheckOpts
if "%~1" EQU "-p" (set PACKAGES=%PACKAGES% %~2) && shift && shift && goto CheckOpts

IF NOT DEFINED __SRCDIR__ (ECHO source directory not exist see usage by %_THIS_FILE_% -h)
rem https://stackoverflow.com/questions/12538562/removing-trailing-backslash-in-a-batch-file
IF "%__SRCDIR__:~-1%"=="\" SET __SRCDIR__=%__SRCDIR__:~,-1%
echo [%_THIS_FILE_%] source directory set to %__SRCDIR__%

rem PCBUILD should end with trailing backslash
set "PCBUILD=%__SRCDIR__%\PCBuild\"
if "%Py_OutDir%"=="" set Py_OutDir=%PCBUILD%
rem set _DISTDIR_="/p:IntermediateOutputPath=%__SRCDIR__%\Tools\nuget\output_dist"
rem set _NUGETPKGDIR_="/p:OutputPath=%__SRCDIR__%\Tools\nuget\output_nupkg"
set "_DISTDIR_=%PCBUILD%output_dist"
set "_NUGETPKGDIR_=%PCBUILD%output_nupkg"
set p_DISTDIR="/p:IntermediateOutputPath=%_DISTDIR_%"
set p_NUGETPKGDIR="/p:OutPutPath=%_NUGETPKGDIR_%"
rem if not defined BUILDX86 if not defined BUILDX64 (set BUILDX86=1) && (set BUILDX64=1)
if not defined BUILDX86 if not defined BUILDX64 (set BUILDX64=1)
echo [%_THIS_FILE_%] Entering %PCBUILD% directory
pushd %PCBUILD%

if defined PACKAGES set PACKAGES="/p:Packages=%PACKAGES%"

IF /I "%__CLEAN_TARGET__%" EQU "Clean" GOTO CLEAN 
IF /I "%__CLEAN_TARGET__%" EQU "CleanAll" GOTO CLEAN

echo [%_THIS_FILE_%] calling external "%__SRCDIR__%\Tools\msi\get_externals.bat"
call "%__SRCDIR__%\Tools\msi\get_externals.bat"

IF "%ERRORLEVEL%" NEQ "0" EXIT /B %ERRORLEVEL%


echo [%_THIS_FILE_%] finding msbuild
call "%PCBUILD%find_msbuild.bat" %MSBUILD%
if ERRORLEVEL 1 (echo Cannot locate MSBuild.exe on PATH or as MSBUILD variable & EXIT /B 1)


if defined BUILDX86 (
    if defined REBUILD ( call "build.bat" -e -r  %_p_platformtoolset% %_p_targetsdk%
    ) else if not exist "%Py_OutDir%win32\python.exe" call "build.bat" -e  %_p_platformtoolset% %_p_targetsdk%
    if errorlevel 1 EXIT /B %ERRORLEVEL%

    %MSBUILD% "%PCBUILD%..\Tools\nuget\make_pkg.proj" /p:Configuration=Release /p:Platform=x86  %p_DISTDIR% %p_NUGETPKGDIR% %PACKAGES% 
    if errorlevel 1 EXIT /B %ERRORLEVEL%
)

if defined BUILDX64 (

    if defined REBUILD (
		echo ...... rebuild ........
		call "build.bat" -p x64 -e -r %_p_platformtoolset% %_p_targetsdk%
    ) else (
		echo ...... build 1 ........
		if not exist "%Py_OutDir%amd64\python.exe" call "build.bat" -p x64 -e %_p_platformtoolset% %_p_targetsdk%
		if errorlevel 1 EXIT /B %ERRORLEVEL%
		echo ...... build 2 ........
		%MSBUILD% "%PCBUILD%..\Tools\nuget\make_pkg.proj" /p:Configuration=Release /p:Platform=x64 %p_DISTDIR% %p_NUGETPKGDIR% %PACKAGES% 
		if errorlevel 1 EXIT /B %ERRORLEVEL%
	)
)

popd

if defined BUILDX64 (
    %MSBUILD% -nologo "%D%%__PYENV_BUILD_PROJ__%" /p:Platform=x64
) ELSE (
    %MSBUILD% -nologo "%D%%__PYENV_BUILD_PROJ__%"
)
endlocal & IF "%ERRORLEVEL%" NEQ "0" EXIT /B %ERRORLEVEL%
exit /B 0

REM Clean / CleanAll __CLEAN_TARGET__
:CLEAN
echo [%_THIS_FILE_%] cleaning .... with  %__CLEAN_TARGET__% %__SRCDIR__%
IF DEFINED BUILDX64 (
    call "build.bat" -t %__CLEAN_TARGET__% -p x64
) else (
    call "build.bat" -t %__CLEAN_TARGET__% 
)
echo [%_THIS_FILE_%] cleaning intermediate output directory %_DISTDIR_%
rmdir %_DISTDIR_% /s /q
echo [%_THIS_FILE_%] cleaning .nupkg output directory %_NUGETPKGDIR_%
rmdir %_NUGETPKGDIR_% /s /q
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
echo.     Set the clean __CLEAN_TARGET__ manually
echo    -h                  Show usage
