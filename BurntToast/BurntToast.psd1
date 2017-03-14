@{
    RootModule = 'BurntToast.psm1'
    ModuleVersion = '0.5.2'
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
                        'New-BTImage',
                        'New-BTInput',
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
* Fixed module commands not auto-loading by removing Basic/Advanced function designation ( :( ).
* Exposed ability to have custom buttons via New-BurntToastNotification, passing result from New-BTButton to the -Button parameter.
* Help created for New-BTButton, and the function has had a pass to ensure it works as per the community toolkit.
* Help completed for New-BurntToastNotification, and Toast alias now exporting correctly.
'
        }
    }
}
