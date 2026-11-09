#Bob Perini#
#11/9/26#

#Readme:
#This is a method to patch ibm spss log4j issues (which it uses in it's directories)

#SPSS patch notifications seem be behind a login, so just watch the log4j website for changes of whatever is the latest stable verison.
#Adjust $newversion as required
#Step 1, create a package or application in Configuration Manager or a MDM of your choice. The files 
#inside are just (log4j-core-version.jar, log4j-1.2-api-version.jar, log4j-api-version.jar)
#Step 2, copy these files to c:\temp (might be same as step 1 depending on your Management Tool)
#Step 3, Run this powershell script as admin. (I use a task sequence, but it can be done manually)

#need to add logging features.

#determine old version programatically based on what is in the folder, there will always be this file in the main 
#spss directory
$oldfile=Get-ChildItem -Path "C:\program files\ibm\SPSS Statistics\" -Filter "*log4j-core*" -File | Sort-Object Name
$oldfilearray = $oldfile[0] -split "-"
$oldversion=$oldfilearray[2] -split ".jar"

#this added whitespace trim the whitespace
$oldversion=$oldversion[0].Trim()
$newversion="2.25.5"

#set the paths for log4j files
$spssLibPath = "C:\Program Files\IBM\SPSS Statistics\"
$spssLibPath2 = "c:\program files\ibm\spss statistics\as\lib\"

#Path to downloaded jar (you figure out how to get it to machine)
$log4jCoreJar = "C:\temp\log4j-core-$newversion.jar"            
$log4japiJar1 = "C:\temp\log4j-1.2-api-$newversion.jar"    
$log4japiJar2 = "c:\temp\log4j-api-$newversion.jar"
$CustomTracker = "c:\temp\log4jupdate$newversion"

#Paths to version being removed
$oldlog4jCoreJar = "log4j-core-$oldversion.jar"            
$oldlog4japiJar1 = "log4j-1.2-api-$oldversion.jar"    
$oldlog4japiJar2= "log4j-api-$oldversion.jar"

# Copy Log4j Core
#root spss folder
Copy-Item -Path $log4jCoreJar -Destination $spsslibpath -Force
Copy-Item -Path $log4japiJar1 -Destination $spssLibPath -Force
Copy-Item -Path $log4japiJar2 -Destination $spssLibPath -Force
#as/lib folder
Copy-Item -Path $log4jCoreJar -Destination $spssLibPath2 -Force
Copy-Item -Path $log4japiJar1  -Destination $spssLibPath2 -Force 
Copy-Item -Path $log4japijar2 -Destination $spssLibPath2 -Force

#remove old files

#root spss folder
remove-Item $spsslibpath$oldlog4jCoreJar -Force 
remove-Item $spsslibpath$oldlog4japiJar1 -Force
remove-Item $spsslibpath$oldlog4japiJar2 -Force

#as/lib folder
remove-Item $spsslibpath2$oldlog4jCoreJar -Force
remove-Item $spsslibpath2$oldlog4japijar2 -Force 
remove-Item $spsslibpath2$oldlog4japiJar1 -Force 

#delete the temp files so that they don't flag vunerability scanners
Remove-item $log4jcorejar -Force
Remove-item $log4japijar1 -Force
Remove-Item $log4japijar2 -Force
