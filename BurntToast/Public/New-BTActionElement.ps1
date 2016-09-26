using module BurntToast.Class

function New-BTActionElement
{
    <#
        .SYNOPSIS
        Creates a new Action Element for Toast Notifications.

        .DESCRIPTION
        The New-BTActionElement cmdlet creates a new Action Element for Toast Notifications.
    
        .INPUTS
        None

        .OUTPUTS
        ToastAction
        
        .EXAMPLE

        .EXAMPLE

        .EXAMPLE

        .LINK
        https://github.com/Windos/BurntToast
    #>

    [CmdletBinding()]
    [OutputType([Image])]
    param
    (
        [Parameter(Mandatory)]
        [string] $Content,

        [Parameter(Mandatory)]
        [string] $Argument,

        [Parameter()]
        [ActivationType] $ActivationType,
        
        [Parameter()]
        [IO.Path] $ImageUri,

        [Parameter()]
        [string] $InputId
    )

    $Props = @($Content, $Argument)

    if ($ActivationType)
    {
        $Props += $ActivationType
    }

    if ($ImageUri)
    {
        $Props += $ImageUri
    }

    if ($InputId)
    {
        $Props += $InputId
    }

    New-Object -TypeName ToastAction -ArgumentList $Props
}
