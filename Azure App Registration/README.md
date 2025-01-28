# Prem2Cloud Terraform App Registration Configuration

Welcome to the **Prem2Cloud Azure App Registration** folder! This section of the repository contains an example Terraform configuration file for setting up an Azure Application Registration to enable Prem2Cloud's access to Microsoft Graph APIs. This configuration provides a basic template for organisations that wish to provision the necessary resources as Infrastructure as Code (IaC).

---

## Features

- **Automated Azure Setup**:
  - Creates an application registration in Azure Active Directory as Infrastructure as Code (IaC).
  - Includes an **optional resource** to generate a client secret for organisations that prefer to create and securely store secrets programmatically.

- **Customisable Configuration**:
  - Allows you to specify optional permissions based on your organisational needs.
  - Provides flexibility to adapt the configuration to specific requirements.

- **Purely a Template**:
  - This configuration may not be **best practice** and is intended only as a starting point or example.
  - Organisations are encouraged to adapt and enhance the configuration to meet their security and operational standards.

---

## Important Notes

- **Manual Steps Available**:
  If you prefer not to use IaC to create the application registration, detailed manual setup instructions are provided in the [Prem2Cloud Azure Connection Documentation](https://prem2cloud.co.uk/docs/azure-connection).

- **Client Secret Optional**:
  The included resource for generating a client secret is entirely optional. It is provided for organisations that want to create secrets programmatically and store them securely. Alternatively, you can generate the client secret manually through the Azure portal.

---

## Configuration Overview

This Terraform configuration file includes the following components:

1. **Application Registration**: Creates a new application registration in Azure AD.
2. **API Permissions**: Grants required Microsoft Graph permissions, including:
   - `User.Read.All`
   - `Device.ReadWrite.All`
   - `DeviceManagementManagedDevices.ReadWrite.All`
   - `DeviceManagementServiceConfig.ReadWrite.All`
   - Optional permissions such as `GroupMember.ReadWrite.All` and `Mail.Send`.
3. **Optional Client Secret**: An optional resource to generate a client secret programmatically. If used, the secret should be securely stored by the organisation.

---

## Setup Instructions

1. **Prepare Your Environment**:
   - Install Terraform: [Terraform Docs](https://developer.hashicorp.com/terraform/tutorials).
   - Ensure you have the necessary Azure permissions to create application registrations and grant API permissions.

2. **Download the Example Configuration**:
   Clone this repository or download the `app-registration.tf` file from this folder.

3. **Customize Resource**:
   - Open the Terraform file and update the resource paramaters, such as:
     - `application_name`: The name of your app registration (e.g., "Prem2Cloud").
     - `optional_permissions`: Include optional permissions like `GroupMember.ReadWrite.All` or `Mail.Send` if needed.

4. **Decide on Client Secret Management**:
   - If you wish to generate a client secret using Terraform, you may make use of the optional resource.
   - If you prefer to create the client secret manually, remove the optional resource and follow the manual steps in the [Prem2Cloud Azure Connection Documentation](https://prem2cloud.co.uk/docs/azure-connection).

5. **Apply the Configuration**:
   - Initialize Terraform:
     ```bash
     terraform init
     ```
   - Review the plan:
     ```bash
     terraform plan
     ```
   - Apply the changes:
     ```bash
     terraform apply
     ```

6. **Record Key Details**:
   After applying the configuration, Terraform will output the following:
   - **Tenant ID**
   - **Client ID**
   - **Client Secret** (if generated). This will not be displayed in the console. Instead it will be saved in your terraform state and/or secure location if defined.

7. **Configure Prem2Cloud Portal**:
   - Log in to the Prem2Cloud Portal as an administrator.
   - Navigate to **Settings > Azure Connection** and enter:
     - Tenant ID
     - Client ID
     - Client Secret
   - Select permissions that have been granted (mandatory permissions are pre-selected; optional permissions can be added).

---

## Example Use Cases

- **IaC Application Registration**: Use this configuration to create and manage Azure Application Registrations programmatically.
- **Custom Permissions**: Tailor permissions to align with your organisation’s security policies.
- **Optional Secret Management**: Choose whether to create and manage client secrets via Terraform or manually.

---

## Documentation

For detailed instructions on setting up Azure access for Prem2Cloud, visit:
**[Prem2Cloud Azure Connection Documentation](https://prem2cloud.co.uk/docs/azure-connection)**

---

## Contributions

We welcome contributions to enhance this configuration or add new functionality. Feel free to submit a pull request or open an issue with your suggestions.

---

## License

This configuration is licensed under the **MIT License**, allowing you to use, modify, and distribute it freely. For details, see the [LICENSE](../LICENSE) file.

---

<p align="center">For support or questions, reach out via our website: <a href="https://prem2cloud.co.uk">Prem2Cloud</a></p>
