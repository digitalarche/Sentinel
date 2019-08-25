# Introduction

#### Lab technology
In this technical workshop, you will not need to access any IaaS or any other machines directly. Instead, you will use your own computer to access a preconfigured lab in Azure.

#### User accounts <br>
To access the azure lab, you will navigate to:https://portal.azure.com<br>
You will then logon with the following account:
**AdminXX@sentinellab.xyz***, where “XX” is the number you have been assigned at the start of class.<br>
For example, if I was assigned number 47, my username would be **user47@sentinellab.xyz**<br>
Username: **AdminXX@sentinellab.xyz**<br>
Password: **Ask the trainer**


# Exercise 1: Review Azure Sentinel Data Connectors
In this exercise you will be reviewing the data connectors of Azure Sentinel to confirm that data is already being collected in the Sentinel Workspace.  Data connectors are critical to a setup of Azure Sentinel so that data can flow into the workspace.  To save time, these data connectors have been configured in advance.
Task 1: Log on to Azure and Navigate to Sentinel
In this task, you will log into the Azure portal and navigate to Sentinel.
1.	In a browser, navigate to https://portal.azure.com.
2.	In the window that opens, click Use another account. 


![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/Exercise%201%20Review%20Azure%20Sentinel%20Data%20Connectors/screenshots/portal1.PNG
)<br><br>

3.	Enter the account information:
Username: **AdminXX@sentinellab.xyz** (where “XX” is the number you have been assigned at the start of class)<br>
Password: **Ask the trainer**

4.	This brings you to the Azure Home. In the box at the top, search for **Sentinel**.
5.	In the results, click on **Azure Sentinel (preview)**.

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/Exercise%201%20Review%20Azure%20Sentinel%20Data%20Connectors/screenshots/portal2.PNG
)<br><br>

6.	Click **briandel**, which is the name of the Sentinel Workspace.

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/Exercise%201%20Review%20Azure%20Sentinel%20Data%20Connectors/screenshots/workspace.PNG
)<br><br>

7.	In the Navigation bar, select Data Connectors

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/Exercise%201%20Review%20Azure%20Sentinel%20Data%20Connectors/screenshots/connectors.PNG
)<br><br>

8.	Locate the data connectors **Azure Active Directory** and **Security Events** and confirm that the Last log received time is within the last 30 minutes.
9.	Click the **Azure Active Directory** connector and Click **Open connector page**
10.	Confirm the status of the connector as **Connected**

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/Exercise%201%20Review%20Azure%20Sentinel%20Data%20Connectors/screenshots/AAD.PNG
)<br><br>

11.	Confirm that there has been recent data received

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/Exercise%201%20Review%20Azure%20Sentinel%20Data%20Connectors/screenshots/data_ingested.PNG
)<br><br>