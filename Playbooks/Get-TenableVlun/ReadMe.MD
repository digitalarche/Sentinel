# Get-TenableVlun

Author: Younes Khaldi


This playbook will get vulnerability data from tenanble.io instance and send it to log analytics workspace.



<a href="https://azuredeploy.net/?repository=https://github.com/Yaniv-Shasha/Sentinel/tree/master/Playbooks/Get-TenableVlun" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FYaniv-Shasha%2FSentinel%2Fmaster%2FPlaybooks%2FGet-TenableVlun%2Fazuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.png"/>
</a>

Authentication part:

- You will need to generate API key from tenable.io 
- on the log analytics write section, the user that authenticated on this action need a write access to Sentinel workspace

Give the AAD app the relevant permission as describe here https://docs.microsoft.com/en-us/windows/security/threat-protection/microsoft-defender-atp/get-discovered-vulnerabilities



![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Playbooks/Get-MDATP-TVMData/pics/1.png
)<br><br>
