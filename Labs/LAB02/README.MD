## Exercise 2: Setup Alerts (Analytics) and Respond to Cases in Azure Sentinel
In this section we will configure Alerts in Azure Sentinel to generate Cases for our security team.  During the review of these cases we will build a Runbook to simplify the handling of these alerts.<br>

**Task 1**: Log on to the My Apps portal as a Standard User<br>
In this task you will logon to the My Apps portal as a standard user to confirm the accounts functionality.  Afterwards, you will send bad passwords to the account to simulate an unauthorized user attempting to gain access.
1.	In a browser, navigate to https://myapps.microsoft.com
2.	In the window that opens, click Use another account. 

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB02/screenshots/login.PNG
)<br><br>

3.	Enter the account information:<br>
Username: **standardXX@sentinellab.xyz** (where “XX” is the number you have been assigned at the start of class)
Password: **Ask the trainer**
4.	Confirm you have access to the My Apps portal.
5.	Close all instances of your browser and Navigate back to https://myapps.microsoft.com
6.	This time, when logging on as **standardxx@sentinellab.xyz** type in an **incorrect password**
7.	Repeat this invalid logon attempt 5 times

**Task 2**: Log on to Azure and Navigate to Sentinel
In this task you will log into the Azure portal and navigate to Sentinel.
1.	In a browser, navigate to https://portal.azure.com.
2.	In the window that opens, click Use another account. 

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB02/screenshots/login.PNG
)<br><br>

3.	Enter the account information:<br>
Username: **AdminXX@sentinellab.xyz** (where “XX” is the number you have been assigned at the start of class)
Password: **Ask the trainer**
4.	This brings you to the Azure Home. In the box at the top, search for Sentinel.
5.	In the results, click on Azure Sentinel (preview)

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB01/screenshots/portal2.PNG
)<br><br>

6.	Click briandel, which is the name of the Sentinel Workspace.

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB01/screenshots/workspace.PNG
)<br><br>

7.	Within the navigation bar, click Analytics

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB02/screenshots/analytics.png
)<br><br>

Task 2: Create Analytics Rule for Failed Logon
1.	Click **Add**<br>
In the Name box type standard**XX** – Failed Logon (where “XX” is the number you have been assigned at the start of class)<br>
2.	Select Alert Severity **Medium**
3.	In **Set Alert Query** copy the following query (substitute “XX” with your assigned number)
```powershell
SigninLogs
| where Status.errorCode == 50126 // Invalid Username or password
| where UserPrincipalName contains "standardXX" 
| project TimeGenerated, Status.failureReason, UserPrincipalName, Status.errorCode, UserId, IPAddress 
| sort by TimeGenerated desc
```

4.	Under Entity Mapping, map the following entities
o	Account -> UserId (Click **Add**)
o	Host -> UserprincipalName (Click **Add**)
o	IP address -> IPAddress (Click **Add**)
5.	Set the Alert Trigger Operator to **Number of results greater than** and the threshold to 0
6.	Set the Alert **scheduling Frequency** to 5 minutes and Period to 30 minutes
7.	Set Alert suppression to On and Suppress alerts for 30 minutes
8.	Click **Create**.

## Task 3: Create Analytics Rule for Admin Group Change
1.	Click **Add**<br>
In the Name box type Admin**XX** – Admin Group Change (where “XX” is the number you have been assigned at the start of class)
2.	Select Alert Severity **Medium**
3.	In **Set Alert Query** copy the following query
```powershell
let accttypes = dynamic(['Domain Admins', 'Enterprise Admins', 'Schema Admins', 'Administrators' , 'Account Operators' , 'Backup Operators' , 'Print Operators' , 'Server Operators' , 'Domain Controllers' , 'Read-only Domain Controllers' , 'Group Policy Creator Owners' , 'Cryptographic Operators']);
SecurityEvent 
| where EventID in (4728, 4729, 4732, 4733, 4756, 4757)
| extend ChangeType = case(EventID in (4729, 4733, 4757), "Member Removed", "Member Added") 
| parse EventData with *'"TargetUserName">'TargetUserName'<'*
| where TargetUserName in (accttypes)
| project ChangeType, ImpactedGroup=TargetUserName, ImpactedAccount=MemberName, ChangeMaker=Account, DC=Computer
```

4.	Under Entity Mapping, map the following entities
o	Account -> ImpactedAccount (Click Add)
o	Host -> ImpactedGroup (Click Add)
5.	Set the Alert Trigger Operator to **Number of results greater than** and the threshold to 0
6.	Set the Alert **scheduling Frequency** to 5 minutes and Period to 1 hour
7.	Set **Alert suppression** to On and Suppress alerts for 1 hour

## Task 4: Review your Cases
1.	Open a new browser tab and Navigate to http://aka.ms/sentinel-investigation to activate the Sentinel Investigation Preview<br>
2.	Navigate back to Azure Sentinel -> Cases
3.	Locate your case standard**XX** – Failed Logon (where “XX” is the number you have been assigned at the start of class)
4.	Click on your case and Click the **Investigate** button
5.	Within the Investigation window hover over the IP Address node and select **More -> Most prevalent accounts associated with this IP** to bring in additional data related to that IP<br>

