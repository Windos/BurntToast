﻿function New-BTAppId {
    <#
        .SYNOPSIS
        Creates a new AppId Registry Key.

        .DESCRIPTION
        The New-BTAppId function create a new AppId registry key in the Current User's Registery Hive. If the desired AppId is already present in the Registry then no changes are made.

        If no AppId is specified then the AppId specified in the config.json file in the BurntToast module's root directory is used.

        .INPUTS
        System.String

        You cannot pipe input to this cmdlet.

        .OUTPUTS
        None

        .EXAMPLE
        New-BTAppId

        This command creates an AppId registry key using the value specified in the BurntToast module's config.json file, which is 'BurntToast' by default.

        .EXAMPLE
        New-BTAppId -AppId 'Script Checker'

        This command create an AppId registry key called 'Script Checker.'

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTAppId.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTAppId.md')]
    param (
        # Specifies the new AppId. You can use any alphanumeric characters.
        #
        # Defaults to the AppId specified in the config.json file in the BurntToast module's root directoy if not provided.
        [ValidateNotNullOrEmpty()]
        [string] $AppId = $Script:Config.AppId
    )

    $RegPath = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings'

    $BaseKey =  (Get-Item HKCU:\).OpenSubKey($RegPath, $true)

    if($PSCmdlet.ShouldProcess("creating: '$RegPath\$AppId' with property 'ShowInActionCenter' set to '1' (DWORD)")) {
        $NewKey = $BaseKey.CreateSubKey($AppId, $true)
        $NewKey.SetValue('ShowInActionCenter', 1, [Microsoft.Win32.RegistryValueKind]::DWORD)
    }
}