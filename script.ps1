# Get current username
$currentUserName = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name

# Get all drive letters
$drives = Get-PSDrive -PSProvider FileSystem

foreach ($drive in $drives) {
    # Construct the path
    $path = $drive.Root
    Write-Host "Applying full control permissions to $path for $currentUserName..."

    # Define the ICACLS command
    $icaclsCommand = "icacls `"$path*`" /grant `"$currentUserName`":(OI)(CI)F /T"

    # Execute the ICACLS command using cmd.exe, bypassing PowerShell parsing issues
    cmd.exe /c $icaclsCommand

    Write-Host "Permissions applied to $path"
}

Write-Host "Operation completed."
