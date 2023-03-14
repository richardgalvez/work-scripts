# This script will add a text list of devices to any SCCM Device Collection. Need to be connected to the site via PowerShell first.
# The Device Collection ID is found by first creating the Device Collection, then going into the Properties.

$textFile = "C:\Temp\{listofdevicesfile}.txt"
$collectionID = "{CollectionID}"

$computerList = Get-Content $textFile

foreach ($Computer in $computerList) {
Write-Host $Computer -Foreground Green -Background Black
Add-CMDeviceCollectionDirectMembershipRule -CollectionID $collectionID `
-ResourceId $(Get-CMDevice -Name $Computer).ResourceID
}

Write-Host "COMPLETE!" -Foreground Magenta -Background Black
Write-Host ""
