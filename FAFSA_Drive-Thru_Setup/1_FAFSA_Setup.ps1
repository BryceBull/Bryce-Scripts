# Relaunch as an elevated process:
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Start-Process powershell.exe "-File", ('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
  exit
}
# Create FAFSA account and set as default auto-logon
$Password = "FAFSA123" | ConvertTo-SecureString -AsPlainText -Force
New-LocalUser "FAFSA" -Password $Password -FullName "FAFSA" -Description "Local account for FAFSA event" -PasswordNeverExpires
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
Set-ItemProperty $RegPath "AutoAdminLogon" -Value "1" -type String 
Set-ItemProperty $RegPath "DefaultUsername" -Value "FAFSA" -type String 
Set-ItemProperty $RegPath "DefaultPassword" -Value "FAFSA123" -type String

# Removes all icons on the public desktop
Remove-Item "C:\Users\Public\Desktop\*" -Force -Confirm:$false -Recurse

# Set Google Chrome to default in Incognito mode
New-Item -Name Chrome -Path HKLM:\SOFTWARE\\Policies\Google
New-Item -Path "HKLM:\SOFTWARE\\Policies\Google\Chrome" -Force | Out-Null
New-ItemProperty -Name "IncognitoModeAvailability" -Path "HKLM:\SOFTWARE\\Policies\Google\Chrome" -Value "2" -PropertyType "DWORD" -Force

# Copies contents of the Shortcuts folder onto the public desktop
Copy-Item -Path $PSScriptRoot\Shortcuts\* -Filter *.lnk -Destination C:\Users\Public\Desktop -Recurse