function New-BTAction {
    <#
        .SYNOPSIS
        Creates an action set for a Toast Notification.

        .DESCRIPTION
        The New-BTAction function creates a Toast action object (IToastActions), defining the controls displayed at the bottom of a Toast Notification.
        Actions can be custom (buttons, context menu items, and input controls) or system handled (Snooze and Dismiss).

        .PARAMETER Buttons
        Button objects created with New-BTButton. Up to five may be included, or fewer if context menu items are also included.

        .PARAMETER ContextMenuItems
        Right-click context menu item objects created with New-BTContextMenuItem. Up to five may be included, or fewer if Buttons are included.

        .PARAMETER Inputs
        Input objects created via New-BTText and New-BTSelectionBoxItem. Up to five can be included.

        .PARAMETER SnoozeAndDismiss
        Switch. Creates a system-handled set of Snooze and Dismiss buttons, only available in the 'SnoozeAndDismiss' parameter set. Cannot be used with custom actions.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.IToastActions

        .EXAMPLE
        New-BTAction -SnoozeAndDismiss
        Creates an action set using the system handled snooze and dismiss modal.

        .EXAMPLE
        New-BTAction -Buttons (New-BTButton -Content 'Google' -Arguments 'https://google.com')
        Creates an action set with a single button that opens Google.

        .EXAMPLE
        $Button = New-BTButton -Content 'Google' -Arguments 'https://google.com'
        $ContextMenuItem = New-BTContextMenuItem -Content 'Bing' -Arguments 'https://bing.com'
        New-BTAction -Buttons $Button -ContextMenuItems $ContextMenuItem
        Creates an action set with both a clickable button and a context menu item.

        .EXAMPLE
        New-BTAction -Inputs (New-BTText -Content "Add comment")
        Creates an action set allowing user textual input in the notification.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTAction.md
    #>

    [CmdletBinding(DefaultParametersetName = 'Custom Actions',
                   SupportsShouldProcess   = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTAction.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.IToastActions])]
    param (
        [ValidateCount(0, 5)]
        [Parameter(ParameterSetName = 'Custom Actions')]
        [Microsoft.Toolkit.Uwp.Notifications.IToastButton[]] $Buttons,

        [ValidateCount(0, 5)]
        [Parameter(ParameterSetName = 'Custom Actions')]
        [Microsoft.Toolkit.Uwp.Notifications.ToastContextMenuItem[]] $ContextMenuItems,

        [ValidateCount(0, 5)]
        [Parameter(ParameterSetName = 'Custom Actions')]
        [Microsoft.Toolkit.Uwp.Notifications.IToastInput[]] $Inputs,

        [Parameter(Mandatory,
                   ParameterSetName = 'SnoozeAndDismiss')]
        [switch] $SnoozeAndDismiss
    )

    begin {
        if (($ContextMenuItems.Length + $Buttons.Length) -gt 5) {
            throw "You have included too many buttons and context menu items. The maximum combined number of these elements is five."
        }
    }
    process {
        if ($SnoozeAndDismiss) {
            $ToastActions = [Microsoft.Toolkit.Uwp.Notifications.ToastActionsSnoozeAndDismiss]::new()
        } else {
            $ToastActions = [Microsoft.Toolkit.Uwp.Notifications.ToastActionsCustom]::new()

            if ($Buttons) {
                foreach ($Button in $Buttons) {
                    $ToastActions.Buttons.Add($Button)
                }
            }

            if ($ContextMenuItems) {
                foreach ($ContextMenuItem in $ContextMenuItems) {
                    $ToastActions.ContextMenuItems.Add($ContextMenuItem)
                }
            }

            if ($Inputs) {
                foreach ($Input in $Inputs) {
                    $ToastActions.Inputs.Add($Input)
                }
            }
        }

        if($PSCmdlet.ShouldProcess("returning: [$($ToastActions.GetType().Name)] with $($ToastActions.Inputs.Count) Inputs, $($ToastActions.Buttons.Count) Buttons, and $($ToastActions.ContextMenuItems.Count) ContextMenuItems")) {
            $ToastActions
        }
    }
}
