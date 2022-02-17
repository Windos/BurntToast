function New-BTImage {
    <#
        .SYNOPSIS
        Creates a new Image Element for Toast Notifications.

        .DESCRIPTION
        The New-BTImageElement function creates a new Image Element for Toast Notifications.

        You can use the parameters of New-BTImageElement to specify the source image, alt text, placement on the Toast Notification and crop shape.

        .INPUTS
        None

        .OUTPUTS
        AdaptiveImage
        ToastGenericAppLogo
        ToastGenericHeroImage

        .EXAMPLE
        $image1 = New-BTImage -Source 'C:\Media\BurntToast.png'

        This command creates a standard image object to be included in the main body of a toast.

        .EXAMPLE
        $image2 = New-BTImage -Source 'C:\Media\BurntToast.png' -AppLogoOverride -Crop Circle

        This command creates an image object to be used as the logo on a toast, cropped into the shape fo a circle.

        .EXAMPLE
        $image3 = New-BTImage -Source 'C:\Media\BurntToast.png' -HeroImage

        This command creates an inmage to be used as a toast's hero image.

        .NOTES
        Credit for most of the help text for this function go to the authors of the UWPCommunityToolkit library that this module relies upon.

        Please see the originating repo here: https://github.com/Microsoft/UWPCommunityToolkit

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
        # The URI of the image. Can be from your application package, application data, or the internet. Internet images must be less than 200 KB in size.
        [string] $Source = $Script:DefaultImage,

        # A description of the image, for users of assistive technologies.
        [string] $AlternateText,

        # Specifies that the image is to be used as the logo on the toast.
        [Parameter(Mandatory,
            ParameterSetName = 'AppLogo')]
        [switch] $AppLogoOverride,

        # Specifies that the image is to be used as the hero image on the toast.
        [Parameter(Mandatory,
            ParameterSetName = 'Hero')]
        [switch] $HeroImage,

        # The horizontal alignment of the image. For Toast, this is only supported when inside a group (not yet implemented.)
        [Parameter(ParameterSetName = 'Image')]
        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveImageAlign] $Align,

        # Control the desired cropping of the image. Supported on Toast since Anniversary Update.
        [Parameter(ParameterSetName = 'Image')]
        [Parameter(ParameterSetName = 'AppLogo')]
        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveImageCrop] $Crop,

        # By default, images have an 8px margin around them. You can remove this margin by including this switch. Supported on Toast since Anniversary Update.
        [Parameter(ParameterSetName = 'Image')]
        [switch] $RemoveMargin,

        # Set to true to allow Windows to append a query string to the image URI supplied in the Tile notification. Use this attribute if your server hosts images and can handle query strings, either by retrieving an image variant based on the query strings or by ignoring the query string and returning the image as specified without the query string. This query string specifies scale, contrast setting, and language.
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
