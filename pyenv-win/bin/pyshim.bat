@ECHO OFF
rem to keep ansi code page in editors : �ѱ� ����


IF EXIST %~dpn0.ps1 (
    powershell -NoLogo -NoProfile -ExecutionPolicy ByPass -File %~dpn0.ps1 %*
)