# Input bindings are passed in via param block.
param($Timer)

#Number of events written per batch to log analytics
$messageSize = 10000
 
 
# Replace with your Log Analytics Workspace ID
$CustomerId = $env:workspaceId
 
# Replace with your Log Analytics Primary Key
$SharedKey = $env:workspaceKey
 
# Specify the name of the record type that you'll be creating
$LogType = $env:customLogName

# Specify the name of the user that will call Exchnage reproting service
$exuser = $env:ExchangeUser
 
# Specify the password of the user that will call Exchnage reproting service
$expass = $env:ExchangeUserPassword
 
# You can use an optional field to specify the timestamp from the data. If the time field is not specified, Azure Monitor assumes the time is the message ingestion time
$TimeStampField = (Get-Date)
 
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

  

#This is the Exchange extraction portion of the code
 
$password = ConvertTo-SecureString $expass -AsPlainText -Force
$credentials=New-Object -TypeName System.Management.Automation.PSCredential ($exuser, $password)
 
if ($credentials) {
$session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/PowerShell-LiveId?BasicAuthToOAuthConversion=true -Credential $Credentials -Authentication Basic -AllowRedirection
                   }
 
if ($session) {Import-PSSession $session -CommandName Get-MessageTrace  -AllowClobber -DisableNameChecking}



#Run the message trace
$messagetrace = Get-MessageTrace -EndDate $endTime  -startdate $startTime
 
#Store the information in loganalytics
$messagetrace.count
$runs = $messagetrace.Count/$messageSize
 
if (($runs -gt 0) -and ($runs -le "1") ) {$runs=1}
$runs
$writeSize = $messageSize
$i = 0
              
        while ($runs -ge 1) { 
    
                    $pagedrecord = $messagetrace[$i..$writeSize] 
                    $pagedjson = $pagedrecord | convertTo-Json
                    Post-LogAnalyticsData -customerId $customerId -sharedKey $sharedKey -body ([System.Text.Encoding]::UTF8.GetBytes($pagedjson)) -logType $logType                          
                                       
    
                $runs -= 1
                $i+= $messageSize +1
                $writeSize += $messageSize + 1 
           
               
                Clear-Variable pagedrecord
                Clear-Variable pagedjson
                                   
                                    } 



# Get the current universal time in the default string format
$currentUTCtime = (Get-Date).ToUniversalTime()

# The 'IsPastDue' porperty is 'true' when the current function invocation is later than scheduled.
if ($Timer.IsPastDue) {
    Write-Host "PowerShell timer is running late!"
}

#add last run time to blob file to ensure no missed packages
$endTime = $currentUTCtime | Get-Date -Format yyyy-MM-ddThh:mm:ss
$azstoragestring = $Env:WEBSITE_CONTENTAZUREFILECONNECTIONSTRING
$Context = New-AzStorageContext -ConnectionString $azstoragestring
if((Get-AzStorageContainer -Context $Context).Name -contains "lastlog"){
    #Set Container
    $Blob = Get-AzStorageBlob -Context $Context -Container (Get-AzStorageContainer -Name "lastlog" -Context $Context).Name -Blob "lastlog.log"
    $lastlogTime = $blob.ICloudBlob.DownloadText()
    $startTime = $lastlogTime | Get-Date -Format yyyy-MM-ddThh:mm:ss
    $endTime | Out-File "$env:TEMP\lastlog.log"
    Set-AzStorageBlobContent -file "$env:TEMP\lastlog.log" -Container (Get-AzStorageContainer -Name "lastlog" -Context $Context).Name -Context $Context -Force
}
else {
    #create container
    $azStorageContainer = New-AzStorageContainer -Name "lastlog" -Context $Context
    $endTime | Out-File "$env:TEMP\lastlog.log"
    Set-AzStorageBlobContent -file "$env:TEMP\lastlog.log" -Container $azStorageContainer.name -Context $Context -Force
    $startTime = $currentUTCtime.AddSeconds(-300) | Get-Date -Format yyyy-MM-ddThh:mm:ss
}
$startTime
$endTime
$lastlogTime
 
 
#remove session
remove-PSSession $session                          
 