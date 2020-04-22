# Export Azure Sentinel analytics rule from one sentinel instance to anther.

- The script is relaying on AZ.sentinel PS Module from **Wortell** https://github.com/wortell/AZSentinel
- The RBAC permission for the user that running the **export part** of the script is at least a Sentinel **reader** https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#azure-sentinel-reader
- The RBAC permission for the user that running the **import part** of the script is a Sentinel **Contributor** https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#azure-sentinel-contributor

### Preparing the ground

Prerequisite for using this module https://github.com/wortell/AZSentinel#prerequisites

- PowerShell Core
- Powershell AZ Module - tested with version 2.4.0
- PowerShell powershell-yaml Module - tested with version 0.4.0

### This script will not migrate Azure Sentinel analytics rules that is:

- Not active.
- From fusion type.
- From 1st party alert providers (ASC\AATP\MCAS\IDP\MDATP).
- If in the new workspace is missing the Log analytics table that the rule query.
