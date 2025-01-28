#Requires -RunAsAdministrator
<#
.SYNOPSIS
    Removes unwanted AppxPackages installed on the system.

.DESCRIPTION
    This script uninstalls specific AppxPackages from a predefined list if they are found on the system.
    It logs success or failure for each package removal attempt.

.PARAMETER AppxPackagesToRemove
    An array of prohibited AppxPackages to remove from the system.

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

# -- Remove each unwanted AppxPackage
foreach ($PackageName in $AppxPackagesToRemove) {
    $InstalledPackage = Get-AppxPackage -Name $PackageName -AllUsers -ErrorAction SilentlyContinue
    if ($InstalledPackage) {
        try {
            Remove-AppxPackage -Package $InstalledPackage.PackageFullName -AllUsers -ErrorAction Stop | Out-Null
            Write-Information "Successfully removed package: $($PackageName)"
        } catch {
            Write-Warning "Failed to remove package: $($PackageName). Error: $_"
        }
    }
}

# -- Check if any unwanted AppxPackages are still installed
$RemainingPackages = Get-AppxPackage -AllUsers | Where-Object { $AppxPackagesToRemove -contains $_.Name }
if ($RemainingPackages) {
    Write-Warning "Some packages could not be removed: $($RemainingPackages.Name -join ', ')"
    exit 1
} else {
    Write-Information "All unwanted AppxPackages have been removed!"
    exit 0
}
