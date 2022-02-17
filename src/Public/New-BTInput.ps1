function New-BTInput {
    <#
        .SYNOPSIS
        Creates an input element on a Toast notification.

        .DESCRIPTION
        The New-BTInput function creates an input element on a Toast notification.

        Returned object is either a TextBox for users to type text into or SelectionBox to users to select from a list of options.

        .INPUTS
        None

        .OUTPUTS
        ToastTextBox
        ToastSelectionBox

        .EXAMPLE
        New-BTInput -Id Reply001 -Title 'Type a reply:'

        This command creates a new text box for a user to type a reply. (n.b. this sort of functionality probably won't work through BurntToast as PowerShell cannot, currently, subscribe to WinRT events.)

        .EXAMPLE
        New-BTInput -Id 'Selection001' -DefaultSelectionBoxItemId 'Item5' -Items $Select1, $Select2, $Select3, $Select4, $Select5

        This command creates a new selection box containing five options and specifying the ID of one of the options as the default.

        .NOTES
        Credit for most of the help text for this function go to the authors of the UWPCommunityToolkit library that this module relies upon.

        Please see the originating repo here: https://github.com/Microsoft/UWPCommunityToolkit

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTInput.md
    #>

    [CmdletBinding(DefaultParametersetName = 'Text',
                   SupportsShouldProcess   = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTInput.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastTextBox], ParametersetName = 'Text')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBox], ParametersetName = 'Text')]

    param (
        # Used so that developers can retrieve user input once the app is activated.
        [Parameter(Mandatory)]
        [string] $Id,

        # Title text to display above the element.
        [Parameter()]
        [string] $Title,

        # Placeholder text to be displayed on the text box when the user hasn't typed any text yet.
        [Parameter(ParametersetName = 'Text')]
        [string] $PlaceholderContent,

        # The initial text to place in the text box. Leave this null for a blank text box.
        [Parameter(ParametersetName = 'Text')]
        [string] $DefaultInput,

        # This controls which item is selected by default, and refers to the Id property of a Selection Box Item (New-BTSelectionBoxItem.)
        #
        # If you do not provide this, the default selection will be empty (user sees nothing).
        [Parameter(ParametersetName = 'Selection')]
        [string] $DefaultSelectionBoxItemId,

        # The selection items that the user can pick from in this SelectionBox. Only 5 items can be added.
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
