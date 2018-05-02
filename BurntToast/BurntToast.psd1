@{
    RootModule = 'BurntToast.psm1'
    ModuleVersion = '0.6.2'
    # Can only use CompatiblePSEditions if PowerShellVersion is set to 5.1, not sure about limiting this to that version yet.
    # CompatiblePSEditions = @('Desktop')
    GUID = '751a2aeb-a68f-422e-a2ea-376bdd81612a'
    Author = 'Joshua (Windos) King'
    CompanyName = 'king.geek.nz'
    Copyright = '(c) 2015 Joshua (Windos) King. All rights reserved.'
    Description = 'Module for creating and displaying Toast Notifications on Microsoft Windows 10.'
    PowerShellVersion = '5.0'
    FunctionsToExport = 'New-BTAction',
                        'New-BTAppId',
                        'New-BTAudio',
                        'New-BTBinding',
                        'New-BTButton',
                        'New-BTContent',
                        'New-BTContextMenuItem',
                        'New-BTHeader',
                        'New-BTImage',
                        'New-BTInput',
                        'New-BTProgressBar',
                        'New-BTSelectionBoxItem',
                        'New-BTText',
                        'New-BTVisual',
                        'New-BurntToastNotification',
                        'Submit-BTNotification'
    CmdletsToExport = @()
    AliasesToExport = @('Toast')
    PrivateData = @{
        PSData = @{
            Tags = @('Notifications', 'Utilities', 'Windows10', 'Toast')
            LicenseUri = 'https://github.com/Windos/BurntToast/blob/master/LICENSE'
            ProjectUri = 'https://github.com/Windos/BurntToast'
            IconUri = 'https://cdn.rawgit.com/Windos/BurntToast/master/Media/BurntToast-Logo.png'
            ReleaseNotes = '
* 
'
        }
    }
}
