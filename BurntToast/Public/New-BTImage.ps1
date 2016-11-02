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

    [CmdletBinding(DefaultParameterSetName = 'Image')]
    [OutputType([AdaptiveImage], ParameterSetName = 'Image')]
    [OutputType([ToastGenericAppLogo], ParameterSetName = 'AppLogo')]
    [OutputType([ToastGenericHeroImage], ParameterSetName = 'Hero')]

    param
    (
        [Parameter()]
        [string] $Source,

        [Parameter()]
        [string] $AlternateText,

        [Parameter(Mandatory,
                   ParameterSetName = 'AppLogo')]
        [switch] $AppLogoOverride,

        [Parameter(Mandatory,
                   ParameterSetName = 'Hero')]
        [switch] $HeroImage,
        
        [Parameter(ParameterSetName = 'Image')]
        [AdaptiveImageAlign] $Align,
        
        [Parameter(ParameterSetName = 'Image')]
        [Parameter(ParameterSetName = 'AppLogo')]
        [AdaptiveImageCrop] $Crop,

        [Parameter(ParameterSetName = 'Image')]
        [switch] $RemoveMargin,

        [Parameter()]
        [switch] $AddImageQuery
    )

    switch ($PsCmdlet.ParameterSetName)
    {
        'Image'
        {
            $Image = [AdaptiveImage]::new()

            if ($Align)
            {
                $Image.HintAlign = $Align
            }

            if ($Crop)
            {
                $Image.HintCrop = $Crop
            }

            $Image.HintRemoveMargin = $RemoveMargin
        }
        'AppLogo'
        {
            $Image = [ToastGenericAppLogo]::new()

            if ($Crop)
            {
                $Image.HintCrop = $Crop
            }
        }
        'Hero'
        {
            $Image = [ToastGenericHeroImage]::new()
        }
    }
    
    if ($Source)
    {
        $Image.Source = $Source
    }

    if ($AlternateText)
    {
        $Image.AlternateText = $AlternateText
    }

    if ($AddImageQuery)
    {
        $Image.AddImageQuery = $AddImageQuery
    }

    $Image
}
