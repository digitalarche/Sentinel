#  Close-SentinelIncident-From-Snow

Author: Yaniv Shasha

This playbook will listen to a close incident events from service now and close the incident in Sentinel

Pre requisites:

1. configure the permission on the log analytics workspace action in the logic with user that have read access on the workspace.
2. on the Http action (get Etag and close incident), create AAD APP and give it Sentinel contributor on Sentinel RG (or use managed identity)

if you are using AAD app copy the above information and add it on the http action authentication section:

* AAD tenant 
* Application ID
* Client secret 

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FYaniv-Shasha%2FSentinel%2Fmaster%2FPlaybooks%2FClose-IncidentFromSNOW-WebHook%2Fazuredeploy.json" target="_blank">
    <img src="https://aka.ms/deploytoazurebutton"/>
    
</a>

<a href="https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FYaniv-Shasha%2FSentinel%2Fmaster%2FPlaybooks%2FClose-IncidentFromSNOW-WebHook%2Fazuredeploy.json" target="_blank">
    <img src="https://aka.ms/deploytoazurebutton"/>
    
</a>

