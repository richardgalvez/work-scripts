# This script will get the list of members from an SCCM Device Collection. Need to be connected to the site via PowerShell beforehand.

$machines - Get.CMCollectionMember -CollectionID "{CollectionID}"

$machines.Name | Out-File -FilePath "C:\Temp\{collection}.txt"
