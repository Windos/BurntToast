function New-BTSelectionBoxItem {
    <#
        .SYNOPSIS
        Creates a selection box item for use in a toast input.

        .DESCRIPTION
        The New-BTSelectionBoxItem function creates a selection box item (ToastSelectionBoxItem) to include as an option in a selection box, produced by New-BTInput.

        .PARAMETER Id
        Unique identifier for this selection box item, also referred to by DefaultSelectionBoxItemId when used in New-BTInput.

        .PARAMETER Content
        String to display as the label for the item in the dropdown.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBoxItem

        .EXAMPLE
        $Select1 = New-BTSelectionBoxItem -Id 'Item1' -Content 'First option in the list'
        Creates a Selection Box Item for use in a selection input element.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTSelectionBoxItem.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTSelectionBoxItem.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBoxItem])]

    param (
        [Parameter(Mandatory)]
        [string] $Id,

        [Parameter(Mandatory)]
        [string] $Content
    )

    $SelectionBoxItem = [Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBoxItem]::new($Id, $Content)

    if($PSCmdlet.ShouldProcess("returning: [$($SelectionBoxItem.GetType().Name)]:Id=$($SelectionBoxItem.Id):Content=$($SelectionBoxItem.Content)")) {
        $SelectionBoxItem
    }
}
