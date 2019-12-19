# Devloped by sysadmins-admin
# The purpose of this script is to provide a light system baseline

#Function Purpose: This function helps to identify section headings
function header($text) {
   
    "`n"
    "=" * $text.length
    $text.toUpper()
    "=" * $text.length
}

# Function Purpose: Establishes initial baseline of system
function grab_baseline_half1(){

    header "date"
    Get-Date # Grab system date and time

    header "hostname"
    hostname  # Grab system hostname

    header "User account(s)"
    Get-WmiObject -Class win32_useraccount -ErrorAction SilentlyContinue # Provides a list of users,their Account types, domains, names, and SIDs

    header "Group(s)"
    Get-LocalGroup -ErrorAction SilentlyContinue # Grabs all groups

    header "Logged on Users"
    (gcim Win32_LoggedOnUser).Antecedent | Format-List name, domain -ErrorAction SilentlyContinue # All logged on users

    header "Active Processes"
    Get-Process -ErrorAction SilentlyContinue # Get all active processes

    header "Services and States"
    Get-Service -ErrorAction SilentlyContinue | Format-Table -AutoSize # All services and their states
    }

# Function Purpose: To many parameters were passed to the first grab_baseline
# which slowed down the script. By separating it here, it optimizes the process.
function grab_baseline_half2(){
    header "Network Information"
    Get-NetIPConfiguration -ErrorAction SilentlyContinue # Display Network Config

    header "Listening Network Sockets"
    Get-NetTCPConnection -ErrorAction SilentlyContinue | Format-Table LocalAddress, LocalPort, RemoteAddress, RemotePort, OwningProcess, State | findstr "Listen" # Gets all listening network sockets

    header "PnP Devices"
    Get-PnpDevice -ErrorAction SilentlyContinue # Get PnP decices

    header "Shared Resources"
    Get-SmbShare -ErrorAction SilentlyContinue # Shared resources

    header "Scheduled Tasks"
    Get-ScheduledTask -ErrorAction SilentlyContinue # Does same thing as schtasks, but using a powershell command

  }

# Function Purpose: The function is responsible for printing output from enumeration to a user specified file/filepath
function first_enum_print(){
    
    # Establishing a user specified filepath
    $first_filepath = Read-Host "Please enter the path you wish to save your first enumeration in. 
    Ex. C:\Users\Bob\Documents\filename1.txt
    Type Here"

    grab_baseline_half2 >> $first_filepath    # Enumeration will be written to a user specified file path
    grab_baseline_half1 >> $first_filepath    

    # The file path specified by the user will be printed on the
    # Main Menu screen so they do not forget it.
    menu("Your first enumeration has been written to $first_filepath")
}

# Function Purpose: The function is responsible for printing output from enumeration to a user specified file/filepath
function second_enum_print(){
    
    # Establishing a user specified filepath
    $second_filepath = Read-Host "Please enter the path you wish to save your second enumeration in 
    Ex. C:\Users\Bob\Documents\filename2.txt
    Type Here"

    grab_baseline_half2 >> $second_filepath    # Enumeration will be written to a user specified file path
    grab_baseline_half1 >> $second_filepath

    # The file path specified by the user will be printed on the
    # Main Menu screen so they do not forget it.
    menu("Your second enumeration has been written to $second_filepath")
}

# Function Purpose: The compare function compares the files stored in dynamic locations
function compare_files(){

   $filepath1 = Read-Host "Please enter path of first enumeration"
   $filepath2 = Read-Host "Please enter path of second enumeration"

   $comparison_file_path = Read-Host "Where would you like to save your comparison file"
    Compare-Object -ReferenceObject $(Get-Content "$filepath1") -DifferenceObject $(Get-Content "$filepath2") >> $comparison_file_path

    menu("Your comparison file has been written to $comparison_file_path")
}

# Function Purpose: Provide a user-friendly interface to interact with th script.
function menu($message){
    Clear-Host
    Write-Host "=== Main Menu ==="
    Write-Host "1) Run First Enumeration" # User Will specify file path at the end 
    Write-Host "2) Save First Enumeration to File"    # User will specify file path at the beginning 
    Write-Host "3) Run Second Enumeration"
    Write-Host "4) Save Second Enumeration to File"  
    Write-Host "5) Compare files"   # User will specify file path at the end
    Write-Host "6) Exit Script"
    Write-Host ""
    Write-Host "$message"

    switch(Read-Host "Please select an option above"){
        1{grab_baseline_half2;
          grab_baseline_half1;
          menu("Enumeration has completed")}
        2{first_enum_print}
        3{grab_baseline_half2;
          grab_baseline_half1;
          menu("Enumeration has completed")}
        4{second_enum_print}
        5{compare_files}
        6{break}
        default{menu("Please choose a valid option")}
    }
}
menu
# Devloped by sysadmins-admin