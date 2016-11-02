using namespace Microsoft.Toolkit.Uwp.Notifications

function New-BTVisual
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
    [OutputType([ToastVisual])]
    param
    (
        [Parameter()]
        [ToastBindingGeneric] $BindingGeneric,

        [switch] $AddImageQuery,

        [uri] $BaseUri,

        [string] $Language
    )

    $Visual = [ToastVisual]::new()

    if ($BindingGeneric)
    {
        $Visual.BindingGeneric = $BindingGeneric
    }

    if ($AddImageQuery)
    {
        $Visual.AddImageQuery = $AddImageQuery
    }

    if ($BaseUri)
    {
        $Visual.BaseUri = $BaseUri
    }

    if ($Language)
    {
        $Visual.Language = $Language
    }

    $Visual
}
