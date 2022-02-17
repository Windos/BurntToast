function New-BTAction {
    <#
        .SYNOPSIS
        Creates an action object for a Toast Notification.

        .DESCRIPTION
        The New-BTAction function creates an 'action' object which contains defines the controls displayed at the bottom of a Toast Notification.

        Actions can either be system handeled and automatically localized Snooze and Dismiss buttons or a custom collection of inputs.

        .INPUTS
        None
            You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.IToastActions

        .EXAMPLE
        New-BTAction -SnoozeAndDismiss

        This command creates an action element using the system handled snooze and dismiss modal.

        .EXAMPLE
        New-BTAction -Buttons (New-BTButton -Content 'Google' -Arguments 'https://google.com')

        This command creates an action element with a single clickable button.

        .EXAMPLE
        $Button = New-BTButton -Content 'Google' -Arguments 'https://google.com'
        $ContextMenuItem = New-BTContextMenuItem -Content 'Bing' -Arguments 'https://bing.com'
        New-BTAction -Buttons $Button -ContextMenuItems $ContextMenuItem

        This example creates an action elemnt with both a clickable button and a right click context menu item.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTAction.md
    #>

    [CmdletBinding(DefaultParametersetName = 'Custom Actions',
                   SupportsShouldProcess   = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTAction.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.IToastActions])]
    param (
        # Button objects created with the New-BTButton function. Up to five can be included, or less if Context Menu Items are also included.
        [ValidateCount(0, 5)]
        [Parameter(ParameterSetName = 'Custom Actions')]
        [Microsoft.Toolkit.Uwp.Notifications.IToastButton[]] $Buttons,

        # Right click context menu item objects created with the New-BTContextMenuItem function. Up to five can be included, or less if Buttons are also included.
        [ValidateCount(0, 5)]
        [Parameter(ParameterSetName = 'Custom Actions')]
        [Microsoft.Toolkit.Uwp.Notifications.ToastContextMenuItem[]] $ContextMenuItems,

        # Input objects created via the New-BTText and New-BTSelectionBoxItem functions. Up to five can be included.
        [ValidateCount(0, 5)]
        [Parameter(ParameterSetName = 'Custom Actions')]
        [Microsoft.Toolkit.Uwp.Notifications.IToastInput[]] $Inputs,

        # Creates a system handeled snooze and dismiss action. Cannot be included inconjunction with custom actions.
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
