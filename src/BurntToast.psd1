@{
    RootModule        = 'BurntToast.psm1'
    ModuleVersion     = '1.0.1'
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
                        'New-BTShortcut',
                        'New-BTText',
                        'New-BTVisual',
                        'New-BurntToastNotification',
                        'Remove-BTNotification',
                        'Submit-BTNotification',
                        'Update-BTNotification'
    CmdletsToExport   = @()
    AliasesToExport   = @('Toast')
    PrivateData       = @{
        PSData = @{
            Tags         = @('Notifications', 'Utilities', 'Windows10', 'Toast')
            LicenseUri   = 'https://github.com/Windos/BurntToast/blob/main/LICENSE'
            ProjectUri   = 'https://github.com/Windos/BurntToast'
            IconUri      = 'https://rawcdn.githack.com/Windos/BurntToast/3dd8dd7457552056da4bbd27880f8283e1116395/Media/BurntToast-Logo.png'
            ReleaseNotes = '# 1.0.1

* Bug Fixes
  * OnActivated events are "sticky"
    * See #256 by [Windos](https://github.com/Windos)

# 1.0.0

* Breaking Changes
  * Custom Audio Path Removed: Support for custom audio file sources has been eliminated.
  * AppId Customization Removed: The ability to specify a custom AppId has been removed.
  * Shoulder Tap Notifications Removed: Support for "shoulder tap" toast types is no longer available.
* Features and Improvements
  * Create and update all help files.
  * Enable "Activation" events on all supported versions of PowerShell, including Windows PowerShell.
  * Enable "Dismissed" and "Failed" events on PowerShell 7.1+.
  * Improve support for attribution text.
  * Shortcut Support: Introduced capability to create Windows shortcuts with proper AppUserModelID—enables full toast branding when launching PowerShell.
  * Event Data Improvements: Event data handling and options improved for notification actions.
* CI and Repository
  * Update Issue and Feature Request Templates.
* Libraries
  * Microsoft.Windows.SDK.NET.Ref library bumped to 10.0.22621.28.
  * Microsoft.Toolkit.Uwp.Notifications library bumped to 7.1.3.
'
        }
    }
}
