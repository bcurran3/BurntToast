param ([string]$message)
# Check if WinRM is running (required to send Toast machine-wide)
$WinRMStatus=(Get-Service 'WinRM').Status

# Start WinRM if not Running
if ((Get-Service WinRM).Status -eq 'Stopped') {Start-Service 'WinRM' -ErrorAction SilentlyContinue}

# Show global toast notification
if ((Get-Service WinRM).Status -eq 'Running') {
     Invoke-Command -ComputerName $env:COMPUTERNAME -ArgumentList $message -ScriptBlock {param([string]$message) New-BurntToastNotification -Text "$message"}
   } else {
     Write-Host "** Can't send global Toast because WinRM service is not running." -Foreground Red
	 }
# Stop WinRM if it was previously in Stopped state
if ($WinRMStatus -eq 'Stopped') {Stop-Service 'WinRM'}
