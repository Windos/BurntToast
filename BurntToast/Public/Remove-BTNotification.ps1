function Remove-BTNotification {
    <#
        .SYNOPSIS
        Removes toast notifications from the Action Center.

        .DESCRIPTION
        The Remove-BTNotification function removes toast notifications from the Action Center.

        If no parameters are specified, all toasts (for the default AppId) will be removed.

        Tags and Groups for Toasts can be found using the Get-BTHistory function.

        .INPUTS
        LOTS

        .OUTPUTS
        NONE

        .EXAMPLE
        Remove-BTNotification

        .EXAMPLE
        Remove-BTNotification -Tag 'UniqueIdentifier'

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/Remove-BTNotification.md
    #>

    [CmdletBinding(DefaultParameterSetName = 'Individual',
                   SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/Remove-BTNotification.md')]
    param (
        # Specifies the AppId of the 'application' or process that spawned the toast notification.
        [string] $AppId = $Script:Config.AppId,

        # Specifies the tag, which identifies a given toast notification.
        [Parameter(ParameterSetName = 'Individual')]
        [string] $Tag,

        # Specifies the group, which helps to identify a given toast notification.
        [Parameter(ParameterSetName = 'Individual')]
        [string] $Group,

        # A string that uniquely identifies a toast notification. Represents both the Tag and Group for a toast.
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Combo')]
        [string] $UniqueIdentifier
    )

    if ($UniqueIdentifier) {
        if($PSCmdlet.ShouldProcess("Tag: $UniqueIdentifier, Group: $UniqueIdentifier, AppId: $AppId", 'Selectively removing notifications')) {
            [Windows.UI.Notifications.ToastNotificationManager]::History.Remove($UniqueIdentifier, $UniqueIdentifier, $AppId)
        }
    } elseif (!(Test-Path -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\$AppId")) {
        Write-Warning -Message "The AppId $AppId is not present in the registry, please run New-BTAppId to avoid inconsistent Toast behaviour."
    }

    if ($Tag -and $Group) {
        if($PSCmdlet.ShouldProcess("Tag: $Tag, Group: $Group, AppId: $AppId", 'Selectively removing notifications')) {
            [Windows.UI.Notifications.ToastNotificationManager]::History.Remove($Tag, $Group, $AppId)
        }
    } elseif ($Tag) {
        if($PSCmdlet.ShouldProcess("Tag: $Tag, AppId: $AppId", 'Selectively removing notifications')) {
            [Windows.UI.Notifications.ToastNotificationManager]::History.Remove($Tag, $AppId)
        }
    } elseif ($Group) {
        if($PSCmdlet.ShouldProcess("Group: $Group, AppId: $AppId", 'Selectively removing notifications')) {
            [Windows.UI.Notifications.ToastNotificationManager]::History.RemoveGroup($Group, $AppId)
        }
    } else {
        if($PSCmdlet.ShouldProcess("AppId: $AppId", 'Clearing all notifications')) {
            [Windows.UI.Notifications.ToastNotificationManager]::History.Clear($AppId)
        }
    }
}
