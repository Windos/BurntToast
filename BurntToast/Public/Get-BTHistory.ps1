function Get-BTHistory {
    <#
        .SYNOPSIS
        TODO

        .DESCRIPTION
        TODO

        .INPUTS
        TODO

        .OUTPUTS
        TODO

        .EXAMPLE
        TODO

        .LINK
        https://github.com/Windos/BurntToast/blob/master/Help/Get-BTHistory.md
    #>

    param (
        # Specifies the AppId of the 'application' or process that spawned the toast notification.
        [string] $AppId = $Script:Config.AppId
    )

    if (!(Test-Path -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\$AppId")) {
        throw "The AppId $AppId is not present in the registry, please run New-BTAppId to avoid inconsistent Toast behaviour."
    } else {
        [Windows.UI.Notifications.ToastNotificationManager]::History.GetHistory($AppId)
    }
}
