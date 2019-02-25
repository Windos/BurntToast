function Remove-BTNotification {
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
        https://github.com/Windos/BurntToast/blob/master/Help/Remove-BTNotification.md
    #>

    param (
        # Specifies the AppId of the 'application' or process that spawned the toast notification.
        [string] $AppId = $Script:Config.AppId,

        [string] $Tag,

        [string] $Group
    )

    if (!(Test-Path -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\$AppId")) {
        Write-Warning -Message "The AppId $AppId is not present in the registry, please run New-BTAppId to avoid inconsistent Toast behaviour."
    }

    if ($Tag -and $Group) {
        [Windows.UI.Notifications.ToastNotificationManager]::History.Remove($Tag, $Group, $AppId)
    } elseif ($Tag) {
        [Windows.UI.Notifications.ToastNotificationManager]::History.Remove($Tag, $AppId)
    } elseif ($Group) {
        [Windows.UI.Notifications.ToastNotificationManager]::History.RemoveGroup($Group, $AppId)
    } else {
        [Windows.UI.Notifications.ToastNotificationManager]::History.Clear($AppId)
    }
}
