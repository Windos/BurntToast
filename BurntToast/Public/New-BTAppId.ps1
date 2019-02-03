function New-BTAppId {
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
        https://github.com/Windos/BurntToast/blob/master/Help/New-BTAppId.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true)]
    param (
        # Specifies the new AppId. You can use any alphanumeric characters.
        #
        # Defaults to the AppId specified in the config.json file in the BurntToast module's root directoy if not provided.
        [ValidateNotNullOrEmpty()]
        [string] $AppId = $Script:Config.AppId,

        # For testing only, a workaround for an issue with Pester Mocking.
        [switch] $DryFire
    )

    $RegPath = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings'

    if (!(Test-Path -Path "$RegPath\$AppId") -or $DryFire) {
        if($PSCmdlet.ShouldProcess("creating: '$RegPath\$AppId' with property 'ShowInActionCenter' set to '1' (DWORD)")) {
            $null = New-Item -Path "$RegPath\$AppId" -Force
            $null = New-ItemProperty -Path "$RegPath\$AppId" -Name 'ShowInActionCenter' -Value 1 -PropertyType 'DWORD'
        }
    } else {
        Write-Verbose -Message 'Specified AppId is already present in the registry.'
    }
}
