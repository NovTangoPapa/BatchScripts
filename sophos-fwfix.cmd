@echo off

REM This script can remediate hosts on the network suffering from a corrupt
REM firewall database file.
REM This is the fix that this script is automating: 
REM https://docs.sophos.com/esg/endpoint-security-and-control/10-6/help/en-us/esg/Endpoint-Security-and-Control/concepts/Firewall_log_database_is_corrupted.html
REM This file must be ran as a domain admin or limited domain admin account.

REM You must create a text file of all computer which have the corrupted database file.
if exist c:\pathtolist\computers.txt goto Label1
echo.
echo Cannot find c:\pathtolist\computers.txt
echo.
Pause
goto :eof

:Label1
for /f %%i in (c:\pathtolist\computers.txt) do call :Sub %%i
goto :eof

:Sub
REM Deletes problem database file
echo "Deleting problem database file"
del "\\%1\C$\ProgramData\Sophos\Sophos Client Firewall\logs\op_data.mdb"

timeout 3

REM Starts firewall service
echo "Starting Sophos Firewall service"
SC \\%1 Start "Sophos Client Firewall"

timeout 3

REM runs a query on the firewall and pauses so you can confirm that the service has turned on
echo "Checking status of Firewall service"
SC \\%1 Query "Sophos Client Firewall"

timeout 3