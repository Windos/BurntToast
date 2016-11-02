using namespace Microsoft.Toolkit.Uwp.Notifications

function New-BTImage
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
    [OutputType([AdaptiveImage])]
    param
    (
        [Parameter()]
        [string] $Source,

        [Parameter()]
        [string] $AlternateText,

        [Parameter()]
        [AdaptiveImageAlign] $Align,
        
        [Parameter()]
        [AdaptiveImageCrop] $Crop,

        [Parameter()]
        [switch] $RemoveMargin
    )

    $Image = [AdaptiveImage]::new()
    
    if ($Source)
    {
        $Image.Source = $Source
    }

    if ($AlternateText)
    {
        $Image.AlternateText = $AlternateText
    }

    if ($Align)
    {
        $Image.HintAlign = $Align
    }

    if ($Crop)
    {
        $Image.HintCrop = $Crop
    }

    $Image.HintRemoveMargin = $RemoveMargin

    $Image
}
