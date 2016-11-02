using namespace Microsoft.Toolkit.Uwp.Notifications

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
    [OutputType([ToastSelectionBoxItem])]

    param
    (
        [Parameter(Mandatory)]
        [string] $Id,
        
        [Parameter(Mandatory)]
        [string] $Content
    )

    [ToastSelectionBoxItem]::new($Id, $Content)
}
