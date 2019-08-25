## Exercise 4: Proactively Investigate Potential Threats, Misconfigurations, and Suspicious Activities with KQL Queries 

**Task 1:** Navigate to Sentinel Hunting and Run all queries<br>
As in Task 1, we will be proactively hunting for Indicators of Attack in Sentinel. In that task we were doing so visually through the use of dashboards. Here, we will use built-in KQL queries to identify signs of potential problems.
1.	From the Azure Sentinel homepage, click on **Hunting.**

2.	In the pane that opens, click on Hunting.
![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB04/screenshots/hunt01.PNG
)<br><br>

3.	Examine the Queries in the middle pane. These are built-in KQL queries provided to help you hunt for adversaries in your environment. Pay attention to the description and also special attention to the Tactics column. You may learn more about a particular tactic by mousing over it for a description. This column helps you understand which part of the attacker kill chain you may insert yourself in with the query. For example, by examining Hosts with new logons, you may be able to detect Lateral Movement in the environment.

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB04/screenshots/hunt02.PNG
)<br><br>

4.	By running all the built-in queries, you have a quick indicator of specific areas of concern. These may form a ready-made map of where your time should be spent hunting in any given point in time.
5.	Click **Run all queries.**
![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB04/screenshots/hunt03.PNG
)<br><br>

6.	Look at the Results column. Note that several of these queries have returned results. These require further investigation. You will want to help your customers pay special investigative attention to the results of queries like New processes observed in last 24 hours, and uncommon processes – bottom 5%. These can be indicators of compromise that are often missed.

**Task 2.** Run Several Single Hunting Queries and Examine the Output in Detail<br>
In this Task, we will run several single queries to hunt for indicators of compromise.
**Step 1:** Run the New processes observed Query and Examine the Output<br>
1.	Click on the query New processes observed in the last 24 hours.
2.	This brings up information about this Hunting query on the right side of the screen.

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB04/screenshots/hunt04.PNG
)<br><br>