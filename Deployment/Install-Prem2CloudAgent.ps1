#Requires -RunAsAdministrator

# -- Define your setings here
[string]$EnrollmentKey = "XXXXX-XXXXX-XXXXX-XXXXX"  # -- Replace with your Prem2Cloud enrollment key. You can leave this blank if using offline mode.
[boolean]$OfflineMode = $false  # -- Set to $true to enable offline mode. Devices must be manually enrolled if using offline mode.

# -- Script Variables (do not modify)
[uri]$InstallerUrl = "https://cdn.prem2cloud.co.uk/Prem2CloudInstaller.exe"
[string]$TempInstallerPath = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "Prem2CloudInstaller.exe")

# -- Function to handle the installer exit code. Modify this with any custom logic you require.
function Invoke-ExitCodeLogic {
    param (
        [int]$ExitCode
    )
    switch ($ExitCode) {
        0 {
            Write-Information "Installation completed successfully." -ForegroundColor Green
        }
        1 {
            Write-Warning "Installation aborted by the user."
        }
        3 {
            Write-Error "Undefined error occurred."
        }
        101 {
            Write-Error "EULA not accepted."
        }
        102 {
            Write-Error "Enrollment key not provided."
        }
        103 {
            Write-Error "Unable to read device serial number."
        }
        104 {
            Write-Error "Unable to read device hardware ID."
        }
        105 {
            Write-Error "Unable to contact Prem2Cloud service."
        }
        106 {
            Write-Error "Invalid enrollment key."
        }
        107 {
            Write-Error "Insufficient licenses available."
        }
        108 {
            Write-Error "Device enrollment failed."
        }
        109 {
            Write-Error "Installer is not running as 64-bit."
        }
        200 {
            Write-Error "Failed to download the installer."
        }
        default {
            Write-Error "Unknown exit code: $ExitCode"
        }
    }
}

# -- Function to check that a network connection is available and wait until it is.
function Wait-NetworkConnection {
    [boolean]$log = $true
    do {
        if ((Test-NetConnection -ComputerName 'cloudflare.com' -Port 80 -ErrorAction SilentlyContinue -WarningAction SilentlyContinue -InformationAction SilentlyContinue).TcpTestSucceeded) {
            if (!$log) {
                Write-Information 'Network connection is now available, continuing...'
            }
            return
        }
        else {
            if ($log) {
                Write-LogWarn 'Network connection is not available, waiting until it is...'
                $log = $false
            }
            Start-Sleep -Seconds 10
        }
    } while ($true)
}

# -- Download the installer
[int]$DownloadInstallerMaxAttempts = 3
[int]$DownloadInstallerAttempts = 0
do {
    $DownloadInstallerAttempts++
    try {
        Write-Information "Downloading the Prem2Cloud installer..."
        Wait-NetworkConnection # -- Check that a network connection is available
        (New-Object System.Net.WebClient).DownloadFile($InstallerUrl.AbsoluteUri, $TempInstallerPath)

    } catch {
        if ($DownloadInstallerAttempts -ge $DownloadInstallerMaxAttempts) {
            Write-Error "Failed to download the installer after $($DownloadInstallerAttempts) attempts."
            exit 1
        }
        Write-Warning "Failed to download the installer. Retrying in 5 seconds..."
        Start-Sleep -Seconds 5
    }
} until ((Test-Path $TempInstallerPath) -or ($DownloadInstallerAttempts -ge $DownloadInstallerMaxAttempts))

# -- Run the installer
try {
    $Arguments = @(
        "/Silent"
        "/EnrolmentKey $($EnrollmentKey)"
        "/Eula Accept"
    )
    if ($OfflineMode) {
        $Arguments = "/Offline"
    }
    $ArgumentsString = $Arguments -join " "

    # -- Run the installer and wait for it to complete
    Write-Information "Starting the Prem2Cloud installer..."
    $Process = Start-Process -FilePath $TempInstallerPath -ArgumentList $ArgumentsString -NoNewWindow
    Write-Information "Installer process started with PID $($Process.Id). Waiting for it to exit..."
    Wait-Process -Id $Process.id

    # -- Handle the installer exit code
    Invoke-ExitCodeLogic -ExitCode $Process.ExitCode
} catch {
    Write-Error "Failed to start the installer: $($_.Exception.Message)"
} finally {
    # -- Clean up the temporary installer file
    if (Test-Path $TempInstallerPath) {
        try {
        Remove-Item -Path $TempInstallerPath -Force
        Write-Information "Temporary installer file deleted."
        } catch {
            Write-Warning "Failed to delete the temporary installer file: $($_.Exception.Message)"
        }
    }
}

# -- End execution and exit
Write-Information "Prem2Cloud Installation script completed."
if ($Process.ExitCode -eq 0){
    exit 0
} else {
    exit 1
}