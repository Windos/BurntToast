function New-BTBinding {
    <#
        .SYNOPSIS
        Creates a new Generic Toast Binding object.

        .DESCRIPTION
        The New-BTBinding function creates a new Generic Toast Binding, where you provide text, images, and other visual elements for your Toast notification.

        .INPUTS
        None

        .OUTPUTS
        ToastBindingGeneric

        .EXAMPLE
        $text1 = New-BTText -Content 'This is a test'
        $text2 = New-BTText
        $text3 = New-BTText -Content 'This more testing'
        $progress = New-BTProgressBar -Title 'Things are happening' -Status 'Working on it' -Value 0.01
        $image1 = New-BTImage -Source 'C:\BurntToast\Media\BurntToast.png'
        $image2 = New-BTImage -Source 'C:\BurntToast\Media\BurntToast.png' -AppLogoOverride -Crop Circle
        $image3 = New-BTImage -Source 'C:\BurntToast\Media\BurntToast.png' -HeroImage
        $binding1 = New-BTBinding -Children $text1, $text2, $text3, $image1, $progress -AppLogoOverride $image2 -HeroImage $image3

        This example uses various BurntToast functions to create a number of objects, and then create a Generic Toast Binding using them as inputs.

        .NOTES
        Credit for most of the help text for this function go to the authors of the UWPCommunityToolkit library that this module relies upon.

        Please see the originating repo here: https://github.com/Microsoft/UWPCommunityToolkit

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTBinding.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTBinding.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastBindingGeneric])]
    param (
        # The contents of the body of the Toast, which can include Text (New-BTText), Image (New-BTImage), Group (not yet implemented), and Progress Bar (New-BTProgressBar).
        #
        # Also, Text elements must come before any other elements. If a Text element is placed after any other element, an exception will be thrown when you try to retrieve the Toast XML content.
        #
        # And finally, certain Text properties like HintStyle aren't supported on the root children text elements, and only work inside a Group. If you use Group on devices without the Anniversary Update, the group content will simply be dropped.
        [Microsoft.Toolkit.Uwp.Notifications.IToastBindingGenericChild[]] $Children,

        # Specifies groups of content (text and images) created via New-BTColumn that are displayed as a column.
        #
        # Multiple columns can be provided and they will be displayed side by side.
        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroup[]] $Column,

        # Set to "true" to allow Windows to append a query string to the image URI supplied in the Toast notification. Use this attribute if your server hosts images and can handle query strings, either by retrieving an image variant based on the query strings or by ignoring the query string and returning the image as specified without the query string. This query string specifies scale, contrast setting, and language.
        [switch] $AddImageQuery,

        # An optional override of the logo displayed on the Toast notification.
        #
        # Created using the New-BTImage function with the 'AppLogoOverride' switch.
        [Microsoft.Toolkit.Uwp.Notifications.ToastGenericAppLogo] $AppLogoOverride,

        # New in Anniversary Update: An optional text element that is displayed as attribution text.
        #
        # On devices without the Anniversary Update, this text will appear as if it's another Text element at the end of your Children list.
        [Microsoft.Toolkit.Uwp.Notifications.ToastGenericAttributionText] $Attribution,

        # A default base URI that is combined with relative URIs in image source attributes.
        [uri] $BaseUri,

        # New in Anniversary Update: An optional hero image (a visually impactful image displayed on the Toast notification).
        #
        # On devices without the Anniversary Update, the hero image will simply be ignored.
        [Microsoft.Toolkit.Uwp.Notifications.ToastGenericHeroImage] $HeroImage,

        # The target locale of the XML payload, specified as BCP-47 language tags such as "en-US" or "fr-FR". This locale is overridden by any locale specified in binding or text. If this value is a literal string, this attribute defaults to the user's UI language. If this value is a string reference, this attribute defaults to the locale chosen by Windows Runtime in resolving the string.
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
