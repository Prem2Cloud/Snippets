# Prem2Cloud Deployment Script

Welcome to the **Prem2Cloud Deployment Script** folder! This section of the repository provides PowerShell scripts designed to deploy the **Prem2Cloud Agent** to devices. These scripts are optimized for flexibility and ease of use, supporting both automated and manual enrollment processes.

---

## Features

- **Flexible Deployment Options**:
  - **Auto Enrollment**: Use an enrollment key for seamless, automated device registration.
  - **Manual Enrollment**: Administrators can manually register devices via the Prem2Cloud portal, depending on organisational preferences.

- **Error Handling and Business Logic**:
  These scripts incorporate logic to handle the **Prem2Cloud installer exit codes**, enabling you to:
  - Diagnose installation issues.
  - Trigger organisation-specific business logic based on error codes or installation outcomes.

---

## Installation Process

1. **Download the Script**:
   Clone this repository or download `Install-Prem2CloudAgent.ps1` script file from this folder.

2. **Configure the Script**:
   Change the variables at the top of the script to match your organisation's preferences:
    - `EnrolmentKey`: The Prem2Cloud enrollment key for automated device registration. Leave as-is for offline registration.
    - `Offline`: Set to `$true` if you want to install the agent in offline mode. This will require manual registration via the Prem2Cloud portal.

 3. **Configure Logic**:
   Adapt the scripts to include custom error handling or trigger workflows specific to your organisation's requirements.

3. **Deploy the Script**:
   Deploy and run the script on the target devices using your preferred deployment method (e.g., Group Policy, SCCM, Intune).
   We recommend testing the script in a controlled environment before deploying it at scale.

---

## Documentation

For more detailed information on deploying the Prem2Cloud Agent, visit:
**[Prem2Cloud Agent Installation Guide](https://prem2cloud.co.uk/docs/agent-installation)**

---

## Example Use Cases

- **Automated Enrollment**: Use the provided scripts in a group policy or deployment tool (e.g., Intune, SCCM) to install and register devices at scale.
- **Custom Error Handling**: React to installer exit codes by triggering alerts, logging errors, or initiating remediation actions.
- **Integration with Existing Systems**: Modify the scripts to align with your organisation's workflows and processes.

---

## Contributions

We welcome contributions to enhance these scripts or add new functionality. Feel free to submit a pull request or open an issue with your suggestions.

---

## License

These scripts are licensed under the **MIT License**, allowing you to use, modify, and distribute them freely. For details, see the [LICENSE](../LICENSE) file.

---

<p align="center">For support or questions, reach out via our website: <a href="https://prem2cloud.co.uk">Prem2Cloud</a></p>
