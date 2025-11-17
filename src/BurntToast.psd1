@{
    RootModule = 'BurntToast.dll'
    ModuleVersion = '2.0.0'
    GUID = '751a2aeb-a68f-422e-a2ea-376bdd81612a'
    Author            = 'Joshua (Windos) King'
    CompanyName       = 'king.geek.nz'
    Copyright         = '(c) 2015 Joshua (Windos) King. All rights reserved.'
    Description       = 'Module for creating and displaying Toast Notifications on Microsoft Windows 10.'
    CompatiblePSEditions = @(
        'Core'
    )
    PowerShellVersion = '7.4'
    CmdletsToExport = @(
        'Send-BurntToast',
        'Get-BurntToastConfig',
        'Set-BurntToastConfig',
        'Reset-BurntToastConfig'
    )
    FunctionsToExport = @()
    VariablesToExport = @()
    AliasesToExport   = @('Toast')
    PrivateData       = @{
        PSData = @{
            Tags         = @('Notifications', 'Utilities', 'Windows10', 'Toast')
            LicenseUri   = 'https://github.com/Windos/BurntToast/blob/main/LICENSE'
            ProjectUri   = 'https://github.com/Windos/BurntToast'
            IconUri      = 'https://rawcdn.githack.com/Windos/BurntToast/3dd8dd7457552056da4bbd27880f8283e1116395/Media/BurntToast-Logo.png'
            ReleaseNotes = '# 1.1.0

* Breaking Changes
  * Placeholder
'
        }
    }
}
