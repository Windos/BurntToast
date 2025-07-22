function Remove-BTNotification {
    <#
        .SYNOPSIS
        Removes toast notifications from the Action Center.

        .DESCRIPTION
        The Remove-BTNotification function removes toast notifications for the current application from the Action Center.
        If no parameters are specified, all toast notifications for this app are removed.
        Specify Tag and/or Group to remove specific notifications. Use UniqueIdentifier to remove notifications matching both tag and group.

        .PARAMETER Tag
        The tag of the toast notification(s) to remove (String).

        .PARAMETER Group
        The group (category) of the toast notification(s) to remove (String).

        .PARAMETER UniqueIdentifier
        Used to specify both the Tag and Group and remove a uniquely identified toast.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        None.

        .EXAMPLE
        Remove-BTNotification
        Removes all toast notifications for the calling application.

        .EXAMPLE
        Remove-BTNotification -Tag 'Toast001'
        Removes the toast notification with tag 'Toast001'.

        .EXAMPLE
        Remove-BTNotification -Group 'Updates'
        Removes all toast notifications in the group 'Updates'.

        .EXAMPLE
        Remove-BTNotification -UniqueIdentifier 'Toast001'
        Removes the toast notification with both tag and group set to 'Toast001'.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/Remove-BTNotification.md
    #>

    [CmdletBinding(DefaultParameterSetName = 'Individual',
                   SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/Remove-BTNotification.md')]
    param (
        [Parameter(ParameterSetName = 'Individual')]
        [string] $Tag,

        [Parameter(ParameterSetName = 'Individual')]
        [string] $Group,

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
