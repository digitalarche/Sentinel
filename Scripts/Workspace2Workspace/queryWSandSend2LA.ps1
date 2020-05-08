
$TimeStampField = (Get-Date)
$CustomerId = "<youworkspaceID>"
$SharedKey = "<yourworkspacekey>"
$logType ="<customtablename>"


# Create the function to create the authorization signature
Function Build-Signature ($customerId, $sharedKey, $date, $contentLength, $method, $contentType, $resource)
{
    $xHeaders = "x-ms-date:" + $date
    $stringToHash = $method + "`n" + $contentLength + "`n" + $contentType + "`n" + $xHeaders + "`n" + $resource
 
    $bytesToHash = [Text.Encoding]::UTF8.GetBytes($stringToHash)
    $keyBytes = [Convert]::FromBase64String($sharedKey)
 
    $sha256 = New-Object System.Security.Cryptography.HMACSHA256
    $sha256.Key = $keyBytes
    $calculatedHash = $sha256.ComputeHash($bytesToHash)
    $encodedHash = [Convert]::ToBase64String($calculatedHash)
    $authorization = 'SharedKey {0}:{1}' -f $customerId,$encodedHash
    return $authorization
}

## query LA (we can add here any query that we want )

$Query = @'
SigninLogs
| where TimeGenerated >= ago(3d) 
| extend UserPrincipalName_s = UserPrincipalName
| join kind= inner (
   AADLogTest_CL
   | where TimeGenerated >= ago(3d)
   | where ExtensionProperty_extension_1fdbfe7a3f344194b08d177c8125ef04_UserLocation_s == "US - Texas"
   ) on UserPrincipalName_s

'@

$Results = Invoke-AzOperationalInsightsQuery -WorkspaceId $CustomerId -Query $Query

$Results.Results | Export-Csv -Path "HelloWorldInTheLogs.csv"
$ResultsJson = $Results.Results | convertTo-Json

## Send Data to LA


# Create the function to create and post the request
Function Post-LogAnalyticsData($customerId, $sharedKey, $body, $logType)
{
    $method = "POST"
    $contentType = "application/json"
    $resource = "/api/logs"
    $rfc1123date = [DateTime]::UtcNow.ToString("r")
    $contentLength = $body.Length
    $signature = Build-Signature `
        -customerId $customerId `
        -sharedKey $sharedKey `
        -date $rfc1123date `
        -contentLength $contentLength `
        -method $method `
        -contentType $contentType `
        -resource $resource
    $uri = "https://" + $customerId + ".ods.opinsights.azure.com" + $resource + "?api-version=2016-04-01"
 
    $headers = @{
        "Authorization" = $signature;
        "Log-Type" = $logType;
        "x-ms-date" = $rfc1123date;
        "time-generated-field" = $TimeStampField;
#        "x-ms-AzureResourceId" = $resourceId;
    }
 
    $response = Invoke-WebRequest -Uri $uri -Method $method -ContentType $contentType -Headers $headers -Body $body -UseBasicParsing
    return $response.StatusCode
 
}

 
 Post-LogAnalyticsData -customerId $customerId -sharedKey $sharedKey -body ([System.Text.Encoding]::UTF8.GetBytes($ResultsJson)) -logType $logType    
