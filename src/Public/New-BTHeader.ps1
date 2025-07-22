function New-BTHeader {
    <#
        .SYNOPSIS
        Creates a new toast notification header.

        .DESCRIPTION
        The New-BTHeader function creates a toast notification header (ToastHeader) for a Toast Notification. Headers are displayed at the top and used for categorization or grouping in Action Center.

        .PARAMETER Id
        Unique string identifying this header instance. Used for replacement or updating by reuse.

        .PARAMETER Title
        The text displayed to the user as the header.

        .PARAMETER Arguments
        String data passed to Activation if the header itself is clicked.

        .PARAMETER ActivationType
        Enum specifying the activation type (defaults to Protocol).

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastHeader

        .EXAMPLE
        New-BTHeader -Title 'First Category'
        Creates a header titled 'First Category' for categorizing toasts.

        .EXAMPLE
        New-BTHeader -Id '001' -Title 'Stack Overflow Questions' -Arguments 'http://stackoverflow.com/'
        Creates a header with ID '001' and links activation to a URL.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTHeader.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTHeader.md')]

    param (
        [Parameter()]
        [string] $Id = 'ID' + (New-Guid).ToString().Replace('-','').ToUpper(),

        [Parameter(Mandatory)]
        [string] $Title,

        [Parameter()]
        [string] $Arguments,

        [Parameter()]
        [Microsoft.Toolkit.Uwp.Notifications.ToastActivationType] $ActivationType = [Microsoft.Toolkit.Uwp.Notifications.ToastActivationType]::Protocol
    )

    $Header = [Microsoft.Toolkit.Uwp.Notifications.ToastHeader]::new($Id, ($Title -replace '\x01'), $Arguments)

    if ($ActivationType) {
        $Header.ActivationType = $ActivationType
    }

    if($PSCmdlet.ShouldProcess("returning: [$($Header.GetType().Name)]:Id=$($Header.Id):Title=$($Header.Title):Arguments=$($Header.Arguments):ActivationType=$($Header.ActivationType)")) {
        $Header
    }
}
