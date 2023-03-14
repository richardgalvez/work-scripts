# Install Qualys Agent and set Proxy

# Install Agent using Customer ID
Start-Process -WindowStyle Hidden -FilePath ".\QualysCloudAgent.exe" -ArgumentList "CustomerId={CUSTOMERID} ActivationId={ACTIVATIONID} WebServiceUri=https://qagpublic.qg1.apps.qualys.eu/CloudAgent/" -Wait

# Set Proxy based on hostname or environment
$hostname = hostname

if ($hostname.Substring(0,3) -eq "XUK" -or $hostname.Substring(0,4) -eq "XSUK" {
Start-Process -WindowStyle Hidden -FilePath "C:\Program Files\Qualys\QualysAgent\QualysProxy.exe" -ArgumentList "/u http://{PROXYIP1}:{ENVIRONMENTPORT}" -Wait
}

if ($hostname.Substring(0,3) -eq "XUS" -or $hostname.Substring(0,4) -eq "XSUS" {
Start-Process -WindowStyle Hidden -FilePath "C:\Program Files\Qualys\QualysAgent\QualysProxy.exe" -ArgumentList "/u http://{PROXYIP2}:{ENVIRONMENTPORT}" -Wait
}

if ($hostname.Substring(0,3) -eq "YUK" -or $hostname.Substring(0,4) -eq "YTUK" {
Start-Process -WindowStyle Hidden -FilePath "C:\Program Files\Qualys\QualysAgent\QualysProxy.exe" -ArgumentList "/u http://{PROXYIP1}:{ENVIRONMENTPORT}" -Wait
}

if ($hostname.Substring(0,3) -eq "YUS" -or $hostname.Substring(0,4) -eq "YTUS" {
Start-Process -WindowStyle Hidden -FilePath "C:\Program Files\Qualys\QualysAgent\QualysProxy.exe" -ArgumentList "/u http://{PROXYIP2}:{ENVIRONMENTPORT}" -Wait
}

# Restart service to apply configuration

Stop-Service -Name QualysAgent
Start-Service -Name QualysAgent

"Qualys Cloud Agent {version} installation script successful." | Out-File -FilePath C:\QCA-Success.txt
