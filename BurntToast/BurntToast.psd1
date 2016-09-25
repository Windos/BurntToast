@{

RootModule = 'BurntToast.psm1'
ModuleVersion = '0.5.0'
CompatiblePSEditions = @('Desktop')
GUID = '751a2aeb-a68f-422e-a2ea-376bdd81612a'
Author = 'Joshua (Windos) King'
CompanyName = 'king.geek.nz'
Copyright = '(c) 2015 Joshua (Windos) King. All rights reserved.'
Description = 'Module for creating and displaying Toast Notifications on Microsoft Windows 10.'
PowerShellVersion = '5.0'
RequiredModules = @('BurntToast.Class')
FunctionsToExport = '*'
CmdletsToExport = @()
AliasesToExport = @()

PrivateData = @{

    PSData = @{

        Tags = @('Notifications', 'Utilities', 'Windows10')
        LicenseUri = 'https://github.com/Windos/BurntToast/blob/master/LICENSE'
        ProjectUri = 'https://github.com/Windos/BurntToast'
        IconUri = 'https://cdn.rawgit.com/Windos/BurntToast/master/Media/BurntToast.png'
        ReleaseNotes = '
## 0.5.0 (2016-??-??)

* Re-written from ground up, now PS Class based
* Developed for and tested on Windows 10 only
'
    }

}

}
