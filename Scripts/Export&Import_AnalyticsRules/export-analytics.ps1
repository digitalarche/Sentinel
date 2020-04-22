Login-AzAccount
Import-Module AzSentinel


#variables
$outputFolder # Export folder
$WorkspaceName = "CxP-AzureSecurityWS"
$SubscriptionId = "6b1ceacd-5731-4780-8f96-2078dd96fd96"


$alerts = Get-AzSentinelAlertRule -SubscriptionId $SubscriptionId -WorkspaceName $WorkspaceName

foreach ($alert in $alerts)
{
If($alert.enabled -eq $True -and $alert.name -ne "FusionBuiltIn" -and $alert.name -ne "FusionBuiltIn" and $alert.severity -ne "null" )
{
   ## $alert | ConvertTo-Json | Out-File c:\temp\$random.name.yaml  
   $outputFolder = "c:\temp\export\2\"
    $outputFileName = $alert.name +".yaml"
    $exportlocation = $outputFolder + "\" + $outputFileName
}
$alert | ConvertTo-Json | Out-File $exportlocation  
}
