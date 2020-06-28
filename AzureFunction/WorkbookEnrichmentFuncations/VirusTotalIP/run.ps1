using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)


$apikey = $env:apikeyip
$url = $Request.query["ip"]

# graphAPI Get users properties
$apiUrl = "https://www.virustotal.com/vtapi/v2/ip-address/report?apikey=$apikey&ip=$ip"
$Data = Invoke-RestMethod  -Uri $apiUrl -Method Get -ContentType aplication/json -UseBasicParsing


$jsondata = $Data | convertTo-Json
$jsondata

# Return Write-OMSLogfile response to output binding
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    Body = $jsondata
    
})

$jsondata
