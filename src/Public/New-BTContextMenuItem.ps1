function New-BTContextMenuItem {
    <#
        .SYNOPSIS
        Creates a Context Menu Item object.

        .DESCRIPTION
        The New-BTContextMenuItem function creates a context menu item (ToastContextMenuItem) for a Toast Notification, typically added via New-BTAction.

        .PARAMETER Content
        The text string to display to the user for this menu item.

        .PARAMETER Arguments
        App-defined string that is returned if the context menu item is selected. Routinely a URI, file path, or app context string.

        .PARAMETER ActivationType
        Enum. Controls the type of activation for this menu item. Defaults to Foreground if not specified.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastContextMenuItem

        .EXAMPLE
        New-BTContextMenuItem -Content 'Website' -Arguments 'https://example.com' -ActivationType Protocol
        Creates a menu item labeled "Website" that opens a URL on right-click.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTContextMenuItem.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTContextMenuItem.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastContextMenuItem])]

    param (
        [Parameter(Mandatory)]
        [string] $Content,

        [Parameter(Mandatory)]
        [string] $Arguments,

        [Parameter()]
        [Microsoft.Toolkit.Uwp.Notifications.ToastActivationType] $ActivationType
    )

    $MenuItem = [Microsoft.Toolkit.Uwp.Notifications.ToastContextMenuItem]::new($Content, $Arguments)

    if ($ActivationType) {
        $MenuItem.ActivationType = $ActivationType
    }

    if($PSCmdlet.ShouldProcess("returning: [$($MenuItem.GetType().Name)]:Content=$($MenuItem.Content):Arguments=$($MenuItem.Arguments):ActivationType=$($MenuItem.ActivationType)")) {
        $MenuItem
    }
}
