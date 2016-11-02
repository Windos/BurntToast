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
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastBindingGeneric])]
    param
    (
        [Parameter()]
        [Microsoft.Toolkit.Uwp.Notifications.IToastBindingGenericChild[]] $Children,

        [switch] $AddImageQuery,

        [Microsoft.Toolkit.Uwp.Notifications.ToastGenericAppLogo] $AppLogoOverride,

        [Microsoft.Toolkit.Uwp.Notifications.ToastGenericAttributionText] $Attribution,

        [uri] $BaseUri,

        [Microsoft.Toolkit.Uwp.Notifications.ToastGenericHeroImage] $HeroImage,

        [string] $Language
    )

    $Binding = [Microsoft.Toolkit.Uwp.Notifications.ToastBindingGeneric]::new()

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
