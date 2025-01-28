// -- Create the Azure AD application for Prem2Cloud.
resource "azuread_application" "prem2cloud" {
  display_name          = "Prem2Cloud"
  description           = "Prem2Cloud is a cloud-based solution that helps organisations migrate their on-premises device management to the cloud."
  marketing_url         = "https://prem2cloud.co.uk/"
  support_url           = "https://prem2cloud.co.uk/support"
  terms_of_service_url  = "https://prem2cloud.co.uk/terms-of-service"
  privacy_statement_url = "https://prem2cloud.co.uk/privacy-policy"
  logo_image            = filebase64("./logo.bmp")
  sign_in_audience      = "AzureADMyOrg"

  // -- API Permissions
  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000"

    // -- User.Read.All
    resource_access {
      id   = "df021288-bdef-4463-88db-98f22de89214"
      type = "Role"
    }

    // -- Device.ReadWrite.All
    resource_access {
      id   = "1138cb37-bd11-4084-a2b7-9f71582aeddb"
      type = "Role"
    }

    // -- DeviceManagementManagedDevices.ReadWrite.All
    resource_access {
      id   = "243333ab-4d21-40cb-a475-36241daa0842"
      type = "Role"
    }

    // -- DeviceManagementServiceConfig.ReadWrite.All
    resource_access {
      id   = "5ac13192-7ace-4fcf-b828-1a26f28068ee"
      type = "Role"
    }

    // -- GroupMember.ReadWrite.All (Optional)
    resource_access {
      id   = "dbaae8cf-10b5-4b86-a4a1-f871c94c6695"
      type = "Role"
    }

    // -- Mail.Send (Optional)
    resource_access {
      id   = "b633e1c5-b582-4048-a93e-9f11b44c7e96"
      type = "Role"
    }
  }
}

// -- Optional: Create a client secret for Prem2Cloud.
resource "azuread_application_password" "prem2cloud" {
  application_id = azuread_application.prem2cloud.id
  display_name   = "Prem2Cloud Client Secret"
  start_date     = "set_a_start_date_here"
  end_date       = "set_an_end_date_here"
}
