REM Run this file as Local Admin, in order to change the last logged in user.
REM Only tested on Windows 7

@echo off

REM Enter domain name in all caps, and username in lowercase

set /p domain=Please enter the domain name:

set /p username=Please enter the name you want to appear as last logged on:

REM Creates reg file 

echo REGEDIT4 >> change.reg  
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI] >> change.reg 
echo "LastLoggedOnUser"="%domain%\\%username%" >> change.reg

REM Runs reg file

C:\WINDOWS\regedit.exe /s change.reg 

REM deletes reg file

del change.reg
