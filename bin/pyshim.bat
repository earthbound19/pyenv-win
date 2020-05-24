@ECHO OFF
rem to keep ansi code page in editors : 한글 라인

IF EXIST "%~dp0..\config\config_env.bat" CALL "%~dp0..\config\config_env.bat"
IF NOT DEFINED PYSHIM_PWSH SET "PYSHIM_PWSH=C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"

IF EXIST %~dpn0.ps1 (
    "%PYSHIM_PWSH%" -NoLogo -NoProfile -ExecutionPolicy ByPass -File %~dpn0.ps1 %*
)