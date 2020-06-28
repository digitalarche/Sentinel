using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)


$apikey = $env:apikeyipGeo
$url = $Request.query["ip"]


$apiUrl = "https://api.ipgeolocation.io/ipgeo?apiKey=$apikey&ip=$ip"
$Data = Invoke-RestMethod  -Uri $apiUrl -Method Get -ContentType aplication/json -UseBasicParsing


$jsondata = $Data | convertTo-Json
$jsondata

# Return Write-OMSLogfile response to output binding
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    Body = $jsondata
    
})

$jsondata

