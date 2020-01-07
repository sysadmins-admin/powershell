# Devloped by sysadmins-admin
# The program's purpose is to enumerate a given process suspected of malicious or ill-mannered acts

# Function Purpose: Visually shows enumeration happening
function enumerate_process(){

    Clear-Host # Clears screen to reduce clutter
        
        Write-Host "" # Adds blank space on terminal to reduce clutter
        $proc_name = Read-Host "Please enter process name to begin enumeration"
    
        Write-Host "" # Adds blank space on terminal to reduce clutter
        Write-Host "Start Time: "
        (Get-Process $proc_name).StartTime # Process start time
    
        Write-Host "" # Adds blank space on terminal to reduce clutter
        Write-Host "Handle Count: "
        (Get-Process $proc_name).HandleCount  # Handle count
        
        Write-Host ""  # Adds blank space on terminal to reduce clutter
        Write-Host "Threads: "
        (Get-Process $proc_name).Threads # List threads associated with process
        
        Write-Host "" # Adds blank space on terminal to reduce clutter
        Write-Host "Path: "
        (Get-Process $proc_name).Path  # Displays full path
        
        Write-Host "" # Adds blank space on terminal to reduce clutter
        Write-Host "Modules: "
        (Get-Process $proc_name).Modules # Associate process with dll(s) it may be accessing
       
        Write-Host "" # Adds blank space on terminal to reduce clutter
        Write-Host "Processor Affinity: "
        (Get-Process $proc_name).ProcessorAffinity  # Additional test to check if payload is attempting to deadlock processors
       
        Write-Host ""  # Adds blank space on terminal to reduce clutter
        Write-Host "Priority Boost: "   
        (Get-Process $proc_name).PriorityBoostEnabled # Checks to see how resource intensive process is
        ### If true, process may be resource intensive ###
        
        Write-Host "" # Adds blank space on terminal to reduce clutter
    
        pause # Allow admin time to respond. This can be removed to aid automation speed by reducing/limiting human interaction.
    
       menu(Write-Host "$proc_name has been enumerated") # Go back to menu
    
    }

# Function Purpose: Prints enumeration report to file
function print_report($message1){
    Clear-Host
    Write-Host "### Print Menu ###"
    Write-Host "1) Enter Process Name to Enumerate" # Perform enumeration"
    Write-Host "2) Main Menu" # Print report
    Write-Host "3) Quit"
    Write-Host ""
    Write-Host "$message1"

    switch (Read-Host "Please select an option above"){
        1{ $Date = Get-Date

           #Name document
           $proc_name1 = Read-Host "Enter process name to print to file"
           
           #Build timestamp text
           $Timestamp = "Report printed on: $Date"

           #Timestamp document
           $Timestamp | Out-File -Append "C:\Users\Bob\Desktop\Investigate\$proc_name1-eval.txt"

           ############Establishing variables to be written to file ############
           
            #Process Start time
            $ProcessStartTime = (Get-Process $proc_name1).StartTime
            $StartTime = "Process '$proc_name1' started at: $ProcessStartTime"

            #Handle count
            $HandleCount = (Get-Process $proc_name1).HandleCount
            $Handles = "Process '$proc_name1' has '$HandleCount' handle(s)"

            #List associated threads per process
            $AssocThreads = (Get-Process $proc_name1).Threads
            $Threads = "The associated threads to '$proc_name1' include: "

            #Locate filepath of process
            $Path = (Get-Process $proc_name1).Path
            $FilePath = "Process '$proc_name1' is located at: $Path"

            # Associate process with dll(s) it may be accessing
            $Modules = (Get-Process $proc_name1).Modules
            $FoundDlls = "Associated DLLS to '$proc_name1' include: "

            #Locate threads bound to specified CPUs. This could be an indication of a resource DoS.
            $ProcAffin = (Get-Process $proc_name1).ProcessorAffinity
            $ResourceCache = "Process '$proc_name1' is utilizing '$ProcAffin' as referenced to the processor cache"

            # Check if process is attempting to deadlock processors
            $Privilege = (Get-Process $proc_name1).PriorityBoostEnabled
            $PrivCheck = "Process '$proc_name1' exhibits resource intensive behavior (T/F): $Privilege"

            $BlankSpace = " " #Used to write in blank spaces between sections

           ############ End of establishing variables to be written to file ############

              #Process startime
              $BlankSpace >> "C:\Users\Bob\Desktop\Investigate\$proc_name1-eval.txt" 
              $StartTime >> "C:\Users\Bob\Desktop\Investigate\$proc_name1-eval.txt" # Add start-time to file

              #Process handles
              $BlankSpace >> "C:\Users\Bob\Desktop\Investigate\$proc_name1-eval.txt" 
              $Handles >> "C:\Users\Bob\Desktop\Investigate\$proc_name1-eval.txt" # Add handle count to file

              #Associated Threads
              $BlankSpace >> "C:\Users\Bob\Desktop\Investigate\$proc_name1-eval.txt"
              $Threads >> "C:\Users\Bob\Desktop\Investigate\$proc_name1-eval.txt"  # List threads associated with process
              $AssocThreads >> "C:\Users\Bob\Desktop\Investigate\$proc_name1-eval.txt"

              #Process Filepath
              $BlankSpace >> "C:\Users\Bob\Desktop\Investigate\$proc_name1-eval.txt"
              $FilePath >> "C:\Users\Bob\Desktop\Investigate\$proc_name1-eval.txt" # Displays full path

              # Associate process with dll(s) it may be accessing              
              $BlankSpace >> "C:\Users\Bob\Desktop\Investigate\$proc_name1-eval.txt"
              $FoundDlls >> "C:\Users\Bob\Desktop\Investigate\$proc_name1-eval.txt"
              $Modules >> "C:\Users\Bob\Desktop\Investigate\$proc_name1-eval.txt"
              
              #Locate thread count bound to specific CPUs
              $BlankSpace >> "C:\Users\Bob\Desktop\Investigate\$proc_name1-eval.txt"
              $ResourceCache >> "C:\Users\Bob\Desktop\Investigate\$proc_name1-eval.txt" # Additional test to check if payload is attempting to deadlock processors
              
              # Determines how resource intensive or resource privileged the process is. If resource value is 'True', then
              # the process exhibits resource intensive behavior 
              $BlankSpace >> "C:\Users\Bob\Desktop\Investigate\$proc_name1-eval.txt"
              $PrivCheck >> "C:\Users\Bob\Desktop\Investigate\$proc_name1-eval.txt"   # Checks to see how resource intensive process is
              
              menu("The enumeration of '$proc_name1' has been printed to file.") -ErrorAction SilentlyContinue # Return to main menu
              
              }
        
        2{menu}  # Return to main menu

        3{break} # Exit script

        default{menu ("Please select a valid option")} # Error handler
    }
}

# Function Purpose: An interactive and user-friendly menu to perform operations
function menu($message){
    Clear-Host
    Write-Host "### Main Menu ###"
    Write-Host "1) Enter Process Name" # Perform enumeration
    Write-Host "2) Print Report" # Print report
    Write-Host "3) Quit"
    Write-Host ""
    Write-Host "$message"

    switch(Read-Host "Please select an option above"){
    1 {enumerate_process} # Starts enumeration of process.
    2 {print_report}  # Prints enumeration of process to file.
    3 {break}             # Exit script
    default {menu ("Please select a valid option")} # Error handler
    }

}
menu

# Devloped by sysadmins-admin