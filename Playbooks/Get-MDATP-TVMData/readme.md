# Get-MDATP-TVMData

Author: Yaniv Shasha

This playbook will ingest MDATP TVM data into sentinel workspace


<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FYaniv-Shasha%2FSentinel%2Fmaster%2FPlaybooks%2FGet-MDATP-TVMData%2Ftemplate.json" target="_blank">
    <img src="https://aka.ms/deploytoazurebutton"/>
</a>
<a href="https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FYaniv-Shasha%2FSentinel%2Fmaster%2FPlaybooks%2FGet-MDATP-TVMData%2Ftemplate.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.png"/>
</a>


Authentication part:

- audience: "https://graph.microsoft.com"
- clientId: "your AAD application client ID"
- secret: "your AAD app secret"
- tenant: "tenant_id"
- type: "ActiveDirectoryOAuth"

Give the AAD app the relevant permission as describe here https://docs.microsoft.com/en-us/windows/security/threat-protection/microsoft-defender-atp/get-discovered-vulnerabilities



![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Playbooks/Get-MDATP-TVMData/pics/1.png
)<br><br>