# Export Azure Sentinel analytics rule between sentinel instances.

- The script is relying on AZ.sentinel PS Module from **Wortell** https://github.com/wortell/AZSentinel
- The RBAC permission for the user that running the **export part** of the script is at least a Sentinel **reader** https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#azure-sentinel-reader
- The RBAC permission for the user that running the **import part** of the script is a Sentinel **Contributor** https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#azure-sentinel-contributor

### Preparing the ground

Prerequisite for using this module https://github.com/wortell/AZSentinel#prerequisites

- PowerShell Core
- Powershell AZ Module - tested with version 2.4.0
- PowerShell powershell-yaml Module - tested with version 0.4.0
- Az.sentinel Module (tested with 0.64 version) by running the above command

Install-Module AzSentinel -Scope CurrentUser -Force

### This script will not migrate Azure Sentinel analytics rules that is:

- Not active.
- From fusion type.
- From 1st party alert providers (ASC\AATP\MCAS\IDP\MDATP).
- When migrated a analytics rule that query missing log analytics table in the destination workspace



Export single rule:

```powershell
Get-AzSentinelAlertRule -SubscriptionId 6b1ceacd-xxx-xxx-xxx-2078dd96fd96 -WorkspaceName "existingWorkspace" -RuleName "Mimikatz has been detected" | ConvertTo-Json | Out-File c:\temp\Mimikatz.yaml  
```

Import Rule:
```powershell
Import-AzSentinelAlertRule -SubscriptionId 44e4eff8-xxx-xxx-xxx-992ac7286382 -WorkspaceName "NewWorksapce" -Settings c:\temp\Mimikatz.yaml -Verbose
```
