function Get-BTHistory {
    <#
        .SYNOPSIS
        Shows all toast notifications in the Action Center or scheduled notifications.

        .DESCRIPTION
        The Get-BTHistory function returns all toast notifications that are in the Action Center and have not been dismissed by the user.
        You can retrieve a specific toast notification with a unique identifier, or include scheduled notifications (either scheduled outright or snoozed).
        The objects returned include tag and group information which can be used with Remove-BTNotification to remove specific notifications.

        .PARAMETER UniqueIdentifier
        Returns only toasts with a matching tag or group specified by the provided unique identifier (string).

        .PARAMETER ScheduledToast
        Switch. If provided, returns scheduled toast notifications instead of those currently in the Action Center.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastNotification
        Microsoft.Toolkit.Uwp.Notifications.ScheduledToastNotification

        .EXAMPLE
        Get-BTHistory
        Returns all toast notifications in the Action Center.

        .EXAMPLE
        Get-BTHistory -ScheduledToast
        Returns scheduled toast notifications.

        .EXAMPLE
        Get-BTHistory -UniqueIdentifier 'Toast001'
        Returns toasts with the matching unique identifier in their tag or group.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/Get-BTHistory.md
    #>

    [cmdletBinding(HelpUri='https://github.com/Windos/BurntToast/blob/main/Help/Get-BTHistory.md')]
    param (
        [string] $UniqueIdentifier,

        [switch] $ScheduledToast
    )

    if ($Script:ActionsSupported) {
        Write-Warning -Message 'The output from this function in some versions of PowerShell is not useful. Unfortunately this is expected at this time.'
    }

    $Toasts = if ($ScheduledToast) {
        [Microsoft.Toolkit.Uwp.Notifications.ToastNotificationManagerCompat]::CreateToastNotifier().GetScheduledToastNotifications()
    } else {
        [Microsoft.Toolkit.Uwp.Notifications.ToastNotificationManagerCompat]::History.GetHistory()
    }

    if ($UniqueIdentifier) {
        $Toasts | Where-Object {$_.Tag -eq $UniqueIdentifier -or $_.Group -eq $UniqueIdentifier}
    } else {
        $Toasts
    }
}
