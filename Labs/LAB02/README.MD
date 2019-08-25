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

6.	Click **briandel**, which is the name of the Sentinel Workspace.

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

## Task 4: Review your Incidents
1.	Open a new browser tab and Navigate to http://aka.ms/sentinel-investigation to activate the Sentinel Investigation Preview<br>
2.	Navigate back to Azure Sentinel -> Cases
3.	Locate your case standard**XX** – Failed Logon (where “XX” is the number you have been assigned at the start of class)
4.	Click on your case and Click the **Investigate** button
5.	Within the Investigation window hover over the IP Address node and select **More -> Most prevalent accounts associated with this IP** to bring in additional data related to that IP<br>

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB02/screenshots/invest01.PNG
)<br><br>

6.	Then, hover once again over the IP address and click **Related alerts** to see other Sentinel alerts based on the same IP Address to help identify other problems related to this bad logon<br>
7.	Navigate back to Azure Sentinel -> Cases and locate your case Admin**XX** – Admin Group Change
8.	Click on your case and Click the **Investigate** button
9.	Within the investigation window you can see the User that was added to the group, and the Group that they were added to.
10.	Hover over the User account **victim4** and click **Related alerts** to see additional alerts related to this Admin group change involving this account.

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB02/screenshots/invest02.PNG
)<br><br>

## Task 5: Create a playbook to respond to your Incidents
In this playbook we will be adding a user into a group based on a Incidents.  This group is already linked to a conditional access policy which will block user logons to all cloud applications.

1.	Within Azure Sentinel, Navigate to **Playbooks**
2.	Click **Add Playbook**
3.	In the Name field type standard**XX**-Block-With-Conditional-Access-Policy (where “XX” is the number you have been assigned)
4.	Under Resource Group, Select **Use existing** and choose **OI-Default-East-US**
5.	Click **Create**
6.	In the Logic Apps Designer, Click **Blank Logic App**
7.	In the text box **Search connectors and triggers** type **Sentinel** and click on the icon for **Azure Sentinel**.
8.	Select **When a response to an Azure Sentinel alert is triggered**
9.	Click **New Step**
10.	Search for **Sentinel** and click on the **Azure Sentinel** icon and click **Get Accounts (preview)**

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB02/screenshots/play01.PNG
)<br><br>

11.	Click the text box **Entities List** and from the flyout, select **Entities**

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB02/screenshots/entat01.PNG
)<br><br>

12.	Click **New Step** and search for Azure AD
13.	Select **Add user to group**
14.	Under Group ID, enter 4aa42844-7b1a-410f-b4eb-aacdc3e98b92
15.	Under User ID, select Accounts AAD user ID from the flyout

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB02/screenshots/accountAAD.PNG
)<br><br>
16.	Click **Save**

## Task 6: Use your new playbook to respond to a Incidents
1.	Navigate back to **Sentinel -> Incidents** in the Azure Portal
2.	Click on your Incidents standardXX – Failed Logon
3.	Click **View full details**
4.	Under the Incidents, click **View playbooks**

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB02/screenshots/viewplay.PNG

5.	From the list of Playbooks locate **standardXX-Block-With-Conditional-Access-Policy** and click **Run**
6.	Close all browser windows and open a new browser
7.	Navigate to https://myapps.microsoft.com
8.	In the window that opens, click **Use another account**. 

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB02/screenshots/login.PNG
)<br><br>

9.	Enter the account information:
Username: **standardXX@sentinellab.xyz** (where “XX” is the number you have been assigned at the start of class)
Password: **Ask the trainer**
10.	You will now see that access to the my apps portal has been blocked due to conditional access

10.	You will now see that access to the my apps portal has been blocked due to conditional access

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB02/screenshots/myapp.PNG
)<br><br>