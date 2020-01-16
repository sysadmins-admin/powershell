<#
    Developed by sysadmins-admin
    
    As with anything I develop, I try to make them as "Press play and walk away" as possible.
    
    I write code in modular formats so you can safely drop it (a standalone function, or 
    the entire program) into your own code if desired.

    Please feel free to use this scipt and/or integrate more complex functions as you see fit.
    Try to build the script by memory to refine your scripting and development Superpowers!

    Remember you are the GURU!

    The Purpose of this program is to provide a minimalistic approach to baselining the amount of files
    by type on your system(s).
    
    Comments are everywhere and that's how I like it!
#>
#Function Purpose: Find files by type and count them
function file_type_counter(){
    #Scenario: Count how many files by type are on C:
    
    Clear-Host # Clears screen for cleaner view

    Write-Host "" # Space added for cleaner output
    Write-Host -ForegroundColor Green "Starting file counter..."
    Write-Host "" # Space added for cleaner output
   
    # More extensions can be added or taken away as per the environment's needs
    $extensions=@("*.txt*", "*.rar*", "*.pdf*", "*.zip*", "*.doc*", "*.exe*", "*.ps1*", "*.sh*")

    #Write to screen to inform admin that scan is starting
    Write-Host -BackgroundColor Cyan -ForegroundColor DarkMagenta "Scanning C: for $extensions"
    Write-Host "" # Space added for cleaner output

    #Iterate through each extension.
    foreach($ext in $extensions){
      
    #Next, perform a Recursive search for .rar files. I used force to grab hidden files too.
    $ext_file = $(Get-ChildItem -Recurse -Force 'C:\' -Include $ext -ErrorAction SilentlyContinue)
    
    #Next, grab the count
    Write-Host -ForegroundColor Green $ext_file.Count "$ext file(s) were found on the C: Drive"
   
   }

   # Inform admin that scan has finished
   Write-Host "" # Space added for cleaner output
   Write-Host -BackgroundColor Cyan -ForegroundColor DarkMagenta "Scanning C: for $extensions"
 }
 file_type_counter

 <#
    Developed by sysadmins-admin
#>