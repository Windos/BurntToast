@{

RootModule = 'BurntToast.psm1'
ModuleVersion = '0.5.0'
# Can only use CompatiblePSEditions if PowerShellVersion is set to 5.1, not sure about limiting this to that version yet.
# CompatiblePSEditions = @('Desktop')
GUID = '751a2aeb-a68f-422e-a2ea-376bdd81612a'
Author = 'Joshua (Windos) King'
CompanyName = 'king.geek.nz'
Copyright = '(c) 2015 Joshua (Windos) King. All rights reserved.'
Description = 'Module for creating and displaying Toast Notifications on Microsoft Windows 10.'
PowerShellVersion = '5.0'
FunctionsToExport = '*'
CmdletsToExport = @()
AliasesToExport = @()
PrivateData = @{
    PSData = @{
        Tags = @('Notifications', 'Utilities', 'Windows10', 'Toast')
        LicenseUri = 'https://github.com/Windos/BurntToast/blob/master/LICENSE'
        ProjectUri = 'https://github.com/Windos/BurntToast'
        IconUri = 'https://cdn.rawgit.com/Windos/BurntToast/master/Media/BurntToast.png'
        ReleaseNotes = '
Note: This has only been tested on Windows 10, version 1607. If you have any problems, please open an issue.

You can consider the a pseudo ''beta'' release, only update to this if you''re keen to try out the latest version and/or report potential issues.

* Converted to using the [UWP Community Toolkit](https://github.com/Microsoft/UWPCommunityToolkit).
* Snooze and Dismiss now available and working.
* Documentation is out of date, this will be polished in the next release.
'
    }

}

}
