# Delete-EmailfromUserMailBox

Author: Yaniv Shasha

This playbook will run on top of sentinel analytics.
The Rule need to identified if phishing email was send to a user's mailbox.
The playbook will extract the email title and the receivers user and check if the message include title and the email is not read. then it will delete the email from the user mailbox.

Authentication part:

  "audience": "https://graph.microsoft.com"
  "clientId": "<your AAD application client ID>"
  "secret": "<your AAD app secret>"
  "tenant": "<tenant_id>"
  "type": "ActiveDirectoryOAuth"

Give the AAD app the relevant permission as describe here https://docs.microsoft.com/en-us/graph/permissions-reference#mail-permissions

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FYaniv-Shasha%2FSentinel%2Fmaster%2FPlaybooks%2FDelete-EmailfromUserMailBox%2Ftemplate.json" target="_blank">
    <img src="https://aka.ms/deploytoazurebutton"/>
</a>
<a href="https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FYaniv-Shasha%2FSentinel%2Fmaster%2FPlaybooks%2FDelete-EmailfromUserMailBox%2Ftemplate.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.png"/>
</a>

