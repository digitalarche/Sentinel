Login-AzAccount
Import-Module AzSentinel

#variables
$outputFolder = "c:\export\"
$WorkspaceName = "ImportWorkSpaceID"
$SubscriptionId = "6b1ceacd-xxxx-xxxx-xxxx-2078dd96fd96"


$alerts = Get-AzSentinelAlertRule -SubscriptionId $SubscriptionId -WorkspaceName $WorkspaceName

foreach ($alert in $alerts)
{
If($alert.enabled -eq $True -and $alert.name -ne "FusionBuiltIn" -and $alert.severity -ne "null")
{
  
    $outputFileName = $alert.name +".yaml"
    $exportlocation = $outputFolder + "\" + $outputFileName
    $alert | ConvertTo-Json | Out-File $exportlocation  
}
}
