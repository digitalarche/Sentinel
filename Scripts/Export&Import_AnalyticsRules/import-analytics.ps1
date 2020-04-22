Login-AzAccount
#variables
$InputFolder = "c:\temp\export\1\" # Input folder
$WorkspaceName = "CentricDemo"
$SubscriptionId = "8f153238-e602-427e-a7c0-3043fbe50918"


$inputalerts = Get-ChildItem -path $InputFolder -Recurse

foreach($inputalert in $inputalerts)
{
Import-AzSentinelAlertRule -SubscriptionId $SubscriptionId -WorkspaceName $WorkspaceName -Settings $inputalert -Verbose 
}

