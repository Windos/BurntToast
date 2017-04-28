@{
    RootModule = 'BurntToast.psm1'
    ModuleVersion = '0.6.0'
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
* Updated bundled UWP Toolkit to 1.4.1
    * Note that this caused an issue where strings were being wrapped with curly braces in end results. A workaround has been implemented, but could mean that if you legitimatly use some rather obscure strings, they may have the braces removed.
* Hero Images working now (Thanks to Creators Update)
* Headers can now be included (Creators Update feature)
* Progress bars can now be included (Creators Update feature)
* Specify a unique identifier in order to replace existing toasts
* You can specify a custom sound file using the -Path parameter of the New-BTAudio function. This hasn''t been exposed through the main function... that poor thing is getting bloated.
* There is now help for every public function, and the online version for each of them can be found on github. Specify the -Online switch when using Get-Help to be taken directly there.
'
        }
    }
}
