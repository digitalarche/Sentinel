# SendAADExtendUserProperties2Senitnel
author: Yaniv Shasha

This azure functions design to query graph API and retrieve users specific properties, parse this data and send it to log analytics via API.

# Notes:

	1. You need to create AAD app and give it the above permission:
	
	User.Read.All, 
	User.ReadWrite.All, 
	Directory.Read.All, 
	Directory.ReadWrite.All
	
	https://docs.microsoft.com/en-us/graph/api/user-get?view=graph-rest-1.0&tabs=http#permissions
	
	
	2. Create function APP that will build on top of PS 
	3. Configure the function with time input trigger and configure it to run Every day at 6am (0 0 6 * * ?)
	4. Copy the above json file into run.ps1
	5. In the function app open the configuration and add Application settings (key value per)

clientId - your AAD Application ID 
TenantId - Your AAD tenant
clientSecret = secret client id for the AAD (you can save the client secret in key vault and add the url instead) 
CustomerId = sentinel workspace id
SharedKey = sentinel workspace key 
LogType = sentinel customer table name 


