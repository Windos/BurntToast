function New-BTSelectionBoxItem
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

    [CmdletBinding()]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBoxItem])]

    param
    (
        [Parameter(Mandatory)]
        [string] $Id,
        
        [Parameter(Mandatory)]
        [string] $Content
    )

    [Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBoxItem]::new($Id, $Content)
}
