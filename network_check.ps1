# Devloped by sysadmins-admin

# Checks network activity to catch possibly malicious callbacks (SYN_SENT, CLOSE, FIN, etc.) every 10 seconds
# Although these may not be complete or attributing threat vectors, they can indicate possible unauthorized network/infrastructure usage
# This approach is similar to IPv6 ACLs 

$i=1
$counter=1

Clear-Host # Clears the screen to reduce clutter
Write-Host "==============WELCOME TO NETSCAN==============" -ForegroundColor Yellow -BackgroundColor DarkCyan
Write-Host "" # Clear line to increase readability

#Initializing while loop break parameter
$SecondsToStop = Read-Host -p "1 iteration = 10 seconds. How many iterations would you like the program to run?"

while($i -lt $SecondsToStop){
    Write-Host -ForegroundColor Cyan -BackgroundColor DarkGray "Starting loop: $counter"
   # Get-Date >> "C:\Users\Bob\Desktop\Investigate\SYN_SENT.txt"
   # netstat -ano | findstr "SYN_SENT" >> "C:\Users\Bob\Desktop\Investigate\SYN_SENT.txt"
    #netstat -ano | findstr "CLOSE*" >> "C:\Users\Bob\Desktop\Investigate\SYN_SENT.txt"
    #netstat -ano | findstr "FIN*" >> "C:\Users\Bob\Desktop\Investigate\SYN_SENT.txt"
    #netstat -ano

    Start-Sleep -Seconds 10 # After scan, sleep for  seconds
    Write-Host -ForegroundColor Cyan -BackgroundColor DarkGray "Ending loop: $counter"
    
    $counter++ # Increment the counter
    $i++ # Increment the iterator
}
  
# Devloped by sysadmins-admin