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
            ReleaseNotes = '# 1.0.0-Preview1

* BREAKING CHANGE: Began rewriting module making use of Toast Content Builder objects. Available functions in Preview1 include:
  * Add-BTAppLogo
  * Add-BTHeroImage
  * Add-BTImage
  * Add-BTText
  * New-BTContentBuilder
  * Show-BTNotification
* UPDATE: Microsoft.Windows.SDK.NET.Ref libraries to 10.0.22000.22
* UPDATE: Microsoft.Toolkit.Uwp.Notifications library to 7.1.2
'
        }
    }
}
