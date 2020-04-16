# Get-MDATP-TVMData

Author: Yaniv Shasha

This playbook will ingest MDATP TVM data into sentinel workspace

Authentication part:

  "audience": "https://graph.microsoft.com"
  "clientId": "<your AAD application client ID>"
  "secret": "<your AAD app secret>"
  "tenant": "<tenant_id>"
  "type": "ActiveDirectoryOAuth"

Give the AAD app the relevant permission as describe here https://docs.microsoft.com/en-us/windows/security/threat-protection/microsoft-defender-atp/get-discovered-vulnerabilities

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fgithub.com%2FYaniv-Shasha%2FSentinel%2Fblob%2Fmaster%2FPlaybooks%2FGet-MDATP-TVMData%2Ftemplate.json" target="_blank">
    <img src="https://aka.ms/deploytoazurebutton"/>
</a>
<a href="https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fgithub.com%2FYaniv-Shasha%2FSentinel%2Fblob%2Fmaster%2FPlaybooks%2FGet-MDATP-TVMData%2Ftemplate.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.png"/>
</a>

