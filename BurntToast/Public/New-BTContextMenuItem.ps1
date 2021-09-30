function New-BTContextMenuItem {
    <#
        .SYNOPSIS
        Creates a Context Menu Item object.

        .DESCRIPTION
        The New-BTContextMenuItem function creates a Context Menu Item object.

        .INPUTS
        None

        .OUTPUTS
        ToastContextMenuItem

        .EXAMPLE
        New-BTContextMenuItem -Content 'Google' -Arguments 'https://google.com' -ActivationType Protocol

        This command creates a new Context Menu Item object with the specified properties.

        .NOTES
        Credit for most of the help text for this function go to the authors of the UWPCommunityToolkit library that this module relies upon.

        Please see the originating repo here: https://github.com/Microsoft/UWPCommunityToolkit

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTContextMenuItem.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTContextMenuItem.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastContextMenuItem])]

    param (
        # The text to display on the menu item.
        [Parameter(Mandatory)]
        [string] $Content,

        # App-defined string of arguments that the app can later retrieve once it is activated when the user clicks the menu item.
        [Parameter(Mandatory)]
        [string] $Arguments,

        # Controls what type of activation this menu item will use when clicked. Defaults to Foreground.
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
