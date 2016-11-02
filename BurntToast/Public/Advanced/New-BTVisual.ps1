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
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastVisual])]
    param
    (
        [Parameter()]
        [Microsoft.Toolkit.Uwp.Notifications.ToastBindingGeneric] $BindingGeneric,

        [switch] $AddImageQuery,

        [uri] $BaseUri,

        [string] $Language
    )

    $Visual = [Microsoft.Toolkit.Uwp.Notifications.ToastVisual]::new()

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
