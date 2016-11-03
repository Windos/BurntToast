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
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.AdaptiveImage], ParameterSetName = 'Image')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastGenericAppLogo], ParameterSetName = 'AppLogo')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastGenericHeroImage], ParameterSetName = 'Hero')]

    param
    (
        [Parameter()]
        [string] $Source = $Script:DefaultImage,

        [Parameter()]
        [string] $AlternateText,

        [Parameter(Mandatory,
                   ParameterSetName = 'AppLogo')]
        [switch] $AppLogoOverride,

        [Parameter(Mandatory,
                   ParameterSetName = 'Hero')]
        [switch] $HeroImage,
        
        [Parameter(ParameterSetName = 'Image')]
        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveImageAlign] $Align,
        
        [Parameter(ParameterSetName = 'Image')]
        [Parameter(ParameterSetName = 'AppLogo')]
        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveImageCrop] $Crop,

        [Parameter(ParameterSetName = 'Image')]
        [switch] $RemoveMargin,

        [Parameter()]
        [switch] $AddImageQuery
    )

    switch ($PsCmdlet.ParameterSetName)
    {
        'Image'
        {
            $Image = [Microsoft.Toolkit.Uwp.Notifications.AdaptiveImage]::new()

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
            $Image = [Microsoft.Toolkit.Uwp.Notifications.ToastGenericAppLogo]::new()

            if ($Crop)
            {
                $Image.HintCrop = $Crop
            }
        }
        'Hero'
        {
            $Image = [Microsoft.Toolkit.Uwp.Notifications.ToastGenericHeroImage]::new()
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
