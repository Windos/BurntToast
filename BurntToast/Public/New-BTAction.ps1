function New-BTAction
{
    <#
        .SYNOPSIS

        .DESCRIPTION

        .INPUTS
        None

        .OUTPUTS
        Image
        
        .EXAMPLE

        .EXAMPLE

        .EXAMPLE

        .LINK
        https://github.com/Windos/BurntToast
    #>

    [CmdletBinding()]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.IToastActions])]
    param
    (
        [Parameter()]
        [Microsoft.Toolkit.Uwp.Notifications.IToastButton[]] $Buttons,

        [Microsoft.Toolkit.Uwp.Notifications.ToastContextMenuItem[]] $ContextMenuItems,

        [Microsoft.Toolkit.Uwp.Notifications.IToastInput[]] $Inputs,

        [switch] $SnoozeAndDismiss
    )

    if ($SnoozeAndDismiss)
    {
        $ToastActions = [Microsoft.Toolkit.Uwp.Notifications.ToastActionsSnoozeAndDismiss]::new()
    }
    else
    {
        $ToastActions = [Microsoft.Toolkit.Uwp.Notifications.ToastActionsCustom]::new()

        if ($Buttons)
        {
            foreach ($Button in $Buttons)
            {
                $ToastActions.Buttons.Add($Button)
            }
        }

        if ($ContextMenuItems)
        {
            foreach ($ContextMenuItem in $ContextMenuItems)
            {
                $ToastActions.ContextMenuItems.Add($ContextMenuItem)
            }
        }

        if ($Inputs)
        {
            foreach ($Input in $Inputs)
            {
                $ToastActions.Inputs.Add($Input)
            }
        }
    }

    $ToastActions
}
