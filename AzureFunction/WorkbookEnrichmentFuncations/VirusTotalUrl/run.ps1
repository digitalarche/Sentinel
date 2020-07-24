using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)


$apikey = $env:apikeyUrl
$url = $Request.query["url"]


# graphAPI Get users properties
$apiUrl = "https://www.virustotal.com/vtapi/v2/url/report?apikey=$apikey&resource=$url"
$Data = Invoke-RestMethod  -Uri $apiUrl -Method Get -ContentType aplication/json -UseBasicParsing
$Data

$jsondata = $Data | convertTo-Json
$jsondata

# Return Write-OMSLogfile response to output binding
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    Body = $jsondata
    
})

$jsondata
