<#
    Developed by sysadmins-admin
    
    Please feel free to use this scipt and/or integrate more complex functions as you see fit.
    Try to build the script by memory to refine your scripting and development Superpowers.

    Remember you are the GURU!

    The Purpose of this program is to provide a minimalistic approach to checkin often forgotten 
    tasks for quick reference to be used. This script may also provide use function plugins for 
    enumeration purposes.

    Comments are everywhere and that's how I like it!

#>

#Function Purpose: Allows User wigth minimal privileges to check SIDs. User may be remote.
function sid_check(){
<#
    This will pull the name of the current user.
    I am splitting off the slash after the username and everything after it. 
#>
$accountname = whoami | ForEach-Object {$_.split("\")[1]}  

# Just another way of finding your SID. This may not check for admins. The $gather_sids
# variable may be updated to find admin by modifying the SID Select-String paramater.
$gather_sids = Get-ChildItem 'C:\$Recycle.Bin' -Force | Select-String "S-1*1"
    #Iterate through possible SIDs and run comparison
    foreach($sid in $gather_sids){
        $finding_user = Get-LocalUser -SID "$sid" -ErrorAction SilentlyContinue
            if($finding_user -like $accountname){
                Write-Host "The SID of $sid matches the account named: $accountname"
                
                #Establish value to pass to check the cache of. This is useful for refined approaches.
                $name_to_pass = $accountname
        
            #Pass value to cache check function
            cache_check($name_to_pass)
           
            #Dump variable value
            $accountname = ''

            #Dump variable value
            $sid = ''
        }

        #Dump variable value
        $finding_user = ''
    }
    
    #Dump variable value
    $gather_sids = ''
}


#Function Purpose: This is a cache check only function, not a cache delete function.
function cache_check($name_passed){
    
    #Pass Variable
    Write-Host -ForegroundColor Cyan "Passed account name: $name_passed"
    
    #If the account name matches, open cache location and clear it
    Get-ChildItem -Force -ErrorAction SilentlyContinue "C:\Users\"$name_passed"\AppData\Local\Microsoft\Windows\INetCache"
           
    #Dump variable value
    $name_passed=''
}

#Function Purpose: Call other key functions
function clean_up(){

    sid_check # Check SID
}
clean_up

<#
    Developed by sysadmins-admin
#>