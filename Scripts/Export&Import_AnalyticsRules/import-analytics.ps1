Login-AzAccount
#variables
$InputFolder = "c:\import\" # Input folder
$WorkspaceName = "YourNewWorkspaceName"
$SubscriptionId = "8f153238-xxxx-xxxx-xxxx-3043fbe50918"


$inputalerts = Get-ChildItem -path $InputFolder -Recurse

foreach($inputalert in $inputalerts)
{
Import-AzSentinelAlertRule -SubscriptionId $SubscriptionId -WorkspaceName $WorkspaceName -Settings $inputalert -Verbose 
}

