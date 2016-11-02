using namespace Microsoft.Toolkit.Uwp.Notifications

function New-BTBinding
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
    [OutputType([ToastBindingGeneric])]
    param
    (
        [Parameter()]
        [IToastBindingGenericChild[]] $Children,

        [switch] $AddImageQuery,

        [ToastGenericAppLogo] $AppLogoOverride,

        [ToastGenericAttributionText] $Attribution,

        [uri] $BaseUri,

        [ToastGenericHeroImage] $HeroImage,

        [string] $Language
    )

    $Binding = [ToastBindingGeneric]::new()

    if ($Children)
    {
        foreach ($Child in $Children)
        {
            $Binding.Children.Add($Child)
        }
    }

    if ($AddImageQuery)
    {
        $Binding.AddImageQuery = $AddImageQuery
    }

    if ($AppLogoOverride)
    {
        $Binding.AppLogoOverride = $AppLogoOverride
    }

    if ($Attribution)
    {
        $Binding.Attribution = $Attribution
    }

    if ($BaseUri)
    {
        $Binding.BaseUri = $BaseUri
    }

    if ($HeroImage)
    {
        $Binding.HeroImage = $HeroImage
    }

    if ($Language)
    {
        $Binding.Language = $Language
    }

    $Binding
}
