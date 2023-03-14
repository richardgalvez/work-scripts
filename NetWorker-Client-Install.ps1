# This script will install NetWorker Client {version}, then set oldauth method.

Start-Process -WindowStyle Hidden -FilePath ".\lgtoclnt-19.5.0.7.exe" -argumentlist "/s /v /q InstallLevel=100 /norestart" -Wait

# Check that nsrexecd is Running.

$nwService = Get-Service nsrexecd
if ($nwService.Status -ne "Running") {
Start-Service -Name nsrexecd
}

$osName = (Get-WmiObject win32_operatingsystem).Caption

# Set oldauth in nsradmin tool if OS is Windows Server 2019 then restart nsrexecd to apply changes. 
# configure-oldauth is a plain file has the commands that would normally be entered via the nsrexec command-line tool.

if ($osName -like "Microsoft Windows Server 2019*") {
Copy-Item ".\configure-oldauth" -Desination "C:\Program Files\EMC Networker\nsr\"

Start-Process -WindowStyle Hidden -FilePath "C:\Program Files\EMC Networker\nsr\bin\nsradmin" -ArgumentList '-p nsrexec -i "C:\Program Files\EMC NetWorker\nsr\configure-oldauth"' -Wait

Stop-Service -Name nsrexecd
Start-Service -Name nsrexecd
}

nsrports -S {firstport}-{endport}

"NetWorker 19.5.0.7 installation script successful." | Out-File -FilePath C:\NWInstalled.txt
