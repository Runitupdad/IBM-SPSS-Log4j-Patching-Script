#need to add logging features to this so we know if it failed and where.

#determine old version programatically
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
#Write-Host "Copying Log4j Core..."
#root spss folder
Copy-Item -Path $log4jCoreJar -Destination $spsslibpath -Force
Copy-Item -Path $log4japiJar1 -Destination $spssLibPath -Force
Copy-Item -Path $log4japiJar2 -Destination $spssLibPath -Force
#as/lib folder
Copy-Item -Path $log4jCoreJar -Destination $spssLibPath2 -Force
Copy-Item -Path $log4japiJar1  -Destination $spssLibPath2 -Force 
Copy-Item -Path $log4japijar2 -Destination $spssLibPath2 -Force

#remove old files
#write-host $spssLibPath$oldlog4jCoreJar

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
