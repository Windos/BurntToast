@{
    RootModule        = 'BurntToast.psm1'
    ModuleVersion     = '0.7.1'
    # Can only use CompatiblePSEditions if PowerShellVersion is set to 5.1, not sure about limiting this to that version yet.
    # CompatiblePSEditions = @('Desktop')
    GUID              = '751a2aeb-a68f-422e-a2ea-376bdd81612a'
    Author            = 'Joshua (Windos) King'
    CompanyName       = 'king.geek.nz'
    Copyright         = '(c) 2015 Joshua (Windos) King. All rights reserved.'
    Description       = 'Module for creating and displaying Toast Notifications on Microsoft Windows 10.'
    PowerShellVersion = '5.0'
    FunctionsToExport = 'Get-BTHistory',
                        'New-BTAction',
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
                        'New-BTShoulderTapBinding',
                        'New-BTShoulderTapImage',
                        'New-BTShoulderTapPeople',
                        'New-BTText',
                        'New-BTVisual',
                        'New-BurntToastNotification',
                        'New-BurntToastShoulderTap',
                        'Remove-BTNotification',
                        'Submit-BTNotification',
                        'Update-BTNotification'
    CmdletsToExport   = @()
    AliasesToExport   = @('ShoulderTap', 'Toast')
    PrivateData       = @{
        PSData = @{
            Tags         = @('Notifications', 'Utilities', 'Windows10', 'Toast')
            LicenseUri   = 'https://github.com/Windos/BurntToast/blob/master/LICENSE'
            ProjectUri   = 'https://github.com/Windos/BurntToast'
            IconUri      = 'https://raw.githubusercontent.com/Windos/BurntToast/master/Media/BurntToast-Logo.png'
            ReleaseNotes = '# 0.7.1

* Update: Microsoft Community Toolkit to 6.0.0
* New: Support relative paths on images
* New: "ScheduledToast" switch added to `Get-BTHistory` which returns scheduled or snoozed toast notifications
* Enhancement: Libraries only loaded on module import if libraries not already loaded
* Enhancement: Validate that image paths exist
* Fix: Reverted to XML clean up to remove curly braces if databindings are not being used (Issue #72)

## Known Issues

* Regardless of what snooze option is chosen, a snoozed toast will re-appear after 9 minutes
  * Cause is unknown and isn''t unique to v0.7.1, will be investigated while working on v0.7.2
'
        }
    }
}
