using namespace Microsoft.Toolkit.Uwp.Notifications

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
    [OutputType([ToastContextMenuItem])]

    param
    (
        [Parameter(Mandatory)]
        [string] $Content,
        
        [Parameter(Mandatory)]
        [string] $Arguments,

        [Parameter()]
        [ToastActivationType] $ActivationType
    )

    $MenuItem = [ToastContextMenuItem]::new($Content, $Arguments)
    
    if ($ActivationType)
    {
        $MenuItem.ActivationType = $ActivationType
    }

    $MenuItem
}
