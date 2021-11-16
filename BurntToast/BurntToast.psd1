@{
    RootModule        = 'BurntToast.psm1'
    ModuleVersion     = '0.8.5'
    # Can only use CompatiblePSEditions if PowerShellVersion is set to 5.1, not sure about limiting this to that version yet.
    # CompatiblePSEditions = @('Desktop')
    GUID              = '751a2aeb-a68f-422e-a2ea-376bdd81612a'
    Author            = 'Joshua (Windos) King'
    CompanyName       = 'king.geek.nz'
    Copyright         = '(c) 2015 Joshua (Windos) King. All rights reserved.'
    Description       = 'Module for creating and displaying Toast Notifications on Microsoft Windows 10.'
    PowerShellVersion = '5.0'
    FunctionsToExport = 'Get-BTHeader',
                        'Get-BTHistory',
                        'New-BTAction',
                        'New-BTAppId',
                        'New-BTAudio',
                        'New-BTBinding',
                        'New-BTButton',
                        'New-BTColumn',
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
                        'New-BurntToastShoulderTap',
                        'New-BurntToastNotification',
                        'Remove-BTNotification',
                        'Submit-BTNotification',
                        'Update-BTNotification'
    CmdletsToExport   = @()
    AliasesToExport   = @('ShoulderTap',
                          'Toast')
    PrivateData       = @{
        PSData = @{
            Tags         = @('Notifications', 'Utilities', 'Windows10', 'Toast')
            LicenseUri   = 'https://github.com/Windos/BurntToast/blob/main/LICENSE'
            ProjectUri   = 'https://github.com/Windos/BurntToast'
            IconUri      = 'https://raw.githubusercontent.com/Windos/BurntToast/main/Media/BurntToast-Logo.png'
            ReleaseNotes = '# 0.8.5

* Actually implement the ability to use a UniqueIdentifier with the Remove-BTNotification function (which was half implemented in 0.8.4)

# 0.8.4

* Enhancement: Header ID on New-BTHeader is now optional. An ID will be auto generated if not specified (#125)
  * Thanks [@glennsarti](https://github.com/glennsarti)
* Enhancement: Hero images can now be specified using the New-BurntToastNotification function using the -HeroImage parameter (#80)
  * Thanks [@UniverseCitiz3n](https://github.com/UniverseCitiz3n)
* Enhancement: AppIDs can now be specified using the New-BurntToastNotification function using the -AppId parameter.
  * Thanks [@cedarbaum](https://github.com/cedarbaum)
* Enhancement: You can now specify a UniqueIdentifier when using the Remove-BTNotification function rather than component Tag and Group strings.
* Fix: Weird edge cases when taking text from Twitch/IRC and using them in a toast is now sorted.
  * Thanks [@potatoqualitee](https://github.com/potatoqualitee) and [@vexx32](https://github.com/vexx32)

# 0.8.3

* Fix: Error when running Update-BTNotification on PowerShell 6.0+ (#120)
* Fix: Error when using actionable toast parameters on any version (#122)
* Fix: Multiple warnings about events not being supported when specifying multiple event types.

# 0.8.2

* Add: AdaptiveGroups are now usable via New-BTColumn

# 0.8.1

* Fix: Toast alias removed in 0.8.0 has been restored
* Deprecation: Signalling removal of Shoulder Tap cmdlets in future version, v0.9.0
* Deprecation: Signalling removal of Path parameter from New-BTAudio in future version, v0.9.0. https://github.com/MicrosoftDocs/windows-uwp/issues/1593

# 0.8.0

* Fix: Images from UNC path failing (#111)
* Add: Ability to force a refresh of cached images via IgnoreCache switch on New-BTImage
* Add: ACTIONABLE NOTIFICATIONS! Exposed via ActivatedAction and DismissedAction parameters on Submit-BTNotification and New-BurntToastNotification
'
        }
    }
}
