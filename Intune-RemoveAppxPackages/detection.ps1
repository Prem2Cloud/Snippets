#Requires -RunAsAdministrator
<#
.SYNOPSIS
    Detects unwanted AppxPackages installed on the system.

.DESCRIPTION
    This script checks if any specified AppxPackages from a predefined list are installed on the system.
    If any are detected, the script outputs their names and exits with a non-zero exit code which triggers an Intune Remediation.

.NOTES
    Author: Prem2Cloud Ltd
#>

# -- Define the list of unwanted AppxPackages
$AppxPackagesToRemove = @(
    'Microsoft.XboxApp',
    'Microsoft.Xbox.TCUI',
    'Microsoft.XboxGameOverlay',
    'Microsoft.XboxGamingOverlay',
    'Microsoft.XboxIdentityProvider',
    'Microsoft.XboxSpeechToTextOverlay',
    'Microsoft.Gaming',
    'Microsoft.ZuneMusic',
    'Microsoft.ZuneVideo',
    'Microsoft.Bingweather',
    'Microsoft.Messaging',
    'Microsoft.BingNews',
    'Microsoft.MicrosoftSolitaireCollection',
    'Microsoft.MixedReality.Portal',
    'Microsoft.SkypeApp',
    'Microsoft.YourPhone',
    'Microsoft.windowscommunicationsapps',
    'Microsoft.WindowsFeedbackHub',
    'Microsoft.Getstarted'
)

# -- Check if any unwanted AppxPackages are installed
$InstalledPackages = Get-AppxPackage -AllUsers | Where-Object { $AppxPackagesToRemove -contains $_.Name }

if ($InstalledPackages) {
    # -- If any unwanted AppxPackages are detected, output their names and exit with a non-zero exit code
    Write-Information "Detected prohibited AppxPackages: $($InstalledPackages.Name -join ', ')"
    exit 1
} else {
    # -- If no unwanted AppxPackages are detected, output a success message and exit with a zero exit code
    Write-Information "No prohibited AppxPackages were detected."
    exit 0
}
