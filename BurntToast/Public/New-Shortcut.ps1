function New-Shortcut {
        <#
        .SYNOPSIS
        Creates a new StartMenu shortcut and returns the newly created AppId.

        .DESCRIPTION
        The New-Shortcut function creates a new StartMenu shortcut and returns the newly created AppId.

        .INPUTS
        System.String

        You cannot pipe input to this cmdlet.

        .OUTPUTS
        AppId

        .EXAMPLE
        New-Shortcut -AppName 'BurntToast' -ShortcutTarget 'C:\Program Files\BurntToast\BurntToast.png' -IconPath 'C:\Program Files\BurntToast\BurntToast.png'

        This command creates a new shortcut to the BurntToast installer example 

        .LINK
        
    #>

    Param (
        [ValidateNotNullOrEmpty()]
        [String]$AppName,
        [String]$ShortcutTarget,
        [String]$IconPath
    )

    # Set up
    $wshShell = New-Object -comObject WScript.Shell
    $shortcutPath = $wshShell.SpecialFolders("StartMenu") + "\" + $AppName + ".lnk"

    # Create New Shortcut
    $newShortcut = $wshShell.CreateShortcut($shortcutPath)
    $newShortcut.TargetPath = $ShortcutTarget
    $newShortcut.IconLocation = $IconPath
    $newShortcut.Description = $AppName
    $newShortcut.WorkingDirectory =  Split-Path($ShortcutTarget)
    $newShortcut.Save()

    # Cleanup COM objects
    Remove-COM $WshShell

    # Collect AppID for the new shortcut we madeS
    $appID = $(Get-StartApps -Name $AppName).AppID

    # Forward slash is required for registry keys
    New-BTAppId -AppId $appID.replace("\","/")

    Return $appID
}



function Remove-COM ($ref) {
    [System.Runtime.InteropServices.Marshal]::ReleaseComObject([System.__ComObject]$ref) | out-null
    [System.GC]::Collect()
    [System.GC]::WaitForPendingFinalizers()
}
