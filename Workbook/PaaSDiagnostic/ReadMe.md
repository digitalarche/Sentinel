# Azure monitor Workbook to visualize PaaS coverage for Azure Sentinel  

this workbook will bring all the PaaS services under the selected subscription and check if it send diagnostic logs to sentinel Workspace.
you can use this workbook as compliance report to track you log collection coverage from Azure PaaS services.
currently the supported workloads are: Keyvault, eventhub, NSG, webApps, Azure SQL, AzureFW, LogicApp, etc...


## Workbooks - how to Import and Export:

This is repeated in a file (open the instructions file in *RAW* mode and download to see the screenshots), see instructions in the workbooks folder:

### Installation Instructions:
 
1. Select the [RAW] button, [Copy] the workbook file content (these are JSON files),  open Azure Monitor Workbooks (from portal.azure.com) - open the “empty” Azure Monitor Workbook, in “advanced edit” mode (press the </> icon ).  Please [paste] over any json that exists.   

2. Then Press [apply] then [Done Editing]

### Export:

Open Azure Monitor Workbooks

1. In “advanced edit” mode (press the </> icon) - Choose "Gallery Template" for JSON file or ARM, then press the blue arrow (to the left of the [Apply] button) to download the file

(![alt text](https://raw.githubusercontent.com/Yaniv-Shasha/Sentinel/master/Workbook/PaaSDiagnostic/pics/1.png
)<br><br>


