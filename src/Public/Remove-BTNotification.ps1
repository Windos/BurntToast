function Remove-BTNotification {
    <#
        .SYNOPSIS
        Removes toast notifications from the Action Center.

        .DESCRIPTION
        The Remove-BTNotification function removes toast notifications from the Action Center.

        If no parameters are specified, all toasts (for the current application) will be removed.

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
        if($PSCmdlet.ShouldProcess("Tag: $UniqueIdentifier, Group: $UniqueIdentifier", 'Selectively removing notifications')) {
            [Microsoft.Toolkit.Uwp.Notifications.ToastNotificationManagerCompat]::History.Remove($UniqueIdentifier, $UniqueIdentifier)
        }
    }

    if ($Tag -and $Group) {
        if($PSCmdlet.ShouldProcess("Tag: $Tag, Group: $Group", 'Selectively removing notifications')) {
            [Microsoft.Toolkit.Uwp.Notifications.ToastNotificationManagerCompat]::History.Remove($Tag, $Group)
        }
    } elseif ($Tag) {
        if($PSCmdlet.ShouldProcess("Tag: $Tag", 'Selectively removing notifications')) {
            [Microsoft.Toolkit.Uwp.Notifications.ToastNotificationManagerCompat]::History.Remove($Tag)
        }
    } elseif ($Group) {
        if($PSCmdlet.ShouldProcess("Group: $Group", 'Selectively removing notifications')) {
            [Microsoft.Toolkit.Uwp.Notifications.ToastNotificationManagerCompat]::History.RemoveGroup($Group)
        }
    } else {
        if($PSCmdlet.ShouldProcess("All", 'Clearing all notifications')) {
            [Microsoft.Toolkit.Uwp.Notifications.ToastNotificationManagerCompat]::History.Clear()
        }
    }
}
