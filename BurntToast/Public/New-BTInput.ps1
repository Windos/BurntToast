using namespace Microsoft.Toolkit.Uwp.Notifications

function New-BTInput
{
    <#
        .SYNOPSIS

        .DESCRIPTION

        .INPUTS
        None

        .OUTPUTS
        Image
        
        .EXAMPLE

        .EXAMPLE

        .EXAMPLE

        .LINK
        https://github.com/Windos/BurntToast
    #>

    [CmdletBinding(DefaultParametersetName = 'Text')]
    [OutputType([ToastTextBox], ParametersetName = 'Text')]
    [OutputType([ToastSelectionBox], ParametersetName = 'Text')]

    param
    (
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
        [ToastSelectionBoxItem[]] $Items
    )

    switch ($PsCmdlet.ParameterSetName)
    {
        'Text'
        {
            $ToastInput = [ToastTextBox]::new($Id)

            if ($PlaceholderContent)
            {
                $ToastInput.PlaceholderContent = $PlaceholderContent
            }

            if ($DefaultInput)
            {
                $ToastInput.DefaultInput = $DefaultInput
            }
        }
        'Selection'
        {
            $ToastInput = [ToastSelectionBox]::new($Id)

            if ($DefaultSelectionBoxItemId)
            {
                $ToastInput.DefaultSelectionBoxItemId = $DefaultSelectionBoxItemId
            }

            foreach ($Item in $Items)
            {
                $ToastInput.Items.Add($Item)
            }
        }
    }

    if ($Title)
    {
        $ToastInput.Title = $Title
    }

    $ToastInput
}
