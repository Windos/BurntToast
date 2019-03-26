@{
    RootModule        = 'BurntToast.psm1'
    ModuleVersion     = '0.7.0'
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
            LicenseUri   = 'https://github.com/Windos/BurntToast/blob/master/LICENSE'
            ProjectUri   = 'https://github.com/Windos/BurntToast'
            IconUri      = 'https://raw.githubusercontent.com/Windos/BurntToast/master/Media/BurntToast-Logo.png'
            ReleaseNotes = '# 0.7.0

* You can now specify images on the network via UNC paths. Fix for #56
* We''re now properly supporting bindable text, and removing the curly braces more gracefully
* Get a list of all toasts you''ve sent, which have not been dismissed by the user, using Get-BTHistory
* Remove toasts you''ve sent, using Remove-BTNotification
* Set expiration times on toasts using the new ExpirationTime parameter on New-BurntToastNotification and Submit-BTNotification
  * Toasts which have expired are removed from the Action Center
* Send toasts directly to the Action Center, and avoid showing them on screen, with the new SuppressPopup switch on New-BurntToastNotification and Submit-BTNotification
* You can now adjust a toasts timestamp (both past and future) using the CustomTimestamp parameter on New-BurntToastNotification and New-BTContent
  * If not specified, the system uses the time at which the toast was received and this may not accuratly reflect the intent of the notification
'
        }
    }
}
