using namespace Microsoft.Toolkit.Uwp.Notifications

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
    [OutputType([IToastActions])]
    param
    (
        [Parameter()]
        [IToastButton[]] $Buttons,

        [ToastContextMenuItem[]] $ContextMenuItems,

        [IToastInput[]] $Inputs,

        [switch] $SnoozeAndDismiss
    )

    if ($SnoozeAndDismiss)
    {
        $ToastActions = [ToastActionsSnoozeAndDismiss]::new()
    }
    else
    {
        $ToastActions = [ToastActionsCustom]::new()

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
