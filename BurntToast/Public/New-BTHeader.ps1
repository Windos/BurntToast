﻿function New-BTHeader {
    <#
        .SYNOPSIS
        Creates a new toast notification header.

        .DESCRIPTION
        The New-BTHeader function creates a new toast notification header for a Toast Notification.

        These headers are diaplyed at the top of a toast and are also used to categorize toasts in the Action Center.

        .INPUTS
        None
            You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastHeader

        .EXAMPLE
        New-BTHeader -Id 'primary header' -Title 'First Category'

        This command creates a Toast Header object, which will be displayed with the text "First Category."

        .EXAMPLE
        New-BTHeader -Id '001' -Title 'Stack Overflow Questions' -Arguments 'http://stackoverflow.com/'

        This command creates a Toast Header object, which will be displayed with the text "First Category."

        Clicking the header will take the user to the Stack Overflow website.

        .LINK
        https://github.com/Windos/BurntToast/blob/master/Help/New-BTHeader.md
    #>

    [CmdletBinding()]

    param (
        # Unique string that identifies a header. If a new Id is provided, the system will treat the header as a new header even if it has the same display text as a previous header.
        #
        # It is possible to update a header's display text by re-using the Id but changing the title.
        [Parameter(Mandatory)]
        [string] $Id,

        # The header string that is displayed to the user.
        [Parameter(Mandatory)]
        [string] $Title,

        # Specifies an app defined string.
        #
        # For the purposes of BurntToast notifications this is generally the path to a file or URI and paired with the Protocol ActivationType.
        [Parameter()]
        [string] $Arguments,

        # Defines tne ActivationType that is trigger when the button is pressed.
        #
        # Defaults to Protocol which will open the file or URI specified in with the Arguments parameter in the relevant system default application.
        [Parameter()]
        [Microsoft.Toolkit.Uwp.Notifications.ToastActivationType] $ActivationType = [Microsoft.Toolkit.Uwp.Notifications.ToastActivationType]::Protocol
    )

    $Header = [Microsoft.Toolkit.Uwp.Notifications.ToastHeader]::new($Id, $Title, $Arguments)

    if ($ActivationType) {
        $Header.ActivationType = $ActivationType
    }

    $Header
}
