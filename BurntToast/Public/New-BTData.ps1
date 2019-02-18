function New-BTData {
    <#
        .SYNOPSIS
        Creates a new toast data bundle.

        .DESCRIPTION
        The New-BTData function creates a new toast data for an updatable toast notification.

        .INPUTS
        TODO

        .OUTPUTS
        TOTO

        .EXAMPLE
        TODO

        .LINK
        https://github.com/Windos/BurntToast/blob/master/Help/New-BTData.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true)]

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

    if($PSCmdlet.ShouldProcess("returning: [$($Header.GetType().Name)]:Id=$($Header.Id):Title=$($Header.Title):Arguments=$($Header.Arguments):ActivationType=$($Header.ActivationType)")) {
        $Header
    }
}
