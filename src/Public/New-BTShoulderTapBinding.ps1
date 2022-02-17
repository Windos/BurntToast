function New-BTShoulderTapBinding {
    <#
        .SYNOPSIS
        Creates a new Shoulder Tap Binding object.

        .DESCRIPTION
        The New-BTShoulderTapBinding function creates a new Shoulder Tap Binding Object, with which you can specify the Image to be displayed.

        .INPUTS
        LOTS...

        .OUTPUTS
        ToastBindingShoulderTap

        .EXAMPLE
        $Image = New-BTShoulderTapImage -Source 'https://www.route66sodas.com/wp-content/uploads/2019/01/Alert.gif'
        New-BTShoulderTapBinding -Image $Image

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTShoulderTapBinding.md
    #>
    [CmdletBinding(HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTShoulderTapBinding.md')]
    [Obsolete('This cmdlet is being deprecated, it will be removed in v0.9.0')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastBindingShoulderTap])]
    param (
        # The image displayed in the Shoulder Tap notification, this object is created using the New-BTShoulderTapImage function.
        [Parameter(Mandatory)]
        [Microsoft.Toolkit.Uwp.Notifications.ToastShoulderTapImage] $Image,

        # Set to "true" to allow Windows to append a query string to the image URI supplied in the Toast notification. Use this attribute if your server hosts images and can handle query strings, either by retrieving an image variant based on the query strings or by ignoring the query string and returning the image as specified without the query string. This query string specifies scale, contrast setting, and language.
        [switch] $AddImageQuery,

        # A default base URI that is combined with relative URIs in image source attributes.
        [uri] $BaseUri,

        # The target locale of the XML payload, specified as BCP-47 language tags such as "en-US" or "fr-FR". This locale is overridden by any locale specified in binding or text. If this value is a literal string, this attribute defaults to the user's UI language. If this value is a string reference, this attribute defaults to the locale chosen by Windows Runtime in resolving the string.
        [string] $Language
    )

    $Binding = [Microsoft.Toolkit.Uwp.Notifications.ToastBindingShoulderTap]::new()

    $Binding.Image = $Image

    if ($AddImageQuery.IsPresent) {
        $Binding.AddImageQuery = $true
    }

    if ($BaseUri) {
        $Binding.BaseUri = $BaseUri
    }

    if ($Language) {
        $Binding.Language = $Language
    }

    $Binding
}
