@{
    RootModule        = 'BurntToast.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = '751a2aeb-a68f-422e-a2ea-376bdd81612a'
    Author            = 'Joshua (Windos) King'
    CompanyName       = 'king.geek.nz'
    Copyright         = '(c) 2015 Joshua (Windos) King. All rights reserved.'
    Description       = 'Module for creating and displaying Toast Notifications on Microsoft Windows 10, Windows Server 2019, and newer.
IMPORTANT: The usage of this module changes substantially with Version 1.0.0, and is not compatible with previous versions.'
    PowerShellVersion = '5.0'
    FunctionsToExport = 'Add-BTAppLogo',
                        'Add-BTHeroImage',
                        'Add-BTImage',
                        'Add-BTInputTextBox',
                        'Add-BTText',
                        'New-BTContentBuilder',
                        'Show-BTNotification'
    CmdletsToExport   = @()
    AliasesToExport   = @('Builder')
    PrivateData       = @{
        PSData = @{
            Tags         = @('Notifications', 'Utilities', 'Windows10', 'Toast')
            Prerelease   = 'Preview1'
            LicenseUri   = 'https://github.com/Windos/BurntToast/blob/main/LICENSE'
            ProjectUri   = 'https://github.com/Windos/BurntToast'
            IconUri      = 'https://raw.githubusercontent.com/Windos/BurntToast/main/Media/BurntToast-Logo.png'
            ReleaseNotes = '## [v1.0.0-Preview2](https://github.com/Windos/BurntToast/releases/download/v1.0.0-Preview2/BurntToast.zip)

### Features

- Added Attribution switch to Add-BTText, allowing addition of attribution text to a toast notification.

- Added Add-BTInputTextBox function, allowing addition of text boxes.

### Improvements

- Ensure all invalid characters are removed from potential file system paths when caching images (thanks @markekraus)

### Libraries

- Microsoft.Windows.SDK.NET.Ref libraries bumped to 10.0.22621.26

## [v1.0.0-Preview1](https://github.com/Windos/BurntToast/releases/download/v1.0.0-Preview1/BurntToast.zip)

### Breaking Changes

- Began rewriting module making use of Toast Content Builder objects. Available functions in Preview1 include:

    - Add-BTAppLogo

    - Add-BTHeroImage

    - Add-BTImage

    - Add-BTText

    - New-BTContentBuilder

    - Show-BTNotification

### Libraries

- Microsoft.Windows.SDK.NET.Ref libraries bumped to 10.0.22000.22

- Microsoft.Toolkit.Uwp.Notifications library bumped to 7.1.2
'
        }
    }
}
