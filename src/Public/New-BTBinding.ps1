function New-BTBinding {
    <#
        .SYNOPSIS
        Creates a new Generic Toast Binding object.

        .DESCRIPTION
        The New-BTBinding function creates a new Generic Toast Binding, in which you provide text, images, columns, progress bars, and more, controlling the visual appearance of the notification.

        .PARAMETER Children
        Array of binding children elements to include, such as Text, Image, Group, or Progress Bar objects, created by other BurntToast functions (New-BTText, New-BTImage, New-BTProgressBar, etc).

        .PARAMETER Column
        Array of AdaptiveSubgroup elements (columns), created via New-BTColumn, to display content side by side within the binding.

        .PARAMETER AddImageQuery
        Switch. Allows Windows to append a query string to image URIs for scale and language support; only needed for remote images.

        .PARAMETER AppLogoOverride
        An optional override for the logo displayed in the notification, created with New-BTImage using the AppLogoOverride switch.

        .PARAMETER Attribution
        Optional attribution text, created with New-BTText. Only supported on modern versions of Windows.

        .PARAMETER BaseUri
        A URI that is combined with relative image URIs for images in the notification.

        .PARAMETER HeroImage
        Optional hero image object, created with New-BTImage using the HeroImage switch.

        .PARAMETER Language
        String specifying the locale (e.g. "en-US" or "fr-FR") for the binding and contained text.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastBindingGeneric

        .EXAMPLE
        $text1 = New-BTText -Content 'This is a test'
        $image1 = New-BTImage -Source 'C:\BurntToast\Media\BurntToast.png'
        $binding = New-BTBinding -Children $text1, $image1
        Combines text and image into a binding for use in a visual toast.

        .EXAMPLE
        $progress = New-BTProgressBar -Title 'Updating' -Status 'Running' -Value 0.4
        $binding = New-BTBinding -Children $progress
        Includes a progress bar element in the binding.

        .EXAMPLE
        $col1 = New-BTColumn -Children (New-BTText -Text 'a')
        $col2 = New-BTColumn -Children (New-BTText -Text 'b')
        $binding = New-BTBinding -Column $col1, $col2
        Uses two columns to display content side by side.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTBinding.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTBinding.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastBindingGeneric])]
    param (
        [Microsoft.Toolkit.Uwp.Notifications.IToastBindingGenericChild[]] $Children,

        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroup[]] $Column,

        [switch] $AddImageQuery,

        [Microsoft.Toolkit.Uwp.Notifications.ToastGenericAppLogo] $AppLogoOverride,

        [Microsoft.Toolkit.Uwp.Notifications.ToastGenericAttributionText] $Attribution,

        [uri] $BaseUri,

        [Microsoft.Toolkit.Uwp.Notifications.ToastGenericHeroImage] $HeroImage,

        [string] $Language
    )

    $Binding = [Microsoft.Toolkit.Uwp.Notifications.ToastBindingGeneric]::new()

    if ($Children) {
        foreach ($Child in $Children) {
            $Binding.Children.Add($Child)
        }
    }

    if ($Column) {
        $AdaptiveGroup = [Microsoft.Toolkit.Uwp.Notifications.AdaptiveGroup]::new()

        foreach ($Group in $Column) {
            $AdaptiveGroup.Children.Add($Group)
        }

        $Binding.Children.Add($AdaptiveGroup)
    }

    if ($AddImageQuery) {
        $Binding.AddImageQuery = $AddImageQuery
    }

    if ($AppLogoOverride) {
        $Binding.AppLogoOverride = $AppLogoOverride
    }

    if ($Attribution) {
        $Binding.Attribution = $Attribution
    }

    if ($BaseUri) {
        $Binding.BaseUri = $BaseUri
    }

    if ($HeroImage) {
        $Binding.HeroImage = $HeroImage
    }

    if ($Language) {
        $Binding.Language = $Language
    }

    if($PSCmdlet.ShouldProcess("returning: [$($Binding.GetType().Name)]:Children=$($Binding.Children.Count):AddImageQuery=$($Binding.AddImageQuery.Count):AppLogoOverride=$($Binding.AppLogoOverride.Count):Attribution=$($Binding.Attribution.Count):BaseUri=$($Binding.BaseUri.Count):HeroImage=$($Binding.HeroImage.Count):Language=$($Binding.Language.Count)")) {
        $Binding
    }
}
