using module BurntToast.Class

function New-BTImageElement
{
    <#
        .SYNOPSIS
        Creates a new Image Element for Toast Notifications.

        .DESCRIPTION
        The New-BTImageElement cmdlet creates a new Image Element for Toast Notifications.
    
        You can use the parameters of New-BTImageElement to specify the source image, alt text, placement on the Toast Notification and crop shape.

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
    [OutputType([Image])]
    param
    (
        [Parameter(Mandatory)]
        [string] $Source,

        [Parameter()]
        [string] $Alt,

        [Parameter()]
        [ImagePlacement] $Placement,
        
        [Parameter()]
        [ImageCrop] $Crop
    )

    $Props = @($Source)

    if ($Alt)
    {
        $Props += $Alt
    }

    if ($Placement)
    {
        $Props += $Placement
    }

    if ($Crop)
    {
        $Props += $Crop
    }

    New-Object -TypeName Image -ArgumentList $Props
}
