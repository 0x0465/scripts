 Get-WinEvent -ComputerName $COMPUTER -FilterHashtable @{logname="Microsoft-Windows-Sysmon/Operational"} | Where {$_.message -like "$HASH"} | Select-Object -Property message -First 100 | Format-List
