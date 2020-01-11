<#
    Developed by sysadmins-admin
    
    Please feel free to use this scipt and/or integrate more complex functions as you see fit.
    Try to build the script by memory to refine your scripting and development Superpowers.

    Remember you are the GURU!

    The Purpose of this program is to provide a minimalistic approach to finding your Security Identifier
    and for freeing up dynamically allocated storage - memory - (variables) within running memory
    for quick reference to be used.

    Comments are everywhere and that's how I like it!

#>

function find_my_sid(){

    <#
        The $accountname variable will pull the name of the current user.
        I am splitting off the slash after the username and everything after it. 
    #>
    
    #This tells you what account you are logged in as.
    $accountname = whoami | ForEach-Object {$_.split("\")[1]}  
    
    <#
        We already know who the user is based on the value stored in $accountname,
        so, we look for it in the list here. 
    #>
    
    # Another interesting way to find SIDs is by looking through system variables like the Recycle Bin
    $gather_sids = Get-ChildItem 'C:\$Recycle.Bin' -Force | Select-String "S-1*1"
        foreach($sid in $gather_sids){  # Separate each sid found in the Recycle Bin system variable
    
            #Plug in each sid separately to temporarily hold for a quick "snatch-and-grab" comparison
            $finding_user = Get-LocalUser -SID "$sid" -ErrorAction SilentlyContinue
                if($finding_user -match $accountname){
    
                    # If the sid associated with the currently logged in user is found, inform user of this script.
                    Write-Host "The SID of $sid matches the account named: $accountname"
                    break # If the sid belonging to the currently logged in user, then break out of the loop
                            # else, keep searching.
                }
    
                #If the sid associated with the currently logged in user is not found, inform user of this script.
                elseif($finding_user -notmatch $accountname) {
                    Write-Host "Could not find a SID associated with the account named $accountname"
                }
        }   
    
        $finding_user = "" #Dump variable after each iteration/comparison. Added security.
    }
    find_my_sid # Call function here
    
<#
    Developed by sysadmins-admin    
#>
    
    