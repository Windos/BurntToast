function Add-BTImage {
    <#
        .SYNOPSIS
        Add an image to a toast notification.

        .DESCRIPTION
        The Add-BTImage function adds one of three image types to a toast notification.

        Multiple images can be added to the body of a toast notification by calling the function without the AppLogo or HeroImage switches multiple times. These images are displayed in the order in which they are added.

        Any images added to the body of a toast notification are displayed after the text of the toast notification.

        By using the AppLogo switch, this function specifies an image to be displayed on a toast notification as the app logo

        Prior to Windows 10 20H2 this app logo would replace the smaller icon that represents the source of a notification, but from 20H2 it is displayed in addition to the icon.

        Finally, using the HeroImage switch, this function specifies an image to be displayed across the top of a toast notification.

        .INPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastContentBuilder. You can pipe a toast content builder object to Add-BTImage.

        System.Uri. One image reference can be provided, this cannot be piped to Add-BTImage.

        .OUTPUTS
        None. The Add-BTImage function does not provide any output by default.

        You can optionally use the PassThru parameter to output the updated toast content builder object, which enables chaining functions together.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>Add-BTImage -ContentBuilder $Builder -Source 'C:\Temp\LocalImage.png'

        This example adds a local image to the body of a toast notification using a toast content builder object.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTImage -Source '\\FS01\Images$\NetworkImage.gif'

        This example adds an image from a network share to the body of a toast notification with its toast content builder object coming from the pipeline.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTImage -Source 'https://example.com/OnlineImage.jpeg'

        This example adds an image from the internet to the body of a toast notification.

        Future invocations of this example will used a cached copy of the referenced image rather than going out to the internet again.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTImage -Source 'https://example.com/OnlineImage.jpeg' -IgnoreCache

        This example adds an image from the internet to the body of a toast notification, it downloads the image from the internet regardless of if it has been previously cached.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTImage -Source 'C:\Temp\LocalImage.png' -AlternateText 'Picture of burnt toast, popped out of a toaster'

        This example adds a local image to the body of a toast notification with supplied alt text to aid with accessibility e.g. the use of screen readers.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTImage -Source 'C:\Temp\LocalImage.png' -Crop Circle

        This example adds a local image to the body of a toast notification cropped into the shape of a circle, overriding the default square shape.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTImage -Source 'C:\Temp\LocalImageOne.png'

        PS C:\>$Builder | Add-BTImage -Source 'C:\Temp\LocalImageTwo.png'

        This example adds two images to a toast content notification, which will be displayed in the order in which they are added.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTImage -Source 'C:\Temp\LocalImage.png' -PassThru |
                          Add-BTText -Text 'First Line of Text' -PassThru |
                          Add-BTText -Text 'Second Line of Text'

        This example a image alongside three custom text elements to a toast content builder object on the pipeline by passing through a refference to the builder object.

        The image is displayed after the text elements, despite being added first.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>Add-BTImage -ContentBuilder $Builder -Source 'C:\Temp\LocalImage.png' -AppLogo

        This example adds a local image as the app logo on the toast notification using a toast content builder object.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>Add-BTImage -ContentBuilder $Builder -Source 'C:\Temp\LocalImage.png' -HeroImage

        This example adds a local image as the hero image on the toast notification using a toast content builder object.

        .NOTES
        You can reference an image from your local computer, a network location, or the internet.

        Online images will be downloaded and cached in the user's TEMP directory for future use.

        Animated GIFs and images with transparent background are supported.

        .LINK
        https://docs.toastit.dev/commands/add-btimage
    #>

    [CmdletBinding(DefaultParameterSetName = 'AdaptiveImage')]
    param (
        # The toast content builder object that represents the toast notification being constructed.
        [Parameter(Mandatory,
                   ValueFromPipeline)]
        [Microsoft.Toolkit.Uwp.Notifications.ToastContentBuilder] $ContentBuilder,

        # The URI of the image. Can be from your local computer, network location, or the internet.
        # Online images will be downloaded and cached in the user's TEMP directory for future use.
        [Parameter(Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string] $Source = $Script:DefaultImage,

        # Specify how the image should be cropped.
        [Parameter(ParameterSetName = 'AdaptiveImage')]
        [Parameter(ParameterSetName = 'AppLogo')]
        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveImageCrop] $Crop = 'Default',

        # A description of the image, for users of assistive technologies.
        [string] $AlternateText,

        # Specify that the online images should be downloaded, regardless of if they have been cached to the TEMP directory.
        # Used when the online resource has been updated and you need to ensure that users see the latest version.
        [switch] $IgnoreCache,

        # Specify that the image should be used as the app logo.
        [Parameter(ParameterSetName = 'AppLogo',
                   Mandatory)]
        [switch] $AppLogo,

        # Specify that the image should be used as the hero image.
        [Parameter(ParameterSetName = 'HeroImage',
                   Mandatory)]
        [switch] $HeroImage,

        # Returns an object that represents the item with which you're working. By default, this cmdlet doesn't generate any output.
        [switch] $PassThru
    )

    begin {}
    process {
        $paramSrc = if ($IgnoreCache) {
            Optimize-BTImageSource -Source $Source -ForceRefresh
        } else {
            Optimize-BTImageSource -Source $Source
        }

        if ($AppLogo.IsPresent) {
            if ($AlternateText) {
                $null = $ContentBuilder.AddAppLogoOverride($paramSrc,
                                                           $Crop,
                                                           $AlternateText)
            } else {
                $null = $ContentBuilder.AddAppLogoOverride($paramSrc,
                                                           $Crop)
            }
        } elseif ($HeroImage.IsPresent) {
            if ($AlternateText) {
                $null = $ContentBuilder.AddHeroImage($paramSrc,
                                                     $AlternateText)
            } else {
                $null = $ContentBuilder.AddHeroImage($paramSrc)
            }
        } else {
            $BTImage = [Microsoft.Toolkit.Uwp.Notifications.AdaptiveImage ]::new()
            $BTImage.Source = $paramSrc
            $BTImage.HintCrop = $Crop

            if ($AlternateText) {
                $BTImage.AlternateText = $AlternateText
            }

            $null = $ContentBuilder.AddVisualChild($BTImage)
        }

        if ($PassThru) {
            $ContentBuilder
        }
    }
    end {}
}