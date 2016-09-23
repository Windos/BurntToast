using module BurntToast.Class

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
    [OutputType([Visual])]
    param
    (
        [Parameter(Mandatory)]
        [object[]] $Element
    )

    $Binding = [Binding]::new()

    foreach ($Ele in $Element)
    {
        $Binding.AddElement($Ele)
    }

    [Visual]::new($Binding)
}
