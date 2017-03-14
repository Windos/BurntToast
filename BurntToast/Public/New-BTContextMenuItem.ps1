function New-BTContextMenuItem
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
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastContextMenuItem])]

    param
    (
        [Parameter(Mandatory)]
        [string] $Content,
        
        [Parameter(Mandatory)]
        [string] $Arguments,

        [Parameter()]
        [Microsoft.Toolkit.Uwp.Notifications.ToastActivationType] $ActivationType
    )

    $MenuItem = [Microsoft.Toolkit.Uwp.Notifications.ToastContextMenuItem]::new($Content, $Arguments)
    
    if ($ActivationType)
    {
        $MenuItem.ActivationType = $ActivationType
    }

    $MenuItem
}
