## Exercise 3: Proactively Investigate Potential Threats, Misconfigurations, and Suspicious Activities Visually 
In this exercise, you will learn how to access Azure Sentinel and how to use a Dashboard to view data visually. You will also learn how to examine the underlying Kusto queries, and to change them.
For this lab, Data connectors have already been added and appropriately configured as necessary.<br>

**Task 1:** Log on to Azure and Navigate to Sentinel
In this task, you will log into the Azure portal and navigate to Sentinel.
1.	In a browser, navigate to https://portal.azure.com.
2.	In the window that opens, click **Use another account**.

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/use.PNG
)<br><br>
3.	Enter the account information:<br>
* Username: **AdminXX@sentinellab.xyz** (where “XX” is the number you have been assigned at the start of class)
* Password: **Ask the trainer**<br>

4.	This brings you to the Azure Home. In the box at the top, search for **Sentinel**.
5.	In the results, click on **Azure Sentinel (preview)**
![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB01/screenshots/portal2.PNG
)<br><br>
6.	Click **briandel**, which is the name of the Sentinel Workspace.
![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB01/screenshots/workspace.PNG
)<br><br>

7.	Take a moment to examine the Sentinel **Overview** page. This page gives you a bird’s eye view of your estate’s data.<br>

**Task 2:* Navigate the Overview Page and Understand Basic Kusto Queries**<br>

1.	Look closely at the pane entitled **Events and alerts over time**. This pane provides a bar graph representing alerts, Windows Firewall Events, Security Events, Performance data, and other data that has been recently gathered.

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/evetns.PNG
)<br><br>

2.	Click on **WindowsFirewall** off to the right.

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/FW.PNG
)<br><br>

3.	This opens up the **Logs** window and also demonstrates a critical point to understand. Azure Log Analytics (and the Kusto Query Language) forms a large portion of the platform upon which Azure Sentinel has been built.

4.	Once the query (“WindowsFirewall”) finishes, examine the data.
5.	Click one of the chevrons on the left to inspect a data element.

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/FW_Events.PNG
)<br><br>

6.	In keeping with this simple query, this piece of data tells a simple story. In the example here, the machine DC04.ad.briandel.ca sent (through the Firewall) a UDP packet to 10.0.0.4 over Port 59,121. In itself, it is not terribly interesting. But in aggregate or as part of an investigation, Kusto queries like this can provide critical data as we shall see.
7.	Return to the Sentinel Overview page by clicking **Azure Sentinel – Overview** at the top.
8.	Click one of the **Security Event** areas of one of the bars – it appears in light green(The Bar color may change).

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/bar.PNG
)<br><br>

9.	This query is slightly more complex and will look something like this (the date and time fields will be different):

```powershell
union SecurityEvent
| where TimeGenerated >= datetime(2019-08-25T16:19:04.063Z) and TimeGenerated < datetime(2019-08-25T16:19:04.063Z) + 1h
```

10.	This query is asking for a **SecurityEvent** (from a Windows security log) during a specified date and time.
11.	Click on one of the chevrons, preferably for an **AccountType** of **User** and not a built-in account like NT AUTHORITY.

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/Atype.PNG
)<br><br>

In this example, the administrator account has failed to log on. This could be very telling as an early indicator of attack. Why is someone logging on (and failing) using the administrator account?<br>
12.	Click *Azure Sentinel – Overview** to return to the Sentinel Overview page.

**Task 3**: Utilize Dashboards to Proactively Investigate Potential Threats, Misconfigurations, and Suspicious Activities<br>
**Step 1**: Learn to navigate the Dashboards frame<br>
In this task, you will learn to proactively investigate using Sentinel Dashboards. Sentinel Dashboards provide visualized data from your connected data sources to help render them proactively actionable.
1.	From the Sentinel Overview page, click on Dashboards.

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/dash01.PNG
)<br><br>

2.	On the next blade that appears, click All.

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/dash02.PNG
)<br><br>

3.	Taka a moment to browse the list of built-in Dashboards such as **Azure Activity, Azure AD Sign-in logs, Office 365**, and third-party Dashboards for products from vendors like Symantec and Palo alto. It is important to understand that **Dashboards** are typically used with Data connectors. In fact, when you add a **Data connector**, you typically receive a **Recommended dashboard**, as in this example:
![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/connection.PNG
)<br><br>

4.	For this exercise, we’ll be using the **Insecure Protocols** built-in dashboard.
5.	From the **Dashboards** blade, click on **Installed**. This brings up a list of previously installed Dashboards.

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/installed.PNG
)<br><br>

6.	Click on **Insecure Protocols**. In the lower right-hand corner, click **View dashboard** in order to bring up the dashboard.
7.	The **Insecure Protocols** dashboard visually represents Security log data from on-premise or IaaS Active Directory Domain Controllers. Specifically, it represents data detailing which insecure protocols are currently in use and their data flows throughout the estate.
8.	Take a moment to browse the dashboard. This dashboard addresses the problem of organizations that wish to remove insecure protocols (like NTLMv1, SMB1, wDigest and weak Kerberos ciphers) but are unable to do so for fear of breaking critical business systems. They need to remediate the sources before they can disable the protocols. And for that they need data visualization.<br>

**Step 2**: Dive deeper in the Insecure Protocols Dashboard to Investigate Security Data
1.	Let’s take a look at the overview graph titled **Insecure Protocols**.

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/dash03.PNG
)<br><br>

2.	On the pie chart, we can immediately see something important. Out of all the Insecure Protocols that could be running in this estate, only Insecure LDAP shows up. That tell us that, so long as this trend continues, we could safely turn off other protocols such as NTLMv1 and SMB1. Mouse over the pie chart to conform that 100% of the Insecure Protocols in the environment are Insecure LDAP.


![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/dash04.PNG
)<br><br>

3.	We can also drop down to the Insecure LDAP section of the page (directly below the Overview) for more insightful data representations. Step 3: Understand and Manipulate the Insecure Protocol Queries Behind the Dashboard<br>
1.	On the **Insecure Protocols** dashboard, scroll down to **Insecure LDA**P**. This was the most active Insecure Protocol in the estate, so it makes sense to examine it closely.
2.	Note that we can drill down in a number of ways – by **Client, Time**, and by **Details**.
3.	By clicking on portions of the pie chart on the far left, Insecure LDAP, by client, we can carve the data by client. 

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/dash05.PNG
)<br><br>

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/dash06.PNG
)<br><br>

4.	On the far right, we can also see a table containing a filtered subset of the data (Insecure LDAP, by details).
![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/dash07.PNG
)<br><br>
5.	Sometimes we will need to assist our customers in delving deeper into a particular data set or sets. In order to do that, we will often want to drill down closer to the actual data collected by Sentinel (Log Analytics on the back end). Let’s do this for this visualizer, Insecure LDAP by details.
6.	Click on the Analytics Blade icon in the upper right corner of the visualizer
![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/dash08.PNG
)<br><br>
7.	This brings up the Kusto Query Language (KQL) query that is used to populate the visualizer. Peruse the query.
![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/dash09.PNG
)<br><br>
8.	This query is asking for logs with EventID 2889 (insecure LDAP bind) and is doing some extractions as well as RegEx matching to put the data in an acceptable format. It is summarizing the data by count (Account, IPAddress) and sorting it in descending order. We can see this in the data that is returned.
![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/dash10.PNG
)<br><br>
9.	We see now that we have an actionable set of data. We know the accounts and IPAddresses that are issuing Insecure LDAP binds. We know where we need to look in order to remediate the problem and ultimately to disallow Insecure LDAP throughout our estate.
10.	Let’s say we needed to go a bit deeper. For example, maybe we need to know the Domain Controller being targeted by the Insecure LDAP binds. We can easily do that in the following steps.
11.	Highlight the whole query, right click and click **Copy.**
![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/dash11.PNG
)<br><br>
12.	At the top, click the **Plus Sign** to open a new Query window.
![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/dash12.PNG
)<br><br>
13.	In the window that opens, Paste the copied query.
14.	Rem out the last two lines using backslashes, like this:
![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/dash13.PNG
)<br><br>
15.	Change the **Time range** to **Last 7 days** and click Run 
![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/dash14.PNG
)<br><br>
16.	This returns the results that are not grouped – closer to what you might think of as “raw” log data. Click one of the chevrons to the left side of the screen in order to examine one of these logs.
17.	This type of data can help fill in the missing pieces to our story. Depending on which log you clicked, you can gain the missing information. In the example below, we see that victim7 made an Insecure LDAP bind from IP 10.1.0.4 and against DC04.
18.	Click on Dashboard in the upper right corner, to return to the dashboard.
![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/dash15.PNG
)<br><br>

19.	On the dashboard page, click on the shield in the upper left corner, next to Insecure Protocols overview.
![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/dash16.PNG
)<br><br>
20.	This returns us to the Azure Sentinel homepage.

### Continue with the next lab
LAB 03 - Proactively Investigate Potential Threats, Misconfigurations, and Suspicious Activities with KQL Queries , click <a href="https://github.com/Yaniv-Shasha/Sentinel/tree/master/Labs/LAB04" target="_blank">here</a>