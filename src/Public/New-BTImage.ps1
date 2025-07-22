function New-BTImage {
    <#
        .SYNOPSIS
        Creates a new Image Element for Toast Notifications.

        .DESCRIPTION
        The New-BTImage function creates an image element for Toast Notifications, which can be a standard, app logo, or hero image. You can specify the image source, cropping, alt text, alignment, and additional display properties.

        .PARAMETER Source
        String. URI or file path of the image. Can be from your app, local filesystem, or the internet (must be <200KB for remote).

        .PARAMETER AlternateText
        String. Description of the image for assistive technology.

        .PARAMETER AppLogoOverride
        Switch. Marks this image as the logo, to be shown as the app logo on the toast.

        .PARAMETER HeroImage
        Switch. Marks this image as the hero image, to be prominently displayed.

        .PARAMETER Align
        Enum. Horizontal alignment (only supported within groups).

        .PARAMETER Crop
        Enum. Specifies cropping of the image (e.g., Circle for logos).

        .PARAMETER RemoveMargin
        Switch. Removes default 8px margin around the image.

        .PARAMETER AddImageQuery
        Switch. Allows Windows to append scaling/language query string to the URI.

        .PARAMETER IgnoreCache
        Switch. Forces image to be refreshed (when used with Optimize-BTImageSource).

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.AdaptiveImage
        Microsoft.Toolkit.Uwp.Notifications.ToastGenericAppLogo
        Microsoft.Toolkit.Uwp.Notifications.ToastGenericHeroImage

        .EXAMPLE
        $image1 = New-BTImage -Source 'C:\Media\BurntToast.png'
        Standard image for a toast body.

        .EXAMPLE
        $image2 = New-BTImage -Source 'C:\Media\BurntToast.png' -AppLogoOverride -Crop Circle
        Cropped circular logo for use on the toast.

        .EXAMPLE
        $image3 = New-BTImage -Source 'C:\Media\BurntToast.png' -HeroImage
        Hero image for the toast header.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTImage.md
    #>

    [CmdletBinding(DefaultParameterSetName = 'Image',
                   SupportsShouldProcess   = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTImage.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.AdaptiveImage], ParameterSetName = 'Image')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastGenericAppLogo], ParameterSetName = 'AppLogo')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastGenericHeroImage], ParameterSetName = 'Hero')]

    param (
        [string] $Source = $Script:DefaultImage,

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

        [switch] $AddImageQuery,

        [switch] $IgnoreCache
    )

    switch ($PsCmdlet.ParameterSetName) {
        'Image' {
            $Image = [Microsoft.Toolkit.Uwp.Notifications.AdaptiveImage]::new()

            if ($Align) {
                $Image.HintAlign = $Align
            }

            if ($Crop) {
                $Image.HintCrop = $Crop
            }

            $Image.HintRemoveMargin = $RemoveMargin
        }
        'AppLogo' {
            $Image = [Microsoft.Toolkit.Uwp.Notifications.ToastGenericAppLogo]::new()

            if ($Crop) {
                $Image.HintCrop = $Crop
            }
        }
        'Hero' {
            $Image = [Microsoft.Toolkit.Uwp.Notifications.ToastGenericHeroImage]::new()
        }
    }

    if ($Source) {
        $Image.Source = if ($IgnoreCache) {
            Optimize-BTImageSource -Source $Source -ForceRefresh
        } else {
            Optimize-BTImageSource -Source $Source
        }

    }

    if ($AlternateText) {
        $Image.AlternateText = $AlternateText
    }

    if ($AddImageQuery) {
        $Image.AddImageQuery = $AddImageQuery
    }

    switch ($Image.GetType().Name) {
        AdaptiveImage { if($PSCmdlet.ShouldProcess("returning: [$($Image.GetType().Name)]:Source=$($Image.Source):AlternateText=$($Image.AlternateText):HintCrop=$($Image.HintCrop):HintRemoveMargin=$($Image.HintRemoveMargin):HintAlign=$($Image.HintAlign):AddImageQuery=$($Image.AddImageQuery)")) { $Image } }
        ToastGenericAppLogo { if($PSCmdlet.ShouldProcess("returning: [$($Image.GetType().Name)]:Source=$($Image.Source):AlternateText=$($Image.AlternateText):HintCrop=$($Image.HintCrop):AddImageQuery=$($Image.AddImageQuery)")) { $Image } }
        ToastGenericHeroImage { if($PSCmdlet.ShouldProcess("returning: [$($Image.GetType().Name)]:Source=$($Image.Source):AlternateText=$($Image.AlternateText):AddImageQuery=$($Image.AddImageQuery)")) { $Image } }
    }
}
