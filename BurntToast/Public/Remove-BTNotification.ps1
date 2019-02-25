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
        [Parameter(ParameterSetName = 'All')]
        [string] $AppId = $Script:Config.AppId,

        [Parameter(ParameterSetName = 'Targeted')]
        [string] $Tag,

        [Parameter(ParameterSetName = 'Targeted')]
        [string] $Group,

        [Parameter(ParameterSetName = 'All',
                   Mandatory)]
        [switch] $All
    )

    if (!(Test-Path -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\$AppId")) {
        Write-Warning -Message "The AppId $AppId is not present in the registry, please run New-BTAppId to avoid inconsistent Toast behaviour."
    }

    if ($All.IsPresent) {
        [Windows.UI.Notifications.ToastNotificationManager]::History.Clear($AppId)
    } elseif ($Tag -and $Group) {
        [Windows.UI.Notifications.ToastNotificationManager]::History.Remove($Tag, $Group)
    } elseif ($Tag) {
        [Windows.UI.Notifications.ToastNotificationManager]::History.Remove($Tag)
    } elseif ($Group) {
        [Windows.UI.Notifications.ToastNotificationManager]::History.RemoveGroup($Group)
    }
}
