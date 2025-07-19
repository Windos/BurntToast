function New-BTInput {
    <#
        .SYNOPSIS
        Creates an input element (text box or selection box) for a Toast notification.

        .DESCRIPTION
        The New-BTInput function creates a ToastTextBox for user-typed input or a ToastSelectionBox for user selection, for interaction via toasts.
        Use the Text parameter set for a type-in input, and the Selection parameter set with a set of options for pick list behavior.

        .PARAMETER Id
        Mandatory. Developer-provided ID for referencing this input/result.

        .PARAMETER Title
        Text to display above the input box or selection.

        .PARAMETER PlaceholderContent
        String placeholder to show when the text box is empty (Text set only).

        .PARAMETER DefaultInput
        Default text to pre-fill in the text box.

        .PARAMETER DefaultSelectionBoxItemId
        ID of the default selection item (must match the Id of one of the provided SelectionBoxItems).

        .PARAMETER Items
        Array of ToastSelectionBoxItem objects to populate the pick list (Selection set).

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastTextBox
        Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBox

        .EXAMPLE
        New-BTInput -Id 'Reply001' -Title 'Type a reply:'
        Creates a text input field on the toast.

        .EXAMPLE
        New-BTInput -Id 'Choice' -DefaultSelectionBoxItemId 'Item2' -Items $Sel1, $Sel2
        Creates a selection (dropdown) input with two options.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTInput.md
    #>

    [CmdletBinding(DefaultParametersetName = 'Text',
                   SupportsShouldProcess   = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTInput.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastTextBox], ParametersetName = 'Text')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBox], ParametersetName = 'Text')]

    param (
        [Parameter(Mandatory)]
        [string] $Id,

        [Parameter()]
        [string] $Title,

        [Parameter(ParametersetName = 'Text')]
        [string] $PlaceholderContent,

        [Parameter(ParametersetName = 'Text')]
        [string] $DefaultInput,

        [Parameter(ParametersetName = 'Selection')]
        [string] $DefaultSelectionBoxItemId,

        [Parameter(Mandatory,
                   ParametersetName = 'Selection')]
        [Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBoxItem[]] $Items
    )

    switch ($PsCmdlet.ParameterSetName) {
        'Text' {
            $ToastInput = [Microsoft.Toolkit.Uwp.Notifications.ToastTextBox]::new($Id)

            if ($PlaceholderContent) {
                $ToastInput.PlaceholderContent = $PlaceholderContent
            }

            if ($DefaultInput) {
                $ToastInput.DefaultInput = $DefaultInput
            }
        }
        'Selection' {
            $ToastInput = [Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBox]::new($Id)

            if ($DefaultSelectionBoxItemId) {
                $ToastInput.DefaultSelectionBoxItemId = $DefaultSelectionBoxItemId
            }

            foreach ($Item in $Items) {
                $ToastInput.Items.Add($Item)
            }
        }
    }

    if ($Title) {
        $ToastInput.Title = $Title
    }

    switch ($ToastInput.GetType().Name) {
        ToastTextBox { if($PSCmdlet.ShouldProcess("returning: [$($ToastInput.GetType().Name)]:Id=$($ToastInput.Id):Title=$($ToastInput.Title):PlaceholderContent=$($ToastInput.PlaceholderContent):DefaultInput=$($ToastInput.DefaultInput)")) { $ToastInput } }
        ToastSelectionBox { if($PSCmdlet.ShouldProcess("returning: [$($ToastInput.GetType().Name)]:Id=$($ToastInput.Id):Title=$($ToastInput.Title):DefaultSelectionBoxItemId=$($ToastInput.DefaultSelectionBoxItemId):DefaultInput=$($ToastInput.Items.Count)")) { $ToastInput } }
    }
}
