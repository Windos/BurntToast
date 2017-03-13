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
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastTextBox], ParametersetName = 'Text')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBox], ParametersetName = 'Text')]

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
        [Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBoxItem[]] $Items
    )

    switch ($PsCmdlet.ParameterSetName)
    {
        'Text'
        {
            $ToastInput = [Microsoft.Toolkit.Uwp.Notifications.ToastTextBox]::new($Id)

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
            $ToastInput = [Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBox]::new($Id)

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
