function New-BTSelectionBoxItem {
    <#
        .SYNOPSIS
        Creates a selection box item.

        .DESCRIPTION
        The New-BTSelectionBoxItem function creates a selection box item, for inclusion in a selection box created with New-BTInput.

        .INPUTS
        None

        .OUTPUTS
        ToastSelectionBoxItem

        .EXAMPLE
        $Select1 = New-BTSelectionBoxItem -Id 'Item1' -Content 'First option in the list'

        This command creates a new Selection Box Item object which can now be used with the New-BTInput function.

        .NOTES
        Credit for most of the help text for this function go to the authors of the UWPCommunityToolkit library that this module relies upon.

        Please see the originating repo here: https://github.com/Microsoft/UWPCommunityToolkit

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTSelectionBoxItem.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTSelectionBoxItem.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBoxItem])]

    param (
        # Developer-provided ID that the developer uses later to retrieve input when the Toast is interacted with.
        #
        # Can also be provided to a selection box to identify the default selection.
        [Parameter(Mandatory)]
        [string] $Id,

        # String that is displayed on the selection item. This is what the user sees.
        [Parameter(Mandatory)]
        [string] $Content
    )

    $SelectionBoxItem = [Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBoxItem]::new($Id, $Content)

    if($PSCmdlet.ShouldProcess("returning: [$($SelectionBoxItem.GetType().Name)]:Id=$($SelectionBoxItem.Id):Content=$($SelectionBoxItem.Content)")) {
        $SelectionBoxItem
    }
}
