function Add-BTAppLogo {
    <#
        .SYNOPSIS
        Override the app logo with a custom image of choice that will be displayed on the toast.

        .DESCRIPTION
        The Add-BTAppLogo function specifies an image to be displayed on a toast notification as the app logo.

        Prior to Windows 10 20H2 this app logo would replace the smaller icon that represents the source of a notification, but from 20H2 it is displayed in adition to the icon.

        .INPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastContentBuilder. You can pipe a toast content builder object to Add-BTAppLogo.

        System.Uri. One image reference can be provided, this cannot be piped to Add-BTAppLogo.

        .OUTPUTS
        None. The Add-BTAppLogo function does not provide any output by default.

        You can optionally use the PassThru parameter to output the updated toast content builder object, which enables chaining functions together.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>Add-BTAppLogo -ContentBuilder $Builder -Source 'C:\Temp\LocalImage.png'

        This example adds a local image as the app logo on the toast notification using a toast content builder object.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTAppLogo -Source '\\FS01\Images$\NetworkImage.gif'

        This example adds an image from a network share as the app logo on the toast notification being constructred.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTAppLogo -Source 'https://example.com/OnlineImage.jpeg'

        This example adds an image from a the internet as the app logo on the toast notification being constructred.

        Future invocations of this example will used a cached copy of the referenced image rather than going out to the internet again.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTAppLogo -Source 'https://example.com/OnlineImage.jpeg' -IgnoreCache

        This example adds an image from a the internet as the app logo on the toast notification being constructred, it downloads the image from the internet regardless of if it has been previously cahced.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTAppLogo -Source 'C:\Temp\LocalImage.png' -AlternateText 'Picture of burnt toast, popped out of a toaster'

        This example adds a local image as the app logo on the toast notification with supplied alt text to add with accessibility e.g. the use of screen readers.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTAppLogo -Source 'C:\Temp\LocalImage.png' -Crop Circle

        This example adds a local image as the app logo on the toast notification cropped into the shape of a cirlce, overriding the default square shape.

        .EXAMPLE
        PS C:\>$Builder = New-BTContentBuilder

        PS C:\>$Builder | Add-BTAppLogo -Source 'C:\Temp\LocalImage.png' -PassThru |
                          Add-BTText -Text 'First Line of Text' -PassThru |
                          Add-BTText -Text 'Second Line of Text'

        This example an app logo followed by three custom text elements to a toast content builder object on the pipeline by passing through a refference to the builder object.

        .NOTES
        You can reference an image from your local computer, a network location, or the internet.

        Online images will be downloaded and cached in the user's TEMP directory for future use.

        Animated GIFs and images with transparent background are supported.

        .LINK
        https://docs.toastit.dev/commands/add-btapplogo
    #>

    [CmdletBinding()]
    param (
        # The toast content builder obejct that represents the toast notification being constructed.
        [Parameter(Mandatory,
                   ValueFromPipeline)]
        [Microsoft.Toolkit.Uwp.Notifications.ToastContentBuilder] $ContentBuilder,

        # The URI of the image. Can be from your local computer, network location, or the internet.
        # Online images will be downloaded and cached in the user's TEMP directory for future use.
        [Parameter(Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string] $Source = $Script:DefaultImage,

        # Specify how the image should be cropped.
        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveImageCrop] $Crop = 'Default',

        # A description of the image, for users of assistive technologies.
        [string] $AlternateText,

        # Specify that the online images should be downloaded, regardless of if they have been cached to the TEMP directory.
        # Used when the online resource has been updated and you need to ensure that users see the latest version.
        [switch] $IgnoreCache,

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

        if ($AlternateText) {
            $null = $ContentBuilder.AddAppLogoOverride($paramSrc,
                                                       $Crop,
                                                       $AlternateText)
        } else {
            $null = $ContentBuilder.AddAppLogoOverride($paramSrc,
                                                       $Crop)
        }

        if ($PassThru) {
            $ContentBuilder
        }
    }
    end {}
}