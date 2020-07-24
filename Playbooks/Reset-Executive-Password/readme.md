# Reset-Executive-Password
author: Yaniv Shasha

This playbook will send an email to L2 DL and ask for a confirmation to the reset AAD password for a Phished user.
NOTE: You must create an app registration for Graph API with appropriate permissions.
NOTE: You will need to add the managed identity that is created by the logic app to the Help Desk Administrator role in Azure AD.

<a href="https://azuredeploy.net/?repository=https://github.com/Yaniv-Shasha/Sentinel/tree/master/Playbooks/Reset-Executive-Password" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FYaniv-Shasha%2FSentinel%2Fmaster%2FPlaybooks%2FReset-Executive-Password%2Fazuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.png"/>
</a>