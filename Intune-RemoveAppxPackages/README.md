# Intune AppxPackage Detection and Remediation Scripts

Welcome to the **Intune AppxPackage Detection and Remediation** solution! This section of the repository contains PowerShell scripts designed to help administrators detect and remove unnecessary or unwanted `AppxPackages` from devices managed through Intune. These scripts are optimized for flexibility and ease of use, providing detailed logging and customizable logic.

---

## Features

- **Proactive Detection**:
  - Identifies specific `AppxPackages` installed on a device from a predefined list.
  - Outputs detailed information about detected packages for administrators to review.

- **Automated Remediation**:
  - Uninstalls specified `AppxPackages` automatically if detected.
  - Handles errors gracefully, providing meaningful feedback on failures.

- **Customizable Logic**:
  - Modify the list of `AppxPackages` to detect or remove based on organizational needs.
  - Implement additional workflows or logging as required.

- **Logging Support**:
  - Built-in logging provides detailed information during script execution.
  - Organisations can enable additional logging by starting and stopping transcripts where required.

---

## Usage Instructions

### 1. **Download the Scripts**
Clone this repository or download the `detection.ps1` and `remediation.ps1` script files from this folder.

### 2. **Configure the Scripts**
Modify the variables at the top of the scripts to align with your organisation’s requirements:
- `AppxPackagesToRemove`: An array containing the names of the `AppxPackages` you wish to detect and/or remove. Update this list as needed.

### 3. **Enable Logging (Optional)**
If you want to take advantage of detailed logging, ensure to:
- Start a transcript at the beginning of the script using `Start-Transcript`.
- Stop the transcript at the end of the script using `Stop-Transcript`.

### 4. **Deploy the Scripts**
Deploy the scripts using Intune Remediations:
- **Detection Script**: Use `detection.ps1` to identify prohibited packages. The script will exit with a non-zero code if any are found.
- **Remediation Script**: Use `remediation.ps1` to uninstall detected packages automatically.

We recommend testing the scripts in a controlled environment before deploying them at scale.

---

## Example Use Cases

- **App Rationalisation**:
  - Remove pre-installed bloatware and unnecessary apps during the device migration process.
- **Compliance Enforcement**:
  - Ensure devices comply with organisational policies by removing disallowed apps.
- **Scalable Automation**:
  - Use Intune to automate detection and remediation across your entire device fleet.

---

## Documentation

For more detailed instructions on deploying scripts via Intune, refer to the **[Microsoft Intune Documentation](https://learn.microsoft.com/intune/)**.

---

## Contributions

We welcome contributions to improve these scripts or add new functionality. Feel free to submit a pull request or open an issue with your suggestions.

---

## License

These scripts are licensed under the **MIT License**, allowing you to use, modify, and distribute them freely. For details, see the [LICENSE](../LICENSE) file.

---

<p align="center">For support or questions, feel free to reach out via our website: <a href="https://prem2cloud.co.uk">Prem2Cloud</a></p>
