# This script will install NetWorekr Client 19.5, then set oldauth method required for backup communication. This version uses PowerShell input the keys.

Start-Process -WindowSyle Hidden -FilePath ".\lgtoclnt-19.5.0.7.exe" -ArgumentList "/s /v /q InstallLevel=100 /norestart" -Wait

# Check that nsrexecd is Running.
$nwService = Get-Service nsrexecd
if ($nwService.Status -ne "Running") {
Start-Service -Name nsrexecd
}

# Set oldauth in nsrdamin tool then restart nsrexecd to apply changes. It will put in the keys.
Start-Process -WindowStyle Hidden -FilePath "C:\Program Files\EMC NetWorker\nsr\bin\nsradmin" -ArgumentList '-p nsrexec' -Wait

$wshell = New-Object -ComObject wscript.shell;
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.SendKeys]::SendWait('. type: nsrla{ENTER}')
Start-Sleep -Milliseconds 200
[System.Windows.Forms.SendKeys]::SendWait('show auth methods{ENTER}')
Start-Sleep -Milliseconds 200
[System.Windows.Forms.SendKeys]::SendWait('update auth methods: "0.0.0.0/0,nsrauth.oldauth"{ENTER}')
Start-Sleep -Milliseconds 200
[System.Windows.Forms.SendKeys]::SendWait('y{ENTER}')
Start-Sleep -Milliseconds 200
[System.Windows.Forms.SendKeys]::SendWait('exit{ENTER}')

Stop-Service -Name nsrexecd
Start-Service -Name nsrexecd

Stop-Process -Name "nsradmin.exe"
