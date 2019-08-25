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

3.	Optional: for background information, you may click on read more on mitre.com. This is an excellent knowledge base of adversary tactics and techniques that have been documented in the wild.
4.	Click **Run Query** and then click **View Results**. This launches the Logs page, pre-populates the KQL query, and displays the results.
![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB04/screenshots/hunt05.PNG
)<br><br>

5.	Briefly examine the table of results. Notice that it features HostCount  and FileName columns of information. From the results, we can see that there have been a number of new processes launched across the estate in the last 24 hours.
6.	This may be a sign of normal, benign programs being run. However, in normally stable environments, these new processes could provide an indication of an unauthorized/malicious binary that has been installed and run. Look closely at the results as shown below. 
![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB04/screenshots/hunt06.PNG
)<br><br>

7.	Right away we might notice some suspicious activity. For purposes of our lab, let’s focus on the highlighted process above and the ones like it. These are processes we do not normally recognize – and they may very well be nefarious. Certainly, we need to investigate further.
8.	Note that we have identified a protentially dangerous process that otherwise would have gone unnoticed in the environment. This can be an early indicator of compromise – and early detection is key to being able to create a meaningful response.
9.	Click on **Azure Sentinel – Hunting** at the top to return to he Hunting section.
![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB04/screenshots/hunt07.PNG
)<br><br>

**Step 2:** Run the Hosts with new logons Query and Examine the Output<br>
1.	Click on the query Hosts with new logons.
2.	This brings up information about this Hunting query on the right side of the screen

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB04/screenshots/hunt08.PNG
)<br><br>

3.	Notice the description.
4.	Scroll down to view the query and the tactics.

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB04/screenshots/hunt09.PNG
)<br><br>

5.	**Optional**: for background information, you may click on read more on mitre.com. This is a knowledge base of adversary tactics and techniques that have been documented in the wild.
6.	Click **Run Query** and then click **View Results.** This launches the Logs page, pre-populates the KQL query, and displays the results.

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB04/screenshots/hunt10.PNG
)<br><br>

7.	Briefly examine the query. The query is asking for successful and failed logon events, creating a union, setting some time parameters, joining several tables, and setting some output parameters.
8.	Briefly examine the table of results. Notice that it features the projected attributes Name and Hostcount. From the results, we can see that a subset of computers have indeed received recent (new) logon activity.
9.	Your output may look slightly different, but right away we might notice some suspicious activity. Multiple domain controllers (DCs) have received new logons. This bears further investigation. New logons to DCs are typically rare; DCs also represent high-value attack targets.

![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Labs/LAB04/screenshots/hunt11.PNG
)<br><br>

**Task 3**: Craft and Execute a Hunting Query to Investigate the New DC Logons<br>

1.	In this Task, we want to investigate the accounts that have logged onto the DCs in the last day.
2.	Click the **Plus** (+) sign next to New Query 1.

