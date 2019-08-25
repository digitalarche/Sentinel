## Exercise 3: Proactively Investigate Potential Threats, Misconfigurations, and Suspicious Activities Visually 
In this exercise, you will learn how to access Azure Sentinel and how to use a Dashboard to view data visually. You will also learn how to examine the underlying Kusto queries, and to change them.
For this lab, Data connectors have already been added and appropriately configured as necessary.<br>

**Task 1:** Log on to Azure and Navigate to Sentinel
In this task, you will log into the Azure portal and navigate to Sentinel.
1.	In a browser, navigate to https://portal.azure.com.
2.	In the window that opens, click **Use another account**.

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/use.PNG
)<br><br>
3.	Enter the account information:
Username: **AdminXX@sentinellab.xyz** (where “XX” is the number you have been assigned at the start of class)
Password: **Ask the trainer**
4.	This brings you to the Azure Home. In the box at the top, search for **Sentinel**.
5.	In the results, click on **Azure Sentinel (preview)**
![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB01/screenshots/portal2.PNG
)<br><br>
6.	Click **briandel**, which is the name of the Sentinel Workspace.
![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB01/screenshots/workspace.PNG
)<br><br>

7.	Take a moment to examine the Sentinel **Overview** page. This page gives you a bird’s eye view of your estate’s data.<br>

**Task 2:** Navigate the Overview Page and Understand Basic Kusto Queries 

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
8.	Click one of the **Security Event** areas of one of the bars – it appears in light green.

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/bar.PNG
)<br><br>

9.	This query is slightly more complex and will look something like this (the date and time fields will be different):

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/secevents.PNG
)<br><br>

10.	This query is asking for a **SecurityEvent** (from a Windows security log) during a specified date and time.
11.	Click on one of the chevrons, preferably for an **AccountType** of **User** and not a built-in account like NT AUTHORITY.

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB03/screenshots/Atype.PNG
)<br><br>