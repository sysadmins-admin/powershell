<#
    Developed by sysadmins-admin

    This script can be modified as you see fit.
    Please feel free to redistribute and/or use any part or all of the code.
    As with any scripts developed here, we try to make them as "Press play and walk away" as possible.
    We attempt to write code in modular formats so you can safely drop it into your own code if desired.
    If something can be written better or more efficiently, please comment the code and submit suggestions.
#>
#Function Purpose: Scan file that use Alternate Data Streams (ADS)
function ads_scan(){
        #Scenario: Find files that contain ADS, hash them, put them in a directory, and if zipped, unzip them within those directories
       
        <#
         This is a counter that will be used later to create numbered directories 
         to house files. 
        #> 
        $i = 1

        #First perform a recursive search
        $streams=$(Get-ChildItem -Force -Recurse C:\ -ErrorAction SilentlyContinue)

        #Find the non-false positives (NFP_files)
        $nfp_files=$($streams | findstr Stream | Where-Object { $_ -match "Stream" -and $_ -notmatch "DATA" })
        
        #Next, grab the count
        Write-Host -ForegroundColor Green $nfp_files.Count " possibly malicious file(s) were found"

        <#
        Next, grab just the content because this is what we want to search for
        Complete automation, no manual handjamming needed
        Using split here to filter output of unwanted additional strings/characters
        #>
        $found_streams=$($nfp_files | ForEach-Object {$_.split(":")[1]} | ForEach-Object {$_.split(" ")[1]})

        Write-Host " " # Space added for cleaner output
        Write-Host -ForegroundColor Green "Gathering information about files that contain Alternate Data Streams..."
        #Next find the file names that contain these streams and grag a 
        foreach($found_file in $found_streams){
                $streams | findstr $found_file
                Write-Host " " #Space added for cleaner output
          }
        
        Write-Host " " # Space added for cleaner output
        Write-Host -ForegroundColor Green "Grabbing files that contain Alternate Data Streams..."

        #Additionally hash each file, using SHA1 here, use your hashing algorithm of choice
        #Next find the file names that contain these streams
        foreach($found_file in $found_streams){

          # Here I removed a space that was was appended to the beginning of the filenames
          $bad_files=$($streams | findstr $found_file | findstr "PSChildName" | ForEach-Object {$_.split(":")[1]} | ForEach-Object {$_.split(" ")[1]})
          
          # Attempting to dynamically hash the file
          # Ran into issue with finding the file
              foreach($bad_file in $bad_files){
                $file_paths=$(Get-ChildItem C:\ -Recurse -Force -Include "$bad_file" -ErrorAction SilentlyContinue | findstr Directory | ForEach-Object {$_.split(":")[2]})
                
                #Strip each file path and pass it as a variable
                foreach($file_path in $file_paths){

                # Append C: to the front of each path assuming all paths are on the C: Drive and test the path
                Write-Host " " # Space added for cleaner ouput
                Write-Host -ForegroundColor Gray "Testing if file path exists..."
                Test-Path -Path C:$file_path\$bad_file
               
               # If the file path exists, (is true), then continue
               if(Test-Path -Path "C:$file_paths\$bad_file"){

                    Write-Host "" # Space added for cleaner output
                    Write-host -ForegroundColor Yellow "Now Hashing: " $bad_file
                     
                    #
                      # Here I am hashing each file, using (argubably) the 3 most widely used hashing algorithms
                      #  Of course, it is jsut fine to use you favorite hashing algorithm of choice
                   
                    Get-FileHash -Algorithm MD5 -Path "C:$file_paths\$bad_file" 
                    Get-FileHash -Algorithm SHA1 -Path "C:$file_paths\$bad_file" 
                    Get-FileHash -Algorithm SHA256 -Path "C:$file_paths\$bad_file"
                    }
                    <# 
                       Now that we have these possibly malicious files, 
                       if needed, COPY (DO NOT SEND) each file(s) individually to
                       these dynamic directories. These directories will be used as
                       locations to extract files if needed.
                    #>
                 
                 
                   if ($i -lt $(($nfp_files.Count + 1))){ 
                    
                    #Print to screen copy progress
                    Write-Host " " # Space added for cleaner output
                    Write-host -ForegroundColor Green "Creating directory C:\Users\Owner\Sectioned_Off$i"
                    New-Item -ItemType Directory  -Path "C:\Users\Owner\Sectioned_Off$i"

                    <#
                      Copying Items directly to the root of the C: Drive is never recommended,
                      so please adjust this path to your environmental needs
                    #>
                    Write-Host " " # Space added for cleaner output
                    Write-Host -ForegroundColor Green "NOW COPYING $bad_file TO C:\Users\Owner\Sectioned_Off$i"
                    Copy-Item "C:$file_path\$bad_file" -Destination "C:\Users\Owner\Sectioned_Off$i"

                    <# 
                    Verifying that the files have been copied
                    Here I am also grabbing the hidden items
                    #>
                        }
                      }
                  
                  $i++  # Post increment the counter
                }
           
          
          }
          
      }

          Write-Host " " # Space added for cleaner ouput
          # Print to screen function completion messge
          Write-Host -BackgroundColor Cyan -ForegroundColor DarkMagenta $nfp_files.Count "POSSIBLY MALICIOUS FILE(S) HAVE BEEN FOUND AND HASHED..."
}

#Function Purpose: Handles program functions
function handler1(){
    
  # Clear the screen 
    Clear-Host
    Write-Host "" # Space added for cleaner output
    Write-Host -BackgroundColor Cyan -ForegroundColor DarkMagenta "Scanning for Alternate Data Streams..."
    ads_scan #Either way, start this function
}
handler1

<#
    Developed by sysadmins-admin.
#>
