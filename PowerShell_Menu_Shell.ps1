<#
    Developed by sysadmins-admin
    
    Please feel free to use this bare menu shell and/or integrate more complex functions as you see fit.
    Try to build the shell by memory to refine your scripting and development Superpowers.

    Remember you are the GURU!

    The Purpose of this program is to provide a minimalistic shell for quick reference to be used.
    Comments are everywhere and that's how I like it!

#>

<# 
Function Purpose: Display contents of complex function as an easy to use interface.
 **Proceed to briefly explain the function. Ensure it is well commented. Know your audience!**
#>
function function_1_menu(){
    Clear-Host # Clears the screen so new menu/function is the only thing present
    # Not needed if you want to see results/output

    Write-Host "Welcome to Function 1" # Know where main_menu1 will send the user.

    Pause # The pause gives user time to react and read the message
    main_menu1('"You left Function 1"') # Returns user to main menu and passes message to main menu screen
}

<# 
Function Purpose: Display contents of complex function as an easy to use interface.
 **Proceed to briefly explain the function. Ensure it is well commented. Know your audience!**
#>
function function_2_menu(){
    Clear-Host # Clears the screen so new menu/function is the only thing present
    # Not needed if you want to see results/output

    Write-Host "Welcome to Function 2" # Know where main_menu1 will send the user.

    Pause # The pause gives user time to react and read the message
    main_menu1('"You left Function 2"') # Returns user to main menu and passes message to main menu screen
}

<# 
Function Purpose: Display contents of complex function as an easy to use interface.
 **Proceed to briefly explain the function. Ensure it is well commented. Know your audience!**
#>
function function_3_menu(){
    Clear-Host # Clears the screen so new menu/function is the only thing present
    # Not needed if you want to see results/output

    Write-Host "Welcome to Function 3" # Know where main_menu1 will send the user.

    Pause # The pause gives user time to react and read the message
    main_menu1('"You left Function 3"') # Returns user to main menu and passes message to main menu screen
}

function main_menu1($message){
    Clear-Host # Clears the screen so the Main Menu is the only thing present
    # Not needed if you want to see results/output

    Write-Host -ForegroundColor Cyan -BackgroundColor DarkGray "====== MAIN MENU ======"
    Write-Host "1) Function 1"
    Write-Host "2) Function 2"
    Write-Host "3) Function 3"
    Write-Host "4) Exit Program"
    Write-Host ""   # Blank space added for clarity
    Write-Host $message # Displays message passed from functions
    
    # This switch statement basically gives life to the options listed above,
    # otherwise, they are just text written to the terminal.
    switch (Read-Host "Please select an option above") {
         1 { <# 
                Each number corresponds to the option listed in the menu.
              
                *** It is important to note that the numbers (switch conditions) only correspond 
                because I am choosingto call the function that correlates to the option listed 
                and not because the numbers happen to match up. I could exit the menu here or 
                call a different function, but that would get confusing! ***
                
            #>

               function_1_menu # Calls the function as defined
               # You can always add more stuff here or before you call the function 
            }
         
         2 { <# 
                Each number corresponds to the option listed in the menu.
            
                *** It is important to note that the numbers (switch conditions) only correspond 
                because I am choosingto call the function that correlates to the option listed 
                and not because the numbers happen to match up. I could exit the menu here or 
                call a different function, but that would get confusing! ***
            #>

               function_2_menu # Calls the function as defined
               # You can always add more stuff here or before you call the function
            }
         3 { <# 
                Each number corresponds to the option listed in the menu.
            
                *** It is important to note that the numbers (switch conditions) only correspond 
                because I am choosingto call the function that correlates to the option listed 
                and not because the numbers happen to match up. I could exit the menu here or 
                call a different function, but that would get confusing! ***
            
            #>

               function_3_menu # Calls the function as defined
               # You can always add more stuff here or before you call the function
            }
         4 { <# 
                Each number corresponds to the option listed in the menu
            
                *** It is important to note that the numbers (switch conditions) only correspond 
                because I am choosingto call the function that correlates to the option listed 
                and not because the numbers happen to match up. I could exit the menu here or 
                call a different function, but that would get confusing! ***

            #>

             Write-Host ""   # Blank space added for clarity
             Write-Host '"You are about to exit the program"' 
             Pause # The pause gives user time to react and read the message
             Clear-Host # Clears the screen so new menu/function is the only thing present
             # Not needed if you want to see results/output
             break # Exits menu
            }
          
         # A default statement is needed to validate user input in case user does not select intended options.   
         Default {
                    Write-Host -ForegroundColor Red "Please enter a valid option"
                    Write-Host ""   # Blank space added for clarity
                    Pause # The pause gives user time to react and read the error message
                    main_menu1 # Returns user to main menu
                }
            }
        }
main_menu1  # Call main_menu1 to initialize the program

<#
    Developed by sysadmins-admin
#>