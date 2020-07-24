# Get-SentinelAlertsEvidence

This playbook will Logic will automatically attach alert evidence from Azure Sentinel alerts and send them to an Event Hub that can be consumed by a 3rd party SIEM solution.


Author: Yaniv Shasha

Deploy the solution
1.	Create an Event Hub using the article "Create an event hub using Azure portal" <br>
https://docs.microsoft.com/en-us/azure/event-hubs/event-hubs-create  or use an existing Event Hub.
2.	Go to the Playbook GitHub page.<br>
3.	Press the “deploy to azure” button.<br>

4. fill the above information:<br>
- Azure Sentinel Workspace Name<br>
- Azure Sentinel Workspace resource group name<br>
- number of event you want to bring(default value is 10 last events )<br>

4.	Once the playbook is deployed, Modify the “Run query and list results” actions and point it to your Azure sentinel workspace.<br>
5.	Next, configure the "send event" actions to use your Event Hub that created earlier.<br>


<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FYaniv-Shasha%2FSentinel%2Fmaster%2FPlaybooks%2FGet-SentinelAlertsEvidence%2Fazuredeploy.json" target="_blank">
    <img src="https://aka.ms/deploytoazurebutton"/>
</a>
<a href="https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FYaniv-Shasha%2FSentinel%2Fmaster%2FPlaybooks%2FGet-SentinelAlertsEvidence%2Fazuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.png"/>
</a>

