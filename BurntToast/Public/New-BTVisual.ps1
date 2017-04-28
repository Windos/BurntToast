﻿function New-BTVisual {
    <#
        .SYNOPSIS
        Creates a new visual element for toast notifications.

        .DESCRIPTION
        The New-BTVisual function creates a new visual element for toast notifications, which defines all of the visual aspects of a toast.

        .INPUTS
        None

        .OUTPUTS
        ToastVisual

        .EXAMPLE
        New-BTVisual -BindingGeneric $Binding1

        This command creates a new Visual element taking a previously configured binding element as input.

        .NOTES
        Credit for most of the help text for this function go to the authors of the UWPCommunityToolkit library that this module relies upon.

        Please see the originating repo here: https://github.com/Microsoft/UWPCommunityToolkit

        .LINK
        https://github.com/Windos/BurntToast/blob/master/Help/New-BTVisual.md
    #>

    [CmdletBinding()]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastVisual])]
    param (
        # The generic Toast binding, which can be rendered on all devices. This binding is created using the New-BTBinding function.
        [Parameter()]
        [Microsoft.Toolkit.Uwp.Notifications.ToastBindingGeneric] $BindingGeneric,

        # Specify this switch to allow Windows to append a query string to the image URI supplied in the Toast notification. Use this attribute if your server hosts images and can handle query strings, either by retrieving an image variant based on the query strings or by ignoring the query string and returning the image as specified without the query string. This query string specifies scale, contrast setting, and language.
        [switch] $AddImageQuery,

        # A default base URI that is combined with relative URIs in image source attributes.
        [uri] $BaseUri,

        # The target locale of the XML payload, specified as BCP-47 language tags such as "en-US" or "fr-FR". This locale is overridden by any locale specified in binding or text. If this value is a literal string, this attribute defaults to the user's UI language. If this value is a string reference, this attribute defaults to the locale chosen by Windows Runtime in resolving the string.
        [string] $Language
    )

    $Visual = [Microsoft.Toolkit.Uwp.Notifications.ToastVisual]::new()

    if ($BindingGeneric) {
        $Visual.BindingGeneric = $BindingGeneric
    }

    if ($AddImageQuery) {
        $Visual.AddImageQuery = $AddImageQuery
    }

    if ($BaseUri) {
        $Visual.BaseUri = $BaseUri
    }

    if ($Language) {
        $Visual.Language = $Language
    }

    $Visual
}
