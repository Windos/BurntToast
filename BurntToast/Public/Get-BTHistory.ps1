function Get-BTHistory {
    <#
        .SYNOPSIS
        Shows all toast notifications in the Action Center.

        .DESCRIPTION
        The Get-BTHistory function returns all toast notifications that are in the Action Center. Toasts that have been dismissed by the user will not be returned.

        The object returned includes tag and group information which can be used with the Remove-BTNotification function to clear specific notification from the Action Center.

        Using the ScheduledToast switch you can get all toast notifications that have been scheduled to display, whether by scheduling outright or snoozing.

        .INPUTS
        STRING

        .OUTPUTS
        ToastNotification
        ScheduledToastNotification

        .EXAMPLE
        Get-BTHistory

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/Get-BTHistory.md
    #>

    [cmdletBinding(HelpUri='https://github.com/Windos/BurntToast/blob/main/Help/Get-BTHistory.md')]
    param (
        # Specifies the AppId of the 'application' or process that spawned the toast notification.
        [string] $AppId = $Script:Config.AppId,

        # A string that uniquely identifies a toast notification. Submitting a new toast with the same identifier as a previous toast will replace the previous toast.
        #
        # This is useful when updating the progress of a process, using a progress bar, or otherwise correcting/updating the information on a toast.
        [string] $UniqueIdentifier,

        # Specified that you need to see scheduled toast notifications, rather the those in the Action Center.
        [switch] $ScheduledToast
    )

    if (!(Test-Path -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\$AppId")) {
        throw "The AppId $AppId is not present in the registry, please run New-BTAppId to avoid inconsistent Toast behaviour."
    } else {
        if ($Script:ActionsSupported) {
            Write-Warning -Message 'The output from this function in some versions of PowerShell is not useful. Unfortunately this is expected at this time.'
        }

        $Toasts = if ($ScheduledToast) {
            [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).GetScheduledToastNotifications()
        } else {
            [Windows.UI.Notifications.ToastNotificationManager]::History.GetHistory($AppId)
        }

        if ($UniqueIdentifier) {
            $Toasts | Where-Object {$_.Tag -eq $UniqueIdentifier -or $_.Group -eq $UniqueIdentifier}
        } else {
            $Toasts
        }
    }
}
